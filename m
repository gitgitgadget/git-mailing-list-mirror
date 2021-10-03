Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0B5C433F5
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 11:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58B161AF0
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 11:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhJCL1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 07:27:33 -0400
Received: from mail-eopbgr1410098.outbound.protection.outlook.com ([40.107.141.98]:24288
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230095AbhJCL1c (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 07:27:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4sXGtOTqFRlnZtxqKDhcBPPQGYHNjxs2NHy9gNoY5iLy+2uBEB2InSegD5m459v9BQbaw5+agxgjozVpUpiBXocGseJEUmkVI/sx1YoPw5KnM3deKzejiLXuqyCu7irLJxnWTTrwRkmmNixpt2TYIP7M3nh72PgCbqCtF+gNrdnw02h9Aqw0r8aTapZXEIlyBRgG5fdwN5h2Db/cAk1leQKCoKRQkJ8XqjHbyhcjJyYvwCU1Vd9gJ+HLIGtDl4nuGFqkwQEvJPOyCTm7W+jRWKgzoZ5YznUarTpwgnC4/Ac9JODJmJNm37KkbSgYROH1f9yCLfaP3SQxyKUXIrdEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27yew7evWQN6GCpFvoe5usLEbkglbyV91muh9AL02Ic=;
 b=hK3MDHI45lOpvHNEE4TFPdcLs4tvEEjNIy5/8BiiUHFDDR8nl1pfopTy967Y07Cac9zdBPcqmFY8pCY0iAQcj32vT71J+A/5GuAZZqRbjB6iDVLSvotVt87nMccrVXUZarhxcuBXZ5nZSyB+G9hmM2BkQNLwlryBNrIlTwzJBshqtrsdBXPf+iq5Qan6RbKUVXvtfM9RNsGru0xGpBPj8wRphlgF0H8EJAlUd0g8Eh3w78OaZ4PYghy28lZlrQsB1RQpW25VprAQfkhZb5uQK3TAhhmTZe+9fyPTZsLc+g3rh/dG4WKVBBcEOhkQ8wZB9AHB3FLNIbjCU+K20vlekA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27yew7evWQN6GCpFvoe5usLEbkglbyV91muh9AL02Ic=;
 b=c9IrElWv2dIpw7i5jWRVU8Fswzp5Hqd1R18PYjSzUNeMBAJRmOmz5qs3GMAC47TbcUefbHnADEnz1FWuQg1gES1zZoAy9YdXYhdXbHXKSaKq5pb4CRwAn7iXyy8qduUAXGvpGex6oP94qgBOWAwDhag39CkCxnBeKB+5kEU1KWc=
Authentication-Results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 TYCP286MB0749.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:7b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14; Sun, 3 Oct 2021 11:25:38 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a0fb:234:5045:d4bf]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a0fb:234:5045:d4bf%6]) with mapi id 15.20.4566.022; Sun, 3 Oct 2021
 11:25:38 +0000
