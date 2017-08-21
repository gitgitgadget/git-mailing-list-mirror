Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AA67208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 12:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753445AbdHUMx2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 08:53:28 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:64681 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753021AbdHUMxT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 08:53:19 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue102
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0LsyLK-1dY3rr1zvm-012WJU; Mon, 21
 Aug 2017 14:53:17 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     hIpPy <hippy2981@gmail.com>
Subject: [PATCH v2 2/3] merge: split write_merge_state in two
Date:   Mon, 21 Aug 2017 14:53:15 +0200
Message-Id: <1fa72c32925d98a5ce8c96a2b504b2e4278dcfff.1503319519.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.364.ge466dba5f7
In-Reply-To: <fe681e447791ded6db52ccd84e64e3637c08ffe5.1503309751.git.git@grubix.eu>
References: <fe681e447791ded6db52ccd84e64e3637c08ffe5.1503309751.git.git@grubix.eu>
In-Reply-To: <cover.1503319519.git.git@grubix.eu>
References: <cover.1503319519.git.git@grubix.eu>
X-Provags-ID: V03:K0:Y3axqr+vTnUpoFhjYzFmYu0jM+VygWH/He93BEZDsZSNqVkA+yV
 3MAqoY6Sry14ivVsELiTShjnKSRdKRNDSI3q1DqFS34FjuYbhmoW+xCmKqXWiZpV38DVYSH
 A9XBYtcAWlWPBpnszr0VEBDNaIPy+gLsGV/dPHKYHrzLK7QI/0lJCttFWKQ6+jICGxkVKD+
 t39iH/Z1xFu/Qb5080tHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LCnHq72DTRk=:OvLxdjmsZRLSNSvUTlCfoY
 FNNnPJcWqoSaKKr4Fi4G23CcDO7GH+bOMDa2wJD9ga4pLqHXSQrZLk7JeS/Ixt4qDzXQXEKTW
 QXrUERQnNWS7wzDR4LzrQrembWN8wQjbFANWJYY8RxmaP7dVh3obpqlZbwSkgP6fuJ5Qi01NK
 hx68BIfajJ7JCWuQG/r90qJZRDFBLjylYoZC+7o859d6RZOoBEpqJnhULECKbupGbTJ/O0LoT
 upfKelzZGVM5OmwHddCNvnWaGDfjhMNTQcJ5c7JNylGCn/VAg7wY+z+edbenfprbndL6WkzJP
 zQuD6aWpVYx0bhDT1xDQD6Qg50bTD3VGSCMETs6NaYDsFirLHFqpSpGffWfhiK41P6tiyr0TK
 EWjSgr9BTLYKTs30r7dNmpsfZqoPIdmRIHllSgt8ppGbC6pUXEjCadXrL8Cm03QkxYFwCG3wr
 9GeV9yHaofKU249CfPSUQMVMrgg5GrxWx82tZoUyEcka0WW4GE0Nrdvy0NKmDFSzHHaVRwXdX
 hAOgJ6SGyPBytzeTHWXFOxo+4mSSxwX0HN4P9Vvw1NOzS3pwiWlgAF26oUkby06YrU2xMmmQj
 cHVGfqeB+janIWaG6H2j/ojbPN0iFgDi8rPkVvELm+vR6R2VNnJejB8ED49iPfE4S1ugPK/ty
 QgSXCflue2YWDMtCZn5GVen4P6Gva1Pn5VlUPNmwvBg9dK97VQYQUIf+1w+6E0ekoONrfMT8H
 l/XmGuvH6uQxBYZu5YycN4Kz85EawqxXVXV+IQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

write_merge_state() writes out the merge heads, mode, and msg. But we
may want to write out heads, mode without the msg. So, split out heads
(+mode) into a separate function write_merge_heads() that is called by
write_merge_state().

No funtional change so far.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 builtin/merge.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index cc57052993..86f0adde3b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -908,7 +908,7 @@ static int setup_with_upstream(const char ***argv)
 	return i;
 }
 
-static void write_merge_state(struct commit_list *remoteheads)
+static void write_merge_heads(struct commit_list *remoteheads)
 {
 	struct commit_list *j;
 	struct strbuf buf = STRBUF_INIT;
@@ -924,8 +924,6 @@ static void write_merge_state(struct commit_list *remoteheads)
 		strbuf_addf(&buf, "%s\n", oid_to_hex(oid));
 	}
 	write_file_buf(git_path_merge_head(), buf.buf, buf.len);
-	strbuf_addch(&merge_msg, '\n');
-	write_file_buf(git_path_merge_msg(), merge_msg.buf, merge_msg.len);
 
 	strbuf_reset(&buf);
 	if (fast_forward == FF_NO)
@@ -933,6 +931,13 @@ static void write_merge_state(struct commit_list *remoteheads)
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
2.14.1.364.ge466dba5f7

