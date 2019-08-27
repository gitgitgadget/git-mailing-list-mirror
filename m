Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D9C81F461
	for <e@80x24.org>; Tue, 27 Aug 2019 08:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfH0I4j (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 04:56:39 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54839 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfH0I4j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 04:56:39 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i2XHK-0007Jn-4m; Tue, 27 Aug 2019 10:56:38 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i2XHJ-00084z-Sc; Tue, 27 Aug 2019 10:56:37 +0200
Date:   Tue, 27 Aug 2019 10:56:37 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, entwicklung@pengutronix.de
Subject: Re: git slow unless piped to cat
Message-ID: <20190827085637.g6cpnuofpteyfqfz@pengutronix.de>
References: <20190827081559.mt5wjpdvqzn62dib@pengutronix.de>
 <20190827084111.GU20404@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190827084111.GU20404@szeder.dev>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 10:41:11AM +0200, SZEDER Gábor wrote:
> On Tue, Aug 27, 2019 at 10:15:59AM +0200, Uwe Kleine-König wrote:
> > I have a problem here with git being slow in some situations.
> > Using git 2.23.0 (from Debian) the effect is:
> > 
> > ukl@dude.ptx:/ptx/src/git/linux.git$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"; time git show v5.2
> > tag v5.2
> > ...
> > 
> > real	0m12.727s
> > user	0m0.300s
> > sys	0m0.371s
> > 
> > But to get the actual data isn't the problem:
> > 
> > ukl@dude.ptx:/ptx/src/git/linux.git$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"; time git show v5.2 | cat
> > tag v5.2
> > ...
> > 
> > real	0m0.764s
> > user	0m0.014s
> > sys	0m0.020s
> > 
> 
> How does 'git --no-pager show v5.2' perform?  If it's as fast as the
> case piping the output to cat, then look into what pager and pager
> options you use.

	ukl@dude.ptx:/ptx/src/git/linux.git$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"; time git --no-pager show v5.2
	tag v5.2
	...

	real	0m13.225s
	user	0m0.355s
	sys	0m0.336s

So this doesn't seem to be the problem. Also the local configuration
can be ruled out:

	ukl@dude.ptx:/ptx/src/git/linux.git$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"; time env GIT_CONFIG_NOSYSTEM=1 HOME=/nonexistant XDG_CONFIG_HOME=/nonexistant git --no-pager show --no-color v5.2
	tag v5.2
	...

	real	0m13.587s
	user	0m0.335s
	sys	0m0.336s

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
