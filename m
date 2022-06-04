Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC918CCA47C
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 10:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiFDKLA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 06:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbiFDKKm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 06:10:42 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCCA1EAC8
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 03:10:40 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id f7-20020a1c3807000000b0039c1a10507fso5442140wma.1
        for <git@vger.kernel.org>; Sat, 04 Jun 2022 03:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wxuWwwkjbPdfaz3LsoitUsiZVfMQsiDM+z7LyfP07MY=;
        b=cuSL0eq/88FQ+yNRUjVMVChb2S+4T0RjIZJ/xTT5ik2OPlFw9sZ36IYmnldgDKEqTN
         50MwiFZU+FzC3fw82ixLPh5WJKu0Q8mb0BbafmPm/r4A8bSe25qVha8yvHYCZ9XkXcku
         NKz+IDJqrdqr9gghHpJfewLejwx9vRWwi1f2/Czu2eQgEDziYhwvpuwuLrErvEWydIGs
         ATCYGASDn6015KRPG75G+i7amPsw6f22mVI65Wq7S6EMWSBEy7c+DH7R3VWJ3NNGk2ae
         QK6xw9YmQW/fPeRIT0XsrR38570ts9YfeaYwaoCsBonovrbLBJSFA5PbeiaPhO1dRz2q
         frUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wxuWwwkjbPdfaz3LsoitUsiZVfMQsiDM+z7LyfP07MY=;
        b=MHh1eKWO+e3yVWzeV4loemm2IJlEtJgZ8axc82mqVNV1MOiFfg7MZKW6VEqvfuF/1t
         P8Ivx+SXWXWej+BSFfW9qkkvJrDaP6Wk+BwNMQlQILMn7+rwV0GucPqC+Kie/r75e6ed
         O4N1zGyQ2kFlHnoKRt8fVQSKr7cVXlx8O/I5nhiXKpnJ/zeMw9EtAdqvMAjZOgFVQAqi
         9Dc3Nup81TKH1DR88USls7hMyJ8OfTMNSuLB9gI8c1RWU0fqQ5FRUbCWpcDmE+968rZR
         aMwrJoa6bg6Nn+D/GrNboH5enXWLsaetMY8lrDtZ/q2obhkt4j5PwqXliRcEi4YUukKj
         lfkw==
X-Gm-Message-State: AOAM533d91N4/HwK6AZM3gv+jScV5KJ55xirXaft4i1IB8q6Zs6tPu9w
        7SsfBG0XtpapufKYCHMeMU4Bl5bXxfwABw==
X-Google-Smtp-Source: ABdhPJwv+foUjzGIZ9WWZ+cvLKVJ0B/Vr1UDLrh3eZLKSLqsjxt7Lb9B/ijhynX0OIGAkuIDs46BrA==
X-Received: by 2002:a05:600c:1d03:b0:397:5f4b:2e46 with SMTP id l3-20020a05600c1d0300b003975f4b2e46mr41999320wms.121.1654337439133;
        Sat, 04 Jun 2022 03:10:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i12-20020a05600c354c00b0039765a7add4sm15069631wmq.29.2022.06.04.03.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 03:10:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v13 6/7] core doc: modernize core.bigFileThreshold documentation
Date:   Sat,  4 Jun 2022 12:10:27 +0200
Message-Id: <patch-v13-6.7-5ed79c58b18-20220604T095113Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1124.g52838f02905
In-Reply-To: <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
References: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com> <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
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
index 41e330f3069..ff6ae6bb647 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -444,17 +444,32 @@ You probably do not need to adjust this value.
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
2.36.1.1124.g52838f02905

