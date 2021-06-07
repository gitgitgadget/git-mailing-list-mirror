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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C686FC47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC8560FE4
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhFGLGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 07:06:40 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:43775 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhFGLGj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 07:06:39 -0400
Received: by mail-wm1-f47.google.com with SMTP id 3-20020a05600c0243b029019f2f9b2b8aso9868132wmj.2
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 04:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ZmmyHoN/10ugWBSheV02LaYJG76CNjTswFD9kYfBO0=;
        b=HxZuI+hPyJoD4sQaaLs4NEuDAWtZKRmByxX2oxR9pKksZKV90ELbPPDAu7WvkyZZnD
         AWN7+lBheryIqpku+8sA7q2yp8yALR+qWgfx/Q6CluvhQOHJ4plSKeAW3FRASC2iLUtP
         uTjPLi3NYb5vYV6Q1Qm8KeABVJqxWn7uYihJyZBCqVDpdMIu+A8rY2hIIKUbquBsSD4x
         yfYWwmWcUReHqUaKW6Jdjr4WF9t219RhuEHZXjR0TrGpxl9Em5y2OhJMzFvndssNxedH
         J9YbUZa05N6GLMZN2FxJHm2yoxvq9B1fRn9OFPv10heJCASHEcDcw3XjRM1zQJrXj6FP
         oGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ZmmyHoN/10ugWBSheV02LaYJG76CNjTswFD9kYfBO0=;
        b=K8mCBEJgpHYy+w+uZXlae7uYsWDhcSbcOGM4C/rYRZS6+FtWF7RWFRHkW91nSP4M17
         tob7gVYcsf0Sbf+6zz/BWCkeAp2dZkaL3l+acdaE67g6ixRnFW1+aiI08MjAv+DiY0Xx
         dHpE7moQzZTrNVmIST3wTb+txN4PttumQTPfmxdYCZrkwC6n7kaYr0hmPe+7GiH/ICqJ
         Ik2X9831jPEYYeF7paTuOk915G6eD7wUk0I1ShP/SAumYgMxqncAXgow0esLjg7ycuR2
         Oduc9+scLP6/7ACOO5XwI+Vb+nx4WmFplWjhs1NmFI3oNhH5DJmFphYrG9Pa/t5z4v0+
         p1YA==
X-Gm-Message-State: AOAM530MgD72zlDOGO3Vftt0kdhabWcaweDRolw84fVX0wFukNhnArPq
        v2rWn1Cikbdcncy8t8ZW55PdC4YiuM4HQg==
X-Google-Smtp-Source: ABdhPJz27fsCBLxd/wJpDz8m/jDEx1+o6MJZ5tuxAhWLJQzctB3nGP68dXVtEJNKHBvN5VC5mPTC2Q==
X-Received: by 2002:a1c:4b12:: with SMTP id y18mr16285681wma.70.1623063827035;
        Mon, 07 Jun 2021 04:03:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c64sm17230575wma.15.2021.06.07.04.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:03:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Dave Huseby <dwh@linuxprogrammer.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/3] SubmittingPatches: move discussion of Signed-off-by above "send"
Date:   Mon,  7 Jun 2021 13:03:41 +0200
Message-Id: <patch-1.3-9fa5437bb5-20210607T110044Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-0.3-0000000000-20210607T110044Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com> <cover-0.3-0000000000-20210607T110044Z-avarab@gmail.com>
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
2.32.0.rc3.434.gd8aed1f08a7

