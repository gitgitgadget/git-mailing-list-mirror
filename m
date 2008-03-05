From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git clone -l
Date: Tue, 4 Mar 2008 19:45:39 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803041937110.19665@iabervon.org>
References: <alpine.LNX.1.00.0803041900080.19665@iabervon.org> <7vd4qa3t9t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 01:46:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWhmC-0003m4-0f
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 01:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757009AbYCEApu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 19:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758100AbYCEApt
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 19:45:49 -0500
Received: from iabervon.org ([66.92.72.58]:41399 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324AbYCEAps (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 19:45:48 -0500
Received: (qmail 26221 invoked by uid 1000); 5 Mar 2008 00:45:39 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Mar 2008 00:45:39 -0000
In-Reply-To: <7vd4qa3t9t.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76161>

On Tue, 4 Mar 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > What, exactly, is -l supposed to do for clone? As far as I can tell, we 
> > automatically do the local magic if we can. Would it be okay to make 
> > "local" default to "if possible", have "-l" mean error if not possible, 
> > and have "--no-local" able to avoid using local magic even if we could use 
> > it?
> 
> It used to be that "-l" meant "When it is local, use hardlink if possible
> otherwise copy without complaining, as either are cheaper than the pack
> piped to unpack."  Lack of -l meant no local magic.
> 
> Recently lack of -l stopped to mean "no local magic".  We still do the
> local magic, but we do not do hardlinks and instead do copies.  An "-l"
> that asks clone across filesystems still falls back to copying but now
> gets a warning.  "--no-hardlinks" does not have any significance anymore,
> as that is what you would get for a local clone without -l.
> 
> The way to refuse local magic is to use file://$path/ explicitly; we do
> not have --no-local.

Ah, okay. I was having a hard time getting the not-using-local-magic case 
to be clearly not using local magic, but I think that was confusion on my 
part. Also, it looks like we need a test that not using -l is equivalent 
to --no-hardlinks.

Would it be okay to additionally block local magic, even with a local 
path, if "--no-local" is used? Using our parse-options code means 
--no-local is accepted anyway, and it's a bit confusing that it doesn't 
block default local magic. (Obviously, this won't break anything, since 
old code wouldn't have accepted it.)

	-Daniel
*This .sig left intentionally blank*
