Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62854C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 22:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ACDD60240
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 22:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhGLWew (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 18:34:52 -0400
Received: from mail-co1nam11on2102.outbound.protection.outlook.com ([40.107.220.102]:11552
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229931AbhGLWev (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 18:34:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1ue+CEVq9JMSr20x8i+tqk6gGJ77KSn/E92b30HuMPJXq8/QRXA7DVCm75tpP26PQ+w1UPkOVY/EHvYBfxAwG8176AhqgnX6oh9X3KhzUKyefzRJDk9R0TPjr7Xu7XTKc6O39sp3VHmvuADwVkxPD1cnIH48fNTKN9an6cZS/n8uGwplU4+pSztRany3fA5eV+dwOZBT/NHJ5f6IXpWieR8HXozRKD6p7DqXQvUhJQOmHqJxqmRymkjmUf9FXBiwQQBOGhoqQGQboA4FdlWrHZzkJblsaMOIlYtfoZ6yeSBUGuQgd+uUMcEHmmj74P5uW7OKoIyy/OHBWQ0LNduDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afz3X26S/Biv+8aunuCtXbg+ToJy4tuQJsoLQ8W9BAE=;
 b=YCLwWfgs3/1gnIu5OquukQy4rhxMfTUJEC0/8mu9z+1ssrwPHCDcNK/GfW6jQCldMUpj3P3hCB/2GWkwMeYPnl18UnTEre4Po4e2dtKsZE7eoPvf8TuR3rKiJ4v84klP1bheZ/z8qKfM5oCCMlvGqQ6Qms0Akask6a+tJ6lajOt+NIO043lR5vlLimCYY+N0wrv+fXB68v2y0K7lCPhM1JBTLJUemTTfumUqvt0kFE5ZTpxCZGQTEiLpe/4yNmryDAdUxerRNl6IwD8x9PG/3W/kg4DtbCgjOmcqPs6mPVyg3nbjdjFgwf7h9tbK+r4HVTohf6SDHVwt7lD61IUReA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nexbridge.ca; dmarc=pass action=none header.from=nexbridge.ca;
 dkim=pass header.d=nexbridge.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nexbridge.onmicrosoft.com; s=selector2-nexbridge-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afz3X26S/Biv+8aunuCtXbg+ToJy4tuQJsoLQ8W9BAE=;
 b=ugfbw+lviDetvIBJXf2PJONf6Eh7PP0PglwV9l81mIlX6JcSDu24p+3YfK1qrypseVOuIUhxiVFoiNWGmgkP1bR1HQGB7I4GurDUuAuGxSWnsVLM+NNxlRyw5UU44D1ynvhEitdvMOoslltR0gkl/o7Tc3XF9PUriNzcoVM1G7Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=nexbridge.ca;
Received: from DM8PR17MB4934.namprd17.prod.outlook.com (2603:10b6:8:3b::24) by
 DM8PR17MB4936.namprd17.prod.outlook.com (2603:10b6:8:37::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.27; Mon, 12 Jul 2021 22:31:59 +0000
Received: from DM8PR17MB4934.namprd17.prod.outlook.com
 ([fe80::7c5c:6e02:71c6:915b]) by DM8PR17MB4934.namprd17.prod.outlook.com
 ([fe80::7c5c:6e02:71c6:915b%7]) with mapi id 15.20.4287.033; Mon, 12 Jul 2021
 22:31:59 +0000
From:   randall.becker@nexbridge.ca
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Patch 1/3] config.c: add conditional include based on worktree.
Date:   Mon, 12 Jul 2021 18:31:37 -0400
Message-Id: <20210712223139.24409-2-randall.becker@nexbridge.ca>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210712223139.24409-1-randall.becker@nexbridge.ca>
References: <20210712223139.24409-1-randall.becker@nexbridge.ca>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:930:8::38) To DM8PR17MB4934.namprd17.prod.outlook.com
 (2603:10b6:8:3b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (173.33.197.34) by CY5PR03CA0023.namprd03.prod.outlook.com (2603:10b6:930:8::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Mon, 12 Jul 2021 22:31:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 332b512f-2940-4c8b-b8b0-08d94584dd17
X-MS-TrafficTypeDiagnostic: DM8PR17MB4936:
X-Microsoft-Antispam-PRVS: <DM8PR17MB4936EC352847807FD201A145F4159@DM8PR17MB4936.namprd17.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MkFIFZEi6l1oBXZtlOkmm2pS5n3sJDCVHvMSqqanSB0f0oUgNDhcdKuTrFVCMY3IQjuQXvSTxJD+yzEYjlkiwAcAr9EMPpzjpixPJ+CTUoMsirKVXG3mPh/NibdZraIT3BqGqgB9a2TE8F7fBcZfVKxxKkLW5w9PXB4QEiMGJiEPYPHgibAB8pdDmwHn4hQL6k+Idt8jP2rsYbq+sr5+xl1HG3zzvwvaP6lUE2fjRWuGk4IVGxaZ+DjtZi/d1ah96ZgosZAaRjXLlkfPOwDm8j5ipfKu+52UlSuxpcfPziIxnNOFgvilIvN/dj0386GbOr+tiFSQ1ONF3IijZUn4N4jZxiX8zwJDlKwVCdJ8oZqQ/VdVckh/OMztlM8XebztlrrDf+rOJpmBdKCcb3rJXSpglUjQrJKPAc2PV4NBE1s/OMu6Bdnx63vljSVb063kjjLaX1zNUggSSytG+CCrRInSfM1peEK2BUfAEgyfTcSHykJGRp0o2CGZ1nPbuCWnZDmpB4vYTAZmiHEbay+/qWEm+RVJhwHuXtb38fY6Abp+nzwUbCeQ/pAFNID4fwQZey3HP8AyG7g/5mBpWZgex9dGMFJGfnfzE81zh51FzRhnw+nPaivc7i9oshzRyQhdYmw2xFWvq2XsS+iTVIj3vNrcnHMoe5jRoRXUoA7j9/EULVp5kgIo7QxXv++K7PqKlCushjheq8n3qFWYiJ2Nfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR17MB4934.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(396003)(366004)(39830400003)(9686003)(66946007)(2906002)(83380400001)(2616005)(86362001)(36756003)(186003)(5660300002)(52116002)(316002)(956004)(8676002)(38100700002)(6512007)(38350700002)(8936002)(6506007)(66556008)(6916009)(1076003)(4326008)(478600001)(26005)(6666004)(66476007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CiQHdQhZzAPubtRhDFXqGILUnJerfYCnVN5rpEqUTXtEXLtn7SvLiG5xi05p?=
 =?us-ascii?Q?Bnqp/OZNLDypq6xL1gIc8CcxYWb4REla6f3lh7OG2hbXUp8Xy6dRSTFP7vLx?=
 =?us-ascii?Q?naDIK8cIctuZZhQgbjMwks68AS3HQ+x+Udn86OdrJKSjEarih7tdRwVnLC/o?=
 =?us-ascii?Q?L0inXoB/WAnKj8paqBB2xV+GSF5yx17+j9ls7BR6yu1uNv20qBUoKw5GhGWt?=
 =?us-ascii?Q?q+IFWqZxfM8ded8GHGOGmbNshK7agX4YWoUwnXVwLbwJ3S8J5DV6HB2yb4Jg?=
 =?us-ascii?Q?gc5E7//mQRVo69n4IqOw69ssbYk0xCS/ihPg2wWE8lBfrH0ZPF5KEmPRJXy6?=
 =?us-ascii?Q?sO6wXw2JX8tqvES66v7tEhxY504i6EwMZrRnS7EE5HWC4siwPgQF/+E5aEK8?=
 =?us-ascii?Q?ygyB8iD1KmMse/d6INXFs8g3F/uYwu18kQC784E9sBzyT0UWXP/2OY5QaLFe?=
 =?us-ascii?Q?7I+YUXlcyVhTfwlnDizeJV6NOdM1lS/Zvgi8S2fNLa1zhpZpqUZl89GFp0KK?=
 =?us-ascii?Q?inxEAdUYzKT4Itr7optuDpTdqCNRbfsE4nSTMMG4cPhRD6TtKZZGhils5Gp2?=
 =?us-ascii?Q?QV+ey/mJv2WrHkOMNCgBrmuAPmymyH//3BTSgWcimZYZmLrl8VCeLy5nOq9Y?=
 =?us-ascii?Q?eb/XjDmHiKPbB7uAVV1oYfe8B+305umge1JFExZ4evha29/ArKlrXpE8PQVZ?=
 =?us-ascii?Q?1IPrO1AIaYCENZ/TcMU/QE7O5lFifYHgDLuDtH/HdZwIaXuV6y40Nf+Bu+h8?=
 =?us-ascii?Q?PWOCAMuEzbjK2rfY1hzkcrgoBFrthkPSss4SoP6AiuyVRUz+TeOzv1b52SsN?=
 =?us-ascii?Q?AjacodqoOwdWpcBYD24PTEM0gu3cgAZ7OH+mbhNLTMY6XapZ44+66Y50fpja?=
 =?us-ascii?Q?mcmQUWTW2RW6xF1nJoAZdrTXN1xiL+ZgOa31PzLiNckTXWcSstQndwQhdal2?=
 =?us-ascii?Q?CghA92VWfpBqiccPPtckHlTKhXdksKmfMFpdqp52xmmAGK2g4D15EngCWyFI?=
 =?us-ascii?Q?FK5zJzSp/YU+HvlAG5zZra41Xfc0vUPHf/d8DYIPsd2pY8mo1NiAmuOYCdCz?=
 =?us-ascii?Q?H/350gJ7RzmSvyBwCcT+5uT0AgIoB6IX1EZnod4VHqVPTZi3C+x9NaF1yX+7?=
 =?us-ascii?Q?b8J7x5VfFJhyiiQeCW698SDsPCqw29vV42PFr+gf8+7eKljC0nb+DHYs31vL?=
 =?us-ascii?Q?j4beFUjWdjyr9Gk5nseOXIfngqt6tFKML6gQ0zvZPx3RDi4/je27KQBnk5/a?=
 =?us-ascii?Q?sneAas63mle2BNJFdNKvKzyDDW/Ut9+SfUAAOsPOet4pBZziDLKxRGAD7KTO?=
 =?us-ascii?Q?Xb9AVMuX/Shkwvcvbic+MEmH?=
X-OriginatorOrg: nexbridge.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 332b512f-2940-4c8b-b8b0-08d94584dd17
X-MS-Exchange-CrossTenant-AuthSource: DM8PR17MB4934.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 22:31:59.8707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d6eda728-7424-4770-8f6a-462632ca4c1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOucd4cpAVAhU3AEn0cBAnF3+yzkQUaETz9kRUeBTCa+HRuS63LSnEjOL9TERkOueini/TpZKiUvLzTEFppPQ57UDngtuz6w3Ft1HEBF3gU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR17MB4936
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

This enhancement extends the [includeIf] semantics to include conditional
inclusion based on whether the conditional is within a specific worktree
or case-insensitive worktree. The [includeIf "worktree:path"] and
[includeIf "worktree/i:path"] and analogous to the gitdir: and gitdir/i:
conditions, respectively.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 config.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/config.c b/config.c
index f9c400ad30..e2b2364579 100644
--- a/config.c
+++ b/config.c
@@ -272,6 +272,64 @@ static int include_by_gitdir(const struct config_options *opts,
 	return ret;
 }
 
+static int include_by_worktree(const struct config_options *opts,
+			       const char *cond, size_t cond_len, int icase)
+{
+	struct strbuf text = STRBUF_INIT;
+	struct strbuf pattern = STRBUF_INIT;
+	int ret = 0, prefix;
+	const char *worktree;
+	int already_tried_absolute = 0;
+
+	if (the_repository->worktree)
+		worktree = the_repository->worktree;
+	else
+		goto done;
+
+	strbuf_realpath(&text, worktree, 1);
+	strbuf_add(&pattern, cond, cond_len);
+	prefix = prepare_include_condition_pattern(&pattern);
+
+again:
+	if (prefix < 0)
+		goto done;
+
+	if (prefix > 0) {
+		/*
+		 * perform literal matching on the prefix part so that
+		 * any wildcard character in it can't create side effects.
+		 */
+		if (text.len < prefix)
+			goto done;
+		if (!icase && strncmp(pattern.buf, text.buf, prefix))
+			goto done;
+		if (icase && strncasecmp(pattern.buf, text.buf, prefix))
+			goto done;
+	}
+
+	ret = !wildmatch(pattern.buf + prefix, text.buf + prefix,
+			 WM_PATHNAME | (icase ? WM_CASEFOLD : 0));
+
+	if (!ret && !already_tried_absolute) {
+		/*
+		 * We've tried e.g. matching worktree:~/work, but if
+		 * ~/work is a symlink to /mnt/storage/work
+		 * strbuf_realpath() will expand it, so the rule won't
+		 * match. Let's match against a
+		 * strbuf_add_absolute_path() version of the path,
+		 * which'll do the right thing
+		 */
+		strbuf_reset(&text);
+		strbuf_add_absolute_path(&text, worktree);
+		already_tried_absolute = 1;
+		goto again;
+	}
+done:
+	strbuf_release(&pattern);
+	strbuf_release(&text);
+	return ret;
+}
+
 static int include_by_branch(const char *cond, size_t cond_len)
 {
 	int flags;
@@ -300,6 +358,11 @@ static int include_condition_is_true(const struct config_options *opts,
 		return include_by_gitdir(opts, cond, cond_len, 0);
 	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
 		return include_by_gitdir(opts, cond, cond_len, 1);
+	else if (skip_prefix_mem(cond, cond_len, "worktree:", &cond, &cond_len))
+		return include_by_worktree(opts, cond, cond_len, 0);
+	else if (skip_prefix_mem(cond, cond_len, "worktree/i:", &cond,
+				 &cond_len))
+		return include_by_worktree(opts, cond, cond_len, 1);
 	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
 		return include_by_branch(cond, cond_len);
 
-- 
2.32.0

