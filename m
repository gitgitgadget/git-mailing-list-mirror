Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB1BC63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4DF36128A
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhGVLbG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 07:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhGVLa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 07:30:56 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F389C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:11:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n1so5667063wri.10
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K+yhTpyzVhN/nepfosHsP+blP+B2cXXBxLPO7BLxL2c=;
        b=VRVGlthnoyUsoU0ylioima12gLjUk9Q0ocDn/nhWXnTn6ArMlVqKVH8riPCe3vFPuj
         T+LrRdxUWWqn5Tdzz26inBhkemSjxqjyHkqpEnIkOTcLNayye1j0WNazeVkzI+8rTCZF
         J0erHVLOcp+FkAswfDzGi1d2CtMPxXpOhXBG2YxLnE0DaXnTWkjttBfYz4Cq+NR4n5AO
         DJcIkgk4KSkRZMrAT8f2WFaZ/ThMTpPjRsIGLt3iz3lFvlcge5h3nOvzL1XciRIqU1XN
         ZaodU5YJo1+1Uc+itMUH2CxlLI030o6yxeYMZH6SCCMk1th18OwW2dzWpIaBPVKe1oQd
         A5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K+yhTpyzVhN/nepfosHsP+blP+B2cXXBxLPO7BLxL2c=;
        b=DywaAL3SVe6rT/R2XG+u+svkfRyJF+oCzF5Uurgk7tieRZxc/4V4y+0yt5WIXw6hWI
         /ByeXlHeFrRgtOeB0i9TZhu0PN8zg2OJaJLRHKQG/AV/9K9C5ld+jdor1YAJhU0agP9y
         dw6mcxVkscy29JP/zJT+U6VA0oLvhxFm4H55oHi3jIFls74SYhSHyAlfmJB3EDTX1KIi
         YvT0LRrYQtgn4J7l7KaKPQmZnmrRwFSZxNmVmGbgsUYMBiItj6W7jC6c87a28fWOeuwI
         xLrPZIjGGCIJ5TDIvS+awEnbnsLqmB7PsL0852x2UN+lBMaqIjd6TG60ZkyZaCu0HkKy
         yWuQ==
X-Gm-Message-State: AOAM531iwfCmzAtS06Ax+jhOXk32E2Utdcy+LD70IgLTgHjDdq8N0gfm
        9+eftm7HribzOvUv/TRGJqDsG4Xn8nCIJg==
X-Google-Smtp-Source: ABdhPJzhLbCCO+jUmvNn3lvSWjXoLy8f+SOguZLXsLEYTILuMBw8rt5Vzwe7+Af6nY15O6VWF+5W5g==
X-Received: by 2002:a5d:6caf:: with SMTP id a15mr48508616wra.313.1626955887515;
        Thu, 22 Jul 2021 05:11:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k24sm30964130wrh.30.2021.07.22.05.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 05:11:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Dave Huseby <dwh@linuxprogrammer.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/2] SubmittingPatches: move discussion of Signed-off-by above "send"
Date:   Thu, 22 Jul 2021 14:11:23 +0200
Message-Id: <patch-1.2-4283f000c5-20210722T120746Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.957.gd9e39d72fe6
In-Reply-To: <cover-0.2-0000000000-20210722T120746Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210607T110044Z-avarab@gmail.com> <cover-0.2-0000000000-20210722T120746Z-avarab@gmail.com>
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

This is a move-only change, no lines here are being altered, only
moved around.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/SubmittingPatches | 158 ++++++++++++++++----------------
 1 file changed, 79 insertions(+), 79 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 3e215f4d80..07e2073155 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -167,6 +167,85 @@ or, on an older version of Git without support for --pretty=reference:
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
+  reviewers themselves when they are completely satisfied with the
+  patch after a detailed analysis.
+. `Tested-by:` is used to indicate that the person applied the patch
+  and found it to have the desired effect.
+
+You can also create your own tag or use one that's in common usage
+such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
+
 [[git-tools]]
 === Generate your patch using Git tools out of your commits.
 
@@ -302,85 +381,6 @@ Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
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
-  reviewers themselves when they are completely satisfied with the
-  patch after a detailed analysis.
-. `Tested-by:` is used to indicate that the person applied the patch
-  and found it to have the desired effect.
-
-You can also create your own tag or use one that's in common usage
-such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
-
 == Subsystems with dedicated maintainers
 
 Some parts of the system have dedicated maintainers with their own
-- 
2.32.0.957.gd9e39d72fe6

