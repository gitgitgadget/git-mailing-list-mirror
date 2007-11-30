From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 16:13:29 -0800
Message-ID: <7veje8twt2.fsf@gitster.siamese.dyndns.org>
References: <20071127160423.GA22807@laptop>
	<Pine.LNX.4.64.0711271617350.27959@racer.site>
	<20071128000731.GD9174@efreet.light.src>
	<7v8x4jb295.fsf@gitster.siamese.dyndns.org>
	<fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
	<7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
	<20071129150849.GA32296@coredump.intra.peff.net>
	<fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com>
	<20071129211409.GA16625@sigill.intra.peff.net>
	<Pine.LNX.4.64.0711292218240.27959@racer.site>
	<20071129231444.GA9616@coredump.intra.peff.net>
	<alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 01:14:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxtW3-0004gA-BO
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 01:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763767AbXK3ANk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 19:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763642AbXK3ANk
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 19:13:40 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:54345 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760622AbXK3ANj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 19:13:39 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8AD782F0;
	Thu, 29 Nov 2007 19:13:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B51C59B346;
	Thu, 29 Nov 2007 19:13:52 -0500 (EST)
In-Reply-To: <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 29 Nov 2007 15:30:05 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66573>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> And from a consistency standpoint, that would be a *good* thing. There are 
> many reasons why the git-xyz format *cannot* be the "consistent" form
> (ranging from the flags like --bare and -p to just aliases), so 
> encouraging people to move to "git xyz" is just a good idea.
>
> Yeah, yeah, the man-pages need the "git-xyz" form, but on the other hand, 
> rather than "man git-xyz", you can just do "git help xyz" instead, and now 
> you're consistently avoiding the dash again!

Ok.  So here is a revised roadmap that a panda brain (that is not so
well working today due to fever) came up.

 - v1.5.4 will ship with gitexecdir=$(bindir) in Makefile.  But the
   release notes for the version will warn users that:

   (1) using git-foo from the command line, and

   (2) using git-foo from your scripts without first prepending the
       return value of "git --exec-path" to the PATH

   is now officially deprecated (it has been deprecated for a long time
   since January 2006, v1.2.0~149) and upcoming v1.5.5 will ship with
   the default configuration that does not install git-foo form in
   user's PATH.

   If further will warn users that git-foo form will be removed in
   v1.5.6 for many commands and it will be merely an accident if some of
   them still work after that.

 - Post v1.5.4, start cooking gitexecdir=$(libexecdir)/git-core, aiming
   for inclusion in v1.5.5, perhaps in Feb-Mar 2008 timeframe.  This
   will also affect the sample RPM spec and resulting RPM binary
   packages I will place on k.org, and I'll ask Gerrit to do the same on
   Debian side.  The official binary packaging of individual distros are
   not under my control, but if there is a handy list of people I can
   send this notice to for other distros, that would help this process.

 - The release notes for v1.5.5 will warn users again that git-foo will
   be removed in v1.5.6 for many commands and it will be merely an
   accident if some of them still work.

 - Post v1.5.5, start cooking the change that does not install hardlinks
   for built-in commands, aiming for inclusion in v1.5.6, in May-Jun
   2008 timeframe.
