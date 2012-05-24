From: David Barr <davidbarr@google.com>
Subject: [PATCH 7/7] vcs-svn: fix clang-analyzer warning
Date: Fri, 25 May 2012 00:04:19 +1000
Message-ID: <1337868259-45626-8-git-send-email-davidbarr@google.com>
References: <1337868259-45626-1-git-send-email-davidbarr@google.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 24 16:05:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXYfn-0004SF-B3
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 16:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379Ab2EXOFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 10:05:44 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50024 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932304Ab2EXOFm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 10:05:42 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so11360466dad.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 07:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=xsfGzHc0T3CccVLTkjnz+7txwuwKVfwRA8iZksBN020=;
        b=X+N5LspDDgSQ8rhzus9vR41fbrfKFiw47lbxEXEi4CK9Kg02kvnU1Y01THh8OgPePp
         latRnrW+dyCclYXqCTUdnTZTnQeEoBfRFI3sp7aXuCrWllWULOdBmMa18FyORNAIptBJ
         oeSkjl7EoJqY/jI0HijEEH06BAkW4RF3kRIW1FIuXS9ndFowUVFrt08B0nqjtEWP6lGt
         gH+ZYQ+cAgd6lb9DoxAMEamWB6F8Cs7XFT5Q+Mcq98VgSCmlLyUgbkDvrorQzsvz3JX8
         kQVrah2A0upzxaFCx+4LxQ3eugpFAndt1CEgG3UuoELf6pN2QLFBl1Tx/fMVLDCQaKJ6
         BJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=xsfGzHc0T3CccVLTkjnz+7txwuwKVfwRA8iZksBN020=;
        b=bsox9BsyC1GGwpP9de++l8EH1PG5qA46jNSQ8kN1o5afxK7+hORbDY5jTofrd+l6pS
         0SQfaJCBJee5IMNAgbZIsq3PEEDirp88zRNR4C++5wg2WcJHKTkUgj45fpALEHzTpgzU
         iF9qDXfHRdkYFzl4x1kBNHdNdxl9rY8y4Zc6o9jwZRbCUFSfwF97+sirG9hS2pWQBte0
         UWJaLEulxaJuakWYvRznyohu3IJ9IOuPQj8IJ78czgGpgHpO3jpqvVnC/sAsEodmYwxf
         9IVFw+xTj4gphIVR9Q7f5co/wbkn8gQOrzKHKauAagposw/xlYV6mdz9Pa3Sf/gNp3WX
         Tk5A==
Received: by 10.68.226.228 with SMTP id rv4mr9993096pbc.167.1337868341842;
        Thu, 24 May 2012 07:05:41 -0700 (PDT)
Received: by 10.68.226.228 with SMTP id rv4mr9993080pbc.167.1337868341758;
        Thu, 24 May 2012 07:05:41 -0700 (PDT)
Received: from localhost.localdomain (c122-107-58-35.blktn5.nsw.optusnet.com.au. [122.107.58.35])
        by mx.google.com with ESMTPS id rv8sm5565332pbc.64.2012.05.24.07.05.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 May 2012 07:05:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2
In-Reply-To: <1337868259-45626-1-git-send-email-davidbarr@google.com>
X-Gm-Message-State: ALoCoQn2G2d4QueY/h35w9MzR68x4nm5uej7Ke+9F1/loOBxmL39GM4LOkgm/hza4wVDwnsRNHVVnXE+1te7lVew5vXP4CxpUckdBvdqLID+MqwOjisDzfoleFEpLNdM/odb38Vaa9qLKIaDVVmBcG6TT3zOkGAN2ymAkW75n4BgH710jlfgifk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198383>

vcs-svn/svndiff.c:278:3: warning: expression result unused [-Wunused-value]
                error("invalid delta: incorrect postimage length");
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from vcs-svn/svndiff.c:6:
vcs-svn/compat-util.h:18:61: note: instantiated from:
#define error(...) (fprintf(stderr, "error: " __VA_ARGS__), -1)
                                                            ^~

Signed-off-by: David Barr <davidbarr@google.com>
---
 vcs-svn/svndiff.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index 7a71833..9cd2ba3 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -258,6 +258,7 @@ static int apply_window_in_core(struct window *ctx)
 static int apply_one_window(struct line_buffer *delta, off_t *delta_len,
 			    struct sliding_view *preimage, FILE *out)
 {
+	int rv = -1;
 	struct window ctx = WINDOW_INIT(preimage);
 	size_t out_len;
 	size_t instructions_len;
@@ -275,16 +276,15 @@ static int apply_one_window(struct line_buffer *delta, off_t *delta_len,
 	if (apply_window_in_core(&ctx))
 		goto error_out;
 	if (ctx.out.len != out_len) {
-		error("invalid delta: incorrect postimage length");
+		rv = error("invalid delta: incorrect postimage length");
 		goto error_out;
 	}
 	if (write_strbuf(&ctx.out, out))
 		goto error_out;
-	window_release(&ctx);
-	return 0;
+	rv = 0;
 error_out:
 	window_release(&ctx);
-	return -1;
+	return rv;
 }
 
 int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
-- 
1.7.10.2
