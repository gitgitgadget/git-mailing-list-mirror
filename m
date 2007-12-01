From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Fri, 30 Nov 2007 18:37:12 -0800
Message-ID: <7vbq9b87jb.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org>
	<7veje8twt2.fsf@gitster.siamese.dyndns.org>
	<20071130003512.GB11683@coredump.intra.peff.net>
	<7vzlwwsgkp.fsf@gitster.siamese.dyndns.org>
	<20071130005852.GA12224@coredump.intra.peff.net>
	<alpine.LFD.0.99999.0711292004340.9605@xanadu.home>
	<20071130011748.GC11683@coredump.intra.peff.net>
	<474FB938.3040209@op5.se>
	<20071130150948.GA22095@coredump.intra.peff.net>
	<7vve7jqz92.fsf@gitster.siamese.dyndns.org>
	<20071130212500.GB25946@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 01 03:37:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyIEi-0003qY-0R
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 03:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758688AbXLAChZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 21:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758681AbXLAChY
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 21:37:24 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40356 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758656AbXLAChW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 21:37:22 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 5BA342F2;
	Fri, 30 Nov 2007 21:37:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 99BA79B994;
	Fri, 30 Nov 2007 21:37:35 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66686>

Jeff King <peff@peff.net> writes:

> I can, of course, always make my own hardlinks (which is really the same
> thing, except the "trick" is slightly harder to perform and perhaps less
> socially acceptable; OTOH, if such a trick is common, perhaps it means
> taking away the dash forms wasn't such a good idea after all).
>
>>  Newbie: Stupid inconsistency.  Who suggested that?
>
> Jeff [runs git-blame]: It must have been Junio! :)

You found a bug in git-blame, then ;-).  I think it should report Jeff.

As Windows ports need to have their own difference _anyway_, I
personally do not think it is a big deal if the Makefile I ship
continues to install the dashed form in gitexecdir, and Windows ports
omit the hardlinks if they feel copies are wasteful.

However, that would introduce hard-to-track platform dependent bugs
(e.g. "git-receive-pack" is asked for by "git-send-pack", but the other
side does not have such a program anywhere).  So my preference at this
point is to move things out of PATH first (without removing the
hardlinks), deal with possible fallout from that move.

And after things stablize, discuss to either remove the hardlinks from
all installations, or to keep them in all installations.  I do not think
"it's this way here but that way there" is a good thing in general.

We do have "git-foo.exe" vs "git-foo" difference and there are some
existing code (most notably, help.c::list_commands_in_dir()) that need
to be aware of it.  Let's try not to make things any worse.
