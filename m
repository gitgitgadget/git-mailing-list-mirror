Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADE3C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 13:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E91A61059
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 13:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbhIJNEE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 09:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbhIJNED (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 09:04:03 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2795BC061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 06:02:52 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u15-20020a05600c19cf00b002f6445b8f55so1357168wmq.0
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 06:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fangyi-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=//kH8LfMD8D+Rh3K+0fl87sff3S6wTNEAzdO2wfkmlo=;
        b=gF9aBNhGEhQRQDIKhMB0GySTC6N3g6VAB9xs0im49PeGYmfdnrrpGVF+3ZnOdJ89wq
         D6hwok8L9oEfprTR5Kq1w/4wXd4UbAHwgQpTdGu6CPQ15IWVOdX2fIFTZGTMLP9TE7Ay
         BMz0mCudipxZKxydYLXNCi+OW0+x0hB0eI8VRDunHBo0Y8oKpRNmhC0v5y0PecYod7JR
         CEcdaKuIxAzXfCBcAnm+O6/gHJF+3cb3AjwSSOBdEVpOfIZR+QeIjiGrbYwEpXLVJUR/
         QPwtI4wDyg1YSqosGUKCxt+OEOq5r2qqhC27+Fg98GSUJc7VQrDnSSHVraSicu7zIMp5
         6HKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=//kH8LfMD8D+Rh3K+0fl87sff3S6wTNEAzdO2wfkmlo=;
        b=5AbTdD7S+AkCxVXhRooEpyPET0dHYMn+We7mTNg3WNynhA8gcEzBGMHcoB8e5xsdjl
         UCHc93rALqIu6ykbxoDazg+HLzCypELyKjwxIiOLDkeTZdghdYZz82SY8yW/WN5WfKHQ
         MsH1T4/6sM2rake4vEiy3LwrmTc4bSixO9IYHk2nPIFQes74m/fmfj5xn+8eFQhvQp1n
         CsM1pDwVrNoblRoPvUh3hl++/LNjV+7qII3v9hrbDw/rTr1ZPLwp7vvYWksNs6oz1C7M
         7FbfsQUyLyVhkTvJWEFUHP8wwmMjksJqaobtwwN4vgAiOeFTg27LezN8HoJixJ4ocUfB
         LpbQ==
X-Gm-Message-State: AOAM531Vyiu6IYLnA8htcceHMtCBKJhUe5aw+qqkNqBWt2q0o9ORLmoP
        9Si21Ej7b20+HOMqMoExCPftTM1chpAlBz5Q
X-Google-Smtp-Source: ABdhPJxCz3Znl2MuIvPTAKrl6PXzj3mBvDFuOIBVgZu5M5PTIc3oGgzWp+bJRuG9KBkZCkrpNF4KeQ==
X-Received: by 2002:a7b:c751:: with SMTP id w17mr8475355wmk.162.1631278970260;
        Fri, 10 Sep 2021 06:02:50 -0700 (PDT)
Received: from localhost.localdomain (cpc157871-brnt5-2-0-cust279.4-2.cable.virginm.net. [86.4.97.24])
        by smtp.googlemail.com with ESMTPSA id n5sm4228001wmd.29.2021.09.10.06.02.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Sep 2021 06:02:49 -0700 (PDT)
From:   Fangyi Zhou <me@fangyi.io>
To:     git@vger.kernel.org
Cc:     Fangyi Zhou <me@fangyi.io>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Birger Skogeng Pedersen <birgersp@gmail.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        CB Bailey <cbailey32@bloomberg.net>,
        =?UTF-8?q?Christopher=20D=C3=ADaz=20Riveros?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Christopher=20D=C3=ADaz=20Riveros?= <chrisadr@gentoo.org>,
        Ed Maste <emaste@FreeBSD.org>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Jean-Noel Avila <jean-noel.avila@scantech.fr>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Kazuhiro Kato <kato-k@ksysllc.co.jp>,
        Kazuhiro Kato <kazuhiro.kato@hotmail.co.jp>,
        Kevin Willford <Kevin.Willford@microsoft.com>,
        Kevin Willford <kewillf@microsoft.com>,
        Peter Kaestle <peter@piie.net>,
        Peter Kaestle <peter.kaestle@nokia.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan <sibisiv.siddharthan@gmail.com>,
        =?UTF-8?q?Slavica=20=C4=90uki=C4=87?= <slawica92@hotmail.com>,
        Slavica Djukic <slavicadj.ip2018@gmail.com>
Subject: [PATCH] .mailmap: Update mailmap
Date:   Fri, 10 Sep 2021 14:02:36 +0100
Message-Id: <20210910130236.40101-1-me@fangyi.io>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to a35b13fce0 (Update .mailmap, 2018-11-09).

This patch makes the output of `git shortlog -nse v2.10.0..master`
duplicate-free by taking/guessing the current and preferred
addresses for authors that appear with more than one address.

Updated from <20200805065408.1242617-1-martin.agren@gmail.com>,
taking into consideration of <xmqqsgcm4ij5.fsf@gitster.c.googlers.com>,
and other replies.

Use the by far most common e-mail address:
 * Brandon Williams
 * Jiang Xin

Use the most recent e-mail address:
 * Birger Skogeng Pedersen
 * Christopher Díaz Riveros
 * Ed Maste
 * Fangyi Zhou
 * Jean-Noël Avila
 * Kevin Willford
 * Peter Kaestle

Use the one from their "Signed-off-by":
 * Damien Robert
 * Kazuhiro Kato
 * Sibi Siddharthan

Use the most recent name / name with correct accents:
 * CB Bailey
 * Christopher Díaz Riveros
 * Jessica Clarke
 * Slavica Đukić

Do not merge:
 * Andreas Schwab

Signed-off-by: Fangyi Zhou <me@fangyi.io>

---
Please let me know if you approve those changes or not.
If no reply is received, the entry will be added in comments.

---
 .mailmap | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 9c6a446bdf..ff0887d9e0 100644
--- a/.mailmap
+++ b/.mailmap
@@ -27,13 +27,16 @@ Ben Peart <benpeart@microsoft.com> <peartben@gmail.com>
 Ben Walton <bdwalton@gmail.com> <bwalton@artsci.utoronto.ca>
 Benoit Sigoure <tsunanet@gmail.com> <tsuna@lrde.epita.fr>
 Bernt Hansen <bernt@norang.ca> <bernt@alumni.uwaterloo.ca>
+Birger Skogeng Pedersen <birger.sp@gmail.com> <birgersp@gmail.com>
 Brandon Casey <drafnel@gmail.com> <casey@nrlssc.navy.mil>
 Brandon Williams <bwilliams.eng@gmail.com> <bmwill@google.com>
+Brandon Williams <bwilliamseng@gmail.com> <bmwill@google.com>
 brian m. carlson <sandals@crustytoothpaste.net>
 brian m. carlson <sandals@crustytoothpaste.net> <sandals@crustytoothpaste.ath.cx>
 brian m. carlson <sandals@crustytoothpaste.net> <bk2204@github.com>
 Bryan Larsen <bryan@larsen.st> <bryan.larsen@gmail.com>
 Bryan Larsen <bryan@larsen.st> <bryanlarsen@yahoo.com>
+CB Bailey <cbailey32@bloomberg.net> Charles Bailey
 Cheng Renquan <crquan@gmail.com>
 Chris Shoemaker <c.shoemaker@cox.net>
 Chris Wright <chrisw@sous-sol.org> <chrisw@osdl.org>
@@ -41,10 +44,12 @@ Christian Ludwig <chrissicool@gmail.com> <chrissicool@googlemail.com>
 Cord Seele <cowose@gmail.com> <cowose@googlemail.com>
 Christian Couder <chriscool@tuxfamily.org> <christian.couder@gmail.com>
 Christian Stimming <stimming@tuhh.de> <chs@ckiste.goetheallee>
-Christopher Díaz Riveros <chrisadr@gentoo.org> Christopher Diaz Riveros
+Christopher Díaz Riveros <christopher.diaz.riv@gmail.com> <chrisadr@gentoo.org>
+Christopher Díaz Riveros <christopher.diaz.riv@gmail.com> Christopher Diaz Riveros
 Clemens Buchacher <drizzd@gmx.net> <drizzd@aon.at>
 Clemens Buchacher <drizzd@gmx.net> <clemens.buchacher@intel.com>
 Csaba Henk <csaba@gluster.com> <csaba@lowlife.hu>
+Damien Robert <damien.olivier.robert+git@gmail.com> <damien.olivier.robert@gmail.com>
 Dan Johnson <computerdruid@gmail.com>
 Dana L. How <danahow@gmail.com> <how@deathvalley.cswitch.com>
 Dana L. How <danahow@gmail.com> Dana How
@@ -64,13 +69,15 @@ Derrick Stolee <dstolee@microsoft.com> Derrick Stolee via GitGitGadget <gitgitga
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
@@ -102,11 +109,14 @@ Jason Riedy <ejr@eecs.berkeley.edu> <ejr@cs.berkeley.edu>
 Jay Soffian <jaysoffian@gmail.com> <jaysoffian+git@gmail.com>
 Jean-Noël Avila <jn.avila@free.fr> Jean-Noel Avila
 Jean-Noël Avila <jn.avila@free.fr> Jean-Noël AVILA
+Jean-Noël Avila <jn.avila@free.fr> Jean-Noel Avila <jean-noel.avila@scantech.fr>
 Jeff King <peff@peff.net> <peff@github.com>
 Jeff Muizelaar <jmuizelaar@mozilla.com> <jeff@infidigm.net>
 Jens Axboe <axboe@kernel.dk> <axboe@suse.de>
 Jens Axboe <axboe@kernel.dk> <jens.axboe@oracle.com>
 Jens Lindström <jl@opera.com> Jens Lindstrom <jl@opera.com>
+Jessica Clarke <jrtc27@jrtc27.com> James Clarke
+Jiang Xin <worldhello.net@gmail.com> <zhiyou.jx@alibaba-inc.com>
 Jim Meyering <jim@meyering.net> <meyering@redhat.com>
 Joachim Berdal Haga <cjhaga@fys.uio.no>
 Joachim Jablon <joachim.jablon@people-doc.com> <ewjoachim@gmail.com>
@@ -138,10 +148,12 @@ Karsten Blees <blees@dcon.de> <karsten.blees@dcon.de>
 Karsten Blees <blees@dcon.de> <karsten.blees@gmail.com>
 Kay Sievers <kay.sievers@vrfy.org> <kay.sievers@suse.de>
 Kay Sievers <kay.sievers@vrfy.org> <kay@mam.(none)>
+Kazuhiro Kato <kato-k@ksysllc.co.jp> <kazuhiro.kato@hotmail.co.jp>
 Kazuki Saitoh <ksaitoh560@gmail.com> kazuki saitoh <ksaitoh560@gmail.com>
 Keith Cascio <keith@CS.UCLA.EDU> <keith@cs.ucla.edu>
 Kent Engstrom <kent@lysator.liu.se>
 Kevin Leung <kevinlsk@gmail.com>
+Kevin Willford <Kevin.Willford@microsoft.com> <kewillf@microsoft.com>
 Kirill Smelkov <kirr@navytux.spb.ru> <kirr@landau.phys.spbu.ru>
 Kirill Smelkov <kirr@navytux.spb.ru> <kirr@mns.spb.ru>
 Knut Franke <Knut.Franke@gmx.de> <k.franke@science-computing.de>
@@ -211,6 +223,7 @@ Peter Baumann <waste.manager@gmx.de> <Peter.B.Baumann@stud.informatik.uni-erlang
 Peter Baumann <waste.manager@gmx.de> <siprbaum@stud.informatik.uni-erlangen.de>
 Peter Krefting <peter@softwolves.pp.se> <peter@softwolves.pp.se>
 Peter Krefting <peter@softwolves.pp.se> <peter@svarten.intern.softwolves.pp.se>
+Peter Kaestle <peter@piie.net> <peter.kaestle@nokia.com>
 Petr Baudis <pasky@ucw.cz> <pasky@suse.cz>
 Petr Baudis <pasky@ucw.cz> <xpasky@machine>
 Phil Hord <hordp@cisco.com> <phil.hord@gmail.com>
@@ -242,9 +255,11 @@ Sebastian Schuberth <sschuberth@gmail.com> <sschuberth@visageimaging.com>
 Seth Falcon <seth@userprimary.net> <sfalcon@fhcrc.org>
 Shawn O. Pearce <spearce@spearce.org>
 Wei Shuyu <wsy@dogben.com> Shuyu Wei
+Sibi Siddharthan <sibisiddharthan.github@gmail.com> <sibisiv.siddharthan@gmail.com>
 Sidhant Sharma <tigerkid001@gmail.com> Sidhant Sharma [:tk]
 Simon Hausmann <hausmann@kde.org> <simon@lst.de>
 Simon Hausmann <hausmann@kde.org> <shausman@trolltech.com>
+Slavica Đukić <slawica92@hotmail.com> Slavica Djukic <slavicadj.ip2018@gmail.com>
 Stefan Beller <stefanbeller@gmail.com> <stefanbeller@googlemail.com>
 Stefan Beller <stefanbeller@gmail.com> <sbeller@google.com>
 Stefan Naewe <stefan.naewe@gmail.com> <stefan.naewe@atlas-elektronik.com>
@@ -296,3 +311,7 @@ Yi-Jyun Pan <pan93412@gmail.com>
 anonymous <linux@horizon.com>
 anonymous <linux@horizon.net>
 İsmail Dönmez <ismail@pardus.org.tr>
+
+# Do not merge
+# Andreas Schwab <schwab@linux-m68k.org>
+# Andreas Schwab <schwab@suse.de>
-- 
2.32.0

