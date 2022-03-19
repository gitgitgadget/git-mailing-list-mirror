Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FD8C433FE
	for <git@archiver.kernel.org>; Sat, 19 Mar 2022 00:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbiCSAZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 20:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241658AbiCSAZE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 20:25:04 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE44129279
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 17:23:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r7so5669611wmq.2
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 17:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Giyf6pUZ7KfzDGXC8IbEa1JQ4sgLmP0etd4CZhg2GI=;
        b=OZlCg+BgJkLS3Y5CVFCKoxh4sR0q2IqVH2vhlN5OYUH6ivKr2hyvqKBDd0pjrnwQK3
         kz3ak1qIdoeSLQkXmhWOHrzJTuACdLwyZvmvhTu4nolnG3pCsrpBHjf+RFFrEeguS+Tu
         dS/bfSRQi0dWbjJxytaTocw+cEEWt7WdJY9SWnU3zJiIZuEa5P9dlz6h7sXpR8RzhQvk
         7wZJ+5qmIMyvaA2D9Hl6IICy7Gq0SXyAgqPpWaj9xv4krIoQFoKtn87Q5nohVDBi3jQ9
         06vpwfjrpB0RcyDoczuiIZWKu0XcPvJF5rdzVqsxntkYmtTpdRO3QEuSnXSceMRgnvoa
         6aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Giyf6pUZ7KfzDGXC8IbEa1JQ4sgLmP0etd4CZhg2GI=;
        b=lM4rcqjP6POwu3wSZhguiIVwQULLKP+DUIKdvvVTCYcBl7iX+kqnMnySHLqbYawR+3
         FKqnkwH6KCZX8MUTsDp4rN7NylKdF/KrTdLYvutgK2pFKATh/H3zR8pcMfxDWk2El/rv
         9rqrYtaQ70AVcTAUGxPSDvPjuBNVWrUZTFltdmsJ6r6/x77CiDRC6/4aV3AE9j6IE9Dd
         A/tKCudWo84ePy0xbO83BANwRkCXmi+yQBU4kcSf7cTpRVth8oSRyiSPj5zp7AAumplg
         28bg5qE0pyAIsi+LdTlv8ohZ2h1Rfby98E9nUVuoRh42luBi9t6VqnfSqc5aVqJR4Sgy
         pXYA==
X-Gm-Message-State: AOAM532PABPqMr9gnINvD0cmkvMYu5WxftbFv8tADwZjpzw6YAWjNYTQ
        Wq9S6BZmjoQur3ufKwAc5IgUUfBLvieJeg==
X-Google-Smtp-Source: ABdhPJwKNnHkBBHxlo3FgPqmii+AdsnXhy9p2dR5PzsRKvts+VriIDtK91Ynx8+hDrkqTQ4k4jSb6w==
X-Received: by 2002:a05:600c:a4b:b0:37b:ea2b:5583 with SMTP id c11-20020a05600c0a4b00b0037bea2b5583mr18337761wmq.139.1647649420079;
        Fri, 18 Mar 2022 17:23:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u25-20020a05600c211900b00389d4bdb3d2sm14865519wml.36.2022.03.18.17.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 17:23:39 -0700 (PDT)
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
Subject: [PATCH v11 6/8] core doc: modernize core.bigFileThreshold documentation
Date:   Sat, 19 Mar 2022 01:23:23 +0100
Message-Id: <patch-v11-6.8-d8ae2eadb98-20220319T001411Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1438.g8874c8eeb35
In-Reply-To: <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com>
References: <cover-v10-0.6-00000000000-20220204T135538Z-avarab@gmail.com> <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com>
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
2.35.1.1438.g8874c8eeb35

