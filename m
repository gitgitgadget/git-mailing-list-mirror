Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762E7C43460
	for <git@archiver.kernel.org>; Wed, 12 May 2021 08:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42084613C8
	for <git@archiver.kernel.org>; Wed, 12 May 2021 08:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhELIqT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 04:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhELIqS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 04:46:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45983C06174A
        for <git@vger.kernel.org>; Wed, 12 May 2021 01:45:10 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y124-20020a1c32820000b029010c93864955so962944wmy.5
        for <git@vger.kernel.org>; Wed, 12 May 2021 01:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8mL+ztmzK+Rm/MAbjbRj9pPhSHscp2JWJ909HiVjFXM=;
        b=lPAk6eSRqLZV8qmlqP7ta0LggySoZGoDqmnQnDNntWQRUZ75L5kEYokHFl9abH193G
         NeScArJHfJ/1GnDjaKaE0w8+bmQ3I9jVt2tZNl2dtCDfC8FwNPd/vaRBDomEnVUBYXyp
         Fni70HVk2zcg0CxxlyyL27lsG92I2wpcEW9W9him8o3t82rWQDFRzCvodpyM5UtSC+FQ
         1r6HCvsfiJC4CcaezQEb6MRbuTkGbVKJGy8frwqM8n56IGxzEajFMk4mL302wn0Li3sO
         ZY6ReBtRFFC61Hd4Lg26UCEdqb3ATNTP8OH6fdbw6e6+nxsHD4S3C+hGfViE4Y7ZrqNQ
         gWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8mL+ztmzK+Rm/MAbjbRj9pPhSHscp2JWJ909HiVjFXM=;
        b=g4tHMRQSpgEFDeGqNNMtLla6D7BNJbq4ohgrH9liNnH29uvW8aaMVW3P+8oRgH9PPs
         7hVjdH5BfOxbGo0vMXx/WFWKiWGjZfAgTzgXENUgwXDH5XqythpdHjF7BaLDnsG6o8XQ
         2N3fSad4f+ZoPCtnauORrGK5gThR/wortlwFDygEYhU9JaNnxaZOsflrxIi9Fd26kuYm
         5CJ5niH2KwkjZNtwuZak3lFW7Z1hvQQNQ9Nr2b7EowRQ6PZ0ggOWkIhUXsxpJwUrqDXJ
         t8Iq97W/tSD4wJSZyuciR2f/jN203RAiP4tW27m+6vg1CGXergdT84v5mWyhDyWaI9wj
         aUSA==
X-Gm-Message-State: AOAM53383Fuqj3oG+SluecrNVtV5e7WOSoeYmaMR3+Wy7KhubGrCtJf8
        JpvPP6ByjBZ8nUQZI5Ujrpx1hi43A5LVYA==
X-Google-Smtp-Source: ABdhPJxI/r5xYbQFbnVx0qiTbWN9aXTF3X6XhlNK4BKTljvtU2rWnTR0nAmCG+cq+olZ2fZxXGqOsg==
X-Received: by 2002:a05:600c:499a:: with SMTP id h26mr36589737wmp.176.1620809108605;
        Wed, 12 May 2021 01:45:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p17sm30284051wru.1.2021.05.12.01.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 01:45:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Dave Huseby <dwh@linuxprogrammer.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] SubmittingPatches: move discussion of Signed-off-by above "send"
Date:   Wed, 12 May 2021 10:45:00 +0200
Message-Id: <patch-1.3-d18a3caa07-20210512T084137Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.909.g789bb6d90e
In-Reply-To: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the section discussing the addition of a SOB trailer above the
section that discusses generating the patch itself. This makes sense
as we don't want someone to go through the process of "git
format-patch", only to realize late that they should have used "git
commit -s" or equivalent.

This is a move-only change, no lines here are are being altered, only
moved around.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/SubmittingPatches | 160 ++++++++++++++++----------------
 1 file changed, 80 insertions(+), 80 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 55287d72e0..2643062624 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -167,6 +167,86 @@ or, on an older version of Git without support for --pretty=reference:
 	git show -s --date=short --pretty='format:%h (%s, %ad)' <commit>
 ....
 
