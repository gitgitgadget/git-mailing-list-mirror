Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74300C432BE
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D2C16138F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbhHWMNo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbhHWMNl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:13:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A400C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:12:59 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k29so25949294wrd.7
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SHzhzV5epQzbUQwJJwrz3oCraqaPu6K+yd7lUWl2kz4=;
        b=vaIJCt0w9SvQb/IFwAmURF2LNH4HOwrite+LfvBQs6eU001B0/A2ZkpTZhCObxKMz/
         VaL5MB+mRqpo9UAIAWQpvNhcfC/tIg8XTObZECCRnpSsTq60f5/+UOkjqdLj2YClBRO2
         eWyGafZMJY0WuQeYeK4h6YbuFrTRu32BvEDrOTuCzrOLU+U+HbwAirOtgV4soKJT12UT
         IvhQhmSk1UvgWImDcZVUwQf2MUJzM5FefCwMMuO6LsoyviEaGRAkR4sDyC44GcNZxp3p
         DIqkk6HSpjNQItEQHaEZbbtA8potkgunJ+XUDwTWSOiVt0TapdCvSpV9DboVhoyWnmVn
         inXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SHzhzV5epQzbUQwJJwrz3oCraqaPu6K+yd7lUWl2kz4=;
        b=aTXaT07tRMVDQvARKeWYnPQVFIbFWx0LOFVB1CCUFmhO8OrqZ6SlJTjijZJ+S8Q3sr
         04c54erdQbLclnerHl6pT8zT1iChUmP1DwVm2MxqIesX7GDgbvYdFfGHvCXYtUyVadUx
         7oNsJk0o4m5b68y8vsHy4rcUHSGAkBIMdMFrsU8DVitfGWC0YdzUS85uwTgNXhjzOlrQ
         2Cg8/+9Wmm66yj6lQC/nXqsf5/H6kctvzhJHfIZz9c28WXNB3aXkCQ3WtF4baHdhiC2Z
         LrFmXXVQ5XPNacBzWyLQbwiCoPjIR1TaeoEFzaKe9gwQCsSjBJFBD6EnCA3iypnq0Xbs
         XQeA==
X-Gm-Message-State: AOAM533VMsN26cgUcRTdlqhPcD/+uNE2Z1UUZ8s+SJzvbOlSiqc+qXXh
        ODeYVkLZuI/Cq/v7sYzTC76KyGpyzrfzATQ9
X-Google-Smtp-Source: ABdhPJxe7JQdCV58qPuILuIoyKIhOEAIG79QgonfPI4MoTGKL6qxV8rAqDt8lxvYC9v3K8P+lcq/BA==
X-Received: by 2002:a5d:49cd:: with SMTP id t13mr1413917wrs.175.1629720777555;
        Mon, 23 Aug 2021 05:12:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u10sm14824952wrt.14.2021.08.23.05.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:12:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v4 03/28] reftable: RFC: add LICENSE
Date:   Mon, 23 Aug 2021 14:12:14 +0200
Message-Id: <patch-v4-03.28-6cf0b244fc5-20210823T120208Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbaddc25a55e
In-Reply-To: <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com> <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The objective of this code is to be usable as a C library, so it can be reused
in libgit2.

This is currently using a BSD license as it is the liberal license I could find,
but this could be changed to whatever fits the stated goal above.

This code is currently imported from github.com/hanwen/reftable. Once this code
lands in git.git, the C code will be removed from github.com/hanwen/reftable,
and the git.git code will be the source of truth.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/LICENSE | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 reftable/LICENSE

diff --git a/reftable/LICENSE b/reftable/LICENSE
new file mode 100644
index 00000000000..402e0f9356b
--- /dev/null
+++ b/reftable/LICENSE
@@ -0,0 +1,31 @@
+BSD License
+
+Copyright (c) 2020, Google LLC
+All rights reserved.
+
+Redistribution and use in source and binary forms, with or without
+modification, are permitted provided that the following conditions are
+met:
+
+* Redistributions of source code must retain the above copyright notice,
+this list of conditions and the following disclaimer.
+
+* Redistributions in binary form must reproduce the above copyright
+notice, this list of conditions and the following disclaimer in the
+documentation and/or other materials provided with the distribution.
+
+* Neither the name of Google LLC nor the names of its contributors may
+be used to endorse or promote products derived from this software
+without specific prior written permission.
+
+THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-- 
2.33.0.662.gbaddc25a55e

