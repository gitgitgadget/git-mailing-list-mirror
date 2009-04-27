From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] Add an option not to use link(src, dest) && unlink(src)
 when that is unreliable
Date: Mon, 27 Apr 2009 13:18:19 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904271314130.22156@localhost.localdomain>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904251042490.3101@localhost.localdomain> <200904252052.10327.j6t@kdbg.org> <7vhc0cw6w8.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0904261940170.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0904271400180.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904270806130.22156@localhost.localdomain> <7vljpl3m8i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 22:21:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyXKt-0006pH-HU
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 22:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756230AbZD0UVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 16:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755828AbZD0UVe
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 16:21:34 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59919 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754960AbZD0UVd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2009 16:21:33 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3RKIKaR018260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 27 Apr 2009 13:18:56 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3RKIJtk008635;
	Mon, 27 Apr 2009 13:18:19 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vljpl3m8i.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.956 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117712>



On Mon, 27 Apr 2009, Junio C Hamano wrote:
> >
> > 	[core]
> > 		usehardlinks = true/false
> 
> I am a bit worried about this name, too.  It may lead people to a
> misunderstanding that we would do something magical when they do this with
> the configuration set:
> 
> 	wget http://some.where/huge-file.mpg 1.mpg
>         ln 1.mpg 2.mpg
>         git add 1.mpg 2.mpg
>         rm -f 1.mpg 2.mpg
>         git checkout-index -a
> 	ls -i ?.mpg

Btw, I do agree that maybe 'usehardlinks' is not a good name either. Maybe 
we should make it clear that we're talking about a specific case for 
object creation.

Maybe the config option shouldn't be a boolean, but a "how to instantiate 
objects". IOW, we could do

	[core]
		createobject = {link|rename}

instead. Maybe we some day could allow "inplace", for some totally broken 
system that supports neither renames nor links, and just wants the object 
to be created with the final name to start with.

(Ok, that sounds unlikely, but I mention it because it's an example of the 
concept. Maybe somebody likes crazy databases, and would like to have a 
"createobject = mysql" for some DB-backed loose object crap).

		Linus
