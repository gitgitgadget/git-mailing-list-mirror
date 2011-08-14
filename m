From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/7] sequencer: Remove sequencer state after final commit
Date: Sun, 14 Aug 2011 16:32:00 -0500
Message-ID: <20110814213200.GA6555@elie.gateway.2wire.net>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-8-git-send-email-artagnon@gmail.com>
 <20110814160440.GK18466@elie.gateway.2wire.net>
 <7vei0nn1cn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 23:32:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsiI3-0002k0-DI
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 23:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362Ab1HNVcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 17:32:10 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52416 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753989Ab1HNVcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 17:32:09 -0400
Received: by gya6 with SMTP id 6so2886489gya.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 14:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EMcQjr0gH7Wp2P02LJn6QCIWvUQ2Nf7DxpiN9VXS+Y4=;
        b=xwf6NLJO5eynsZHEv/wPLNe6LjCMRoryuc47dOv6OSCODtXjtrgJX32VATymFv5M6l
         mIWb382YONZU+IgSlQcWl7s1bcpuvCvTLb0RxdDjhgCI1wLNKjSuprD2pR02NQcQuBbE
         U8Vthq8bT9rafzc584+DRghLo4PYEd5HRYPGk=
Received: by 10.150.244.18 with SMTP id r18mr4225490ybh.78.1313357527826;
        Sun, 14 Aug 2011 14:32:07 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-76-206-233-80.dsl.chcgil.sbcglobal.net [76.206.233.80])
        by mx.google.com with ESMTPS id g16sm3274954ybi.8.2011.08.14.14.32.06
        (version=SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 14:32:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vei0nn1cn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179348>

Hi Junio,

Junio C Hamano wrote:

> It still is unclear why "removing the sequencer state when no more insns
> are pending" is so necessary that the codebase needs to bend backwards to
> support that in the first place. What problem is d3f4628e really trying to
> solve?

I believe it is meant to support command sequences such as these:

1.
	git cherry-pick foo; # has conflicts
	... resolve conflicts and "git add" the resolved files ...
	git commit
	git cherry-pick bar

2.
	git cherry-pick foo bar; # has conflicts applying "bar"
	... resolve ...
	git commit
	git cherry-pick baz

Those were intuitive things to do before the sequencer existed, and if
I understand correctly, d3f4628e was intended to support people and
scripts (such as the test suite) that have these commands wired into
their fingers.
