Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A902EC433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 14:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359233AbiBDOHd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 09:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359146AbiBDOH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 09:07:29 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F76C06174E
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 06:07:26 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l123-20020a1c2581000000b0037b9d960079so717445wml.0
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 06:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rS82AN9ggQ95EQjBaDTqYqAilpHhg81vKe10JKsB6rM=;
        b=LbCy9WgM5teHioWDQw4Lz01BEBH1ge8NQeRyacqekQgq6dNUGAKToFATzBS8VM68sR
         mUorH2Grof1P+53M/v9T9uG3zrL1LZqOPgiC/QuUdUy0D4PYZegcrDPQsJW6JfhrRy3k
         IujtTClkoaWJD7Ve5+y1tsW0y5gXwv4IC6kEl1CKJ2fc6Jp8l/QqWLbueu+hMHGPWT0z
         VPGgVpnh2Nh2fAqkPWgopPZiItc2NvZUs4Ni9YhVCbBppGQXNcmHSrO1fAOSH/JuL35A
         Ns0ycOFc8wAtu7YMiB8DfYOHOkOmyx+R+xZGn8wvDnh4kpf9UPmggJZxK7sD9AokBpWc
         KC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rS82AN9ggQ95EQjBaDTqYqAilpHhg81vKe10JKsB6rM=;
        b=wb9wS3v2Z90PzMiVOfc//FFx6ZyIXUwNf2U9KJTACEK21vKOBnCvG7rUSB2nKoT8tp
         DqwlUQpynmYKm6ZiJviw6iyKM+82utsrbyhFF+NxBysBLLRg1NUnZtzSpl/h1IOiLIWM
         nOn5SZGubxBKk18w6R+m2ZSm5w8zS6g/edMlxufHzXfu6MmGrHWoUGjJsljpAEOi9WQK
         Q07+BJDXMY3W6WHyo8Sx1ZPQMZqrLzoAC1W6QWYIeADbFL81YJvxGyhzNaaAXVb43uPS
         jLY35syPSYsOnCDEZLMfbXBblSZYVtagPEjp5fKBsMW2FzdmQg6Jb9VzqVnSLoPP2wvl
         gpow==
X-Gm-Message-State: AOAM530t8Nzx8sHwHHnxYEIuuHNZws372kJweXgzgjzpgdNTTF+FrTMH
        7q6L3H/iwy1Aoac+eb6Fgw03FtTHEYqLBw==
X-Google-Smtp-Source: ABdhPJynvei8zzEhd90bmpn5SJa/P5VSoKh+py0qpLVPTEW451CaM9X5dd1ExLxdKQgsv/eFkPGNVg==
X-Received: by 2002:a7b:c933:: with SMTP id h19mr2403395wml.114.1643983644861;
        Fri, 04 Feb 2022 06:07:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u19sm618722wmm.0.2022.02.04.06.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 06:07:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 5/6] core doc: modernize core.bigFileThreshold documentation
Date:   Fri,  4 Feb 2022 15:07:11 +0100
Message-Id: <patch-v10-5.6-4550f3a2745-20220204T135538Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v10-0.6-00000000000-20220204T135538Z-avarab@gmail.com>
References: <20220120112114.47618-1-chiyutianyi@gmail.com> <cover-v10-0.6-00000000000-20220204T135538Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The core.bigFileThreshold documentation has been largely unchanged
since 5eef828bc03 (fast-import: Stream very large blobs directly to
pack, 2010-02-01).

But since then this setting has been expanded to affect a lot more
than that description indicated. Most notably in how "git diff" treats
them, see 6bf3b813486 (diff --stat: mark any file larger than
core.bigfilethreshold binary, 2014-08-16).

In addition to that, numerous commands and APIs make use of a
streaming mode for files above this threshold.

So let's attempt to summarize 12 years of changes in behavior, which
can be seen with:

    git log --oneline -Gbig_file_thre 5eef828bc03.. -- '*.c'

To do that turn this into a bullet-point list. The summary Han Xin
produced in [1] helped a lot, but is a bit too detailed for
documentation aimed at users. Let's instead summarize how
user-observable behavior differs, and generally describe how we tend
to stream these files in various commands.

1. https://lore.kernel.org/git/20220120112114.47618-5-chiyutianyi@gmail.com/

Helped-by: Han Xin <chiyutianyi@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/core.txt | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a1..b6a12218665 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -412,17 +412,32 @@ You probably do not need to adjust this value.
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
 core.bigFileThreshold::
-	Files larger than this size are stored deflated, without
-	attempting delta compression.  Storing large files without
-	delta compression avoids excessive memory usage, at the
-	slight expense of increased disk usage. Additionally files
-	larger than this size are always treated as binary.
+	The size of files considered "big", which as discussed below
+	changes the behavior of numerous git commands, as well as how
+	such files are stored within the repository. The default is
+	512 MiB. Common unit suffixes of 'k', 'm', or 'g' are
+	supported.
 +
-Default is 512 MiB on all platforms.  This should be reasonable
-for most projects as source code and other text files can still
-be delta compressed, but larger binary media files won't be.
+Files above the configured limit will be:
 +
-Common unit suffixes of 'k', 'm', or 'g' are supported.
+* Stored deflated, without attempting delta compression.
++
+The default limit is primarily set with this use-case in mind. With it
+most projects will have their source code and other text files delta
+compressed, but not larger binary media files.
++
+Storing large files without delta compression avoids excessive memory
+usage, at the slight expense of increased disk usage.
++
+* Will be treated as if though they were labeled "binary" (see
+  linkgit:gitattributes[5]). This means that e.g. linkgit:git-log[1]
+  and linkgit:git-diff[1] will not diffs for files above this limit.
++
+* Will be generally be streamed when written, which avoids excessive
+memory usage, at the cost of some fixed overhead. Commands that make
+use of this include linkgit:git-archive[1],
+linkgit:git-fast-import[1], linkgit:git-index-pack[1] and
+linkgit:git-fsck[1].
 
 core.excludesFile::
 	Specifies the pathname to the file that contains patterns to
-- 
2.35.1.940.ge7a5b4b05f2

