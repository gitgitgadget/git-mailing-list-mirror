Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37A8C4332D
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 13:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1E4F2255F
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 13:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbhAKNPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 08:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731858AbhAKNPl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 08:15:41 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76131C061795
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 05:15:00 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g185so15041309wmf.3
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 05:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m7Glqoq6rnZ9d8+KJhUB+YL4NSbzqGzOvKThTCTXe88=;
        b=ZjOyIYBlEGPaAtpvCOl+1O7hOLr4U7HhpQgiybfqyWizUbURDA+xA/m5DaP6aI9GT1
         uJTfRmZv8fy5hUNaHvD1cE6ddOYbCs5mO5B/OtWC5J/RJsENgMC8jcG4COqbfnGqyudN
         al8UIq3YjHhe+VKlAiufj6DiyZexxTKn+mKhCxniKUAWOoAmvzPAjQ8kjVM6Dhk1sTUp
         9pRnCHllfYbXKw4o1WUKM4WF0NYZyBYs2BlIxeaAkU/K3gb7tNFHAsuJcYRRd/kfuyG0
         HlQ6ImHzA6Z+4X2gxiTggqy+qPmGM/yKtZVUJfepmexy2ohAuI/moQXlD9rwO73neVjU
         R1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m7Glqoq6rnZ9d8+KJhUB+YL4NSbzqGzOvKThTCTXe88=;
        b=qHHuUR2/1IFxOEzA0BFdKMIR26zG7G+Lsg2OFuedzQFcWOgaXP7C6Ysqh3tTV16O0k
         39K4g0UPqUmLghqoQs297Oa9wYWYHTmX5xpu3dk830flQEkeMPLE1VoJ13MbU+P4atFJ
         mf46tocI6snzYw/GTNHFScnTmqPB3X4ouNkLiuVnnhKteLcg9U3/SYJFl70q5DBesRR6
         kWRr0bWdgsJPNNagNsmhkcK8k3ykI8mt980j+53cl8kMRXMbLogG1+//RpMkN3V7j8cL
         5vZ5sYAt3/KQOERPT5rt+SGapqFQHh1RkzrtjLwT0pStLDDsKmDSv5bdMQ0KmX1EFTyA
         VGsw==
X-Gm-Message-State: AOAM533JJeAVhftnEfqPsMZPNKRqOvxkN+w2OFPvXauvHmN//o4mlxM/
        Vdlk+OsDHqRNkXNSpphe37hIyDmzzhUpxQ==
X-Google-Smtp-Source: ABdhPJynD4sT6q38BYG+nRo6RqJ1ZKk4tbZSo11LoVoepBi89JK8/LErGLaWnH7wwizHf5+xzG01/w==
X-Received: by 2002:a1c:c2d4:: with SMTP id s203mr14594059wmf.58.1610370898814;
        Mon, 11 Jan 2021 05:14:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q73sm22924450wme.44.2021.01.11.05.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 05:14:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] gettext.c: remove/reword a mostly-useless comment
Date:   Mon, 11 Jan 2021 14:14:51 +0100
Message-Id: <20210111131451.7084-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <87pn2b6eyb.fsf@evledraar.gmail.com>
References: <87pn2b6eyb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mostly remove the comment I added 5e9637c6297 (i18n: add
infrastructure for translating Git with gettext, 2011-11-18). Since
then we had a fix in 9c0495d23e6 (gettext.c: detect the vsnprintf bug
at runtime, 2013-12-01) so we're not running with the "set back to C
locale" hack on any modern system.

So having more than 1/4 of the file taken up by a digression about a
glibc bug that mostly doesn't happen to anyone anymore is just a
needless distraction. Shorten the comment to make a brief mention of
the bug, and where to find more info by looking at the git history for
this now-removed comment.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 gettext.c | 94 +++++++++----------------------------------------------
 1 file changed, 15 insertions(+), 79 deletions(-)

