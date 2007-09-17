From: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: git-send-email creates duplicate Message-Id's
Date: Mon, 17 Sep 2007 23:47:01 +0300
Message-ID: <20070917204701.GU6372@mea-ext.zmailer.org>
References: <11900179463203-git-send-email-avi@qumranet.com> <20070917155901.GP18232@stusta.de> <7vejgxyrde.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adrian Bunk <bunk@kernel.org>, Avi Kivity <avi@qumranet.com>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 22:47:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXNUv-0008PX-SU
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 22:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756924AbXIQUrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 16:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752685AbXIQUrH
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 16:47:07 -0400
Received: from z2.cat.iki.fi ([212.16.98.133]:38417 "EHLO z2.cat.iki.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751918AbXIQUrG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 16:47:06 -0400
Received: (mea@mea-ext) by mail.zmailer.org id S2261613AbXIQUrB (ORCPT
	<rfc822;git@vger.kernel.org> + 1 other);
	Mon, 17 Sep 2007 23:47:01 +0300
Content-Disposition: inline
In-Reply-To: <7vejgxyrde.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58480>

On Mon, Sep 17, 2007 at 01:22:05PM -0700, Junio C Hamano wrote:
> Adrian Bunk <bunk@kernel.org> writes:
> 
> > The following might be a bug in git-send-email (git maintainers Cc'ed
> > and KVM list removed from Cc): 
> >
> > Patch 54 got the same Message-Id as patch 61 and patch 89 got the same 
> > Message-Id as patch 104.
> > ...
> > The emails are:
> > http://marc.info/?l=linux-kernel&m=119002061330270&w=2
> > http://marc.info/?l=linux-kernel&m=119002059626434&w=2
> > http://marc.info/?l=linux-kernel&m=119002060011801&w=2
> > http://marc.info/?l=linux-kernel&m=119002060318915&w=2
> 
> The old code generated rand(4200) for each message and appended
> it to the timestamp.  I do not know where the original author
> got 4200 from, but I think if you send many messages within a
> single second it is possible to get collisions.
> 
> I guess something like this patch is an improvement?  It
> generates a single prefix from timestamp and random, and appends
> a number that is incremented for each message.

Much better.   You may also consider a possibility of
letting your local MTA do the  Message-ID generation, unless
you are tracking something with it and thus need to know the
generated values.  .. but apparently git much prefers sending
email by SMTP, where the message-id must be present, or one
really should block any such emails..  (except that systems
like qmail send error messages without message-id ...)

My own recipe is:
       sprintf("%d-%d-%d", time , getpid, ++localsequence)
catenate on that your favourite domain name where that recipe
is likely to be valid, and you are all set.


  /Matti Aarnio  --  one of  <postmaster@vger.kernel.org>
