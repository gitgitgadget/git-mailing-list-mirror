From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] index: be careful when handling long names
Date: Mon, 14 Jan 2008 00:33:23 +0100
Message-ID: <20080113233323.GB19970@steel.home>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org> <7vtzliqh3u.fsf@gitster.siamese.dyndns.org> <7vd4s6qal0.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801130922030.2806@woody.linux-foundation.org> <7vsl11plbe.fsf@gitster.siamese.dyndns.org> <7vhchhpd3h.fsf_-_@gitster.siamese.dyndns.org> <20080113225321.GA19970@steel.home> <7v4pdhpbmw.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 00:34:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JECL5-0008RZ-Qj
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 00:34:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530AbYAMXd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 18:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754489AbYAMXd0
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 18:33:26 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:16598 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920AbYAMXd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 18:33:26 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJqjpg==
Received: from tigra.home (Fab5c.f.strato-dslnet.de [195.4.171.92])
	by post.webmailer.de (mrclete mo21) (RZmta 15.4)
	with ESMTP id 601c7fk0DIDwr4 ; Mon, 14 Jan 2008 00:33:24 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E800C277AE;
	Mon, 14 Jan 2008 00:33:23 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id B88DC56D22; Mon, 14 Jan 2008 00:33:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v4pdhpbmw.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70424>

Junio C Hamano, Mon, Jan 14, 2008 00:08:07 +0100:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > Junio C Hamano, Sun, Jan 13, 2008 23:36:34 +0100:
> >> +test_expect_success 'very long name in the index handled sanely' '
> >> +
> >> +	a=a && # 1
> >> +	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 16
> >> +	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 256
> >> +	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 4096
> >
> > I'd expect it to fail on some systems (everywindowsthing up to w2k,
> > maybe some commercial unices).
> 
> My understanding is that Everywindowsthing do not come with any
> (POSIX compliant) shell that we support by default, so if you
> are talking about a limit of shell variable value, I do not
> think it is an issue to begin with.  It is just the matter of

Oh, right. The file system wont even see it, it is passed directly to
update-index.

> picking a sensible shell (I understand both Cygwin and msys
> ports use a shell that supports more than 4k bytes in value
> given to a variable).

can't check right now, but I believe it is so

> I would agree that it might overflow the argument limit when
> this is given to "echo", though.  We cannot do much about it,
> but you may have cleverer ideas.

I thought about conditionally disabling the test, like it was done
when the tabs in filenames had to be tested. Wont be needed for this
particular case.
