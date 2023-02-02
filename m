Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547F7C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjBBJcs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjBBJcp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:32:45 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2158B4AA4E
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:32:43 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l8so878815wms.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1qjNOAhIKvP4aOQnU3+1zqmYU20nn3ykG5nkJeXmzg=;
        b=SW7OvkVu75tDKluAovdEHAU4MAqc1/d0WLtwdBcp09XUKYdF5CU6SzUZzsIv8eqDIn
         Z/z0+clK7Q1r/1QV9D8tKlHBfuEZMLWdbQebVeA0pdgnWbtyqBWlmryjZRIEQa0Mvylw
         pkK/gxqfOlY5uyLKLBnzdrPH1mrA1wfh8iN/w1q24QUhRtW2AFYn1HchR+dzA4CcWt6q
         7MH3kX90MAeaTiUdZ7Vz7c16JQF8jPXAUKwtDtX3C6mvcub+V5MPSd1JevchVCfAsdfK
         223X6qra0gTSBpaRKD9XQf/TNNJ5/ikePE/UkRMkUWEB+GyiJSnceSpRpYhlcY2zegny
         /Q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1qjNOAhIKvP4aOQnU3+1zqmYU20nn3ykG5nkJeXmzg=;
        b=wQUGKlm7VfQLYFahnTBdd3mWpqUpfE43jrwxvHxR0DGCxFgxCEeGP0+UPZzUY4erEz
         3VUnpt3Tvyy81F2OPG9ejyHnml6S67jT+7MSBoqDgRrEFf8YI1aWnSQwqZrCM0Q+mVb0
         2nkl/awfUZa1DO33CDtgtKnIDEY47WJ0l/ySKAcsgIq0mhTIgXVdwydXqkRl5mGbo1sW
         rWQxDLxXSbR6I+QI3jWfwN2SlvH3GXYzc/yt7EV8rlbKRUmn0YfYx+Lk1x0uRelNkbhk
         ulR/jRugG9iOyn+Z8TMkvdVoEhTv+0x70QzSLKlQn25hf/Qh6UtxQ9ofi/N0fyMxlmqH
         /eSQ==
X-Gm-Message-State: AO0yUKXncgvqRaK7FnkHw53jlJeoU+VFKnI7u1/uAksIJqPlcf8+JSKE
        MlyccEuPA01hC3+iDCrRT6yx038c23XlMtbC
X-Google-Smtp-Source: AK7set/0tw94VLjj9hi9jFRTHITLhd4ePetGqAkWfeiBZ07Yw2oVS5MfzGen3sNd9aKHnYYdcIRoWg==
X-Received: by 2002:a05:600c:5406:b0:3dc:5614:919f with SMTP id he6-20020a05600c540600b003dc5614919fmr5178734wmb.23.1675330361339;
        Thu, 02 Feb 2023 01:32:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c2cd300b003cf71b1f66csm4238753wmc.0.2023.02.02.01.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:32:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eli Schwartz <eschwartz93@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/9] git config docs: document "tar.<format>.{command,remote}"
Date:   Thu,  2 Feb 2023 10:32:22 +0100
Message-Id: <patch-2.9-3cf4bf5a538-20230202T093212Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
References: <230131.86357rrtsg.gmgdl@evledraar.gmail.com> <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the "tar.<format>.command" and "tar.<format>.remote"
configuration was added in [1] and [2], we have not included it in the
"git-config(1)" docs themselves.

Since we're including "Documentation/config/tar.txt" in
"Documentation/config/git-archive.txt" as of the preceding commit,
let's move this documentation to the former, to be included in the
latter.

This is a move-only change, aside from changing the mention of "`git
archive`" to "linkgit:git-archive[1]", for consistency with other such
mentions.

1. 767cf4579f0 (archive: implement configurable tar filters,
   2011-06-21)
2. 7b97730b764 (upload-archive: allow user to turn off filters,
   2011-06-21)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/tar.txt  | 18 ++++++++++++++++++
 Documentation/git-archive.txt | 18 ------------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/config/tar.txt b/Documentation/config/tar.txt
index c68e294bbc5..894c1163bb9 100644
--- a/Documentation/config/tar.txt
+++ b/Documentation/config/tar.txt
@@ -6,3 +6,21 @@ tar.umask::
 	linkgit:git-archive[1] for
 	details. If `--remote` is used then only the configuration of
 	the remote repository takes effect.
+
+tar.<format>.command::
+	This variable specifies a shell command through which the tar
+	output generated by linkgit:git-archive[1] should be piped. The command
+	is executed using the shell with the generated tar file on its
+	standard input, and should produce the final output on its
+	standard output. Any compression-level options will be passed
+	to the command (e.g., `-9`).
++
+The `tar.gz` and `tgz` formats are defined automatically and use the
+magic command `git archive gzip` by default, which invokes an internal
+implementation of gzip.
+
+tar.<format>.remote::
+	If true, enable the format for use by remote clients via
+	linkgit:git-upload-archive[1]. Defaults to false for
+	user-defined formats, but true for the `tar.gz` and `tgz`
+	formats.
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index bbb407d4975..268e797f03a 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -133,24 +133,6 @@ CONFIGURATION
 
 include::config/tar.txt[]
 
-tar.<format>.command::
-	This variable specifies a shell command through which the tar
-	output generated by `git archive` should be piped. The command
-	is executed using the shell with the generated tar file on its
-	standard input, and should produce the final output on its
-	standard output. Any compression-level options will be passed
-	to the command (e.g., `-9`).
-+
-The `tar.gz` and `tgz` formats are defined automatically and use the
-magic command `git archive gzip` by default, which invokes an internal
-implementation of gzip.
-
-tar.<format>.remote::
-	If true, enable the format for use by remote clients via
-	linkgit:git-upload-archive[1]. Defaults to false for
-	user-defined formats, but true for the `tar.gz` and `tgz`
-	formats.
-
 [[ATTRIBUTES]]
 ATTRIBUTES
 ----------
-- 
2.39.1.1392.g63e6d408230

