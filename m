Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81CDC2BAEE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 17:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BAB208CA
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 17:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgCXR3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:29:51 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48155 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbgCXR3v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 13:29:51 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jGnN7-00032x-FW; Tue, 24 Mar 2020 18:29:49 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jGnN7-0006zt-4t; Tue, 24 Mar 2020 18:29:49 +0100
Date:   Tue, 24 Mar 2020 18:29:49 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     git@vger.kernel.org
Cc:     oystwa@gmail.com, entwicklung@pengutronix.de
Subject: bug in git-log with funny merges
Message-ID: <20200324172949.yx7kketvkkl5lyvt@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

TL;DR: how can @~..v5.4.27 be empty, but @..v5.4.27 contain commits?

I hit a situation with git that I don't understand. After asking in #git
I found two others who agree this is strange and I should report here.

You can recreate my history with the following commands:

	$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
	$ cd linux
	$ git remote add -f stable git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
	$ wget https://www.kleine-koenig.org/tmp/funnymerge
	$ git fetch funnymerge HEAD
	$ git checkout FETCH_HEAD

With that in place I have:

	$ git log --oneline --boundary --graph v5.4.27..
	*---.   86fd3e9df543 (HEAD) customers/sample/20200324-1
	|\ \ \  
	| | | * 6bfe59d959c3 iio: dac: ltc2632: remove some unused defines
	| | | * fc25f80fa2d6 iio: dac: ltc2632: add support for LTC2636 family
	| | | * aaf713847341 iio: dac: ltc2632: drop some duplicated data
	| | | * 36f4e0527245 dt-bindings: iio: ltc2632: expand for ltc2636 support
	| | * | dd98c18c4ae4 rtc: pcf2127: implement reading battery status bits
	| | |/  
	| * | 2704eba85eb7 serial: imx: use hrtimers for rs485 delays
	| * | 6fde0395f781 serial: imx: implement rts delaying for rs485
	| * | c288981265b7 serial: imx: support an enable-gpio
	| * | a7198bfcc09f serial: imx: fix a race condition in receive path
	| * | 38777ea60445 tty: serial: imx: use the sg count from dma_map_sg
	| * | 9dabd7937faf serial: imx: adapt rx buffer and dma periods
	* | | d1437a91a10e Release customers/sample/20200324-1
	* | | 803aad81ca69 iio: dac: ltc2632: remove some unused defines
	* | | 8a4579487b00 iio: dac: ltc2632: add support for LTC2636 family
	* | | 25a9309d7ded iio: dac: ltc2632: drop some duplicated data
	* | | e8f40385c55d dt-bindings: iio: ltc2632: expand for ltc2636 support
	* | | b95a62694eae rtc: pcf2127: implement reading battery status bits
	* | | f5af38a6b7a1 serial: imx: use hrtimers for rs485 delays
	* | | 14075cd0ce1b serial: imx: implement rts delaying for rs485
	* | | 338647d2ab5c serial: imx: support an enable-gpio
	* | | b31f3c6fbc18 serial: imx: adapt rx buffer and dma periods
	o | | 585e0cc08069 (tag: v5.4.27, stable/linux-5.4.y) Linux 5.4.27
	 / /  
	o / da0c9ea146cb (tag: v5.4-rc2) Linux 5.4-rc2
	 /  
	o 219d54332a09 (tag: v5.4) Linux 5.4

(This is a tree format we use to archive kernel trees for our customers.
It contains a snapshot of the relevant topic branches and a
linearisation to put into a quilt stack.)

So v5.4.27 is an ancestor of HEAD:

	$ git merge-base --is-ancestor v5.4.27 @ && echo yes
	yes

But!:

	$ git rev-list --count HEAD..v5.4.27
	3868

So there are 3868 patches that are in v5.4.27 but not HEAD? I would have
expected zero. Also

	$ git log HEAD..v5.4.27

lists commits, but

	$ git log HEAD~..v5.4.27

does not. (The latter is expected.)

I tested with git 2.26.0 and also git 2.0.0 and on different machines,
with the same results.

Am I missing something, or is there a (quite old) bug in git somewhere?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
