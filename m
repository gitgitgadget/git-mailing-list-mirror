Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD183C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 13:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237941AbiGSNwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 09:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbiGSNvp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 09:51:45 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2109.outbound.protection.outlook.com [40.92.19.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3927F53C
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 06:04:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqMCLrRMHZrDuvxTAMe9GJF9j31whoyVdOUgskVErAg6hvUKKdHic0m/bocU1JA2yE/5BXOXajnlv66ASWK5cqL7uCIsVMzsHSniwVZp42vtVtS39jcnxh5rJCCLTBQdBhOVttQ/r7JvEbv1hTbXeGvdG0wuDFNmibSnxXJNPDGVS+kdd1oPBiyoxOBcIgl6MMd9GD5rn5pG7lHpw0vFh2WBDc+7AB6EpmEEP8uVg9wpdoLTkDWxncIMOHaXyvs75VSO/oysbVR34glr57gpWDGec3q9kTYzEb8JKCWLtxnrNLmv7t56lZKzuMV6v17xV803jHc/+5ZguZQxhu2H2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8icxPxOv0M0EFM6ce6nrOE8tJgJwlBBR2E1EJ9HeLUw=;
 b=JmBkap1LVUUX1znzO4d87jMkpSeQrdJ3NEEHaUT2nJTrw7J6mBUOLeTBMrhnYGrRYBnGVSn8qQAIhm55lwzum3sEuoX+q+fe7mhzLjq5ANVAUm/yBrCDyc0YrexQXbEuQVGtXYNPbHSBF41kkDL3a60YJ4l3j34zceE35QUtmtcc1NIpo1OF9oa4oFQ/O3PysV1BFpS+KyOnlfIvCdPRbmYysdKlxafQih9erf4VFNKqZNkQ5EZjNjr11eUI0KxDudP/P7z8m+rAo6MbmccECfgghWKXBrikeAiTd9S+mHmaMp3JVP8/E4r1x7O+pDvPXe8lRg2Chr4CesULgZxqkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8icxPxOv0M0EFM6ce6nrOE8tJgJwlBBR2E1EJ9HeLUw=;
 b=Jwc2tIBcZa5xHqdungMAVVUgGD5wIfjaaaXUGGoyIzFdaWrvin2/lKx1F/TpoObbq4gu05RJ5Hm1LyEm1XCPJ0HrCOj6TUbYyBYsGrTj5CMYIu6+g0o1zNh8z1ua3K4reravnAknlawDl3PpU06SI5+RllYoppDbO334T3BgpzSgXIk6WuIhjGAasCwJ5cQKysVkgjSRtqHHchg/muzM6+64qXbxYTHfT6/ee5K2av0LcMj3hmEtikYPCrq8BilCanMk0Xo1pR2dGoRDqbmCJVvpcACJo82uzz8aPICZJr6Zr1mrpYqODKD34ck8f881cGSE/Xx8SwEyzM+NwXSlyA==
Received: from PH7PR14MB5594.namprd14.prod.outlook.com (2603:10b6:510:1f6::17)
 by DS0PR14MB5518.namprd14.prod.outlook.com (2603:10b6:8:ce::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.23; Tue, 19 Jul 2022 13:04:07 +0000
Received: from PH7PR14MB5594.namprd14.prod.outlook.com
 ([fe80::9102:6337:5382:5f07]) by PH7PR14MB5594.namprd14.prod.outlook.com
 ([fe80::9102:6337:5382:5f07%9]) with mapi id 15.20.5438.014; Tue, 19 Jul 2022
 13:04:07 +0000
From:   Celeste Liu <coelacanthus@outlook.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Raman Gupta <rocketraman@gmail.com>,
        Celeste Liu <coelacanthus@outlook.com>
Subject: [PATCH v2] contrib/rerere-train: avoid useless gpg sign in training
Date:   Tue, 19 Jul 2022 21:03:58 +0800
Message-ID: <PH7PR14MB5594BE1B100435DCD28C1E45CE8F9@PH7PR14MB5594.namprd14.prod.outlook.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [lnXYc4Jv7F70NBVJ0+uFTKUzUkIJeNJSemav0qWXqnwuyyEM7hOcQemeiARsjyBO]
X-ClientProxiedBy: TYCPR01CA0137.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::13) To PH7PR14MB5594.namprd14.prod.outlook.com
 (2603:10b6:510:1f6::17)
X-Microsoft-Original-Message-ID: <20220719130358.336356-1-coelacanthus@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99bb70c5-d03e-41b1-3041-08da6987296f
X-MS-Exchange-SLBlob-MailProps: S/btQ8cKWiRL6ml4iGf9rtH8u2be02mKpj6E2ieoRWNfOuyCJszh6NzVSBZH0akcovhe430HzQfF9SYqtFzqBjV/z1qBjQQeBc/IV4Pddhxs2ooiaz+ocJxCeGSEkztZVVbHsNSQ84SwTHpHYCkk+3kli0YPDBLMth+z44lLKkJVPuUHh3/6ZvFxhihTPh9WT4vIMnp7GtkzKDmhfzUvI5qudBrBqwCowFJqUc454gkmpdETZE0RaqtyXZufcW6g07yybyN8wiyjClDD6j1e/OJKV2KudL6B6pxyUiuyHvnh5apJQysCuz6aSKeXAsEB7w6rqZeuM7wSoc0UTjQNGKEBNXOnoGGO/S7kqciS+dB5SFyltwXy1IneIacbKe6fG80tPmnw6Yj+4RFXVGGPj+K0YBk6GpCrxuq13PCnWZoW/NZKtazerxsVQWijp8HFgZ9xgofJmGYTWQoIz+KAn+169zP4bOfsYN8RPEFcQtyC31VzYbmVJowHo7ELFghtWBoiNdm7+KAvgd30Q3UWmUlv1/IxlT9U+YF53YX/jlWBByacSiXHRJ8R0Qy2+tSRaX7TaBZiQt9b6OYQEhcpA3oTFKVvqfEdLOTHHkD3bHKuoHvElkwxFEyW9RBkXLazFyCsgDqfCKhpYnyrhuRTL/LON/odz6K/7TEZXJEo8A9IVQMdwT4TAmZ+1Y2AFtgnYHpxsbyR6IGO46lw6aCGkqRTJYICjWFgt+jJvNQUNIwMSAam2f36DRMXmXr7meUIYkAdQRhl19M=
X-MS-TrafficTypeDiagnostic: DS0PR14MB5518:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJ7mrmt9Las5GRAOCw4IDJoFhTxo6nO1dizy2njzJC7+BGOIbRbXoPdlChSZBvO00qmkbmFnBr7uCsT3UgjM8w6LVDTHVmWA55G/dgbXtPdAxRsp5OhP7nYYSYfyJsY32iwSBEL4x3iBbaW29S0yBxUg7qsugRGZW2v+D4jeRRAPXHY0JdF5P3v5YaMDKjG19HabrNlK7ud6MHsXotgjO3+xFGMmffrvAgnP5Z5iEklaG5juBd0NrSchexF3igaucxBSqXnDFCK72RHXGkiPsWCZMnfvSl3/sYNRCoTXvsfaO4o5L0SfnlbXnOJJMcEBWF6meyezgGlbbMDx1bcTsDTnCs/wZxkkLOxhnevrZaB5x4R9AOow7HyrNE8FR6c8J/50hec03nJdkCpCSKP6UphjKtm0cZsZRVV8XO70jvJEJF3QY4yhQISyu12BlGDV50O4ingZoTXp4dNARSZ4gETjS+l1PWYE9F3hUQefznW7IB4sN1KsO9o6qnQaE7VVtRI1kZlwUOvTaxUsV1iU/Km2qSa2KOQFUK/8JTnzaFEbOV2+9fX5vJc0cQbqm6pYckXUgVZbid1OmnKZc8IpL/JMwDn4zGariUhpUxtoq1v6OB+a9v273NgLIBZTfEJ0Va2oUPJ7FqUcD9BhajRXDQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XCnEXpkrlZcQ+7BTQMseXWfAAcD2jvey3zew+rP6oujsOOLI9z4vVgwNPmfL?=
 =?us-ascii?Q?H4hXsBo/Am29kL2inEd36ap6pWAKVRl8+31C8rsFlK3BBqNJAHOm+BKSPcFj?=
 =?us-ascii?Q?O7tYnKIPfLwgGGLinKL79b1uTiOfOD0Uvr30TRD+hyBZibkDAYiPnKHZ70xe?=
 =?us-ascii?Q?nG3+H7+Yldr6QVPRE4RNkQ/4wtpmjkJvhBX6Sg/+JHknyxXruWzx1rM7dCj/?=
 =?us-ascii?Q?D/2D5Xvd+5YMPU5FJSmts2XeyeL5zGHwXlMkGQrPBjyJOqKeOKJYI8MuwNMJ?=
 =?us-ascii?Q?2UZUk21g0ucwGOrmMj7iTuGtPG1j4H+SqQZiSdcPfW5VFe2PnceiEpF06NvT?=
 =?us-ascii?Q?7W0OJKYP+MU8nqTYXtAoYSPYvRmrBp4wlZCi4yic8LppBzLzYh5QSoLFIUIV?=
 =?us-ascii?Q?uG9ezoUu7WtQfTMqVzRBCKmwUL7PlifiNiDBfYPRfMrIjxgNT5D4vjEiCkZT?=
 =?us-ascii?Q?CD0jjcaHHs1JLx4Vs0ALG3IIUd1G44anXF1uRuM5+QZ6rFL+U9UvHqfDeoWq?=
 =?us-ascii?Q?0MS/ZYAtQJ6+Aets7+zPrOSCqbrBcybCLkZssk88esuqhmmPKVKuxmvdkTYe?=
 =?us-ascii?Q?2ANQN18023Tyo3gLu2LzzE61fzIs4IlEVhgkFIzYoxfJEVhpo3heG0VDNa2Z?=
 =?us-ascii?Q?Fl3OQGTq/rLk/j8b8VhBdVd4TfeOdi7GzW7Zdv9XZ2tnTPz3HPhHxQhQeBHZ?=
 =?us-ascii?Q?Iyv4jRB/0dFldrtGbDy3m8Sd2RDMaECDxnO17W1GsvpHIcYrsFBmmS38G8di?=
 =?us-ascii?Q?b7A45rY/QG0wN9FxYwWkiRoCLiRRrx4oRByFF5LGfyKCeTqidc3ux2+bcu3k?=
 =?us-ascii?Q?8bFY0StIbAIDODq56jURC59NIJWAq8+u5PkM17CjWCMXWDBvLuJfRt1RdxPL?=
 =?us-ascii?Q?+DWYlIJofK2+LFZ6uxT612G6SGPB2GTsYU7IysCZ7EEic7FSURJXVAxEJvf3?=
 =?us-ascii?Q?qPLw0/DgC0QUuq3Hmx8hCOVxS+FvmMwlk8k3ny2FF/vhDA671DjSOPgSi+4/?=
 =?us-ascii?Q?t+gf55vqPP9D03l/2MoKmLPlkwUrSZSIhPJAzqLYJUEPtrpjMrJGzSbohzdF?=
 =?us-ascii?Q?6Ltsabx434eGgaAnFB89vh70I93Yy3uwK3gjiphvbbYX3Xtp7Mc0l6DPrRmZ?=
 =?us-ascii?Q?HDSfjGnsicRbUIq0YSlKmvmOV2tAfuYkCMAa5Fz0tffX4oNMUvMF/PuYwEJb?=
 =?us-ascii?Q?fv48tXUnpwlfnlQ5YNcIwXMYPTTvxmvB6VGWgehysyMQ2MQUU1BlTvvKdToh?=
 =?us-ascii?Q?0FIhGVkMJBzx1yVCrr0Z7CNgyKKy+nyKv2vbvSoZMIfTLgWXq6d7dYxTBcfD?=
 =?us-ascii?Q?ypf1WU95qDNciL071Jkm0kwYO8Vt7na8z8stAJ+5WiVEtuCw8OTGMno7X5Kj?=
 =?us-ascii?Q?epZfm5Q=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99bb70c5-d03e-41b1-3041-08da6987296f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR14MB5594.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 13:04:06.9730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR14MB5518
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The rerere-train script now signs all temporary commits,
which is unnecessary and useless.
This commit turns off gpg signing.

Signed-off-by: Celeste Liu <coelacanthus@outlook.com>
---

v2: add problem detail in commit message.

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