Date:   Sun, 3 Oct 2021 19:25:29 +0800
From:   "Hongren (Zenithal) Zheng" <i@zenithal.me>
To:     Junio C Hamano <gitster@pobox.com>, Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] apply: fix delete-then-new patch fail with 3way
Message-ID: <YVmTKWlOFr+IwzzI@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: BYAPR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::39) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
Received: from localhost (2402:f000:6:600b::11) by BYAPR06CA0026.namprd06.prod.outlook.com (2603:10b6:a03:d4::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend Transport; Sun, 3 Oct 2021 11:25:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e519ba2e-557f-4cc4-1a6c-08d98660865d
X-MS-TrafficTypeDiagnostic: TYCP286MB0749:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <TYCP286MB0749E8C0E39E32C1F598B28CBCAD9@TYCP286MB0749.JPNP286.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7gPrNMIvHzraKtw6FRQH3WdrXvAOCEZyqJ2HY+qXc+PVAGl4VqgaZrqsxdntn66Y5/nfEoWNm0QiimrQxllIjBmXplrjhUx2HHkHkaYDmXEqio6BALfrew+Fr+kEb3uq/z9AMCO8pkQiJ5q60vI9oeOObb5E4a7faYxsGHH30jt5/vIJBgOT6ugOVNsSivfASoif4BT0j5xP+NPcqmXXM3tlU1s48nQTuzlaDA/71vLnFJ8/RIrQbOkZ9ArefEQpQKbMkPwKjgzuSILMbbuKkfqBvFQ+eNWCQkpWUkqUMI2xfR+PDxFxVPUzRqwknHXxeyW3PRNFWR6yE9IPZOrFrjcOYyzlMPe2RwsxCkJ1FDcs85E4iKugMSvRmGfBYliIXqGzWqSjB0zDLNh+Tx/Jvf99QXZzEeddZ5Hq4V1ve1HnHY29iC37CcrRI/tru8JJbovb66waAhzPljiXSaL+Pbmye+yTNpw68RX2S0+TEt0sVsnfeoJU33rTuNLlSGjzAHUYQO4ZMLjFHq2k5qvR5HIm+ZZiQUB1AoT44EKMn1tszDYV2xRUQvlbdC34qDfXVKcomoVeLpUAgCCz95DCvIbT7RAOb5caz76otaizHYLNSdhAY8aW2NmQwM1Lo00t872eYXPrwIoFmFYQL0+GJzX1aol7i3ybqQQ9MmWA6JJ3vZGM49RXvC0NmUOMo562Y19v67rb0Il3y+t2TNuSEuQRL0IS9PfNmhbJJm/Fe5dfH9QNSI5owTjc9E3jB05EDPTMbagKwRdcScY0+vk990xuh6bk/9ofzb8sTRU/8X8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(346002)(376002)(366004)(39830400003)(136003)(396003)(6486002)(186003)(8676002)(83380400001)(6496006)(5660300002)(508600001)(966005)(6666004)(4326008)(52116002)(38100700002)(9686003)(8936002)(66476007)(2906002)(66946007)(33716001)(786003)(66556008)(316002)(110136005)(86362001)(49092004)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GhZ3oiAGJGJVKz/D89+JMpH00bm7hsPcq5ULbXJuw+US/qrbQTXgi8NF2Wp6?=
 =?us-ascii?Q?uBk8Q1M7DSyAKaCpFX0pERJSPtI9vpAm1I1U9hjwoYIElaZ9hsZmy+2Yu289?=
 =?us-ascii?Q?mq8E2ZCn6c2GQp4+tp57W15pmKh/dqZjycvMMuAuAJBr8uzCDdigx+hTdpnY?=
 =?us-ascii?Q?aBNaWLVbZm+pmlgAR/PqznKv2FlCgW7GF3FYHWAdoFjWLL0O4SZzz3JWF703?=
 =?us-ascii?Q?j5NY7kiuOIJTHcYfXWPDqvOd/PHDeb6SsPXg6nTZTAa9bgkfrQ792IXjp9uZ?=
 =?us-ascii?Q?3rmKkH/3twgFM45FQh7aA+S/UbXl4ncgV/bdvgHbxspo8NDSzXm/yd7UAVKU?=
 =?us-ascii?Q?giTJSdImqqFtLHtnvBerQ1LZK7bBWrHLVwPn3YFNT9pLKBTo1KmKNcCAyG5i?=
 =?us-ascii?Q?y5xjAFVL+YaMu3pkjIO44ermCVc/CpSLBtg0sDZVsKa+Qdma9zI2hi8niSqQ?=
 =?us-ascii?Q?WJZjI1e9RHFgGN8hEIaU49Mi6aCTk/nkCezJgk3Kl2uRW+DKTb3wzDZzEqck?=
 =?us-ascii?Q?w4Lb6z3Ssz6qj1kYI63E5hq9NJ3lrbz8WYdhDsdszc+8I9bJnP190wP2mD++?=
 =?us-ascii?Q?u8st5lHXCf4ZIU/V4GW9jRJdT857JlYET5lvZn3eTem1/Eiyzk6A1OBx8Z1G?=
 =?us-ascii?Q?VkRsvwEC/DDKMCs/QYlsSz7eNbGdPtG5rXDmkLdghCs10grDcP0xK+9pFedr?=
 =?us-ascii?Q?OqwMK/Vg+So6DT/jPHF+iqdxlTGEKMN2r+dafU1um9fWRUJEu/dH4Ei6mCfu?=
 =?us-ascii?Q?VFWUJToTTt52DWuLjshNK9rPUuBt617oYX6VY45MfIcICp0bLAYf7sdtU+y3?=
 =?us-ascii?Q?Dok+NB+VBWbp/Cbk8Q3J9wDZp8LYFFrLBO0h8NXJYHJhjC8d7MBV2oUQzoFE?=
 =?us-ascii?Q?AnPuE9J+/IFZxcOoTqpXzdxsEOk+XvvF+jy6PsP6B6vfpUC8ixbdeAglPNvK?=
 =?us-ascii?Q?sYP2GFTTxNzXfZdg/u2T1LBQlSSQxgu2mqlNjs/mQ+RuAQEDN1njgLYt1YLl?=
 =?us-ascii?Q?VID1XyA6fCSRCwwuaoOLsjcYrdrzeuLYrwvR+arkn/YShmkd2iAeqKpKOAy3?=
 =?us-ascii?Q?vWNWbma2PWPTD3OljRwV7cbS9vH6wp7HJxQcFd2MJF8swM5CxQah3P6703oz?=
 =?us-ascii?Q?Upfy3cHBznWFQBLyr7iWiLwYJbt5AXnr/IA+kF/VXBdCHIZ+PPiXhhC751BL?=
 =?us-ascii?Q?5GN6EO94wpb5XtvDHmHmpfOCXubf3sJ/7d9Beg8Lbf4m5i0ko4pl1gmlwJeC?=
 =?us-ascii?Q?Ezagkv67Weq9H8WayEBt/pPOF1tOttFoJSLq+C1R6zeVkGxc+ZB85+aRFqEm?=
 =?us-ascii?Q?KpjZh7yOoWQHs+fKt5CjVPzhQTCryIQnuPatsm+JaayeYw=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: e519ba2e-557f-4cc4-1a6c-08d98660865d
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2021 11:25:37.9713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: levD4EbTINFd8Am9EKccXC2NsI+0/Yu+LhQoernUUje9WA8jCCAwTvNTQusWAO+i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB0749
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For one single patch FILE containing both deletion and creation
of the same file, applying with three way would fail, which should not.

When git-apply processes one single patch FILE, patches inside it
would be applied before write_out_results(), thus it may occur
that one file being deleted but it is still in the index when
applying a new patch, in this case, try_threeway() would find
an old file thus causing merge conflict.

To avoid this, git-apply should fall back to directly apply
when it turns out to be such cases.

Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
---
 apply.c                   | 13 ++++++++++++-
 t/t4108-apply-threeway.sh | 20 ++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

More notes below:

This patch is a bugfix hence it is based on branch `maint`.

This bug is caused by a behavior change since 2.32 where
git apply --3way would try 3-way first before directly apply.

Interestingly, if the deletion patch and the addition patch are in
two patch files, applying with three way would go on cleanly.

As indicated in commit msg, if these two patches are in different
patch files, write_out_results() would be called twice, unlike when
they are in the same file, write_out_results() would be called altogether
after all patches being applied.

One way to fix this is to check for this kind of conditions, which
is presented in this patch.

A side note though, this kind of checks and fixes already exist
as indicated by variable ok_if_exists in function check_patch().
See the comment around this variable for more info.

This kind of fixes is really dark magic.

Another way, which I do not adopt because it requires major refactor
but it is more clean and understandable, is to change the way
write_out_resultes() is called, namely instead of calling it
after all patches being applied in one patch FILE, after each patch
being applied, we write_out_result immediately thus deleting one file
would immediately delete the file from the index.

The man page of `patch` says: If the patch file contains more than
one patch, patch tries to apply each of them as if they came
from separate patch files. So I think this way is more standardized.

However, as also indicated by comments around variable
ok_if_exists in function check_patch(), consequtive patches in one
file have special meanings as endowed by diff.c::run_diff()

I do not know how to handle this, so I just send it as notes.

More comment: this problem or this kind of fix may be related to 
https://lore.kernel.org/git/YR1OszUm08BMAE1N@host1.jankratochvil.net/

diff --git a/apply.c b/apply.c
index 44bc31d6eb5b42d4077eff458246cde376cb6785..3fa96fcc781bdc27f66a35442f27972a0e84ea77 100644
--- a/apply.c
+++ b/apply.c
@@ -3558,8 +3558,19 @@ static int try_threeway(struct apply_state *state,
 	char *img;
 	struct image tmp_image;
 
-	/* No point falling back to 3-way merge in these cases */
+	/*
+	 * No point using 3-way merge in these cases
+	 *
+	 * For patch->is_new, if new_name does not exist in the index,
+	 * we can directly apply; if new_name exists,
+	 * according to ok_if_exists in check_patch(),
+	 * there are cases where new_name gets deleted in previous patches
+	 * BUT still exists in index, in this case, we can directly apply.
+	 */
 	if (patch->is_delete ||
+	      (patch->is_new &&
+	       (index_name_pos(state->repo->index, patch->new_name, strlen(patch->new_name)) < 0 ||
+		was_deleted(in_fn_table(state, patch->new_name)))) ||
 	    S_ISGITLINK(patch->old_mode) || S_ISGITLINK(patch->new_mode))
 		return -1;
 
diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index 65147efdea9a00e30d156e6f4d5d72a3987f230d..14bbb393430ed57a236d25aa568a0fdc6d221a6d 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -230,4 +230,24 @@ test_expect_success 'apply with --3way --cached and conflicts' '
 	test_cmp expect.diff actual.diff
 '
 
+test_expect_success 'apply delete then new patch with 3way' '
+	git reset --hard main &&
+	test_write_lines 1 > delnew &&
+	git add delnew &&
+	git commit -m "delnew" &&
+	cat >delete-then-new.patch <<-\EOF &&
+	--- a/delnew
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-1
+	--- /dev/null
+	+++ b/delnew
+	@@ -0,0 +1 @@
+	+2
+	EOF
+
+	# Apply must succeed.
+	git apply --3way delete-then-new.patch
+'
+
 test_done
-- 
2.32.0

