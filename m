Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDC7C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 11:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbiGSLqm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 07:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGSLqk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 07:46:40 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2029.outbound.protection.outlook.com [40.92.41.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBDA13F29
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 04:46:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoHgMacAIv7eDj4SA0qppptTPHVRbVb+ynqHrzRlwBKLahWMqY73pJBtq+VF5h3Md2cVMnkVSnk14oqfWK1Ob7V3kNiDs1yvCxbia8O1m3Yb/7r+RKd+hA/Hq1c0mVcHF3iziPt5Ul6evUeCqRdh2hDO6ocDMWhTUdVg3A60QwdbIMUsTFotN9mpM5M08sWdHu/DMSadLSqEr33kCEgcQNLebxKn6rCThyVjgofP+XUQiVHtvetQeenN91Molbjn9jIUbFi/RPMZJrpuDmTmx9nPs1MFGCUO3222cOJVUbH+dzi6ChKOg9w0RJgSItmgZrzPMAXifjDYrn0ng7iz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2+SF2Q+PRRme7pDKXIu00QiYV9krhHZq1e2CHZKg/U=;
 b=E/4gYUvC9WB5kBUETsthdkIRjRpCkOOBb1HGoYvMIsp8Dh20ZwXVD1O5jxmQPQ8KcTwZwvt5lV+TKFPWUdhpqiPZ9lVLvDoJOD61BJwEptiMkfB4JBFmllkUDrfJA1Lb3gFap4l2E85gy10TD9l9jVCbgXxzugodsIan76w5+z9p1R9utiSXMEttxpkEoR+URbdl1U0/c8dS3Ao4VlDpl08L0GkDurHDvfGpZ4gX4jrAwakodkkLKLxaq/SEHHxcRuo9Y4Y/QZLl42XPzEUfuEpecvvfr26jMxtGiK7y6V9CqIXnlUY9GRt1rWFAh4yDkZKf2UD4PQppmHpZV/T2Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2+SF2Q+PRRme7pDKXIu00QiYV9krhHZq1e2CHZKg/U=;
 b=eoa0pqhZZsnxsW6x9yl6jHSKNRyaWEYOxJ7PjALC4bGpzd53g7nZ+X/dpMLdsHL+dC2XgmGVovpS/b9SXLXwe4kTay1DZ+JFFlN5ISRGE9XuoYGk6qwTs/AbnWvaeT7DtUjoFVRC/Z00jNuCEvbg5lW/xqdJmh2zlgWK0bHqArl5/M4FyN/NPOsI+ZbL+Qn57jK0Cji1mgiEp5SpPaWpOM9fDe4X7tHMDHZ3OWOqN55IptyuqRvLbWcdUlCLyw6Bz8sjpIKh6ktH1yg7pf9WlyoMT8eMqs+lFaTSNJs6Rg94ymUAyMzMexvDRG0mU5grJGtrDnOYFNsiwzSG0oTpkw==
Received: from PH7PR14MB5594.namprd14.prod.outlook.com (2603:10b6:510:1f6::17)
 by MN2PR14MB3440.namprd14.prod.outlook.com (2603:10b6:208:1b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Tue, 19 Jul
 2022 11:46:38 +0000
Received: from PH7PR14MB5594.namprd14.prod.outlook.com
 ([fe80::9102:6337:5382:5f07]) by PH7PR14MB5594.namprd14.prod.outlook.com
 ([fe80::9102:6337:5382:5f07%9]) with mapi id 15.20.5438.014; Tue, 19 Jul 2022
 11:46:37 +0000
From:   Celeste Liu <coelacanthus@outlook.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Raman Gupta <rocketraman@gmail.com>,
        Celeste Liu <coelacanthus@outlook.com>
Subject: [PATCH] contrib/rerere-train: avoid useless gpg sign in training
Date:   Tue, 19 Jul 2022 19:40:46 +0800
Message-ID: <PH7PR14MB5594D28D5CF94BD30DB9D3C4CE8F9@PH7PR14MB5594.namprd14.prod.outlook.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [UfAasDfrAtwAGVxdKIAu1rdGpxWX+MxZuqgVPhaMqKj0usmHY2VF0hsDB6YfHo+y]
X-ClientProxiedBy: TYAPR01CA0088.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::28) To PH7PR14MB5594.namprd14.prod.outlook.com
 (2603:10b6:510:1f6::17)
X-Microsoft-Original-Message-ID: <20220719114046.317399-1-coelacanthus@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9adef641-56f2-4dd2-4db8-08da697c56a3
X-MS-Exchange-SLBlob-MailProps: mBRmoEB1kyIpDFlCVXgVLAF7DwjwsNmcMhBWBytetWdRicSIkdYLDJJvhSP/+0JDyQ+vrFerocAzCr4kITsFHg4eGJqo0DMzY652BiYGbZvo+p35xE0pKq89q23Baa0LJTGt/phP0TijSsRQb5YE3AnrJjfmwWOLTUW3wIkIHa3zpZQBPpAbM2FZVWatSU0PhOOiQINRfRUPrywwhbWICOzxts6MgLKMfInBaW8esLjJRu9kmx/GjWGnwRAnRrsHHaUw8oHuGVAuEICPo5DSu3UDcb89lf2vRdKWzzlegyFh752ktluwDGMyxZc3lM1uCl+E+tXLWtpKblIk4E6accHd1QUXbH3ripIurbhVmu10ZsdgRQyzhz6JEpHtgrWsYIxfKxKcXhreh1VU0Qp+S9WD66oB4ssxWklpuQZUehe14E6UNrDjLG/19dhv38boy/n71+AJ51rzEPZNwGmgs28W2WgjQH7qb5TvZoApvpohJi7AK5ed5nRcqJR8M83arh+J+TFmGETrDSK+6G13oHXlqa0L1UL7xnGcxwglEibddJE7GeACKRTEQo5p77wPloBwyi5m//hOwNpej4tXRkWLMDp65OQeUphKfgalCH1u5l3arloSSSLr+AjHwmaUD+gUpTCAv4RDBNlpNB/p8N2eHFNkFV752rKiK9N2yAGTe/s5n1cyv7s2i38n7pTPAeX6MTYuCw/TK25qVke0I6a/JgmLZGb+gxMFnq7+VU0rmxHIBnV6yOdBlc8mvoTokimKWlODrAE=
X-MS-TrafficTypeDiagnostic: MN2PR14MB3440:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nA5t/Jtdjxr+b0WA32AgrDKlFYPiHr1wR3fw4bh5qiW4NOuyPTD3nLSglfm0NGKKs+7sKub7dPwcTmWPzdxS4NYH4FcKh30bLUCH+C2t9B6gbp3DYAu/lRshV7R+DRktmvNdpyf1rtI42s5IB4ilLzQ9cBS+ewvM4DoG+CPgkTcNcnzyi61rYH6ZM5CrE5tlv5B65fUSUQPPlV6BlgU4EwLgSXrssZxFrvfBt/zkv4Qzpm6nxhz54V0ZYMW5/7WHMzygP5cnFFZgMqjm6APQebewugDtxI345QfwNdIYQ3wFH8xjO2sFjR+OgX3yM4lDyMs2ejxD5vnKZr3GD7vu9qqaMrvm+mfJ0my96U+Rx7jvgIaVcqvqPf8uZ9UWaNYy+rDLEPKp4d0qJYiRwYtbJznmPmemeYsslmRguSMMzAH5irU0hoDivmvUBvJG6dNIVccoheO6qSKJTXxAfUA12wFd5wafTxQT4ICk22bn+3mLx1WVvUAibD/4ItyHlQy++7CLOLGNSYaVaAETqBrNmMoTjZV7Q/bB7JG2X0TmMe1fvXR8e/L8dilOzuJu2E3BrlYVIA0dIbJ2RgdVTcLeBfWSulpCaCx2QyY3ga4dENa3g+D8r47mQEaBQH0HECrp
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WIIavDwdvaJzrCPI/FLxXt9CcXs12bmnaTuXPinkHsR0ANAEuhBWULt+GDsg?=
 =?us-ascii?Q?W65hoDQLIZIkfuctZRYDIHF9Nw3lwj6jMApK0m7r45nXqngrHeEyVKbsxKfq?=
 =?us-ascii?Q?6GaAXDX8o4Q4BcEP8N157KemD7hKEI9gKvGZMHSk4McZEzDRJGVWFCRpsOr6?=
 =?us-ascii?Q?NKH02r0WhMHgr8jOIRXKhZgFVjx2J6sIYTxKLFaHew509j+wG2ff9hPBYiSx?=
 =?us-ascii?Q?W2kyheEU3peVp1+O+XWbh0DSPJAhtarjT2lXm+xWlhqAdJ8yRH5dhXX7G7nK?=
 =?us-ascii?Q?P7QberF/F6HGE3fFRZcleObSTa73h/5MFx15aKhRNmSweurdhMNJCC/E517W?=
 =?us-ascii?Q?+vSI/yipFLcuJNv3dtjOl0SzGzx+8r06/SeCJZUO1iQS6ITsoo8FCaXCjyaZ?=
 =?us-ascii?Q?RG6kkbIg/Oje82PwcI0vJwBDvl7E47ovOaDTlBXhW5tyXVctV9cVu5QB855y?=
 =?us-ascii?Q?DlmgGHnqNZUCQvuSd6WiU15meWdUzqapboLYVpEMKqEQR1OgAz/gE6XkKv5C?=
 =?us-ascii?Q?yTbPfDO+M0Qe2AyT/11cAbBMcHL0tiSvCQzA6ZA6v8UmpjgB6JIyGhamcvLm?=
 =?us-ascii?Q?4BZoNKReHWCa4vM9PS9w8P8B2ey439tY3ifQZVlYrn49nXurcDEr5vKNgkUX?=
 =?us-ascii?Q?TD6kT1t9JWN7peLWZP7OV0574btxr9XBsJdMqCQfFyLdt7WL6HC5gLwwjCNO?=
 =?us-ascii?Q?8YKrVFGnHQA6JlDqG34/cL/0vYsJ5W+10t0F7dTgNxVS9MrLK9B8DVqD6Iss?=
 =?us-ascii?Q?0jZYMczGoC0MvtlAIreXtpGTRE15aAb5DZiztMmFaNer/sD6ozZA7Jy+9Obo?=
 =?us-ascii?Q?40TlA/U4GAN/iZTNCrWraMo+KtdussnWyp9QnU6JlfrqrFtkLDBEo8p8lirw?=
 =?us-ascii?Q?lUkKHVujJAR4blR9NQ7xGYrqZIEs1JiXe8s92LAaAUTVIlgzR7M1sKNA+xCi?=
 =?us-ascii?Q?lSjvBB5MvGlpWlpqizJKeiLqAjEqe08ix6/zu8CHpmnGMGp0ZNFJdVbzsGTc?=
 =?us-ascii?Q?XB7mOWKXDhYr0PzETdoeeJeBFVDYW32+5ZSSRWf1lwpeo2bbXz3Ot1uyp+WM?=
 =?us-ascii?Q?ttneqzugS5tf/Agncrqp0Fj/E8OazQ5DRQZsyug/3iOyvbTWFZoMJ/0KIeKQ?=
 =?us-ascii?Q?zr6iOYOcK80udOHZzd8K1hoCQOlHcd2KLL67MUHbeeGTbkyrwciRt3gyDX/7?=
 =?us-ascii?Q?Q5mQ4K1tNVvtIT7Uyt1fDtAOjX/tDTEHKd+6mgoQj9L1liXO31lCF1pJywAY?=
 =?us-ascii?Q?s+fzlg2BJkWwjhEO7vknYmSBuR5V5U5P214r8hYpz+ClEzrftaPqVISS7Jld?=
 =?us-ascii?Q?BQxlMgzw1Xt9EeLFBorikNkfIQXef5F9Ge2LpBJXIZE1zvccpA4xaCZgoJb5?=
 =?us-ascii?Q?sIR2qJU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9adef641-56f2-4dd2-4db8-08da697c56a3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR14MB5594.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 11:46:37.9263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR14MB3440
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Celeste Liu <coelacanthus@outlook.com>
---
 contrib/rerere-train.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/rerere-train.sh b/contrib/rerere-train.sh
index 26b724c8c6..bd01e430ef 100755
--- a/contrib/rerere-train.sh
+++ b/contrib/rerere-train.sh
@@ -75,7 +75,7 @@ do
 		continue
 	fi
 	git checkout -q "$parent1^0"
-	if git merge $other_parents >/dev/null 2>&1
+	if git merge --no-gpg-sign $other_parents >/dev/null 2>&1
 	then
 		# Cleanly merges
 		continue
-- 
2.37.1

