Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C18EB64DC
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 10:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjGHK4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jul 2023 06:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHK4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2023 06:56:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA0C12C
        for <git@vger.kernel.org>; Sat,  8 Jul 2023 03:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1688813782; x=1689418582; i=georgmueller@gmx.net;
 bh=nbrBmqlhOOcxlG1ynz3yjLLagVKgsU2FU5OcLcyGXhY=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PojbHmY0oVnBuIPAuv1OZdPtgxlyxNan+cT4iLp8C0I0/l9sBsDc+7+4DvTHwzvUxlFkMAB
 DjWIXgMv3NS37SEWf1zNubsuEmSLqNl6MCgxxg2SBcpDjrd0ZdiTnziaR4nvSj/vz4P/5T3Et
 kHc6ZiqAlePa+fC08O2wfDj6cbjsJgTc/iFK32jcloW487eQs3JjSXJJ8/HyYaP1KVGXZQ/fg
 HvRk3oarptX3ueiWASCFO9sT1kPi79dYakV8kW54vjedroKz0n5qQEfXqiyx54/AZbTEefqGH
 nkNLCoHGH6KDCLLh9owt4IsowX5hfmIOydYW/cIsGeO+RupfBbIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from nb-georg.home ([109.104.37.175]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mr9Bk-1pgKx60gru-00oIbU; Sat, 08
 Jul 2023 12:56:22 +0200
From:   =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
Subject: [PATCH 1/2] gitk: limit factor scaling on resize to widths below 1900px
Date:   Sat,  8 Jul 2023 12:55:43 +0200
Message-ID: <20230708105546.2945446-3-georgmueller@gmx.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230708105546.2945446-2-georgmueller@gmx.net>
References: <20230708105546.2945446-2-georgmueller@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ahJAzHHQriGc63oZ18WQz8UCRHQh8kTXmo+3O09+W1zbpFxfdDQ
 vE2uDyEimUcwnU6YEYDbWYUzsaPotUIonMMCjxiUVaM4NUURbMi3kNcbrZnEmfjhTFj2VQi
 sE7uVPc0Hb1W2lAa95ehwXYMnmb8NQrVVwmf3kZm2Vp46kDU0B6FnUuneI5PJG4uSigzFLD
 7wGAeZYcE3v5fEq0CTSgQ==
UI-OutboundReport: notjunk:1;M01:P0:W0732f7LyC4=;Iw949T/C4ZJpcRYS9+qGG93l1FS
 iVNGU2o1WTtpfaH8lRABiAamTgJO0gJvzElsBueZ7J58qKM0HL/Vj0IR2UYvHuWz01LxDDCW1
 j+Ji7aqj92ovnHtG7PDLCNkuzE9vqUFa42GIL5EYZ3NBvM5Dn4UIVciZNnEXkqaNSfkAaBxi/
 OpUN6CW80JUWr0fBYvluhOGTetbtZUXT4shMSA6ofWR6R+dossnjJAUNpLDNDG5T52WXfHfMc
 h7dLbAtCHK6zl3escMZr2JR8BGpuUX3kM2JyfUSuloXl+BVquiFIAY9CiLiIi1jm1Ebl3I3Z2
 EzLDy2xOeCx/MM3tk9Rdn9JUu4ogf5MIyVxVDkrEdwfRCEUVojG24FOHCJRE8JOxzKObrp9CP
 i5TpnR0iaWdXaDCzx0c0v02xJ8RSruiPpRPbalWyYJv/RKZ5sj9r6LOcJlf+bJEXmjKKttjxp
 Vq850uOWWmY2OYcQMSTKjqVfkzGnZv979lQ2Wnt8ZXlYIHrUBRfTCHxb6wULiRQk3lFf7K0mG
 rAN+nZ/BH5rnIZW7TuwuPr4RkEOCkTX0br3WeMis75xKxqfXKVGMStu/UO2Zoox0SVBMRrY3M
 jexlpmaRSs2T2bKOsr5Mzv4EyhI8SN2dObF0k3UzEA5pZRH0ymT+uJhU6B9iUANnpXivp5CwB
 eMSXKeuioRc3TrVinDAx6Lj2oRNN+LAYcXxWRTfnKuZtGsu/FkxV3SiO+3EcyaaZH8Lkrh/IQ
 qCwD2GLT7jMgCsjR0Pw88KsCpm9+bGBRIu5Qg4YVbs3Sgfg/JxHZR4VABbG4wQbOT0CrnrvcK
 vaStulJ90jsM7gmeTojNInRXGRkNakpbhk4N21tq/bi8SiMgfpfQUu1eA6YKEPUWXdDs57vGd
 25wvMeaI1ibAEc8eAAECW4ojSwq0AqL5MLlpm0RUBdMJBSEb0dEwEZEKzcK3QicxbeC8w0GS1
 DueQogg2KKDqJivKobPcAfDaMgI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If old and new width is above 1900, the scaling would result in widening
the author and date column unnecessarily.

Signed-off-by: Georg M=C3=BCller <georgmueller@gmx.net>
=2D--
 gitk-git/gitk | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index df3ba2ea99..0f229aadd7 100755
=2D-- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2985,6 +2985,9 @@ proc resizeclistpanes {win w} {
             set s0 [$win sash coord 0]
             set s1 [$win sash coord 1]
         }
+        if {$oldwidth($win) > 1900 && $w > 1900} {
+            return
+        }
         if {$w < 60} {
             set sash0 [expr {int($w/2 - 2)}]
             set sash1 [expr {int($w*5/6 - 2)}]
@@ -3029,6 +3032,9 @@ proc resizecdetpanes {win w} {
         } else {
             set s0 [$win sash coord 0]
         }
+        if {$oldwidth($win) > 1900 && $w > 1900} {
+            return
+        }
         if {$w < 60} {
             set sash0 [expr {int($w*3/4 - 2)}]
         } else {
=2D-
2.41.0

