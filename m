Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC13C207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755705AbcIKKyj (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:54:39 -0400
Received: from mout.gmx.net ([212.227.15.18]:54669 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755470AbcIKKyi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:54:38 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MA91t-1btjdb3lEX-00BN4r; Sun, 11 Sep 2016 12:54:35
 +0200
Date:   Sun, 11 Sep 2016 12:54:19 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 14/25] sequencer: introduce a helper to read files written
 by scripts
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <9787d4599f09e78880ee5328485c1ceb4c375cea.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pkfwj/Cw8H9S6aOVIrERfGQutr6ub+P4uBjgGmVWHiA8dQMCEuc
 ankhZBI8bS3QQlZMORs2nvq9LgEutD/pVOQ6k/uSepCzyaHx7u56HZj2LqGo6ue2NoGjEqR
 cLSwU/wV7F6T48VbGZ+AvSGkuiNQHUSuQuSPNWMHk7oQjdwCyPrcJ2cO2BKpaPXHvOXQfrH
 NA8N8BFv528iR9Ffnoq0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kZFo2NKDHXY=:K1H5fDQ3LKgWV01OhKrKnI
 pKQFRfngHEuzgC1ui+2fzzZ35srOVqn6LyM+U5326v3FOpFGW4C54fsI0hgiDs3EfG1v9HzdM
 Qbsi0dktZEokSAu84hH/5RMPXiAAivyurXi8K5SDMemVIHlr1heZADhQPWMBlhtrlQhis5A4e
 9mCMaYKrZ0redA9OY++2ti/rMOsAO0ZpzPhwCn0QZePg2n59UgO8JbCAcjwon+T4Tk5NrEf+x
 ulCV8tuT3q++eM3HPxrE+2uscpMrsau2CJZztGpdzZNy3pAH2i0HtBzl6fhtIjZrn8HqB5IC+
 WvrQ0FR/S3wNpmrjrilAbB/6hzbk0PqGE0NxyBHUOLA8L6kQMBVV8/GsdirOAUCtDQW6beq1b
 hXZNSkO9PT/imxYgtNr4cHyiuuCiFbL48em6q0myp7xDzHW6XwT+kRrs8cI5rTL7ab8DZnNA/
 07ui7t/R4yOINAUKCsowXxaI23PwSj9L0eDltik9WhE7As1O/CbQ5urMjEGDVfzfwe2vb/EVu
 tOLRNEXpC72G2o6To91d4xOtK+wVZ8EWfgg5t3G6YWxos/nBLJ7XR3EM7Bm9v7ckr7B6Esc80
 z6FnHG9h9n7hFBZS3mHRQqo9UtrrUgo6U9z/0DMY+QkRcNyJD+IkvxmG6CCISMhddtji4upym
 ObU6D88PNgvRIwKUb2/VZMLAvrLzeVYrOubrXpPwm6WhVVO9ztyEctesUjMWw9/odLrJc+M0O
 PCY/I+vyRv+TREF93KxI615X1GpmsHp5eYSubJ6+UeFYulReRHV5pyJOzaW62C5gxO40KNTF6
 k7YEcQr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we are slowly teaching the sequencer to perform the hard work for
the interactive rebase, we need to read files that were written by
shell scripts.

These files typically contain a single line and are invariably ended
by a line feed (and possibly a carriage return before that). Let's use
a helper to read such files and to remove the line ending.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 6c35fe8..086cd0b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -242,6 +242,37 @@ static int write_message(struct strbuf *msgbuf, const char *filename)
 	return 0;
 }
 
+/*
+ * Reads a file that was presumably written by a shell script, i.e.
+ * with an end-of-line marker that needs to be stripped.
+ *
+ * Returns 1 if the file was read, 0 if it could not be read or does not exist.
+ */
+static int read_oneliner(struct strbuf *buf,
+	const char *path, int skip_if_empty)
+{
+	int orig_len = buf->len;
+
+	if (!file_exists(path))
+		return 0;
+
+	if (strbuf_read_file(buf, path, 0) < 0) {
+		warning_errno("could not read '%s'", path);
+		return 0;
+	}
+
+	if (buf->len > orig_len && buf->buf[buf->len - 1] == '\n') {
+		if (--buf->len > orig_len && buf->buf[buf->len - 1] == '\r')
+			--buf->len;
+		buf->buf[buf->len] = '\0';
+	}
+
+	if (skip_if_empty && buf->len == orig_len)
+		return 0;
+
+	return 1;
+}
+
 static struct tree *empty_tree(void)
 {
 	return lookup_tree(EMPTY_TREE_SHA1_BIN);
-- 
2.10.0.windows.1.10.g803177d


