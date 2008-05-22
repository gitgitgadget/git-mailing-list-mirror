From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Restricting access to a branch
Date: Wed, 21 May 2008 17:37:20 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805211732520.3081@woody.linux-foundation.org>
References: <20080521163616.31fad56f@extreme> <7vhccrxkdm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Hemminger <shemminger@vyatta.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 22 02:38:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jyyp7-000189-43
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 02:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764393AbYEVAh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 20:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764539AbYEVAh1
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 20:37:27 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53093 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763872AbYEVAhZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 May 2008 20:37:25 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4M0bLJG026934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 21 May 2008 17:37:22 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4M0bKSC008818;
	Wed, 21 May 2008 17:37:21 -0700
In-Reply-To: <7vhccrxkdm.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.416 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82590>



On Wed, 21 May 2008, Junio C Hamano wrote:

> Stephen Hemminger <shemminger@vyatta.com> writes:
> 
> > Is there some standard way to freeze a branch and not allow anymore changes to
> > be pushed?
> >
> > Yes, I know it is possible by playing with hook files, but that doesn't seem
> > very admin friendly.
> 
> If you do not want to use hooks, then the answer is no.  Sorry.

Hmm. I don't think that's strictly true.

What you *can* do is:

 - rename the branch to something that includes a slash (aka 
   subdirectory). Let's call it "frozen/mybranch" as an example.

 - do a 'git gc' to make sure that branch is in the packed refs file.

 - make the subdirectory of that branch is unwritable (ie just do 
   something like "chmod -w refs/heads/frozen")

and now the filesystem permissions should mean that you can't actually 
update that branch any more, even though you can read it.

Of course, if the person has full shell access, then they can still just 
undo those file permissions, but at least it should be protected from 
accidentally being overwritten.

This is all totally untested, of course.

		Linus
