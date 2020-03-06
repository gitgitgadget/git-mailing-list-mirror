Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1404EC10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 09:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70EE20848
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 09:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgCFJTf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:19:35 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49317 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgCFJTe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 04:19:34 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jA98n-0002gD-NB; Fri, 06 Mar 2020 10:19:33 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jA98n-0007lV-Cn; Fri, 06 Mar 2020 10:19:33 +0100
Date:   Fri, 6 Mar 2020 10:19:33 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     git@vger.kernel.org
Cc:     entwicklung@pengutronix.de
Subject: git range-diff picky about passed ranges
Message-ID: <20200306091933.mx2jmurmdnsjua4b@pengutronix.de>
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

taking the Linux repository (with stable) as an example[1]. Commit
24906a41eecb73d51974ade0847c21e429beec60 was backported to
stable/linux-5.3.y. Using git version 2.25.1 (as provided by Debian) and
2.26-rc0 (built from junio/master).

To compare these I'd like to use the rev^! syntax with git range-diff,
but range-diff refuses:

	$ git range-diff dc5ae31afbae83038dfce8d2bd35bbe7ba05a536^!  24906a41eecb73d51974ade0847c21e429beec60^!
	fatal: no .. in range: 'dc5ae31afbae83038dfce8d2bd35bbe7ba05a536^!'

I would expect this command to give the same output as

	c1=dc5ae31afbae83038dfce8d2bd35bbe7ba05a536
	c2=24906a41eecb73d51974ade0847c21e429beec60
	git range-diff $c1^..$c1 $c2^..$c2

. After all, $c1^! is supposed to be equivalent to $c1^..$c1 (at least
for commits with exactly on parent as is the case here).

Best regards
Uwe

[1] so suitable remotes are:

	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
