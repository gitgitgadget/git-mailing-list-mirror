Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D17AC20899
	for <e@80x24.org>; Wed, 23 Aug 2017 12:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753996AbdHWMLA (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 08:11:00 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:63928 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753943AbdHWMKy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 08:10:54 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue103
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0MFzpm-1doIOY0q9u-00Ez03; Wed, 23
 Aug 2017 14:10:52 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     hIpPy <hippy2981@gmail.com>
Subject: [PATCH v3 3/4] merge: split write_merge_state in two
Date:   Wed, 23 Aug 2017 14:10:44 +0200
Message-Id: <5e23092c21b834424f7a9bb0a0fc01c0a729293d.1503489842.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.426.g4352aa77a5
In-Reply-To: <xmqq1so34m6d.fsf@gitster.mtv.corp.google.com>
References: <xmqq1so34m6d.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <cover.1503489842.git.git@grubix.eu>
References: <cover.1503489842.git.git@grubix.eu>
X-Provags-ID: V03:K0:tjK6fIz1o2r+TJLRjoBPk4seX1X6h4JdoZxUjxqh2vIgYCVnzLO
 h9dNYjvqP16C/Q4QZXoJrs1FDCk9lxwkBEG8TuO27y8aUcl/oQpGimIRUgnI1r651IDHQLr
 bNBhcWodWc+a6wg5Povo/G8f3fZMp9zP98KX5g8fEZudhquRFb0wCo2Pu0Y2uepxU4L+s0t
 XGqQWhxKR5wd3d9NiNy3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pEboQwI32X4=:1s68Lr2dW0qciVTcJiZL5x
 eDY5cNsCB9Zy5na+LIoKuYGfEUg3Qg87j3ZwyWVHnoUGMklxOygGXWGYej8bPK2qfxORI/ul8
 kVt69ie2KOfTthC2mHC3lcE7AgCFgyBiBBHYNCsXGTAmtn1KF+5+FnayaGnWNCj686/f88bZh
 jLlcRcRT5xtGeHoc+9NJ+SBZlfi6rJrlJaB2dzbOPYSEklYoMyuFEiO8aiauDw83EMo8lM3m1
 PCMvvt63/hBrc/t9dpy/fkG6EquPR5Tft1NkzI1SwHErArdHSzY3JKXQPviVVwGATpjPpVTiq
 ys+JPXK0NubDeaF69suMKNmvT/Q67+HPxlHBIkZt0PZzJLc/DsYwleHeoj8tHzPrlWP1GnEjH
 eBldgSYjTKGSvoYlZYn08W0Lh6kLKQEQBXWKJKYsIKRi4YKxtlEVyA9JmhG9j8TwHaRV8pcXm
 vMsnT/FwhzUxxQHQGAf9VC1FB8yjp0yTOyiORM0R1qh+XlO3+xjT+2gKkZTaI3Q2BU6bUkFNI
 EZHiHXBqusg0OTrBriFVOas04ESZzs3KHzQqq+oUe7l1zWENq05EIOJpZ7aXgZjxi4xawkSGi
 knJKBPDh1wbiYpK5sY0GmDJqeryX97BXqT9HT1sL6HMo/pXCCjs7pJsKWowwldGgOgGz1cN8l
 30iZeHkQWa0ywBTBkxoiUfV9zmzK9Bn30Dsh+MeduceHl0WaVGgMi6iW/lqISG1NteHKGN/PL
 jIXA+ejsI8NJmzPh85VQv08/497MxT9ZFeQN6g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

write_merge_state() writes out the merge heads, mode, and msg. But we
may want to write out heads, mode without the msg. So, split out heads
(+mode) into a separate function write_merge_heads() that is called by
write_merge_state().

No funtional change so far, except when these non-atomic writes are
interrupted: we write heads-mode-msg now when we used to write
heads-msg-mode.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 builtin/merge.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index dafec80fa9..db3335b3bf 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -910,7 +910,7 @@ static int setup_with_upstream(const char ***argv)
 	return i;
 }
 
-static void write_merge_state(struct commit_list *remoteheads)
+static void write_merge_heads(struct commit_list *remoteheads)
 {
 	struct commit_list *j;
 	struct strbuf buf = STRBUF_INIT;
@@ -926,8 +926,6 @@ static void write_merge_state(struct commit_list *remoteheads)
 		strbuf_addf(&buf, "%s\n", oid_to_hex(oid));
 	}
 	write_file_buf(git_path_merge_head(), buf.buf, buf.len);
-	strbuf_addch(&merge_msg, '\n');
-	write_file_buf(git_path_merge_msg(), merge_msg.buf, merge_msg.len);
 
 	strbuf_reset(&buf);
 	if (fast_forward == FF_NO)
@@ -935,6 +933,13 @@ static void write_merge_state(struct commit_list *remoteheads)
 	write_file_buf(git_path_merge_mode(), buf.buf, buf.len);
 }
 
+static void write_merge_state(struct commit_list *remoteheads)
+{
+	write_merge_heads(remoteheads);
+	strbuf_addch(&merge_msg, '\n');
+	write_file_buf(git_path_merge_msg(), merge_msg.buf, merge_msg.len);
+}
+
 static int default_edit_option(void)
 {
 	static const char name[] = "GIT_MERGE_AUTOEDIT";
-- 
2.14.1.426.g4352aa77a5

