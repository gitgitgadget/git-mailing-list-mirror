Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3CDC54E49
	for <git@archiver.kernel.org>; Thu,  7 May 2020 13:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1A7920708
	for <git@archiver.kernel.org>; Thu,  7 May 2020 13:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAve3YO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgEGNRy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 09:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726864AbgEGNRv (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 09:17:51 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349F1C05BD0C
        for <git@vger.kernel.org>; Thu,  7 May 2020 06:17:51 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e26so6488531wmk.5
        for <git@vger.kernel.org>; Thu, 07 May 2020 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QVh2I/ihn8bhGOVhEi5ckFPVrBSzgqLhPRE1/wJdP2k=;
        b=pAve3YO89/AyFhwI3XabDFL37DyNah82eTk+Up51osCMI8noU7daQg739UjSwhFkqI
         7L+5qKWWNojSjYESrk4aEctVRcWQVPGaGSTYMLiaa0+ZAMNVEIXwDcfV+D6vcW+R6+73
         dDYPuzDpu+KNfEg96r64OBoWHAeNjW0Zd9ObXlzYL/n1W8UAaGXgDJt8JEHbVoQgv48y
         5jGMcckEsLlHiTn9gYvLP5SEQPs01nv0kYNLaeD79yaBpSDTM6rN9rgzEErYAlgNHhkZ
         bXDo+G20JqTWPO7zCfjIn0L4fYN8leFk/09TB4Jf2mAjAOq6YS+nW/8brE613OY5u8VC
         kspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QVh2I/ihn8bhGOVhEi5ckFPVrBSzgqLhPRE1/wJdP2k=;
        b=HkvJoW6aNv1YkaNFFcI0/VfG6afeV7n3jdmfmjq66IlpfCVamgI3vRYzkxcPKmpv3d
         K0+6/6C1ngw40GNi5PikSvaIiq3+kGvmrPiaZhGMKhlHeTKqjtdsD3ATjtWigjEw15vf
         F7nXNZDDqlgAiGJuyowQ24l3Psw54E7jAOFLxIsUmGLh8O540UFs+rDDdhtw+NXsss+r
         +rwWpuCLAsDfI4l7S6/S+UkLO5OObHEhWwHhZunFmhF7jts2XA4cK9TdG+//oTUkshvl
         6uJwUJhoNEi/Ko9xRGBVxTg0HJACE/4XnT9PXP2xAD7SmhTJO1dqcEg+jDTmc+//f9Dg
         KGxg==
X-Gm-Message-State: AGi0PubYq1r+GRCdvubJNOUnU2BQHWAhc1Ip+Ls37K8R/Lw9A9V4Keny
        uqxvxcnfG9u60lBxzmnn3245WAmm
X-Google-Smtp-Source: APiQypKqE2r2nAoXXhO5pnTf2EnTmpXXDqSriXDqKTJvKYJ+WYdaNRbB3lO4XYHTShxHT7vTujjS8A==
X-Received: by 2002:a1c:5502:: with SMTP id j2mr11214041wmb.56.1588857469798;
        Thu, 07 May 2020 06:17:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c20sm8267057wmd.36.2020.05.07.06.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 06:17:49 -0700 (PDT)
Message-Id: <4ccc5ecbf3d8106ea55b8eb17cd8ad14df3c2680.1588857462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.627.git.1588857462.gitgitgadget@gmail.com>
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 May 2020 13:17:40 +0000
Subject: [PATCH 08/10] Makefile: skip git-gui if dir is missing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmaill.com, peff@peff.net, me@ttaylorr.com,
        jrnieder@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

As an effort to promote "dogfooding" the sparse-checkout feature within
the Git codebase, it is helpful to explore which portions of the
codebase are optional.

The NO_TCLTK variable in the Makefile allows ignoring the git-gui
application at build time. If the local sparse-checkout removes that
directory, then the build will fail without manually defining that
variable. Instead, check to see if the directory exists at build time to
see if we can automatically ignore this directory.

With this change, the following list of directories can be supplied to
"git sparse-checkout set" and Git will build and test on Linux:

	Documentation
	builtin
	compat/.depend
	contrib
	ewah
	mergetools
	negotiator
	perl
	refs
	sha1dc
	sha256
	t
	templates
	trace2
	vcs-svn
	xdiff

The "make install" command requires the "gitweb" and "po" directories.
The "po" directory will become optional in the next change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 2e8029b8026..70760d315cb 100644
--- a/Makefile
+++ b/Makefile
@@ -313,7 +313,8 @@ all::
 #
 # Define NO_PYTHON if you do not want Python scripts or libraries at all.
 #
-# Define NO_TCLTK if you do not want Tcl/Tk GUI.
+# Define NO_TCLTK if you do not want Tcl/Tk GUI. This will also be defined
+# if the git-gui directory is missing.
 #
 # Define SANE_TEXT_GREP to "-a" if you use recent versions of GNU grep
 # and egrep that are pickier when their input contains non-ASCII data.
@@ -1860,6 +1861,12 @@ ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
 
+ifndef NO_TCLTK
+	ifeq ($(ls git-gui),)
+		NO_TCLTK = NoThanks
+	endif
+endif
+
 ifeq ($(PERL_PATH),)
 NO_PERL = NoThanks
 endif
-- 
gitgitgadget

