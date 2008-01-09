From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] refer to post-patch lines in whitespace warnings
Date: Wed, 9 Jan 2008 16:35:37 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801091525030.13593@iabervon.org>
References: <alpine.LNX.1.00.0801091046100.13593@iabervon.org> <7vy7ayhhpj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 22:36:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCial-0005Qr-Ir
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 22:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbYAIVfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 16:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753178AbYAIVfj
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 16:35:39 -0500
Received: from iabervon.org ([66.92.72.58]:44286 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752270AbYAIVfj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 16:35:39 -0500
Received: (qmail 26253 invoked by uid 1000); 9 Jan 2008 21:35:37 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Jan 2008 21:35:37 -0000
In-Reply-To: <7vy7ayhhpj.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70018>

On Wed, 9 Jan 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > When I rebase series with bad whitespace, I end up with unhelpful messages 
> > like:
> >
> > .dotest/patch:412: trailing whitespace.
> > -- 
> > .dotest/patch:446: trailing whitespace.
> > -- 
> >
> > These line numbers obviously refer to lines in a file that's been removed 
> > by the time I can do anything about it.
> 
> The message is more appropriate for a workflow to "git apply --check"
> first, fix the patchfile and then applying for real.

Right; I'd keep it the same for all cases in which the patch is not 
applied: "git apply --check" (which doesn't apply it regardless) or when 
whitespace errors prevent application; so the message would be, in either 
case, appropriate to the workflow.

In fact, in your workflow, it wouldn't make any sense to give the 
resulting location of the whitespace, because that version of the file 
hasn't been created. I think that only one of the possible location 
reports is actually helpful: if it wasn't applied, the line in the patch 
file; if it was, the line in the working tree.

> > ... if, in the case where it leaves the working tree 
> > modified with the non-compliant whitespace, it gave this location rather 
> > than the patch's location (because, even if you have the patch still, 
> > you'd need to revert it first in order to be able to apply a fixed version 
> > anyway).
> 
> In such a case, "git diff" will highlight the non-compliant whitespace.
> 
> More problematic is if you used whitespace=warn to let it commit anyway.
> You can use "git diff $beginning_of_series..HEAD" the same way
> to locate the breakages, but you then need to do "rebase -i" to
> fix it up (I personally would run "format-patch", fix the problems in
> the patch text, and run "am", instead of "rebase -i", mostly
> because I am used to working that way).

I should point out that, in this particular series, the non-compliant 
whitespace is in the "expected result" file for tests for email message 
generation, and it actually has to be like that. The annoying thing is 
that it's not clear what file has the trailing whitespace, so it's not 
clear that it is supposed to be that way from the message.

	-Daniel
*This .sig left intentionally blank*
