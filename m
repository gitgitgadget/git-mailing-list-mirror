Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A402C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C81610E5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbhJ0IIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:08:48 -0400
Received: from mail-ve1eur01hn2244.outbound.protection.outlook.com ([52.100.7.244]:31484
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239150AbhJ0IIr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 04:08:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVid0QZ0cIk7GefOEUF9gSOP2rlnn2U+N5rq+bNG/kBYBWRsXY8pbib/I6KA8Q4SkiDbnnsw6L2z6Lv8NZbCPU7BNwW6wswOuEzFd4qUNNv153v9/3CBNfORoxLVsUCmPQKECaX7dBEFHEwCLd5jIbSeqjJi8/mOw1sDzgxvj3wahORNFq0TbQARpjgn8TY81Se+6M0odZe/RLi0L16EVtRRNjeSMiLzBS937PFC5dLqFjLSNH0McFN8gy1N3xp/fmkI6FBbZZl5iODxo0Vq+q1S9K3mbhZNp9kbIN+NyZ/N9+DZ7dYnuo4cJVz0oC0tvCkpi7+aYkdRpPwEAdTdew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9w/WM8vXUvBA0xdK5pzeG8DhS9as02TitdPOdQYk6o=;
 b=IT+D2ksYfaus5dJpVdjtTm/YDZjktQ3QB6IRZsCNdFhbpN7NGPB77sXnNGVg/FO0YRGC16i+IjBKMEnzV0IbfCJOi+hm+1QVv17BgBKY92z+2FE1d6xDeCH7TrOdD84Hut1lB1C5A+H023k/wuC5fkgqoi9Rt5xeDJtPZp1plSqhopOhoWe5KQjCpsLpMR++JTqVoiXU/a1vs4eqvEdAacFq891kcjlLyD0qw6UC7+RbekluuGdpKfrrpiS7lOZPOd7Ha7lZLPLeSowE9FfO1rVmXYBOfpvzGIohO9lDFKYk1POywwaDV1lWkCRbxNwZKO4zmL28NAMMocWqI3COcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9w/WM8vXUvBA0xdK5pzeG8DhS9as02TitdPOdQYk6o=;
 b=deaHHNxI+4xhkfoUNJv6rzjYOz4FJM5wUdKtwnWSjRUqx1XHWeDrfAth+NxE+JceENrl23StJ6r/iyVdkE/hdbIQlqVt5U8LndUAvOdCLiXHiHi0BE36jtCnbPz2DV11askq8vMf5JZgu6bD54KyDhSlV1rk6kjX6d8SMRZ40YQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4158.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 08:06:21 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 08:06:21 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/6] ssh signing: add key lifetime test prereqs