+[[sign-off]]
+=== Certify your work by adding your `Signed-off-by` trailer
+
+To improve tracking of who did what, we ask you to certify that you
+wrote the patch or have the right to pass it on under the same license
+as ours, by "signing off" your patch.  Without sign-off, we cannot
+accept your patches.
+
+If (and only if) you certify the below D-C-O:
+
+[[dco]]
+.Developer's Certificate of Origin 1.1
+____
+By making a contribution to this project, I certify that:
+
+a. The contribution was created in whole or in part by me and I
+   have the right to submit it under the open source license
+   indicated in the file; or
+
+b. The contribution is based upon previous work that, to the best
+   of my knowledge, is covered under an appropriate open source
+   license and I have the right under that license to submit that
+   work with modifications, whether created in whole or in part
+   by me, under the same open source license (unless I am
+   permitted to submit under a different license), as indicated
+   in the file; or
+
+c. The contribution was provided directly to me by some other
+   person who certified (a), (b) or (c) and I have not modified
+   it.
+
+d. I understand and agree that this project and the contribution
+   are public and that a record of the contribution (including all
+   personal information I submit with it, including my sign-off) is
+   maintained indefinitely and may be redistributed consistent with
+   this project or the open source license(s) involved.
+____
+
+you add a "Signed-off-by" trailer to your commit, that looks like
+this:
+
+....
+	Signed-off-by: Random J Developer <random@developer.example.org>
+....
+
+This line can be added by Git if you run the git-commit command with
+the -s option.
+
+Notice that you can place your own `Signed-off-by` trailer when
+forwarding somebody else's patch with the above rules for
+D-C-O.  Indeed you are encouraged to do so.  Do not forget to
+place an in-body "From: " line at the beginning to properly attribute
+the change to its true author (see (2) above).
+
+This procedure originally came from the Linux kernel project, so our
+rule is quite similar to theirs, but what exactly it means to sign-off
+your patch differs from project to project, so it may be different
+from that of the project you are accustomed to.
+
+[[real-name]]
+Also notice that a real name is used in the `Signed-off-by` trailer. Please
+don't hide your real name.
+
+[[commit-trailers]]
+If you like, you can put extra tags at the end:
+
+. `Reported-by:` is used to credit someone who found the bug that
+  the patch attempts to fix.
+. `Acked-by:` says that the person who is more familiar with the area
+  the patch attempts to modify liked the patch.
+. `Reviewed-by:`, unlike the other tags, can only be offered by the
+  reviewer and means that she is completely satisfied that the patch
+  is ready for application.  It is usually offered only after a
+  detailed review.
+. `Tested-by:` is used to indicate that the person applied the patch
+  and found it to have the desired effect.
+
+You can also create your own tag or use one that's in common usage
+such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
+
 [[git-tools]]
 === Generate your patch using Git tools out of your commits.
 
@@ -302,86 +382,6 @@ Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
 `Tested-by:` lines as necessary to credit people who helped your
 patch, and "cc:" them when sending such a final version for inclusion.
 
-[[sign-off]]
-=== Certify your work by adding your `Signed-off-by` trailer
-
-To improve tracking of who did what, we ask you to certify that you
-wrote the patch or have the right to pass it on under the same license
-as ours, by "signing off" your patch.  Without sign-off, we cannot
-accept your patches.
-
-If (and only if) you certify the below D-C-O:
-
-[[dco]]
-.Developer's Certificate of Origin 1.1
-____
-By making a contribution to this project, I certify that:
-
-a. The contribution was created in whole or in part by me and I
-   have the right to submit it under the open source license
-   indicated in the file; or
-
-b. The contribution is based upon previous work that, to the best
-   of my knowledge, is covered under an appropriate open source
-   license and I have the right under that license to submit that
-   work with modifications, whether created in whole or in part
-   by me, under the same open source license (unless I am
-   permitted to submit under a different license), as indicated
-   in the file; or
-
-c. The contribution was provided directly to me by some other
-   person who certified (a), (b) or (c) and I have not modified
-   it.
-
-d. I understand and agree that this project and the contribution
-   are public and that a record of the contribution (including all
-   personal information I submit with it, including my sign-off) is
-   maintained indefinitely and may be redistributed consistent with
-   this project or the open source license(s) involved.
-____
-
-you add a "Signed-off-by" trailer to your commit, that looks like
-this:
-
-....
-	Signed-off-by: Random J Developer <random@developer.example.org>
-....
-
-This line can be added by Git if you run the git-commit command with
-the -s option.
-
-Notice that you can place your own `Signed-off-by` trailer when
-forwarding somebody else's patch with the above rules for
-D-C-O.  Indeed you are encouraged to do so.  Do not forget to
-place an in-body "From: " line at the beginning to properly attribute
-the change to its true author (see (2) above).
-
-This procedure originally came from the Linux kernel project, so our
-rule is quite similar to theirs, but what exactly it means to sign-off
-your patch differs from project to project, so it may be different
-from that of the project you are accustomed to.
-
-[[real-name]]
-Also notice that a real name is used in the `Signed-off-by` trailer. Please
-don't hide your real name.
-
-[[commit-trailers]]
-If you like, you can put extra tags at the end:
-
-. `Reported-by:` is used to credit someone who found the bug that
-  the patch attempts to fix.
-. `Acked-by:` says that the person who is more familiar with the area
-  the patch attempts to modify liked the patch.
-. `Reviewed-by:`, unlike the other tags, can only be offered by the
-  reviewer and means that she is completely satisfied that the patch
-  is ready for application.  It is usually offered only after a
-  detailed review.
-. `Tested-by:` is used to indicate that the person applied the patch
-  and found it to have the desired effect.
-
-You can also create your own tag or use one that's in common usage
-such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
-
 == Subsystems with dedicated maintainers
 
 Some parts of the system have dedicated maintainers with their own
-- 
2.31.1.909.g789bb6d90e

