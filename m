From: Sam Vilain <sam@vilain.net>
Subject: Re: [spf:guess] Re: Git import of the recent full enwiki dump
Date: Sat, 17 Apr 2010 13:44:56 +1200
Message-ID: <1271468696.3302.35.camel@denix>
References: <w2x2d460de71004161647z41492baav3685249fa05145d6@mail.gmail.com>
	 <m2ofabb9a1e1004161719h977b53b7oc2c452c2a2b0025e@mail.gmail.com>
	 <20100417004852.GA32053@post.servercare.de>
	 <20100417005342.GA8475@spearce.org>
	 <20100417010147.GB32053@post.servercare.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Sebastian Bober <sbober@servercare.de>
X-From: git-owner@vger.kernel.org Sat Apr 17 03:45:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2x6E-0007Wp-A8
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 03:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321Ab0DQBpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 21:45:06 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:55730 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109Ab0DQBpF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 21:45:05 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 4251921C406; Sat, 17 Apr 2010 13:45:02 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 86AE421C381;
	Sat, 17 Apr 2010 13:44:57 +1200 (NZST)
In-Reply-To: <20100417010147.GB32053@post.servercare.de>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145221>

On Sat, 2010-04-17 at 03:01 +0200, Sebastian Bober wrote:
> I'm not dissing fast-import, it's fantastic. We tried with 2-10 level
> deep trees (the best depth being 3), but after some million commits it
> just got unbearably slow, with the ETA constantly rising.

How often are you checkpointing?  Like any data import IME, you can't
leave transactions going indefinitely and expect good performance!

Would it be at all possible to consider using a submodule for each page?
With a super-project commit which is updated for every day of updates or
so.

This will create a natural partitioning of the data set in a way which
is likely to be more useful and efficient to work with.  Hand-held
devices can be shipped with a "shallow" clone of the main repository,
with shallow clones of the sub-repositories too (in such a setup, the
device would not really use a checkout of course to save space).  Then,
history for individual pages could be extended as required.  The device
could "update" the master history, so it would know in summary form
which pages have changed.  It would then go on to fetch updates for
individual pages that the user is watching, or potentially even get them
all.  There's an interesting next idea here: device-to-device update
bundles.  And another one: distributed update; if, instead of writing to
a "master" version - the action of editing a wiki page becomes to create
a fork and the editorial process promotes these forks to be the master
version in the superproject.  Users which have pulled the full
repository for a page will be able to see other peoples' forks, to get
"latest" versions or for editing purposes.  This adds not only a
distributed update action, but the ability to have decent peer
review/editorial process without it being arduous.

Without good data set partitioning I don't think I see the above
workflow being as possible.  I was approaching the problem by first
trying to back a SQL RDBMS to git, eg MySQL or SQLite (postgres would be
nice, but probably much harder) - so I first set out by designing a
table store.  But the representation of the data is not important, just
the distributed version of it.

Actually this raises the question - what is it that you are trying to
achieve with this wikipedia import?

Sam
