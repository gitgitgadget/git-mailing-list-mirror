Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE396C433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 17:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D38DD61163
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 17:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbhJERD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 13:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbhJERDX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 13:03:23 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944D1C061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 10:01:32 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a131-20020a1c7f89000000b0030d4c90fa87so112506wmd.2
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 10:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KDvVC0t7JLWTaPpLcPsOvJVdAO1r4sCZoc57AGgpDDk=;
        b=ZWVysQc1GhEU9GH58GvdeK/ILcfE805dkrr1QAzstmzkWHRLYCQT2bBM7CTcETGhYw
         DwCmpISeklhDj75FmP+dPJRbzRRabC/GGScabUgRoL6iUHonaDV41t8G86M2/PeClRHX
         /oQugai2SGJxbDV62FFGE/iprhx8ypZ0Sf0yo/JVCgxpiMniNrG0RN6WXsQCXmrxHJuO
         OV4XTCwp9WKAGu+gDJPYTUaJBW0hDtUtVWT7ZjKksJjKj5ZAeNQ/yEYBSF/fk5GrG/8L
         nB6aiwrikfvddz+4HeyjTjQAIZvev/IRBNEoRaxP8I2pGGVNVhmQh+xqVBGmaOJ/peRw
         Tt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KDvVC0t7JLWTaPpLcPsOvJVdAO1r4sCZoc57AGgpDDk=;
        b=ACCoepilP48X0iHa6lm0D3VSOxQDbO9WuQQoKB8FKOmT51acHIZt4COfv4JYOOhvv1
         xIgBtbLWF5sw2Q70zwTgC1W5bnORhfVcXJZE/5iJpmrIUDx9jFjbtTbrIaRL4mFMmPjt
         InhWj8DS5LExaHGJc6WMg0m38hVRgrMC9sCrDoZuRRrCy3HwAg33/IEagp/XA6iytxKS
         zSt8yRg4EYWWIfm7qXW6Uxo7xdY6p+dmxlqe1Y0yVdVpUjt4VEsAGYbtDE8RpJ5l9tOc
         2KISb+JimDCj14Eizb3GB1mDT6JalcQu9dRxUpZpPUx7lTRmKVpbXynHX0hSN3xAAXta
         ci/g==
X-Gm-Message-State: AOAM531Ozb0XYaQ71QsG3Mx/ANwo+YmBoQFk78sS8Ok9EomaK2oVZhvm
        D47/mgBK5CT/9sd69F34FFe3MjYga4U=
X-Google-Smtp-Source: ABdhPJwojRjmYkhuZgQCUR19DibTUySjInKM5VOOBgUW/wtSljHVxIPZhXbRMOBI6F8b+oWD3zh4yw==
X-Received: by 2002:a05:600c:4a27:: with SMTP id c39mr4588213wmp.39.1633453290890;
        Tue, 05 Oct 2021 10:01:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z79sm2551261wmc.17.2021.10.05.10.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 10:01:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/5] COPYING: remove mention of GPLv3, clarify sub-project COPYING
Date:   Tue,  5 Oct 2021 19:01:15 +0200
Message-Id: <patch-v2-3.5-44375bece46-20211005T170031Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
In-Reply-To: <cover-v2-0.5-00000000000-20211005T170031Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20211002T091212Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20211005T170031Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The COPYING file added in [1] is a product of its era, at the time
discussions around the GPLv3 were quite active. Since then we have had
almost no "GPL v2 or later" notices anywhere.

Since then[2][3] linux.git has replaced its version of almost the
identical wording with something that's a bit more formal, and which
isn't mostly addressing a hypothetical future GPL v3 migration. Let's
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
2.33.0.1441.gbbcdb4c3c66

