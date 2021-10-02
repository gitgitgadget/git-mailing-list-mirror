Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E05C433EF
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 09:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921BC61B06
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 09:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhJBJVS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 05:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbhJBJVP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 05:21:15 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4DCC0613E9
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 02:19:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r7so3848837wrc.10
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 02:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iJxjO04Fv1Zibpib3Iuz1FkFzIfD7NE1CJpf8WGhtBg=;
        b=YebSBEjbRT64swafIx0E9EXXY+juFAN+Fru71G+oBrtqpFaRJlCQ15zGrg44b4z8yO
         DPGNPLZj/qmYoRR+Izreo5vocufxneIdoU/iiQk6AdSW2vDdZarIISDCd0axHq7QMyvK
         9f5LoaLlvXsjRt7fM/lLxUbY1dhmgNDBjZhNplyji4aft2iWVJYljsf7a7pkIL+/PzSU
         h5+oh6EPLprHjkD5J8iNjWmDSqfA7DoCej12x+wxiCx7/+fHa0gRQG1dn26/2atITt+1
         0yh/L9vq85XdfBorqzrUlBSxjSWEdnPj9yyxhSX6TcNXsAcxV+8FKu395zyFeI+8ZUrw
         WoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iJxjO04Fv1Zibpib3Iuz1FkFzIfD7NE1CJpf8WGhtBg=;
        b=2f3WOJthTIL8iv3kiSlXBVtS+bP4h5b9Yvf2jP5XZf0uWHSfufS/6V0SW5nVoY/m8t
         jd3HIyRN/b33gmLp+OP9+v5z5Cl+xXB3gCoNpFI0Xz+X1ZElFgcliYXtaC0P9lY0ANqO
         xiYcNQQRYUCrjf1C19kB62uB1qi63yGrR9T3MiB+sNLpw+xYGnocFI/L4Dn5EBb9ZuKo
         k5MOAb5dEkwSdSLNYVMwVnQlneMkXSEnguRP1D5TksjSlk3He9H017GJtTqMYaL18KkK
         6wT8yfXPdgf7DiEjimH4yi0o/QJJGAVUDb9WVQfOTA4lOtO13Wxgx+6nfiosaaXSjvqn
         YxpA==
X-Gm-Message-State: AOAM533Rdl5dZDBIVuiJAlod58m0EpcZKhsvJOOs5ApHtJN9zk7E+mHq
        ACTgEUpb+jhg3U5vs/tdxEdpq6zh1qSOSw==
X-Google-Smtp-Source: ABdhPJzr8kjvRtBI29+sy7YfKUhhHak/Yy6lIuq8/FVgo31Em4cKT9+ra76d1E+nSDT/hVx5FLuobw==
X-Received: by 2002:a5d:6288:: with SMTP id k8mr2579015wru.137.1633166367694;
        Sat, 02 Oct 2021 02:19:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s13sm6735805wrv.97.2021.10.02.02.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 02:19:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] COPYING: remove mention of GPLv3, clarify sub-project COPYING
Date:   Sat,  2 Oct 2021 11:19:18 +0200
Message-Id: <patch-3.5-e91f8ce6984-20211002T091212Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1380.g193143c62ce
In-Reply-To: <cover-0.5-00000000000-20211002T091212Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20211002T091212Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The COPYING file added in [1] is a product of its era, at the time
discussions around the GPLv3 were quite active. Since then we have had
almost on "GPL v2 or later" notices anywhere.

Since then[2][3] linux.git has replaced its version of almost the
identical wording with something that's a bit more formal, and which
isn't mostly addressing a hypothetical future GPL v3 migratin. Let's
do the same. Now we:

A. Let it suffice to say that things are licensed under GPL v2 unless
   explicitly otherwise stated. The new wording is an amalgamation of
   the start of Linux's "COPYING" file[4] and the end of our pre-image
   first paragraph added in[1].

B. Add some brief wording about how the licenses of subdirectories
   such as "sha1dc/" and "compat/regex/" should be discovered. This is
   also intended to cover future in-tree additions such as the
   "reftable" directory[5][6].

C. Include the same "subject to this COPYING file" wording as
   linux.git has used since[7].

1. 075b845a857 (Add a COPYING notice, making it explicit that the
   license is GPLv2., 2005-04-11)
2. torvalds/linux@bf02d491237e (COPYING: use the new text with points
   to the license files, 2018-03-23)
3. torvalds/linux@74835c7db032 (COPYING: state that all contributions
   really are covered by this file, 2020-02-06)
4. torvalds/linux@88de995ccf48 (COPYING: create a new file with points
   to the Kernel license files, 2018-03-23)
5. https://lore.kernel.org/git/2597ddfeae1d9da8695151f62379c85621ad0fcb.1632841817.git.gitgitgadget@gmail.com/
6. https://lore.kernel.org/git/xmqqtui4k1j5.fsf@gitster.g/
7. torvalds/linux@74835c7db032 (COPYING: state that all contributions
   really are covered by this file, 2020-02-06)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 COPYING | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/COPYING b/COPYING
index 536e55524db..19de8f2ea1b 100644
--- a/COPYING
+++ b/COPYING
@@ -1,21 +1,20 @@
-
- Note that the only valid version of the GPL as far as this project
- is concerned is _this_ particular version of the license (ie v2, not
- v2.2 or v3.x or whatever), unless explicitly otherwise stated.
-
- HOWEVER, in order to allow a migration to GPLv3 if that seems like
- a good idea, I also ask that people involved with the project make
- their preferences known. In particular, if you trust me to make that
- decision, you might note so in your copyright message, ie something
- like
-
-	This file is licensed under the GPL v2, or a later version
-	at the discretion of Linus.
-
-  might avoid issues. But we can also just decide to synchronize and
-  contact all copyright holders on record if/when the occasion arises.
-
-			Linus Torvalds
+Git is provided under the terms of the GNU General Public License
+version 2 only (GPL-2.0), unless explicitly otherwise stated.
+
+The license described in this COPYING file applies to Git's source as
+a whole, though individual source files can have a different license
+which is required to be compatible with the GPL-2.0. All contributions
+to Git are subject to this COPYING file.
+
+Different but compatible licenses may apply to individual files or
+directories. Defer to files matching "*COPYING*" or "*LICENSE*" in
+subdirectories for the license of files therein, or to copyright
+notices at the top of individual files.
+
+Examples include "sha1dc/LICENSE.txt" covering the imported "sha1dc/"
+directory (and optional "sha1collisiondetection/" submodule), the
+"xdiff/" directory licensed under the LGPL v2.1 (see the "LGPL-2.1"
+file), and imported external code such as "compat/regex/".
 
 ----------------------------------------
 
-- 
2.33.0.1380.g193143c62ce

