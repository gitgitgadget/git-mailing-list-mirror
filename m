Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD6CC433FE
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 09:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbiBYJFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 04:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238862AbiBYJFP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 04:05:15 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E982F22B97D
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 01:04:43 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id x15so3381489wrg.8
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 01:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9hH9YZkZqxD7XhacnhN7uYdoqAWWEYpoX62Cx4nE1zg=;
        b=fASsewY6uQSDuFlZCs2rHDfwZ6xdeH07+XgDQay5/BMVuT9PiCqps0Y0h+wvupU2uM
         WbcKdUslwuwtM+6DlooiUXtmMPnCiAUyRXmlD49DOfZSIqp/UYhoV1GVe1gazLHQiHdi
         sdAIG2sc2ZYtPkRSxB2LmhfzrP+AjI9QLjKbnOLIFqEAkF7kj9opw49Pu1QU+deQGOqx
         0HM/1xNrIyXlH9EFf3D/PA2IiQk+D6eyqYJVSnftpOYYsT7Ajs4dUfIMM+pXUVwuMvSA
         EtEFWLryJHFTZXoER/uubztbwoyg/lcHmrPwC8/QkIhHBB/1E9ViUB0fFFj6KiWyX273
         0WUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9hH9YZkZqxD7XhacnhN7uYdoqAWWEYpoX62Cx4nE1zg=;
        b=QPu+/ArounJrWOoJdvYbffx4sw9pWTanPIfWa3aqC7AsYU1iWjY08vCGSv9LXGzXDr
         /lKHDQbdrbtEcbuG2OMqCvxniZIneRt6xJOLnQQVTDtdYUNthCeMdh55EskOuP1fwlC3
         2MVfLk57Ei61pq0gDbD/ckbk+ESPOqVprB1kpqINkSvcbvv+KxTL21pNirlBShEzVV6a
         6SPqC5m2O1+iBSZ4IRNho3Ih7U6AHuvCkoJ8MFHBL6BTC2iIzEPtbraI2VbLScCS93nW
         iqNMm0fqgFONQQt1k5bJ9fS9t2Gmvy3gdnwI4vKtDRYlY74tRiEkhUg4usfYL6vnsTXf
         eoSg==
X-Gm-Message-State: AOAM530Rj8LsHWT/h/xDodl2HSjkQnY/Md5wqvhkVNXkS4s/yB8krjYI
        4xSYrtjV0ypqnaGfVrHj83lk1ERAwYlREA==
X-Google-Smtp-Source: ABdhPJyIoPe6yumPaPwvQmVU9X5Ihp3iBAViZbslZxHQgFG6xcT3Qz0/d3sfFfZ7+laqz9mWV5Babw==
X-Received: by 2002:a5d:43d1:0:b0:1ed:d1de:2141 with SMTP id v17-20020a5d43d1000000b001edd1de2141mr5246670wrr.394.1645779882215;
        Fri, 25 Feb 2022 01:04:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l38-20020a05600c1d2600b0037e9090fb1esm5636657wms.24.2022.02.25.01.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 01:04:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/9] Makefile: disable GNU make built-in wildcard rules
Date:   Fri, 25 Feb 2022 10:04:29 +0100
Message-Id: <patch-v3-3.9-9392e3c3e97-20220225T090127Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1175.gf9e1b23ea35
In-Reply-To: <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Override built-in rules of GNU make that use a wildcard target. This
can speeds things up significantly as we don't need to stat() so many
files. GNU make does that by default to see if it can retrieve their
contents from RCS or SCCS. See [1] for an old mailing list discussion
about how to disable these.

The speed-up may wary. I've seen 1-10% depending on the speed of the
local disk, caches, -jN etc. Running:

    strace -f -c -S calls make -j1 NO_TCLTK=Y

Shows that we reduce the number of syscalls we make, mostly in "stat"
calls.

We could also invoke make with "-r" by setting "MAKEFLAGS = -r"
early. Doing so might make us a bit faster still. But doing so is a
much bigger hammer, since it will disable all built-in rules,
some (all?) of which can be seen with:

    make -f/dev/null -p | grep -v -e ^# -e ^$

We may have something that relies on them, so let's go for the more
isolated optimization here that gives us most or all of the wins.

1. https://lists.gnu.org/archive/html/help-make/2002-11/msg00063.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 shared.mak | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/shared.mak b/shared.mak
index 0170bb397ae..29f0e69ecb9 100644
--- a/shared.mak
+++ b/shared.mak
@@ -1,3 +1,14 @@
+### Remove GNU make implicit rules
+
+## This speeds things up since we don't need to look for and stat() a
+## "foo.c,v" every time a rule referring to "foo.c" is in play. See
+## "make -p -f/dev/null | grep ^%::'".
+%:: %,v
+%:: RCS/%,v
+%:: RCS/%
+%:: s.%
+%:: SCCS/s.%
+
 ### Flags affecting all rules
 
 # A GNU make extension since gmake 3.72 (released in late 1994) to
-- 
2.35.1.1175.gf9e1b23ea35

