Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18E7620285
	for <e@80x24.org>; Wed, 30 Aug 2017 18:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbdH3SUW (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 14:20:22 -0400
Received: from mout.web.de ([212.227.15.14]:65209 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752098AbdH3SUU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 14:20:20 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MEVU9-1dkhop2nV3-00Fl23 for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 20:20:18 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 34/34] wt-status: release strbuf after use in wt_longstatus_print_tracking()
Date:   Wed, 30 Aug 2017 20:20:18 +0200
Message-Id: <20170830182018.21390-1-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:tqLOrzm1SyBe7mbNi4sTwBWJ+yURLxzwhgHSnGkhg0Gnsktr7Q5
 v9ADgzE+QchVFDXfCuou338kMDRrn52cEidbmOllyllc/rDDtUmZw64JlPk1k4rYDG7X8TW
 yUC2IBm90Fh0Va32tU/NtvBYJYhpYjvm7KWFn16ibjMnzZ5rENO5vbtl0uNkQQxyE393yRo
 hcu4HOC2Gzbo4FSsM0rBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Oc2szsVQ1BQ=:ei6M33KNeFTca5rKO5jTwO
 6MFtXqfpIvsp/jw6jGLTm+T0Bp7Oo9WawAHvGCfkAKdH2qR51fOb0wP974jq4O1v3kvEB5zsa
 MkIcacG2KkGQL1y2v+GGluqd22N+dTLW3y88jYmJvVoqdgJvntdfgvoRAUr5520QhB6PYkoU0
 aVa4OTO23Km5cZIOVePXNYiQatPmjW+Ib1s+d/YUizPoAInMEymJHD8CPGcNWvRLNruilLTSm
 kqSC6PfaK50gAlg5uWhYevibsBrD9xVDTGNp0dLGBc6m3bzDhabkC9IIFH33nmEM9GLXptdaW
 RpBqnZJ9x1hugc4qMluKGYVG6mmRoxTWJklLa6ZhJT3I8QTmNWvLzIbpdxpw5griPKFBncWnl
 NWt1z5O9nvEMLd5pZSHzDGKPbBAGzOTmx8VafRvb+ozBX3gd9Tf/YXtzyxkBboG252y7FLLnv
 vkcxWJoOiCbjeRUMfY0BTkJ1RC9T48QCSWaxr1Ls8l5stAIk/SxHeZTvEanFij1pOOlOptuKs
 yLATyI/BBoV2Di1nhM6Ba/WC8m2NQUZO76b8JJINo31Qmjyj9sL0iD/eTw79UeE36WCBH3d1J
 1jR9rKCSg/k06kXhR9fat7pufLGko+jtqh95qLr3DY9Mud+f3VPiB6pW3Pr+MpBYGlgvaRJti
 Ncs5Rb9DXv2yDCiHc9/ZqF7oxfqjq0UQtgTTOIkKhRYhYZOqY9a/FN/kZ+hOgA5Zp7cbe1Q3p
 1qnuAburbNAIWtAl7BvI+kXps4w5OA/7NzInnOV2pbzm7aQAZgEbIwTh+AlM5hDTg+gtPE87b
 sV5j6xIoiTT6hQtks7ocrkSPQQcUA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If format_tracking_info() returns 0 only if it didn't touch its strbuf
parameter, so it's OK to exit early in that case.  Clean up sb in the
other case.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 wt-status.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/wt-status.c b/wt-status.c
index cafafb5ecd..ac972acbab 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -998,34 +998,35 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 static void wt_longstatus_print_tracking(struct wt_status *s)
 {
 	struct strbuf sb = STRBUF_INIT;
 	const char *cp, *ep, *branch_name;
 	struct branch *branch;
 	char comment_line_string[3];
 	int i;
 
 	assert(s->branch && !s->is_initial);
 	if (!skip_prefix(s->branch, "refs/heads/", &branch_name))
 		return;
 	branch = branch_get(branch_name);
 	if (!format_tracking_info(branch, &sb))
 		return;
 
 	i = 0;
 	if (s->display_comment_prefix) {
 		comment_line_string[i++] = comment_line_char;
 		comment_line_string[i++] = ' ';
 	}
 	comment_line_string[i] = '\0';
 
 	for (cp = sb.buf; (ep = strchr(cp, '\n')) != NULL; cp = ep + 1)
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s),
 				 "%s%.*s", comment_line_string,
 				 (int)(ep - cp), cp);
 	if (s->display_comment_prefix)
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "%c",
 				 comment_line_char);
 	else
 		fputs("\n", s->fp);
+	strbuf_release(&sb);
 }
 
 static int has_unmerged(struct wt_status *s)
-- 
2.14.1

