Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD68C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 16:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59AA520786
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 16:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="al2A9LpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgCaQUT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:20:19 -0400
Received: from forward400p.mail.yandex.net ([77.88.28.105]:32956 "EHLO
        forward400p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730011AbgCaQUT (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 31 Mar 2020 12:20:19 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Mar 2020 12:20:18 EDT
Received: from mxback30j.mail.yandex.net (mxback30j.mail.yandex.net [IPv6:2a02:6b8:0:1619::230])
        by forward400p.mail.yandex.net (Yandex) with ESMTP id D67B21BC12E1
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 19:15:13 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback30j.mail.yandex.net (mxback/Yandex) with ESMTP id kc3glIl72K-FDkqa7QQ;
        Tue, 31 Mar 2020 19:15:13 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1585671313;
        bh=RB2zkM8uL1+YzKHoNZo4l7jpom298dw6yxycueCzOsY=;
        h=Message-Id:Date:Subject:To:From;
        b=al2A9LpAgWUZRo9xUYEzX3vkb3rR0HdRTLAu2Zi2vl0YE6N5uST77wBnr/KtRRos1
         zSBimNMGkFB2waXQtmuyT4Nf+NAr3tHQLCCaZqezX8AFJ1r1eq3uExgfhkgKbMvGNO
         lxwuhqRbh1J0Yi/y1aLQHEts8BrgVMARqhxQYk3A=
Authentication-Results: mxback30j.mail.yandex.net; dkim=pass header.i=@ya.ru
Received: by myt4-eb6256e01f8b.qloud-c.yandex.net with HTTP;
        Tue, 31 Mar 2020 19:15:13 +0300
From:   =?utf-8?B?X1J1Um9fICjQkNC90LTRgNC10Lkg0KHRgtC+0YbQutC40Lkp?= 
        <ruro.ruro@ya.ru>
Envelope-From: ruro-ruro@yandex.ru
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [BUG] git pull -- error: nothing to do
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 31 Mar 2020 19:15:13 +0300
Message-Id: <8017591585671131@myt3-605d5ea4bc20.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After updating git from `v2.25.1` to `v2.26.0`, I've noticed that performing `git pull` on an up-to-date repository now results in a non-zero exit code and `error: nothing to do` on stderr.
With version 2.25.1, `git pull` used to finish with exit code 0 and `Current branch master is up to date.` on stdout.

The current (`v2.26.0`) behaviour only happens with the following config options:
```
[pull]
    rebase = true
[rebase]
    autoSquash = true
    abbreviateCommands = true
```
If any 1 of the 3 config options is not set, there is no error.

I think, this is a bug since many scripts and utilities rely on the exit code of `git pull` and the current behaviour causes false errors.

-- 
Andrey Stotskiy,
ruro.ruro@ya.ru
