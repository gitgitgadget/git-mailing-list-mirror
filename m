Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5517EEB58C
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 12:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243308AbjIIMzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 08:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243176AbjIIMzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 08:55:09 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5685CCE6
        for <git@vger.kernel.org>; Sat,  9 Sep 2023 05:55:04 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so49679611fa.2
        for <git@vger.kernel.org>; Sat, 09 Sep 2023 05:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694264102; x=1694868902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4Xd3I+aDLLb5T7ltsuZAlpzXYmBiVpjHADojfB88nM=;
        b=SUzJnSlKGPoBrGGkI/8vxbWeVGTzLvgdwKZx11mZUngsBBbPuE/Zkyma0vFOEA4QVg
         579lmg1PgEozGTBG9JhXTjRQHWGQ/bVBtwSz1Ii/CEPOGlRKx+yQ/2svyq62FksuiSSh
         vDsLWWNnNTdt5xWjRql3O54PpW03XySsjKNCUbVw4bDaHjSiyFc0K8+gBt3VUl3ltgUD
         UQCDLPBlCsSzBVsf4IfH60nW68Dy70UdSAX6WEePwd/evtAAnFIRgWGSdBjxxehtl+jZ
         W6GrlttwGeSGPSmQ8Aiwg317rJumeNr3l37+V012pJuh0O5PLAj75jlVE35wVZEJJuHV
         RlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694264102; x=1694868902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4Xd3I+aDLLb5T7ltsuZAlpzXYmBiVpjHADojfB88nM=;
        b=vW8o2wexbLDxaYViEMRj382lpPxeKJeljZNousvlOAje9+FwF58Ao+08DL6IKjSfA/
         hhp70ZzAr8Mx+q2mp6ALT7Yz5QVN6xrwsFLFePToXxTnA7JgOX0pr0MpkM07/Jz19+Yt
         9j3S3Pr/eYWg8Bmxox9zj83/Ic8WmoLCmgRE8UujVkSAYIGnZtnddompHkDz22z1k8Ck
         KrwXI+LQovXcoT9ZwckoRfZeFewv2JPLiPxIx9Zfs+apGjB2zzfFMOwa4nqpd96lfd4L
         wZDbcl0Xc3Gcp9Yyf2yapWdpnebNrMPcNWbgrjW4p5v5Rf9ZR9pXYTkZzvUdujUZS1w3
         UJUg==
X-Gm-Message-State: AOJu0YyO4cQk9WBbZ1cLSi6Qyo8IMF3x06NQBUa7nf+OwTIHCZCDshxo
        oHvKrL6MIIw/78ae0m2emj4=
X-Google-Smtp-Source: AGHT+IHiQbVO9HS/dXo478pyQj4WmymZHk8qCOVd+jSHk9GVgsjWJm1qJIe84M0aLEVZ2D/6MQYV6g==
X-Received: by 2002:a2e:9dc6:0:b0:2bc:f5a0:cc27 with SMTP id x6-20020a2e9dc6000000b002bcf5a0cc27mr4351944ljj.47.1694264102442;
        Sat, 09 Sep 2023 05:55:02 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x1-20020a2e9dc1000000b002ba130e9a29sm649871ljj.76.2023.09.09.05.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 05:55:02 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 2/2] diff-merges: introduce '-d' option
Date:   Sat,  9 Sep 2023 15:54:46 +0300
Message-Id: <20230909125446.142715-3-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230909125446.142715-1-sorganov@gmail.com>
References: <20230909125446.142715-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option provides a shortcut to request diff with respect to first
parent for any kind of commit, universally. It's implemented as pure
synonym for "--diff-merges=first-parent --patch".

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-options.txt | 4 ++++
 Documentation/git-log.txt      | 2 +-
 diff-merges.c                  | 3 +++
 t/t4013-diff-various.sh        | 8 ++++++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index f93aa3e46a52..d773dafcb10a 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -51,6 +51,10 @@ ifdef::git-log[]
 Note: This option not implying `-p` is legacy feature that is
 preserved for the sake of backward compatibility.
 
+-d::
+	Produce diff with respect to first parent.
+	Shortcut for '--diff-merges=first-parent -p'.
+
 -c::
 	Produce combined diff output for merge commits.
 	Shortcut for '--diff-merges=combined -p'.
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 9b7ec96e767a..59bd74a1a596 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -120,7 +120,7 @@ By default, `git log` does not generate any diff output. The options
 below can be used to show the changes made by each commit.
 
 Note that unless one of `--diff-merges` variants (including short
-`-m`, `-c`, and `--cc` options) is explicitly given, merge commits
+`-d`, `-m`, `-c`, and `--cc` options) is explicitly given, merge commits
 will not show a diff, even if a diff format like `--patch` is
 selected, nor will they match search options like `-S`. The exception
 is when `--first-parent` is in use, in which case `first-parent` is
diff --git a/diff-merges.c b/diff-merges.c
index ec97616db1df..6eb72e6fc28a 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -125,6 +125,9 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 	if (!suppress_m_parsing && !strcmp(arg, "-m")) {
 		set_to_default(revs);
 		revs->merges_need_diff = 0;
+	} else if (!strcmp(arg, "-d")) {
+		set_first_parent(revs);
+		revs->merges_imply_patch = 1;
 	} else if (!strcmp(arg, "-c")) {
 		set_combined(revs);
 		revs->merges_imply_patch = 1;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 5de1d190759f..a07d6eb6dd97 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -473,6 +473,14 @@ test_expect_success 'log --diff-merges=on matches --diff-merges=separate' '
 	test_cmp expected actual
 '
 
+test_expect_success 'log -d matches --diff-merges=1 -p' '
+	git log --diff-merges=1 -p master >result &&
+	process_diffs result >expected &&
+	git log -d master >result &&
+	process_diffs result >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'deny wrong log.diffMerges config' '
 	test_config log.diffMerges wrong-value &&
 	test_expect_code 128 git log
-- 
2.25.1

