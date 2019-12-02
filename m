Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B63C432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 19:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FF220833
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 19:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWtV9U0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfLBT0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:26:22 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:44298 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbfLBT0V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 14:26:21 -0500
Received: by mail-pj1-f66.google.com with SMTP id w5so153580pjh.11
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 11:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gyLviCkmsibPy2IXo2iKRSI8705RaeibkftDFO0GYdA=;
        b=iWtV9U0n8aoPcD6AusC/8dbaTvQiU+HjO6ReIAnabGHKkafcSNCjHUV7t6eH0ma3Eq
         gS5BSuFou2KqDivVshVQG1K3bGIvsZyUFtRkHOU+nz3BWGqN2w3ydYWRjpAbRSR9Jdwy
         d5VJ7FSTDW2o/mRoQpfZczonf+dfwkCPFparsOwsSkxyxD6JLTMYzA1c2fk39Ox3Ztvw
         2LRjVgaWqsbF8uMrK5xmMDF9Vp4Spt4SAEiKOndwyTGOyIwURxBV96bHOt+s8N+0u6Br
         phBfA37Kbz8AJ0ZOoTRsrTpTu1yjSvH7GOLYh0z+1hKpFt+I1QiizwCVQrGd0B4tcXzc
         Gh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gyLviCkmsibPy2IXo2iKRSI8705RaeibkftDFO0GYdA=;
        b=JJb7HMlXIcw5j0Tl94W0gdIZ68tDbvhIsNu7uVouLMQazc0GkUY8D+73g8TN5MMi6n
         /uBVbPG4AWJq5S2NiqpQNKaoYlH+nVZto+H2f5W2gkEmLkDR1QmX4198ImrH8im2ktz5
         LSfFMknJhKl3XcoEcjANuX9kEuxB2z8RrJ8n1SgafNb2dDKEbueY3oQtk04V7uCJVS5t
         yjZI9gqUOXErGfiI6X4S+PhCO9ysSXT93smY6wXJF9cBu3P/fj1Mmft/VFSEOUKd1xOq
         anvhG8jejQkz2eaYnkFzAp1djOyd+Uy+0R7sMKSQGJLY+cxgnWlF3OIng2b2xi3EtIY2
         51hg==
X-Gm-Message-State: APjAAAVwjDXE0aAXDxdedgFWzRen+VqtmLcJ6xNXaa/VuDtbGvGMFUP0
        dwhfxpNWc/juPoD2n3/K6DmHdgrk
X-Google-Smtp-Source: APXvYqwTDzOWdXfg9xccna1P6D2yGEFbft/5yf5set2a8qt8DFuSHJP76/z0E3YuNVdMJcj5W1t64Q==
X-Received: by 2002:a17:902:ff14:: with SMTP id f20mr819674plj.262.1575314780484;
        Mon, 02 Dec 2019 11:26:20 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id q6sm251408pfl.140.2019.12.02.11.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 11:26:20 -0800 (PST)
Date:   Mon, 2 Dec 2019 11:26:18 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] doc: replace MARC links with lore.kernel.org
Message-ID: <0f100f06c54702f0209f73a1a5b2482452d681de.1575314676.git.liu.denton@gmail.com>
References: <cover.1574882812.git.liu.denton@gmail.com>
 <cover.1575314676.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575314676.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we're now recommending lore.kernel.org, replace marc.info links
with lore.kernel.org.

Although MARC has been around for a long time, nothing lasts forever
(see Gmane). Since MARC uses opaque message identifiers, switching to
lore.kernel.org should be a strict improvement since, even if
lore.kernel.org goes down, the Message-ID will allow future readers to
look up the referenced messages on any other archive.

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
index 1ed3ca33b7..b9cda46a80 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -205,8 +205,8 @@ only affects the files in the working tree, but with
 entries, and with `--cached`, it modifies only the index
 entries.
 
-See also http://marc.info/?l=git&m=116563135620359 and
-http://marc.info/?l=git&m=119150393620273 for further
+See also https://lore.kernel.org/git/7v64clg5u9.fsf@assigned-by-dhcp.cox.net/ and
+https://lore.kernel.org/git/7vy7ej9g38.fsf@gitster.siamese.dyndns.org/ for further
 information.
 
 Some other commands that also work on files in the working tree and/or
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 8bce75b2cf..2ba5b7a20c 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -4687,5 +4687,5 @@ Write a chapter on using plumbing and writing scripts.
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

