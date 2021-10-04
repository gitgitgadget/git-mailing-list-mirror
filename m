Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A966C41535
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 00:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 818D9610CC
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 00:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhJDAsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 20:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbhJDAsM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 20:48:12 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F99C061783
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 17:46:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d6so27451099wrc.11
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 17:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GWUdVnEpZXSuQnFu/I6N6ig92Hm2queX9QSH/S3rsSY=;
        b=YunObwZ6WPkO5H7tUDvqN4tC1c5FcAfgHp8yOx2XX4b3ul24ukcu9zcX7Azq47QVtg
         S+TrmmQc5i3dgXzMH+/ss7Y0ZmPc0gdQqtYbQf+8rxn7yI5AEQg4S+m1cMF9jWj5aTOy
         JTW9cR+0AuOMKUA9/BN81lFUKS3eyHya8Jthy8WeKhm+oIO5KHsdfPXEb0F+r4vv7s8i
         SX9CERzEP7bKLGqUOy+28+3LSpSH+D8LWyTEW6lMK7HzUCl+yG2h9Xr+FklVBeCD2OJG
         OAIWN58yRxICfUlGv9Q/AcGNmCdeR1gqJ0JAw4sbM7WGaBO6mSt1Lr1UmXbNwxCIFEPf
         UcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GWUdVnEpZXSuQnFu/I6N6ig92Hm2queX9QSH/S3rsSY=;
        b=be3GbMpBd1m6djbJ0bif6HGD+46lB7j69goyMfKpRmL6BNs1j43QOu5xBK6ZA0OtrM
         GN95cytEKlx/ZtvxJUfbmAyXI5+/66BRm53K0Bul/nr/NrjKXuklJ0UQAgd0sCXrl0MH
         Wh/5JWazX5KHuKyjHiyLC42Z7RI2b1Q1YkIBBnB4yjyN0tC0dlwqE0xglLyxrKx88DHW
         OgGTFHUAof6wdcGRs+vpPzXH9LDgTUUvQJXwgxhUTzZlQzsKmSMOKYfcyn9FEoOK747I
         7HxkRYWrIsHWtxmewgHLr+M7AbIFdu28ib1zNW1O2AQ3X/nB+XGnOm0Q8w/WYYkoFawZ
         3Ulg==
X-Gm-Message-State: AOAM530y4yLpZ4e0FUdcb4gQvICfJcU7/TgZaqGHI778gZZDqm7JvKUU
        7NGppUs4r5v/XPY1uLvxaRUqaOEfrGGBBw==
X-Google-Smtp-Source: ABdhPJycnyBbGXFCZmPpv4ofiSadzskf+WfM5TF3aM96K17vLm+3kJwiHK++Brux3QeJu1/N21TRGA==
X-Received: by 2002:adf:8bd2:: with SMTP id w18mr11024820wra.432.1633308380548;
        Sun, 03 Oct 2021 17:46:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7sm13526773wrc.55.2021.10.03.17.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 17:46:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/10] dir.c: get rid of lazy initialization
Date:   Mon,  4 Oct 2021 02:46:07 +0200
Message-Id: <patch-06.10-2b243d91696-20211004T002226Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g83021034c5d
In-Reply-To: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "Lazy initialization" in prep_exclude() left behind by
aceb9429b37 (prep_exclude: remove the artificial PATH_MAX limit,
2014-07-14).

Now that every caller who sets up a "struct dir_struct" is using the
DIR_INIT macro we can rely on it to have done the initialization. As
noted in an analysis of the previous control flow[1] an earlier
passing of of "dir->basebuf.buf" to strncmp() wasn't buggy, as we'd
only reach that code on subsequent invocations of prep_exclude(),
i.e. after this strbuf_init() had been run. But keeping track of that
makes for hard-to-read code. Let's just rely on the initialization
instead.

This does change the behavior of this code in that it won't be
pre-growing the strbuf to a size of PATH_MAX. I think that's OK.

That we were using PATH_MAX at all is just a relic from this being a
fixed buffer from way back in f87f9497486 (git-ls-files: --exclude
mechanism updates., 2005-07-24).

Pre-allocating PATH_MAX was the opposite of an optimization in this
case. I logged all "basebuf.buf" values when running the test suite,
and by far the most common one (around 80%) is "", which we now won't
allocate at all for, and just use the "strbuf_slopbuf".

The second most common one was "a/", followed by other common cases of
short relative paths. So using the default "struct strbuf" growth
pattern is a much better allocation optimization in this case.

1. https://lore.kernel.org/git/87sfxhohsj.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 dir.c | 8 --------
 dir.h | 4 +++-
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/dir.c b/dir.c
index 39fce3bcba7..efc87c2e405 100644
--- a/dir.c
+++ b/dir.c
@@ -1550,14 +1550,6 @@ static void prep_exclude(struct dir_struct *dir,
 	if (dir->pattern)
 		return;
 
-	/*
-	 * Lazy initialization. All call sites currently just
-	 * memset(dir, 0, sizeof(*dir)) before use. Changing all of
-	 * them seems lots of work for little benefit.
-	 */
-	if (!dir->basebuf.buf)
-		strbuf_init(&dir->basebuf, PATH_MAX);
-
 	/* Read from the parent directories and push them down. */
 	current = stk ? stk->baselen : -1;
 	strbuf_setlen(&dir->basebuf, current < 0 ? 0 : current);
diff --git a/dir.h b/dir.h
index ff3b4a7f602..e3757c6099e 100644
--- a/dir.h
+++ b/dir.h
@@ -342,7 +342,9 @@ struct dir_struct {
 	unsigned visited_directories;
 };
 
-#define DIR_INIT { 0 }
+#define DIR_INIT { \
+	.basebuf = STRBUF_INIT, \
+}
 
 struct dirent *readdir_skip_dot_and_dotdot(DIR *dirp);
 
-- 
2.33.0.1404.g83021034c5d