diff --git a/gettext.c b/gettext.c
index 35d2c1218db..1b564216d03 100644
--- a/gettext.c
+++ b/gettext.c
@@ -87,88 +87,24 @@ static int test_vsnprintf(const char *fmt, ...)
 
 static void init_gettext_charset(const char *domain)
 {
-	/*
-	   This trick arranges for messages to be emitted in the user's
-	   requested encoding, but avoids setting LC_CTYPE from the
-	   environment for the whole program.
-
-	   This primarily done to avoid a bug in vsnprintf in the GNU C
-	   Library [1]. which triggered a "your vsnprintf is broken" error
-	   on Git's own repository when inspecting v0.99.6~1 under a UTF-8
-	   locale.
-
-	   That commit contains a ISO-8859-1 encoded author name, which
-	   the locale aware vsnprintf(3) won't interpolate in the format
-	   argument, due to mismatch between the data encoding and the
-	   locale.
-
-	   Even if it wasn't for that bug we wouldn't want to use LC_CTYPE at
-	   this point, because it'd require auditing all the code that uses C
-	   functions whose semantics are modified by LC_CTYPE.
-
-	   But only setting LC_MESSAGES as we do creates a problem, since
-	   we declare the encoding of our PO files[2] the gettext
-	   implementation will try to recode it to the user's locale, but
-	   without LC_CTYPE it'll emit something like this on 'git init'
-	   under the Icelandic locale:
-
-	       Bj? til t?ma Git lind ? /hlagh/.git/
-
-	   Gettext knows about the encoding of our PO file, but we haven't
-	   told it about the user's encoding, so all the non-US-ASCII
-	   characters get encoded to question marks.
-
-	   But we're in luck! We can set LC_CTYPE from the environment
-	   only while we call nl_langinfo and
-	   bind_textdomain_codeset. That suffices to tell gettext what
-	   encoding it should emit in, so it'll now say:
-
-	       Bjó til tóma Git lind í /hlagh/.git/
-
-	   And the equivalent ISO-8859-1 string will be emitted under a
-	   ISO-8859-1 locale.
-
-	   With this change way we get the advantages of setting LC_CTYPE
-	   (talk to the user in his language/encoding), without the major
-	   drawbacks (changed semantics for C functions we rely on).
-
-	   However foreign functions using other message catalogs that
-	   aren't using our neat trick will still have a problem, e.g. if
-	   we have to call perror(3):
-
-	   #include <stdio.h>
-	   #include <locale.h>
-	   #include <errno.h>
-
-	   int main(void)
-	   {
-		   setlocale(LC_MESSAGES, "");
-		   setlocale(LC_CTYPE, "C");
-		   errno = ENODEV;
-		   perror("test");
-		   return 0;
-	   }
-
-	   Running that will give you a message with question marks:
-
-	   $ LANGUAGE= LANG=de_DE.utf8 ./test
-	   test: Kein passendes Ger?t gefunden
-
-	   The vsnprintf bug has been fixed since glibc 2.17.
-
-	   Then we could simply set LC_CTYPE from the environment, which would
-	   make things like the external perror(3) messages work.
-
-	   See t/t0203-gettext-setlocale-sanity.sh's "gettext.c" tests for
-	   regression tests.
-
-	   1. http://sourceware.org/bugzilla/show_bug.cgi?id=6530
-	   2. E.g. "Content-Type: text/plain; charset=UTF-8\n" in po/is.po
-	*/
 	setlocale(LC_CTYPE, "");
 	charset = locale_charset();
 	bind_textdomain_codeset(domain, charset);
-	/* the string is taken from v0.99.6~1 */
+
+	/*
+	 * Work around an old bug fixed in glibc 2.17 (released on
+	 * 2012-12-24), at the cost of potentially making translated
+	 * messages from external functions like perror() emitted in
+	 * the wrong encoding.
+	 *
+	 * The bug affected e.g. git.git's own 7eb93c89651 ([PATCH]
+	 * Simplify git script, 2005-09-07), which is the origin of
+	 * the "David_K\345gedal" test string.
+	 *
+	 * See a much longer comment added to this file in 5e9637c6297
+	 * (i18n: add infrastructure for translating Git with gettext,
+	 * 2011-11-18) for more details.
+	 */
 	if (test_vsnprintf("%.*s", 13, "David_K\345gedal") < 0)
 		setlocale(LC_CTYPE, "C");
 }
-- 
2.29.2.222.g5d2a92d10f8

