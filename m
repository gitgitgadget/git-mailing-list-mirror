Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D345620285
	for <e@80x24.org>; Wed, 30 Aug 2017 17:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbdH3R6c (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:58:32 -0400
Received: from mout.web.de ([212.227.17.11]:55946 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751610AbdH3R61 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:58:27 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LfRnJ-1dBnRr0xWD-00p0or for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:58:26 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 11/34] diff: release strbuf after use in show_rename_copy()
Date:   Wed, 30 Aug 2017 19:58:10 +0200
Message-Id: <20170830175825.20905-6-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175825.20905-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830175825.20905-1-l.s.r@web.de>
X-Provags-ID: V03:K0:0AA4qAxsY8EsAonB0dDBetLHA3eUz2yFmvX9iOyqrH6GPsxnRQV
 89M1o/jyMsgv8OVlVBv7Kf5sHy+wu9QulIC+HRggLwWwaGlAyzB6t30GYar4sP6/XNIIWEH
 wKjFX3keuFr5TzND562CS3XMI13dDVwduLgUvr71A7SNvMlqaq97EHJQHYBGGdGMs4stm3N
 cEOZW0KsRlqUJA9XxqIXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1hjnA5RydUM=:F6GLgSXNaTMpUtwZjQn/aa
 9I+d6UQh9LQhc73DHsyrg3mgOV4IVzL3WkZZCp5GA+kz8zWWnVa3l5JywZ0twPDbNDnbGG042
 yN78Oz1cBJAH9yHCZ6vEfvPWqnOL91CLUbVtWM9Lrn19xL7fMjjeQbXm06tva8iYCY6W6S8+h
 sqj03TJIQuTEyM3/jwrrg53/apjiccQ3vf/Vzq+NzRRmDTR7JQjoqPgb/KQ6GV+CbM+YIKzz/
 q1IqUjmqKgbJ79czzObbv1cK+L2all5o09wM+Nrp24HWJCnCWnR1YyGMx6qjUADBpGhDE6VO7
 7ZB7XP/BTP9aVjY+Wdbda0rqGiZgn1kQNf/qRLAuX6i2UCQUhh27p+51ANqrt++cOPMW0/i85
 eCykrFlb3yoz9JZg1QDattvNLWIBi91w2wyfRqco09CSCbuR9cWXtWfUO+VpJ09j5jAAjGBDQ
 0UVKlqbPcjE8spq4X6Sjss10kVvs6dbJ1FSAU4bJ+8z2UcQ47roM3vmMuRq2FjV4C5HgmYTni
 4sQavtZNIfnEPS57Du1vuvqreL401wtwp4ifIOfXnj2TnG4R4ad+Rot748Fjo1/FlARnW50X4
 LwGJ1Ra45bGcgvQMrstAa4VqeQGkEDCIGh3VtPC4pUo2bX0ol+lyxPpiJQO1MqPEFS9OV9Y0i
 bOXxpK779gypRcuhyCkFPQwOSem/7UTaPPtcqyf73HdrddFVUOUihscGH8Ekj3E/fTlGnPtu1
 WY7NVYseDPiS2A114xAf8+yNdqSPsuHBWn+7BHNVcGZrfQwiP91X+/pWfFZR3qViB0S3kXz25
 rFZ13R21PpW/m1ZPrOKl5HM6CC1lA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 diff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/diff.c b/diff.c
index 4148ba6980..33c65f492d 100644
--- a/diff.c
+++ b/diff.c
@@ -5281,14 +5281,15 @@ static void show_mode_change(struct diff_options *opt, struct diff_filepair *p,
 static void show_rename_copy(struct diff_options *opt, const char *renamecopy,
 		struct diff_filepair *p)
 {
 	struct strbuf sb = STRBUF_INIT;
 	char *names = pprint_rename(p->one->path, p->two->path);
 	strbuf_addf(&sb, " %s %s (%d%%)\n",
 			renamecopy, names, similarity_index(p));
 	free(names);
 	emit_diff_symbol(opt, DIFF_SYMBOL_SUMMARY,
 				 sb.buf, sb.len, 0);
 	show_mode_change(opt, p, 0);
+	strbuf_release(&sb);
 }
 
 static void diff_summary(struct diff_options *opt, struct diff_filepair *p)
-- 
2.14.1

