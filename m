Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461FDC433FE
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 13:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbiC2N6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 09:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237617AbiC2N6J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 09:58:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AF9224743
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 06:56:26 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id pv16so35381483ejb.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b1ulR9U5v7pVV4iT8TQeISOfZLlmxSyVb0eBhpXz4lU=;
        b=ofQZK/D6bNDVTqYNrWQHmfTxDbOfU+FV6d7WRMaYWUAjGIJddTcG1iUs+RW6+5dqmn
         gaIK/w/+KMJW6Kf1ZabVa4hAPPeMON+hlx7KhRB1HUMaJdQpt0qdMG2NtQ6sauipHLFT
         iEg23g7xdEOKUSWJlwH4WR5g4Mhpi+rlToawWN2bJ4oWjsYyODZcCTcfg/5jJ1JnFBo+
         BVZhM0DYyO+NLVZRasIEBKg4QgZZgMeUHFsJLpm7zOzjO0pnrHXGMs9He+SU4501ozDM
         FIbXg1Kdx6S7os2Jne1JrVpAHfpLdrRbPx7OXONNB9401tv9uKbLX1eWpxK9bAMy7MiJ
         tKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b1ulR9U5v7pVV4iT8TQeISOfZLlmxSyVb0eBhpXz4lU=;
        b=nbBkGM5DY1tEJ3t2K2Lybq8Zof/weYn9GkDkI96dkYk6qsHTHNTIotWwYqOnwJbI1d
         EtNuk8a7CGMJ8ZOlK22XyDeOnUTy08y2C9SrykHyalmer0KEIZefZyuG6y4zWGivdUcD
         XqMElgm2JTieQXnQugyPvEC76J0FQT4J51yvF6TB6rJsk+XXJ6fmGx+3gU8JBJoSuzq9
         YuIIY+bXfiK7kfEQ+FceveA/prV/1EYet3nncHqGYcfCObYaFMwsH4a1H4gIKwv7G3wc
         MkvV6EKmt5xvMa1Q/rfwe/lSW56hyQt9br0bWCMeDQWQuw7ytqwuyV7TUbqjkdWhh2a3
         dzAg==
X-Gm-Message-State: AOAM533RfngCpqwQ9qOqHtmPApZDqj3S3Gzme7KekY24tjprOJnIicNA
        pou2oHbQlvpByYW5Py4/vLJF/cuXhhzKvA==
X-Google-Smtp-Source: ABdhPJyKN/2vcJOqrGQLSTXaVRDuEN4GcdRL0vUsoH7n2QNyaW0GLN73haeED4YnvCsipjpTJGO4MQ==
X-Received: by 2002:a17:907:2d0a:b0:6df:8bc8:236f with SMTP id gs10-20020a1709072d0a00b006df8bc8236fmr34262176ejc.527.1648562184786;
        Tue, 29 Mar 2022 06:56:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ds5-20020a170907724500b006df8f39dadesm7006601ejc.218.2022.03.29.06.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 06:56:24 -0700 (PDT)
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
Subject: [PATCH v12 6/8] core doc: modernize core.bigFileThreshold documentation
Date:   Tue, 29 Mar 2022 15:56:11 +0200
Message-Id: <patch-v12-6.8-33ffcbbc1f0-20220329T135446Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1548.g36973b18e52
In-Reply-To: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
References: <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com> <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
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
index 9da3e5d88f6..5fccbd56995 100644
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
2.35.1.1548.g36973b18e52

