Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F99AC77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 11:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjDML5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjDML5t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 07:57:49 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFAB2D46
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:57:48 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-329627dabfbso2160275ab.0
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681387068; x=1683979068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Y2MeFhvA5g7wm+r14vXppbes/c6GT5tCrJK1YCMJcU=;
        b=WZeSOPRl8tyYU9TwFhdzeVBoVUw2GE0mbzUO7G2D0cXEfuwWETHdbgK0n+UN7csAo5
         0KIZwmSH4eEV0Cne9bik16jfRvwLquk/4F3MKOTW0LaXM1tsTa9sUWwpLldMxJLvXIxn
         Xe6sPDwfg2I4i4BiTGrhI3thDbKSIK0qWa8MrPxsgcXXR1a0Ojg6trQRm73009y+oYUk
         deGZLsbFBbatf2AvWgIkj8RniQGski3fu8v5V6+B8eE+BOlUB3QMbJRUbFrtBSjTsUDL
         5Q8laui6MxNNEEBqaV04T4JN9nyWzLDiMu3Fyt/86iyAbE9JEOKh426FjmdE1bNCGW0J
         LX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681387068; x=1683979068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Y2MeFhvA5g7wm+r14vXppbes/c6GT5tCrJK1YCMJcU=;
        b=I9VknHGPdya0POcUh5ROl6POWz+0coNCaBXZA03HKg2lKm+8oqOrVhoKm59lgwX6QJ
         XbofFkCYO7smCtWD7CTNHqsrWZIjtpAwzf8iN4N6xxSkMc/tsaUAJ9kNX3T1Qrjxob4h
         g35Dwckc76MlOxLfntnezcLuzIX1o/6M726BPBNeDkUss3MWHvC43O4Hf+ZxPM5WXX6Q
         nV5J/k7ltaH1mNM295F4JHh107LHHiuMGrLJsddzIr8BpDerVWh7JGTlyOXpUMgiOaMR
         p0279/hYhRWDbhDMK5xiBcfyRl3b1JqU76ZMDIYcYnVbK/LotRC+8WfmV/2f/tLIqHCA
         RxnA==
X-Gm-Message-State: AAQBX9fYrucVXsMgNglpMgn6a4WHoI54Lr3BXkKQJNhrd0Y9Gfv7MmKL
        +iW7BFZNUh+dK64dbdYXmL8pBoP9aec=
X-Google-Smtp-Source: AKy350ZUqAnuLNBPmpeneRkn+GAwN4f6Zc0KJBuaNfzsXvdYDic5Usq33Zd9CKdiqmW/P3+jIFyc/g==
X-Received: by 2002:a05:6e02:927:b0:329:4142:e9ff with SMTP id o7-20020a056e02092700b003294142e9ffmr1085534ilt.10.1681387067873;
        Thu, 13 Apr 2023 04:57:47 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id b18-20020a92a052000000b003159b6d97d6sm384579ilm.52.2023.04.13.04.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 04:57:47 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Johnsen <chris_johnsen@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 01/12] doc: add test for doc tools output
Date:   Thu, 13 Apr 2023 05:57:34 -0600
Message-Id: <20230413115745.116063-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230413115745.116063-1-felipe.contreras@gmail.com>
References: <20230413115745.116063-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t0600-doc-tools.sh | 91 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100755 t/t0600-doc-tools.sh

diff --git a/t/t0600-doc-tools.sh b/t/t0600-doc-tools.sh
new file mode 100755
index 0000000000..0f9a4053a9
--- /dev/null
+++ b/t/t0600-doc-tools.sh
@@ -0,0 +1,91 @@
+#!/bin/sh
+
+test_description='Check the output of documentation tools'
+
+. ./test-lib.sh
+
+doc_dir="$GIT_BUILD_DIR/Documentation"
+
+command -v asciidoc >/dev/null && test_set_prereq ASCIIDOC
+command -v asciidoctor >/dev/null && test_set_prereq ASCIIDOCTOR
+
+cat >git-foo.txt <<EOF
+git-foo(1)
+===========
+
+NAME
+----
+git-foo - Test command
+
+SYNOPSIS
+--------
+[verse]
+'git-foo' [<arg>]
+
+DESCRIPTION
+-----------
+description
+
+GIT
+---
+Part of the linkgit:git[1] suite
+EOF
+
+cat >git-foo.1.expected <<EOF
+'\" t
+.TH "GIT\-FOO" "1" "2005\-01\-01" "Git 1\&.0\&.0" "Git Manual"
+.ie \n(.g .ds Aq \(aq
+.el       .ds Aq '
+.nh
+.ad l
+.SH "NAME"
+git-foo \- Test command
+.SH "SYNOPSIS"
+.sp
+.nf
+\fIgit\-foo\fR [<arg>]
+.fi
+.sp
+.SH "DESCRIPTION"
+.sp
+description
+.SH "GIT"
+.sp
+Part of the \fBgit\fR(1) suite
+EOF
+
+xmltoman() {
+	base="$1"
+	shift
+	xmlto --skip-validation -m "$doc_dir/manpage-normal.xsl" -m "$doc_dir/manpage-bold-literal.xsl" "$@" man "$base.xml"
+}
+
+build_asciidoc_py() {
+	asciidoc -f "$doc_dir/asciidoc.conf" -amanmanual='Git Manual' -amansource='Git 1.0.0' -arevdate='2005-01-01' -b docbook -d manpage \
+		-o "$1.xml" "$1.txt" &&
+	xmltoman "$1"
+}
+
+build_asciidoctor() {
+	asciidoctor -acompat-mode -atabsize=8 -I "$doc_dir" -rasciidoctor-extensions -alitdd='&#x2d;&#x2d;' \
+		-amanmanual='Git Manual' -amansource='Git 1.0.0' -arevdate='2005-01-01' -b docbook5 -d manpage \
+		-o "$1.xml" "$1.txt" &&
+	xmltoman "$1" -x "$doc_dir"/manpage.xsl
+}
+
+check_manpage() {
+	sed -e '/^\.\\"/d' -e '/^$/d' "$1.1" >"$1.1.actual" &&
+	test_cmp "$1.1.expected" "$1.1.actual"
+}
+
+test_expect_failure ASCIIDOC 'legacy asciidoc.py' '
+	build_asciidoc_py "git-foo" &&
+	check_manpage "git-foo"
+'
+
+test_expect_failure ASCIIDOCTOR 'modern asciidoctor (docbook5)' '
+	build_asciidoctor "git-foo" &&
+	check_manpage "git-foo"
+'
+
+test_done
-- 
2.40.0+fc1

