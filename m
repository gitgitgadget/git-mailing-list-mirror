Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88A17208DB
	for <e@80x24.org>; Wed, 30 Aug 2017 17:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbdH3Rue (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:50:34 -0400
Received: from mout.web.de ([212.227.17.12]:51730 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752001AbdH3RuI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:50:08 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MAMli-1dfv403kdO-00Ba3P for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:50:06 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 10/34] diff: release strbuf after use in diff_summary()
Date:   Wed, 30 Aug 2017 19:49:41 +0200
Message-Id: <20170830175005.20756-11-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:u8o69mYyc+G/1V7r67LqO/4PomRnssYeGmF8sogJi4FLoog3+PJ
 WgdHI5kvLqB2ckZOrv5wRVqYqT88jY0YN4F5kNzOJJi445tqu6e+b+k2dv0yvKPdNxCySVF
 H//i7OmPoXsZNVcnS7NfhQM/apvWu2ScXbNKVM9YXkmwpPvBffNx5n8tgt8Vl7UklKcgkVd
 LgsY90Qs4j2YS0rC9Du/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ABpJd+sNGgE=:yqeGX3A+ulQf2PnJ86Zls/
 J4b9yWMYJHrbi0uY7l3LhhZjb0isTBbrXYXQpjprm8zxvPVi70WdYQXaDOZK5w2dNCosJgxkD
 D+WH4XK0UuwokkAoki6ZlO0gQfc0PVVu10qGkgpA0XEKj1jY+ymKuMGHeNLJiM6SdiLEntZ8v
 sYPOz6T8knQj0LE7UYsM78PbFZRGstOZrnJWMdkptnvfadQzAdDvAFXR//yvZQJaZ8hntULFC
 ib+k4csg5I7t4fY6etU4cV79jrxNGwrI5N2fJmsoZ4NJ/yo6X8XYMEL/oIBIwDlJMl2rvtJGx
 yLYnmxv4xB20H/PN4TpvuLq8DOYKTYYG3wwqZc4KapVZdkx+SLlbKGYHbYzNR+wa8196tTupJ
 WKbqyu7k6tKgGq/KNgXODUAlLzr3zMF9CopZJ6xhtEArHahvMAndU5hRzxeZq/Z7g1tRHLBEj
 scC43hExzL1ooj2KEBQ4jDQWIQZz99DBxh8A29IRq5WsA3EhaSpBFGvNzDOiV8IVezRykdRem
 qqFglX7YfhE4XvgYBMTtsf5lgslrn15STmWnXbADoIrQCJk7z4EIMNrwwnaeaU7YSyiObWt76
 5wPfsCEx3qMxIkJoNcaSWKifoWfCzNI9lgD9xLHmfoYeDj1jPoSJOeX33hydir2q4Jbxe7Rin
 1XHDVvptVUG3eipLsZmBey5ttapBzQuPPoRGww+Tu+uJq+bK0gIQQzfG2iE3J05qFpapPaZxK
 +C8HIJHUdMZopNrZEGJvnX+wfQZ/0yAHhXzs544+y2HZhOWHN2Q0QnDH0lK4EUUzX54D82BEV
 SIXgfUL+45cPfBUKomEsC/jcmnJwA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 diff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/diff.c b/diff.c
index 3d3e553a98..4148ba6980 100644
--- a/diff.c
+++ b/diff.c
@@ -5294,28 +5294,29 @@ static void show_rename_copy(struct diff_options *opt, const char *renamecopy,
 static void diff_summary(struct diff_options *opt, struct diff_filepair *p)
 {
 	switch(p->status) {
 	case DIFF_STATUS_DELETED:
 		show_file_mode_name(opt, "delete", p->one);
 		break;
 	case DIFF_STATUS_ADDED:
 		show_file_mode_name(opt, "create", p->two);
 		break;
 	case DIFF_STATUS_COPIED:
 		show_rename_copy(opt, "copy", p);
 		break;
 	case DIFF_STATUS_RENAMED:
 		show_rename_copy(opt, "rename", p);
 		break;
 	default:
 		if (p->score) {
 			struct strbuf sb = STRBUF_INIT;
 			strbuf_addstr(&sb, " rewrite ");
 			quote_c_style(p->two->path, &sb, NULL, 0);
 			strbuf_addf(&sb, " (%d%%)\n", similarity_index(p));
 			emit_diff_symbol(opt, DIFF_SYMBOL_SUMMARY,
 					 sb.buf, sb.len, 0);
+			strbuf_release(&sb);
 		}
 		show_mode_change(opt, p, !p->score);
 		break;
 	}
 }
-- 
2.14.1

