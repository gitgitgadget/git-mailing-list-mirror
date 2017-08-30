Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D201420285
	for <e@80x24.org>; Wed, 30 Aug 2017 17:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751945AbdH3R5e (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:57:34 -0400
Received: from mout.web.de ([212.227.17.11]:59989 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751929AbdH3R5c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:57:32 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LvSPv-1dMCls1PdL-010dxV for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:57:31 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 20/34] notes: release strbuf after use in notes_copy_from_stdin()
Date:   Wed, 30 Aug 2017 19:57:30 +0200
Message-Id: <20170830175730.20864-1-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:z9vQU4oP5JBYlxnm9HkJqq+OpJA+VdIo8LHgwOfZcYLBp/jh3DW
 7xvnU/ZzPSGK4vXjNiSuAK9A8BAoAhlxoxKh5B61V03PfeLSi/fKcHTtK8XzQVPyT+CPxvK
 nb+SDMUvCkrAc7gBdW9YJ5+ub54ngYc3EyFUNT3oU2C5ZP/ImP5oAUjBKjNieTiq55fdXVP
 3sn5wyWmKZvqjhYTYiQIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IAIo9jw7Vz4=:XwHapMwaZ1jxGYcA2Gn77s
 O0HoN2odorGxAvYkQcltSkEPblkTHNbGf/Q6IXdgoRfYpfe2MO4orSd5j8ayCcTLYn9umgKTF
 DjUniUsMA2lbTfZVHWL0H1n5j5s5DVb+FXsIIwnCz9wwhKxPqyG4G/u3AT9D9+NmsmbcHb0ps
 pRWqa9UpGW0r8KJYD0i8fn5AMUv3EDoiO+4BNKyCvanEQhu+hChvyQJ2lAtwadJrMaQ4TMqeT
 uOwTwDNY8dHbl7mJMyiKKibtMzyFafK/lj48HFMpLr5IPxvct4F6gBfOoUgmvxrRhX1qUYFIw
 gp/gIyoBTI8W86OZKbGTEbkg3MjNC/XsrPTLxdJ9oIPW32bsYBYUZTtWKA0hJUBHxbpIT7h9G
 f6lkEKd2jVpuvIU3yScYiuXXgehwCZk4Mm4gAuphmZisxTI3I17EZqteoCl4QNkuLyD68LONd
 MmZGCvD7iDoce5v7xaX48oVbv2QmMiy+HfkDqVTVrA/+4bJBYoakJkjCAV4FCcIi8UDC2HJew
 Ku8j/lDvGy2laIFvavv1Cl58XLzBX8NB0q7mFPteidg/1sS+AuO5gp4vg3ECqP2Hldeec9dgk
 p26HwxceS7oqYL/jhVR/nFKiS69uKBiTaoPK3HpwWHGYyTXuwOpnw0KSOIg0gNaOdn8s3IQCU
 CClrjbYRvZA/yvMtskIUFW/RAgyOoTVzO7k2j8L/2uw8cExM0S6M6i/BoS5L9f2lwK2sVfwwH
 sySpV/EaF77qMDPsaXAV4QbsdoSw8zTV21CvLwhcqf2j/iIRfMA7JpNejWuCVqKTWwDdfLq+H
 mBhx/f7SbmXIGwDyCFOJT83Ac6NBw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/notes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/notes.c b/builtin/notes.c
index 4303848e04..8e54f2d146 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -278,56 +278,57 @@ static int parse_reedit_arg(const struct option *opt, const char *arg, int unset
 static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct notes_rewrite_cfg *c = NULL;
 	struct notes_tree *t = NULL;
 	int ret = 0;
 	const char *msg = "Notes added by 'git notes copy'";
 
 	if (rewrite_cmd) {
 		c = init_copy_notes_for_rewrite(rewrite_cmd);
 		if (!c)
 			return 0;
 	} else {
 		init_notes(NULL, NULL, NULL, NOTES_INIT_WRITABLE);
 		t = &default_notes_tree;
 	}
 
 	while (strbuf_getline_lf(&buf, stdin) != EOF) {
 		struct object_id from_obj, to_obj;
 		struct strbuf **split;
 		int err;
 
 		split = strbuf_split(&buf, ' ');
 		if (!split[0] || !split[1])
 			die(_("malformed input line: '%s'."), buf.buf);
 		strbuf_rtrim(split[0]);
 		strbuf_rtrim(split[1]);
 		if (get_oid(split[0]->buf, &from_obj))
 			die(_("failed to resolve '%s' as a valid ref."), split[0]->buf);
 		if (get_oid(split[1]->buf, &to_obj))
 			die(_("failed to resolve '%s' as a valid ref."), split[1]->buf);
 
 		if (rewrite_cmd)
 			err = copy_note_for_rewrite(c, &from_obj, &to_obj);
 		else
 			err = copy_note(t, &from_obj, &to_obj, force,
 					combine_notes_overwrite);
 
 		if (err) {
 			error(_("failed to copy notes from '%s' to '%s'"),
 			      split[0]->buf, split[1]->buf);
 			ret = 1;
 		}
 
 		strbuf_list_free(split);
 	}
 
 	if (!rewrite_cmd) {
 		commit_notes(t, msg);
 		free_notes(t);
 	} else {
 		finish_copy_notes_for_rewrite(c, msg);
 	}
+	strbuf_release(&buf);
 	return ret;
 }
 
-- 
2.14.1

