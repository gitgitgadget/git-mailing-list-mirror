From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make the exit code of add_file_to_index actually useful
Date: Sun, 2 Mar 2008 22:42:41 +0100
Message-ID: <20080302214241.GB13954@steel.home>
References: <47C95E34.1050306@dirk.my1.cc> <20080302154154.GC2973@steel.home> <20080302154238.GD2973@steel.home> <alpine.LSU.1.00.0803021555500.22527@racer.site> <7vtzjpoye6.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dirk =?iso-8859-15?Q?S=FCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 22:43:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVvxp-00041K-Uq
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 22:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757201AbYCBVmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 16:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757297AbYCBVmp
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 16:42:45 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:54940 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757126AbYCBVmo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 16:42:44 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFzzec4=
Received: from tigra.home (Fac78.f.strato-dslnet.de [195.4.172.120])
	by post.webmailer.de (klopstock mo18) (RZmta 16.8)
	with ESMTP id 503f40k22Hc1vS ; Sun, 2 Mar 2008 22:42:42 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id DBDDB277BD;
	Sun,  2 Mar 2008 22:42:41 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id B9D3356D24; Sun,  2 Mar 2008 22:42:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vtzjpoye6.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75848>

Junio C Hamano, Sun, Mar 02, 2008 17:59:13 +0100:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sun, 2 Mar 2008, Alex Riesen wrote:
> >
> >> -			add_file_to_cache(path, verbose);
> >> +			if (add_file_to_cache(path, verbose))
> >> +				exit(1);
> >
> > Does it really, really _have_ to be exit(1)?  I mean, now you block even 
> > the faintest chance that we can libify libgit.a by overriding die_routine.
> 
> I think Alex did so not to break the existing scripts that rely on these
> dying, but it should have been exit(128) to really stay compatible.

Sorry, this time it was actually mostly accident. I just selected the
first non-zero.

> Why is this even needed to begin with?  I am aware of Dirk's original
> issue discussed elsewhere, but we try fairly hard to be A-O-N when we can
> afford to, and this option deliberately breaks it.  What is the real
> reason why such an unreadable (either for privilege or for I/O error)
> file should not live in .gitignore?

Another program keeps the file open. There is an exclusive mode for
opening files, which locks the files for everyone. I believe it is
even default mode, unless selected otherwise.

