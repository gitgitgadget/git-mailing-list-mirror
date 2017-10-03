Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A13AE2036B
	for <e@80x24.org>; Tue,  3 Oct 2017 19:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751194AbdJCT4c (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 15:56:32 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34521 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbdJCT4b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 15:56:31 -0400
Received: by mail-wr0-f196.google.com with SMTP id z1so6635325wre.1
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 12:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cfBkp2WOQ/TtyqW5PCwuPG0+G0LdzObMfWQXXFvNLbA=;
        b=c2qz2Pz0l8IRJG75chAohQKWxPCJ0K50ZYuM6eH9xqfsvTN+xH025ljSkQSPQEFACE
         vWB7eLanKEzV06sPyzt7EzR3NGTkQ3wPUHOFGDqQFTHLE18jkB5hMdpibovey5j9HybJ
         F82E2y0Qgk5H2Zg2NiS5ptwlWW4Npw2u2j2rDvQ/Zbf7VlZ9fFJumjZtDssvVAqgruwv
         Nl5yZBPcd5vYwqzl4CeBj5XTv31bmbnLQpDyKq5HH5PjyV1FJR7C8UPCKWJZrYUReheG
         zkKkSy3wp+axSbxfO35lb28FfMZ+WV2QZlpjVfBZSOHJ/tmZLhk02yo763nQWLS7cxjh
         4c+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cfBkp2WOQ/TtyqW5PCwuPG0+G0LdzObMfWQXXFvNLbA=;
        b=JpTtiO62mEDNMXtXr+APdnJEDeUD1wGgwX3ZtU2ksRwF57y6q4lZed4MvUl0bxn0ps
         6ALLdP9gRCH4vnmLLq4L8GPQRHj0E9EL7GgBrHGrjMq6WZot1JOkn+Z1JQNPw9y+pukv
         tiHQD2DhXIPKK0FCOSI9pL782BE7GWXmO+UwyoxgG3jW00YGHPxOcPN/G+UTX4H3LcXR
         OrHKKRF3anh1ox5MN92+J6QvVJnRVijI/+R8JwjOBdjg1ZvOfghO05s/gkPI3sbvKP8r
         E/aWEbEpgNr2GiV0G/lAdgOgym+wddTDC4rxnRIhFuLqCv8zip25sks3S9kiI8/lvA3+
         MVUg==
X-Gm-Message-State: AHPjjUgQHNARPlGjaGoYoKnINsv10iVurAuNWcfQaZ713Bewdw3oT6kn
        UtLanXSg742M3azhMc1fuDhkvqXJ
X-Google-Smtp-Source: AOwi7QAC4Sms/IKAA54PJwohrliObbkRLmvmge4C5v787hPJhlfhzqIUmrpft6jLFVOf4Ytgm0/PqA==
X-Received: by 10.223.199.136 with SMTP id l8mr13820265wrg.121.1507060589874;
        Tue, 03 Oct 2017 12:56:29 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id w18sm11132196wra.61.2017.10.03.12.56.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Oct 2017 12:56:29 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] path.c: fix uninitialized memory access
Date:   Tue,  3 Oct 2017 20:57:11 +0100
Message-Id: <20171003195713.13395-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89
In-Reply-To: <20171003195713.13395-1-t.gummerer@gmail.com>
References: <20171003195713.13395-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In cleanup_path we're passing in a char array, run a memcmp on it, and
run through it without ever checking if something is in the array in the
first place.  This can lead us to access uninitialized memory, for
example in t5541-http-push-smart.sh test 7, when run under valgrind:

==4423== Conditional jump or move depends on uninitialised value(s)
==4423==    at 0x242FA9: cleanup_path (path.c:35)
==4423==    by 0x242FA9: mkpath (path.c:456)
==4423==    by 0x256CC7: refname_match (refs.c:364)
==4423==    by 0x26C181: count_refspec_match (remote.c:1015)
==4423==    by 0x26C181: match_explicit_lhs (remote.c:1126)
==4423==    by 0x26C181: check_push_refs (remote.c:1409)
==4423==    by 0x2ABB4D: transport_push (transport.c:870)
==4423==    by 0x186703: push_with_options (push.c:332)
==4423==    by 0x18746D: do_push (push.c:409)
==4423==    by 0x18746D: cmd_push (push.c:566)
==4423==    by 0x1183E0: run_builtin (git.c:352)
==4423==    by 0x11973E: handle_builtin (git.c:539)
==4423==    by 0x11973E: run_argv (git.c:593)
==4423==    by 0x11973E: main (git.c:698)
==4423==  Uninitialised value was created by a heap allocation
==4423==    at 0x4C2CD8F: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==4423==    by 0x4C2F195: realloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==4423==    by 0x2C196B: xrealloc (wrapper.c:137)
==4423==    by 0x29A30B: strbuf_grow (strbuf.c:66)
==4423==    by 0x29A30B: strbuf_vaddf (strbuf.c:277)
==4423==    by 0x242F9F: mkpath (path.c:454)
==4423==    by 0x256CC7: refname_match (refs.c:364)
==4423==    by 0x26C181: count_refspec_match (remote.c:1015)
==4423==    by 0x26C181: match_explicit_lhs (remote.c:1126)
==4423==    by 0x26C181: check_push_refs (remote.c:1409)
==4423==    by 0x2ABB4D: transport_push (transport.c:870)
==4423==    by 0x186703: push_with_options (push.c:332)
==4423==    by 0x18746D: do_push (push.c:409)
==4423==    by 0x18746D: cmd_push (push.c:566)
==4423==    by 0x1183E0: run_builtin (git.c:352)
==4423==    by 0x11973E: handle_builtin (git.c:539)
==4423==    by 0x11973E: run_argv (git.c:593)
==4423==    by 0x11973E: main (git.c:698)
==4423==

Avoid this by checking passing in the length of the string in the char
array, and checking that we never run over it.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 path.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/path.c b/path.c
index b533ec938d..12f41ee877 100644
--- a/path.c
+++ b/path.c
@@ -34,20 +34,21 @@ static struct strbuf *get_pathname(void)
 	return sb;
 }
 
-static char *cleanup_path(char *path)
+static char *cleanup_path(char *path, int len)
 {
 	/* Clean it up */
-	if (!memcmp(path, "./", 2)) {
-		path += 2;
-		while (*path == '/')
-			path++;
+	int skip = 0;
+	if (len >= 2 && !memcmp(path, "./", 2)) {
+		skip += 2;
+		while (skip < len && *(path + skip) == '/')
+			skip++;
 	}
-	return path;
+	return path + skip;
 }
 
 static void strbuf_cleanup_path(struct strbuf *sb)
 {
-	char *path = cleanup_path(sb->buf);
+	char *path = cleanup_path(sb->buf, sb->len);
 	if (path > sb->buf)
 		strbuf_remove(sb, 0, path - sb->buf);
 }
@@ -64,7 +65,7 @@ char *mksnpath(char *buf, size_t n, const char *fmt, ...)
 		strlcpy(buf, bad_path, n);
 		return buf;
 	}
-	return cleanup_path(buf);
+	return cleanup_path(buf, n);
 }
 
 static int dir_prefix(const char *buf, const char *dir)
@@ -494,7 +495,7 @@ const char *mkpath(const char *fmt, ...)
 	va_start(args, fmt);
 	strbuf_vaddf(pathname, fmt, args);
 	va_end(args);
-	return cleanup_path(pathname->buf);
+	return cleanup_path(pathname->buf, pathname->len);
 }
 
 const char *worktree_git_path(const struct worktree *wt, const char *fmt, ...)
-- 
2.14.1.480.gb18f417b89