Date:   Wed, 27 Oct 2021 10:06:12 +0200
Message-Id: <20211027080616.619956-3-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027080616.619956-1-fs@gigacodes.de>
References: <20211027080616.619956-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR0502CA0071.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::48) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM6PR0502CA0071.eurprd05.prod.outlook.com (2603:10a6:20b:56::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 08:06:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c2d10fe-59cd-4d5b-403a-08d99920a963
X-MS-TrafficTypeDiagnostic: PR3PR10MB4158:
X-Microsoft-Antispam-PRVS: <PR3PR10MB4158083D7ED0A1F410017028B6859@PR3PR10MB4158.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jg7/k7uOFOOTF1ZhE9IQTMKTtwGkL5OnFgpiVoJiwyTUOYA1rrp4nzQa78rI?=
 =?us-ascii?Q?wt0eEMiHuA9lCydS3S9O1rJr9/p9NOt3wOKo8d43rG/QAxdeDw1iQ4541mg4?=
 =?us-ascii?Q?wAwVqZl253p1OgSpdhP052GSwuetOISN4YBp04va8pAZZH4EN2kVIrj+zfjv?=
 =?us-ascii?Q?Q6rxkgpfUhgIyaNrLT6xC5Fm/a8DOwC/ghuz9tC5qTcWRz5hxp/XJVR6iSXu?=
 =?us-ascii?Q?C/eX+D8uBZ49PJ3Kj6gdHwo1Ompp6Z0gIKKMKMd0QcmQpNlkkUnUm3UieEuM?=
 =?us-ascii?Q?wnXUiq77Tz2dgQ9Fs8N5qYuBG8ZS/hiTNKulB5YKEyYZqCAiCfStFqhknUgT?=
 =?us-ascii?Q?VqCZqk1GcZGseydL60KNJyZr7qkrIWhsExNVhRLLHEdanYWWBiFmHEl/4CfQ?=
 =?us-ascii?Q?YAEnTi4ufg9c1CFT1IvZ8cvOVEHyRtXMJGPdY7uQUPqyHA86VBzgcuETGyFk?=
 =?us-ascii?Q?xNAS38P8OdGuR7ELu+dN67i3pl+L6OWzS3AoNkaaoTPUbFEcHe7/3Nd2MHzz?=
 =?us-ascii?Q?T3fFYiSoYY9Omak2bhSbgR25hubzMapNqJsLpqdRSigUHIJAlSpD6qGJg49y?=
 =?us-ascii?Q?IU3tqHbWPs/urS8N2YNcBZCptAoc9ZRmgi8XuTDsNtXrNFeLtcR/fbjW+mEO?=
 =?us-ascii?Q?K8voQci7P1q7c0m+lHj0S9B7VydfVTpnajEw4D2WO4K0jhZQkXkLl8s0CX3G?=
 =?us-ascii?Q?rHLu8h+M4m73Vh1wRBHeNOlGstnlPLqHg+eU7xNnaNGxAqDii+HwaxnvULSd?=
 =?us-ascii?Q?CM61fjpTJXSH64tlZfcQ8tWEi4on/OzcrUTruTF8Dt4QPjoczjM3de6GcDos?=
 =?us-ascii?Q?Xb+HLukFRNuwNClLl2Q9KQZCvDEvI7CNFZZ0aCTr6BIIXspqJc7tJL/oOKjL?=
 =?us-ascii?Q?us17vq18FjvJKmZ+MwWtUCKBYVjf4yTzDrLyLwTxNkE2kD8TW1zl43HwGiKd?=
 =?us-ascii?Q?k4MoXZOUopWsh5ZBQQgnGOb6upg+A2FGmtV8+h5qNR9nsunh6xCirYr5Gojd?=
 =?us-ascii?Q?FKgeYyQGWZHHi7foNAbVSR/3Tg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(366004)(396003)(39840400004)(376002)(136003)(346002)(66476007)(66946007)(2616005)(52116002)(6496006)(66556008)(186003)(8676002)(8936002)(316002)(6486002)(4326008)(38100700002)(1076003)(54906003)(6916009)(36756003)(508600001)(2906002)(83380400001)(6666004)(5660300002)(86362001)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vq2ERYxa/dV3ZMCdQ1hXeHHL4mCoyZVRucJ4OdA9Oxc5ZVT+hEDXdY+SIPE5?=
 =?us-ascii?Q?Cr+VThRCqGLuNNkGo6m8FPLqHeqNKU72L6ycfpxuQWRrvpFHtAZnMoa+fayI?=
 =?us-ascii?Q?crJP9lWOjAdiR68cTg4GCIEq9QWF/2T9KiqMSVFtmnBQhpWd/CLgO7AXSSFE?=
 =?us-ascii?Q?RklA1ODUbQHe7T7bL3uiY6lo0/YxEYN+uqSRM5FGqrRl+az6XLFGXH09aXyu?=
 =?us-ascii?Q?/mVPr/oh3NPfVcgqmUWdKrGaDjnwz6JxBVoPHkbW+9Cj+rT2RCWoqqdjvrw/?=
 =?us-ascii?Q?ODd071paDezwdEeuvYt8BO5IDYihM0Jb1CMRzXngRg8hQ5sQuSCI3RKaYAMX?=
 =?us-ascii?Q?1gR1w2CM7B8c+twJAG8bQtchiKs3jWT7EiFf1aJgmW0L0oYeWFX5auJiZG3t?=
 =?us-ascii?Q?G2LFB4/QeQHilnJETaycq5mK9UQGekKvmxKczdaxVFFmA3p7jqbiyXEpUCHR?=
 =?us-ascii?Q?K8dm6Nb0C+TPYHjC/4FsC9lwJFMtk6njycb0hmFZpucmwSydC/ZJYxh5nE6q?=
 =?us-ascii?Q?v5mDYptRfGovP11cOhKduN3LI8Fqb7l61rDVWb4mkq8jQcM9ONeyelqnfbPf?=
 =?us-ascii?Q?VbZwB5CltwyFz85+bugopLegz6JkaAzvhQMVp0pJaC98BEl4k4XDNm8u5YYd?=
 =?us-ascii?Q?1TFulnPwnd1osCl7YLC9YTYQAhy/2vQyuxfEfoZ3qtysV4g0wBqg2eJpsMWw?=
 =?us-ascii?Q?tIl/MWvd7Vmjyv5/VUMmZKYC4b9KsZnAg6TNgEEdu+6btOxeYyd4t8Bk6Tu0?=
 =?us-ascii?Q?Rdun3L/WgMugOEBXpJF52TzNe9+55jtaTyPbKy8Hk6sskoWBbSVbR3kW3BTw?=
 =?us-ascii?Q?OhrHDb8iUlWczEgk52JlXnmkKQ1W2xkhFWXbIByxdPOfNElQh8S/j/P80oQh?=
 =?us-ascii?Q?814h1006oiNUhhPGz0pPSO5yG7Pfb5F7SSuGvG0YNQz3F2bUhbWqxYj0HqD9?=
 =?us-ascii?Q?V8bjeFcxi5G2Gx7ePywWSzMj2afzmQb+3gFBRqTlAVrvXqyF2ZDfuV9ntBZr?=
 =?us-ascii?Q?ul19VMel0bKSSx7f93jT7nNCfxGkXcLKE65EIOfr87mo2sKIRLxaJsFI64S4?=
 =?us-ascii?Q?l4CkodkHLfhZOvrRUA0hz3pt4i6TRHdDmFLqg5CJiUVCOPL7zftOWgOvKsmE?=
 =?us-ascii?Q?lrOMa70x0DXztKMK98d/gwce7cuKtDJ0jgfqFMr2d9QkjqqDqJ4RAMlVh+3Z?=
 =?us-ascii?Q?DmvFQ6AD+MrBhYWAAxuK+hgGFD56fbk1+f53LwC48/9Ss3Wkkj2uu9+etOWK?=
 =?us-ascii?Q?Cs7BKggONoz+0AlWLzGmORqvmtAwq6bJWSoRJpJVQ5xQnp3pDcFNb3o1PK27?=
 =?us-ascii?Q?Emf1IFT6e6sDiRSTnAjmlPE4pNrrpGUk9HJruLxAD8V4t0XPVhp7/5jp8DcH?=
 =?us-ascii?Q?lSDP7/hd3iZUYvCMfqKMXGSCqa/Ikfx4wtyY1K0DH3WaVfvYY5AU4uCtyNHG?=
 =?us-ascii?Q?tCBuM1XIvIdveON8oQ9HCoGD/8dtW0crWFcE09kQbStSKYOBt+tun7viKQpG?=
 =?us-ascii?Q?YyhJjbf2p1qC7k88EeUPtzPj7lJ2ubolQ1rFhpqULfPK/+/X1FRlO/WjMiMa?=
 =?us-ascii?Q?6SKxZDd3tg6nGtUFAe7I5x5gRSujiN23/FN61fk0oV5tD3xl8+xZMkqTSaPw?=
 =?us-ascii?Q?xUDHT/1cQ4DimY5QFV9xjAXw6yxJfvAEPJTCL0Lxa3+2MLvvcbpkPUFzFavD?=
 =?us-ascii?Q?8kIKwIlpQ6qHJ17wLcNiZFtHnAmSQiUr67rejWYHY9zwvMYe7efplkN8Ziyz?=
 =?us-ascii?Q?dgemysjvpg=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2d10fe-59cd-4d5b-403a-08d99920a963
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 08:06:21.1165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xp7FAsgIGR3SOjgYvBdqQmsySTBnTepg4nWWgjdBIi/hDskydNa49MjX8DBLPCYRZReKpOq0VKCmuAFAk4vUFzetUtTGFsYafJJRUQAj8uQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4158
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

if ssh-keygen supports -Overify-time, add test keys marked as expired,
not yet valid and valid both within the test_tick timeframe and outside of it.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/lib-gpg.sh | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index f99ef3e859..139e7a45ea 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -90,6 +90,10 @@ test_lazy_prereq RFC1991 '
 GPGSSH_KEY_PRIMARY="${GNUPGHOME}/ed25519_ssh_signing_key"
 GPGSSH_KEY_SECONDARY="${GNUPGHOME}/rsa_2048_ssh_signing_key"
 GPGSSH_KEY_UNTRUSTED="${GNUPGHOME}/untrusted_ssh_signing_key"
+GPGSSH_KEY_EXPIRED="${GNUPGHOME}/expired_ssh_signing_key"
+GPGSSH_KEY_NOTYETVALID="${GNUPGHOME}/notyetvalid_ssh_signing_key"
+GPGSSH_KEY_TIMEBOXEDVALID="${GNUPGHOME}/timeboxed_valid_ssh_signing_key"
+GPGSSH_KEY_TIMEBOXEDINVALID="${GNUPGHOME}/timeboxed_invalid_ssh_signing_key"
 GPGSSH_KEY_WITH_PASSPHRASE="${GNUPGHOME}/protected_ssh_signing_key"
 GPGSSH_KEY_PASSPHRASE="super_secret"
 GPGSSH_ALLOWED_SIGNERS="${GNUPGHOME}/ssh.all_valid.allowedSignersFile"
@@ -112,7 +116,20 @@ test_lazy_prereq GPGSSH '
 	echo "\"principal with number 2\" $(cat "${GPGSSH_KEY_SECONDARY}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
 	ssh-keygen -t ed25519 -N "${GPGSSH_KEY_PASSPHRASE}" -C "git ed25519 encrypted key" -f "${GPGSSH_KEY_WITH_PASSPHRASE}" >/dev/null &&
 	echo "\"principal with number 3\" $(cat "${GPGSSH_KEY_WITH_PASSPHRASE}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
-	ssh-keygen -t ed25519 -N "" -f "${GPGSSH_KEY_UNTRUSTED}" >/dev/null
+	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_UNTRUSTED}" >/dev/null
+'
+
+test_lazy_prereq GPGSSH_VERIFYTIME '
+	# Check if ssh-keygen has a verify-time option by passing an invalid date to it
+	ssh-keygen -Overify-time=INVALID -Y check-novalidate -s doesnotmatter 2>&1 | grep -q -F "Invalid \"verify-time\"" &&
+	ssh-keygen -t ed25519 -N "" -C "timeboxed valid key" -f "${GPGSSH_KEY_TIMEBOXEDVALID}" >/dev/null &&
+	echo "\"timeboxed valid key\" valid-after=\"20050407000000\",valid-before=\"200504100000\" $(cat "${GPGSSH_KEY_TIMEBOXEDVALID}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
+	ssh-keygen -t ed25519 -N "" -C "timeboxed invalid key" -f "${GPGSSH_KEY_TIMEBOXEDINVALID}" >/dev/null &&
+	echo "\"timeboxed invalid key\" valid-after=\"20050401000000\",valid-before=\"20050402000000\" $(cat "${GPGSSH_KEY_TIMEBOXEDINVALID}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
+	ssh-keygen -t ed25519 -N "" -C "expired key" -f "${GPGSSH_KEY_EXPIRED}" >/dev/null &&
+	echo "\"principal with expired key\" valid-before=\"20000101000000\" $(cat "${GPGSSH_KEY_EXPIRED}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
+	ssh-keygen -t ed25519 -N "" -C "not yet valid key" -f "${GPGSSH_KEY_NOTYETVALID}" >/dev/null &&
+	echo "\"principal with not yet valid key\" valid-after=\"29990101000000\" $(cat "${GPGSSH_KEY_NOTYETVALID}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}"
 '
 
 sanitize_pgp() {
-- 
2.31.1

