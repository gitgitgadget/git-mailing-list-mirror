Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9431FC433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 21:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EBB822B42
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 21:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsL+LbZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHDVIO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgHDVIO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 17:08:14 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19E5C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 14:08:13 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b11so23135369lfe.10
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 14:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NxEcV8jmoVbILN5FPHhnj43KQN7di6FNkFxcJF5OFU4=;
        b=EsL+LbZw2yPAMA+UCP3MeXE4Mk13trVli3Xc5ocmeUsmKWikXx6a8UHT+RlHx5GOCV
         I4HF5v1z4LeE0BtvomayKuNzYgLSdBiC962CFoQQKMtQq5264AOHrcQKID6Bpvwys/IU
         cjgVcKh7fLKQkygFidceWvAFNKRZhSXcJX617pW1rgSHtbJfhu+R4T4VvGFyJud8wOez
         13FheBVIC14FFVlXVAuKNa5Pdgadg5Os8GgGA14W9UtKsCa+8l+PNbVNR1YIHFJA9tPE
         tb3hOUZfBrU6c3m3NzGcYnydnUwJoq5HwmjMRR5BgCfC7v4JhT/aB2oNsSQ9yIGijazn
         hoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NxEcV8jmoVbILN5FPHhnj43KQN7di6FNkFxcJF5OFU4=;
        b=PpWwRbt+FFjkEjZodsrdUu2f+rJ5Yt3a3+Z452p3G0mTrtN8Wjhbdlsv+0WUKzrFpm
         RREzrXH4AZEBe5UWoSAocyQsA3H0nxqTBtYDz1PqZKt0AYveWVphOqwJidiPaQS5gZ4C
         O0GNRbNqT45kfJwc/gX1D0fDX4bzTmPunukhQof9f7zx3jBdoroKO+1UU29rinx+KTAO
         wcxLANIMUtyVjrJq1I+yy2Ay1Mp8stwAnu1BXxPiEQhLdYjdNdTxDt/Q0Ai++GhF0so2
         be/Rdl1fGcFKgBJDRWi8gEpgQ8TO6Uv+iSAYnjH0/iScPGdaTDbWn8Qaw8jsggd8wHe2
         2X5Q==
X-Gm-Message-State: AOAM530BNcwm15vQzRwBIti7T0A40po5fM9rQKim8j5yoridvZiIE34+
        7uqZG4AU2au5fQJW5gRrUMS6uKWK
X-Google-Smtp-Source: ABdhPJwOF+W/UCI4zwe+KBaunSASLpMRoQ8MYBbWUMmKN32LBCOLR3ZPzbW+3gLKGVLDNhdED61zRA==
X-Received: by 2002:a19:230e:: with SMTP id j14mr38902lfj.19.1596575291765;
        Tue, 04 Aug 2020 14:08:11 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id t22sm70614lfr.12.2020.08.04.14.08.10
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 14:08:10 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] Update .mailmap
Date:   Tue,  4 Aug 2020 23:07:58 +0200
Message-Id: <20200804210758.1241259-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to a35b13fce0 ("Update .mailmap", 2018-11-09), make the output
of `git shortlog -nse v2.10.0..master` duplicate-free by taking/guessing
the current and preferred addresses for authors that appear with more
than one address.

Use the by far most common e-mail address:
 * Brandon Williams
 * Jiang Xin

Use the most recent e-mail address:
 * Andreas Schwab
 * Birger Skogeng Pedersen
 * Ed Maste
 * Fangyi Zhou
 * Kevin Willford
 * Peter Kaestle

Use the one from their "Signed-off-by":
 * Damien Robert
 * Sun Chao

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 .mailmap | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index bde7aba756..b4e6eb7dd7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -18,6 +18,7 @@ Alexey Shumkin <alex.crezoff@gmail.com> <zapped@mail.ru>
 Alexey Shumkin <alex.crezoff@gmail.com> <Alex.Crezoff@gmail.com>
 Anders Kaseorg <andersk@MIT.EDU> <andersk@ksplice.com>
 Anders Kaseorg <andersk@MIT.EDU> <andersk@mit.edu>
+Andreas Schwab <schwab@linux-m68k.org> <schwab@suse.de>
 Andrey Mazo <ahippo@yandex.com> Mazo, Andrey <amazo@checkvideo.com>
 Aneesh Kumar K.V <aneesh.kumar@gmail.com>
 Amos Waterland <apw@debian.org> <apw@rossby.metr.ou.edu>
@@ -27,8 +28,10 @@ Ben Peart <benpeart@microsoft.com> <peartben@gmail.com>
 Ben Walton <bdwalton@gmail.com> <bwalton@artsci.utoronto.ca>
 Benoit Sigoure <tsunanet@gmail.com> <tsuna@lrde.epita.fr>
 Bernt Hansen <bernt@norang.ca> <bernt@alumni.uwaterloo.ca>
+Birger Skogeng Pedersen <birger.sp@gmail.com> <birgersp@gmail.com>
 Brandon Casey <drafnel@gmail.com> <casey@nrlssc.navy.mil>
 Brandon Williams <bwilliams.eng@gmail.com> <bmwill@google.com>
+Brandon Williams <bwilliams.eng@gmail.com> <bwilliamseng@gmail.com>
 brian m. carlson <sandals@crustytoothpaste.net>
 brian m. carlson <sandals@crustytoothpaste.net> <sandals@crustytoothpaste.ath.cx>
 brian m. carlson <sandals@crustytoothpaste.net> <bk2204@github.com>
