Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B38C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E6120835
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6KeI392"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfK0T27 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:28:59 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36853 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbfK0T26 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:28:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id k13so11428021pgh.3
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wm/xCpWtU8zcKnHJPsvosPZRDLOCoHqQU1+03JJdpss=;
        b=O6KeI392fAfzIVfd4i57n3p0FxrVRIl80pS2j8i8jaGlDy3oOUdALzcN09Jnf8mmhv
         mN9PlHrQJZyvSVfs+PkhlUIue6zAUzBwI9HugGX0x0ef/ZQbInHhbNXNWJioTKAfsM8K
         Ot87C7brN5r50loGPdAEcCtKCJ+7wPonuXLsFx3Dm52W7T0lVqy7QWkorZbtSIsJdovp
         dG3hbTbwm8cI1ln9IowINf1csGzZ6Z5Oc1VARi3rgFD1ohax+D2LOfaIBrDg88BQC7bZ
         Rb2ahgWd1dRD0YFFBnb+djbq4fKbeZf3Ju/BV8NKS/3OGn/GJyLb5876/ThgMe5oMmey
         vsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wm/xCpWtU8zcKnHJPsvosPZRDLOCoHqQU1+03JJdpss=;
        b=YzlGFk9/33mI1tthbavnkOKhzDItc1nRIc/pYm8sld6aT0YJ16OGj54pWOvtSESRcJ
         VVY3m4qjs8nYx9MJ8S4fohn5cINsbE/Xq74599TwqIstEbsDYtxs00iIwMBAKFAGrccs
         EM5UsUDwQQq/Ag8Y44rUjKOOx8Oola4fpuxR0EydQNMCFSpdigq3tRUBeUqG9LMe2Ine
         Hyr0b3v0+b4lSmB8qDHDflFVBgP3pqnf0inoqa9BCt2dRVpDB3CIZcSQTIeCSU/2R8zm
         GpxG94iRNasuuhCqzX6yOaQtG4Y212p1KmKeuYgcR9huZVbP9zNfPKm/A5OujGEhym14
         0tZg==
X-Gm-Message-State: APjAAAV1zkfqUqxpK+RX8E8i2oyJGUUZMILB/1ruTv3WQP3SLRUxpeTC
        XwSIzqtqv5YQrIF6NdnLthydiQ6x
X-Google-Smtp-Source: APXvYqwE2MaWGxD09obn9birjBlitg5QuoLwl27GDCCADY0hx16OP39RsPmSUiSZ+NAvoY0n7bQVkQ==
X-Received: by 2002:a62:7590:: with SMTP id q138mr25386484pfc.241.1574882937600;
        Wed, 27 Nov 2019 11:28:57 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id k10sm7411115pjs.31.2019.11.27.11.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:28:56 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:28:55 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
Subject: [PATCH 1/2] doc: replace MARC links with LKML
Message-ID: <14167012a13125fe3c31af27afe68f84c9cdd2a2.1574882812.git.liu.denton@gmail.com>
References: <20191127125231.GH22221@sigill.intra.peff.net>
 <cover.1574882812.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574882812.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we're now recommending lore.kernel.org, replace marc.info links
with lore.kernel.org.

Although MARC has been around for a long time, nothing lasts forever
(see Gmane). Since MARC uses opaque message identifiers, switching to
LKML should be a strict improvement since, even if LKML goes
down, the Message-ID will allow future readers to look up the referenced
messages on any other archive.

We leave behind one reference to MARC in the README.md since it's a
perfectly fine mail archive for personal reading, just not for linking
messages for the future.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-bisect-lk2009.txt | 2 +-
 Documentation/gitcli.txt            | 4 ++--
 Documentation/user-manual.txt       | 4 ++--
 t/t6021-merge-criss-cross.sh        | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index 5bcf4d9b94..72dbe6dbea 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -1353,6 +1353,6 @@ References
 - [[[4]]] https://lore.kernel.org/git/7vps5xsbwp.fsf_-_@assigned-by-dhcp.cox.net/[Junio C Hamano. 'Automated bisect success story'.]
 - [[[5]]] https://lwn.net/Articles/317154/[Christian Couder. 'Fully automated bisecting with "git bisect run"'. LWN.net.]
 - [[[6]]] https://lwn.net/Articles/277872/[Jonathan Corbet. 'Bisection divides users and developers'. LWN.net.]
-- [[[7]]] http://marc.info/?l=linux-kernel&m=119702753411680&w=2[Ingo Molnar. 'Re: BUG 2.6.23-rc3 can't see sd partitions on Alpha'. Linux-kernel mailing list.]
+- [[[7]]] https://lore.kernel.org/lkml/20071207113734.GA14598@elte.hu/[Ingo Molnar. 'Re: BUG 2.6.23-rc3 can't see sd partitions on Alpha'. Linux-kernel mailing list.]
 - [[[8]]] https://www.kernel.org/pub/software/scm/git/docs/git-bisect.html[Junio C Hamano and the git-list. 'git-bisect(1) Manual Page'. Linux Kernel Archives.]
 - [[[9]]] https://github.com/Ealdwulf/bbchop[Ealdwulf. 'bbchop'. GitHub.]
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 4b32876b6e..373cfa2264 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -211,8 +211,8 @@ only affects the files in the working tree, but with
 entries, and with `--cached`, it modifies only the index
 entries.
 
-See also http://marc.info/?l=git&m=116563135620359 and
-http://marc.info/?l=git&m=119150393620273 for further
+See also https://lore.kernel.org/git/7v64clg5u9.fsf@assigned-by-dhcp.cox.net/ and
+https://lore.kernel.org/git/7vy7ej9g38.fsf@gitster.siamese.dyndns.org/ for further
 information.
 
 Some other commands that also work on files in the working tree and/or
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 06bd8994ee..833652983f 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -4574,5 +4574,5 @@ Write a chapter on using plumbing and writing scripts.
 Alternates, clone -reference, etc.
 
 More on recovery from repository corruption.  See:
-	http://marc.info/?l=git&m=117263864820799&w=2
-	http://marc.info/?l=git&m=117147855503798&w=2
+	https://lore.kernel.org/git/Pine.LNX.4.64.0702272039540.12485@woody.linux-foundation.org/
+	https://lore.kernel.org/git/Pine.LNX.4.64.0702141033400.3604@woody.linux-foundation.org/
diff --git a/t/t6021-merge-criss-cross.sh b/t/t6021-merge-criss-cross.sh
index 213deecab1..d254e020b6 100755
--- a/t/t6021-merge-criss-cross.sh
+++ b/t/t6021-merge-criss-cross.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Fredrik Kuivinen
 #
 
-# See http://marc.info/?l=git&m=111463358500362&w=2 for a
+# See https://lore.kernel.org/git/Pine.LNX.4.44.0504271254120.4678-100000@wax.eds.org/ for a
 # nice description of what this is about.
 
 
-- 
2.24.0.504.g3cd56eb17d

