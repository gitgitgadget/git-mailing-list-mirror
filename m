From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make the exit code of add_file_to_index actually useful
Date: Tue, 13 May 2008 08:00:13 +0200
Message-ID: <20080513060013.GA3622@steel.home>
References: <20080302154154.GC2973@steel.home> <20080302154238.GD2973@steel.home> <alpine.LSU.1.00.0803021555500.22527@racer.site> <7vtzjpoye6.fsf@gitster.siamese.dyndns.org> <20080512175654.GB3128@steel.home> <7vzlqvxt1p.fsf@gitster.siamese.dyndns.org> <20080512205414.GH3128@steel.home> <7viqxjxj0h.fsf@gitster.siamese.dyndns.org> <20080512224844.GI3128@steel.home> <7vve1jw130.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dirk S??sserott <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 08:01:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvnZU-0006ac-Lj
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 08:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755691AbYEMGAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 02:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756247AbYEMGAR
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 02:00:17 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:60400 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755691AbYEMGAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 02:00:16 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarO+BInc
Received: from tigra.home (Fab5c.f.strato-dslnet.de [195.4.171.92])
	by post.webmailer.de (mrclete mo28) (RZmta 16.34)
	with ESMTP id 300a08k4D3Yku6 ; Tue, 13 May 2008 08:00:14 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 47FCD277BD;
	Tue, 13 May 2008 08:00:14 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 103F956D28; Tue, 13 May 2008 08:00:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vve1jw130.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81990>

Junio C Hamano, Tue, May 13, 2008 01:32:19 +0200:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > Junio C Hamano, Tue, May 13, 2008 00:19:42 +0200:
> > ...
> >> I would understand there can be some files that cannot be read.  But when
> >> there is such a file, why is it Ok to ignore an error to update the
> >> contents from that file if/when the user asks to index the current
> >> contents, provided if the contents of that file is to be tracked?  Isn't
> >> it the true cause of the problem that the file is being tracked but it
> >> shouldn't?
> >
> > No, I don't think so. Consider "git add dir/". It is _not_ 1 (one)
> > operation. It is many operations (add every file in the "dir/"). Why
> > should all of them be considered failed just because the third file
> > from the bottom could not be read (and the user may have not even seen
> > it, because it wasn't there before, like a temporary file from Excel).
> > And for a user (for me, at least) "git add" is an intermediate
> > operation anyway...
> 
> Ah, Ok, I was overly cautious, and the worry is unfounded, as long as you
> do not trigger this "ignore" thing upon "git commit -a".

Yes, builtin-commit.c explicitely keeps its behaviour: the 0 in flags
argument makes sure die() is called. "Ignore errors" must be requested
with ADD_FILES_IGNORE_ERRORS.