@@ -45,6 +48,7 @@ Christopher Díaz Riveros <chrisadr@gentoo.org> Christopher Diaz Riveros
 Clemens Buchacher <drizzd@gmx.net> <drizzd@aon.at>
 Clemens Buchacher <drizzd@gmx.net> <clemens.buchacher@intel.com>
 Csaba Henk <csaba@gluster.com> <csaba@lowlife.hu>
+Damien Robert <damien.olivier.robert+git@gmail.com> <damien.olivier.robert@gmail.com>
 Dan Johnson <computerdruid@gmail.com>
 Dana L. How <danahow@gmail.com> <how@deathvalley.cswitch.com>
 Dana L. How <danahow@gmail.com> Dana How
@@ -64,13 +68,15 @@ Derrick Stolee <dstolee@microsoft.com> Derrick Stolee via GitGitGadget <gitgitga
 Deskin Miller <deskinm@umich.edu>
 Đoàn Trần Công Danh <congdanhqx@gmail.com> Doan Tran Cong Danh
 Dirk Süsserott <newsletter@dirk.my1.cc>
+Ed Maste <emaste@FreeBSD.org> <emaste@freebsd.org>
 Eric Blake <eblake@redhat.com> <ebb9@byu.net>
 Eric Hanchrow <eric.hanchrow@gmail.com> <offby1@blarg.net>
 Eric S. Raymond <esr@thyrsus.com>
 Eric Wong <e@80x24.org> <normalperson@yhbt.net>
 Erik Faye-Lund <kusmabite@gmail.com> <kusmabite@googlemail.com>
 Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> <eyvind-git@orakel.ntnu.no>
-Fangyi Zhou <fangyi.zhou@yuriko.moe> Zhou Fangyi
+Fangyi Zhou <me@fangyi.io> <fangyi.zhou@yuriko.moe>
+Fangyi Zhou <me@fangyi.io> Zhou Fangyi <fangyi.zhou@yuriko.moe>
 Florian Achleitner <florian.achleitner.2.6.31@gmail.com> <florian.achleitner2.6.31@gmail.com>
 Franck Bui-Huu <vagabon.xyz@gmail.com> <fbuihuu@gmail.com>
 Frank Lichtenheld <frank@lichtenheld.de> <djpig@debian.org>
@@ -107,6 +113,8 @@ Jeff Muizelaar <jmuizelaar@mozilla.com> <jeff@infidigm.net>
 Jens Axboe <axboe@kernel.dk> <axboe@suse.de>
 Jens Axboe <axboe@kernel.dk> <jens.axboe@oracle.com>
 Jens Lindström <jl@opera.com> Jens Lindstrom <jl@opera.com>
+Jiang Xin <worldhello.net@gmail.com> <xin.jiang@huawei.com>
+Jiang Xin <worldhello.net@gmail.com> <zhiyou.jx@alibaba-inc.com>
 Jim Meyering <jim@meyering.net> <meyering@redhat.com>
 Joachim Berdal Haga <cjhaga@fys.uio.no>
 Joachim Jablon <joachim.jablon@people-doc.com> <ewjoachim@gmail.com>
@@ -142,6 +150,7 @@ Kazuki Saitoh <ksaitoh560@gmail.com> kazuki saitoh <ksaitoh560@gmail.com>
 Keith Cascio <keith@CS.UCLA.EDU> <keith@cs.ucla.edu>
 Kent Engstrom <kent@lysator.liu.se>
 Kevin Leung <kevinlsk@gmail.com>
+Kevin Willford <Kevin.Willford@microsoft.com> <kewillf@microsoft.com>
 Kirill Smelkov <kirr@navytux.spb.ru> <kirr@landau.phys.spbu.ru>
 Kirill Smelkov <kirr@navytux.spb.ru> <kirr@mns.spb.ru>
 Knut Franke <Knut.Franke@gmx.de> <k.franke@science-computing.de>
@@ -213,6 +222,7 @@ Peter Krefting <peter@softwolves.pp.se> <peter@softwolves.pp.se>
 Peter Krefting <peter@softwolves.pp.se> <peter@svarten.intern.softwolves.pp.se>
 Petr Baudis <pasky@ucw.cz> <pasky@suse.cz>
 Petr Baudis <pasky@ucw.cz> <xpasky@machine>
+Peter Kaestle <peter@piie.net> <peter.kaestle@nokia.com>
 Phil Hord <hordp@cisco.com> <phil.hord@gmail.com>
 Philip Jägenstedt <philip@foolip.org> <philip.jagenstedt@gmail.com>
 Philip Oakley <philipoakley@iee.email> <philipoakley@iee.org> # secondary <philipoakley@dunelm.org.uk>
@@ -256,6 +266,7 @@ Steven Grimm <koreth@midwinter.com> <sgrimm@sgrimm-mbp.local>
 Steven Grimm <koreth@midwinter.com> koreth@midwinter.com
 Steven Walter <stevenrwalter@gmail.com> <swalter@lexmark.com>
 Steven Walter <stevenrwalter@gmail.com> <swalter@lpdev.prtdev.lexmark.com>
+Sun Chao <sunchao9@huawei.com> <16657101987@163.com>
 Sven Verdoolaege <skimo@kotnet.org> <Sven.Verdoolaege@cs.kuleuven.ac.be>
 Sven Verdoolaege <skimo@kotnet.org> <skimo@liacs.nl>
 SZEDER Gábor <szeder.dev@gmail.com> <szeder@ira.uka.de>
-- 
2.28.0.236.gb10cc79966

