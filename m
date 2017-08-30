Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02C4320285
	for <e@80x24.org>; Wed, 30 Aug 2017 17:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbdH3RuN (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:50:13 -0400
Received: from mout.web.de ([217.72.192.78]:55680 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751747AbdH3RuI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:50:08 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MLxs8-1dsam22IG4-007k33 for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:50:06 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 07/34] commit: release strbuf on error return in commit_tree_extended()
Date:   Wed, 30 Aug 2017 19:49:38 +0200
Message-Id: <20170830175005.20756-8-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:NQrvOG2gRP99+T1FkGiCUwuhJwVx8EK5TSsW/J1itQa57bGTmw+
 OPQOi7kr3baz6Jla1nhjzbVWvbNMKpcvYEBQpGKyIOdBPIjcZ1/hz+FVIsxWf/h1ArJQQRG
 zMSui8w8AMfbAGArzgqoZTcA01B4rqgxTtTQ5NUE5JnBfvhx02RURbSaf3fy0nRkY6Sw86V
 ROLPIHDEJbc25todxE3TQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:REDC5OQJabU=:MaROZPZLGBjTElYeiSSnfh
 1PZk2EprO+evEqdzXVNr3MTA0dfQL47kdirwzn1LDYqateebemx6pytgaGSaSmmInj5R+N/9Y
 AjdJUZXNWkvAW1I2KfsWTwl2u3OHSKMU0E1wGbCWYLym6oLLMV8M8rOjQ+C9CuUz8Chow1hW/
 tRgmsSol/uYn9ulMYFZa5zIPrzdiLqSv8Br/LGSxxaPi5fb1dIxy7jiF6C14MK2BmRyPVUoH6
 Gl/qmPOWsaXd9lflsmRy+qBj9Dia9ZpxEaBhSHYRJNfsmO+OBUjHEF49AUVyLZp7bRpX4ukv6
 5dCL/7JlO0NFSQClLyDCGaZZlLHs8b9z4jl6O4tcE0cMJPQFZMxlqdkri6dMfJzKdd1wVRZIe
 9qTiVkpPJh80MVod8blSsLfmxvplhpBRTBrX7eOvhmyLCKNzt4v35cb8dm/SkrPXAC29P1rGe
 uPnfiYzdUxw+UAFN99yHDNpYE847i3xx39x17JasOvawiiXdIonUDKLUzxQMBmKcNMwtm3UC4
 pKzTdSelL26hk9AQb50dJA34fbGKQYjoKctoEU4C5RRs4WcnlSG0Jr7sPyo2yQoBkgEhKisSk
 n5VW/6SFKWTbniNVO93G0zDLFGnHu4re38vO66eH/AOrikfkxVtdwijaKlzdwI5mG+BIbYo49
 /gCQp/m7NVF6D+WLjlNkn2Xtx/g4Z7zLXLQOazwj9TVq20PylXKsnIfabL65d8/cu4MmeEUIv
 SeV+mGDo4a9n60WmxGtG4cBHh28u+KDiKbvG2HitbJXEl6QgbMSXrOeTubLFC6xirHYhYb4zB
 TLV7+L0mIFtu7o9SDGWq9acMQpQhw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 commit.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 8b28415939..51f969fcbc 100644
--- a/commit.c
+++ b/commit.c
@@ -1514,60 +1514,63 @@ N_("Warning: commit message did not conform to UTF-8.\n"
 int commit_tree_extended(const char *msg, size_t msg_len,
 			 const unsigned char *tree,
 			 struct commit_list *parents, unsigned char *ret,
 			 const char *author, const char *sign_commit,
 			 struct commit_extra_header *extra)
 {
 	int result;
 	int encoding_is_utf8;
 	struct strbuf buffer;
 
 	assert_sha1_type(tree, OBJ_TREE);
 
 	if (memchr(msg, '\0', msg_len))
 		return error("a NUL byte in commit log message not allowed.");
 
 	/* Not having i18n.commitencoding is the same as having utf-8 */
 	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
 
 	strbuf_init(&buffer, 8192); /* should avoid reallocs for the headers */
 	strbuf_addf(&buffer, "tree %s\n", sha1_to_hex(tree));
 
 	/*
 	 * NOTE! This ordering means that the same exact tree merged with a
 	 * different order of parents will be a _different_ changeset even
 	 * if everything else stays the same.
 	 */
 	while (parents) {
 		struct commit *parent = pop_commit(&parents);
 		strbuf_addf(&buffer, "parent %s\n",
 			    oid_to_hex(&parent->object.oid));
 	}
 
 	/* Person/date information */
 	if (!author)
 		author = git_author_info(IDENT_STRICT);
 	strbuf_addf(&buffer, "author %s\n", author);
 	strbuf_addf(&buffer, "committer %s\n", git_committer_info(IDENT_STRICT));
 	if (!encoding_is_utf8)
 		strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);
 
 	while (extra) {
 		add_extra_header(&buffer, extra);
 		extra = extra->next;
 	}
 	strbuf_addch(&buffer, '\n');
 
 	/* And add the comment */
 	strbuf_add(&buffer, msg, msg_len);
 
 	/* And check the encoding */
 	if (encoding_is_utf8 && !verify_utf8(&buffer))
 		fprintf(stderr, _(commit_utf8_warn));
 
-	if (sign_commit && do_sign_commit(&buffer, sign_commit))
-		return -1;
+	if (sign_commit && do_sign_commit(&buffer, sign_commit)) {
+		result = -1;
+		goto out;
+	}
 
 	result = write_sha1_file(buffer.buf, buffer.len, commit_type, ret);
+out:
 	strbuf_release(&buffer);
 	return result;
 }
-- 
2.14.1

