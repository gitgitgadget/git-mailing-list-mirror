From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git merge ignoring whitespace
Date: Fri, 13 Feb 2009 02:38:19 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902130231300.26370@racer>
References: <2754.1233876289@relay.known.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Fri Feb 13 02:40:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXn2U-0008IN-G4
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 02:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760535AbZBMBi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 20:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754487AbZBMBi0
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 20:38:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:49022 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760364AbZBMBiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 20:38:25 -0500
Received: (qmail invoked by alias); 13 Feb 2009 01:38:22 -0000
Received: from pD9EB2494.dip0.t-ipconnect.de (EHLO noname) [217.235.36.148]
  by mail.gmx.net (mp007) with SMTP; 13 Feb 2009 02:38:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18eP2VkxdQeD7Xg3tCUGbvNUxajkOVWJQ4wYcbMMh
	C4/2qUg4JWyMWA
X-X-Sender: gene099@racer
In-Reply-To: <2754.1233876289@relay.known.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109700>

Hi,

On Thu, 5 Feb 2009, layer wrote:

> Junio, on 3/25/07 you said:
> 
>   I know Linus does not like applying patches with whitespace
>   fuzziness, but I personally think a merge that ignores
>   whitespace changes would be a useful thing to have, without
>   having to call an external specialized merge backend. In other
>   words, I do not think it is so special a thing to want to, but
>   it is rather an unfortunate norm.  I am not opposed to give
>   git-merge-recursive a command line option to tell it to merge
>   ignoring the whitespace-only changes, when it does the 3-way
>   file-level merge internally.
> 
> Whatever came of this?  I tried giving git merge a --ignore-whitespace
> argument and the error message that followed show no equivalent
> argument.

I can think of two issues:

- there was this -X patch by Junio, but I think it is a bad interface to 
  pass merge backend options, as it is not closely coupled with the 
  backend.  Just imagine this:

	git merge -X ignore-whitespace -s resolve,recursive

  Does the "-X ignore-whitespace" impact resolve, recursive, or both?  And 
  we'd need some way to specify the option to the backend.  I thought that

	git merge -s resolve,recursive/ignore-whitespace

  would be a sane syntax, but at least _I_ did not have a need to pass 
  backend options yet.

- more fundamental, how should the merge ignoring whitespace work?  Which 
  version would it take if the lines agree _except_ for whitespace 
  changes?  This needs to be well designed, as we have not only merges 
  (where we have "ours" and "theirs"), but also rebases (where we have 
  "theirs" and _then_ "ours"), and of course recursive merges when there 
  is more than a single merge base (and there, it gets really nasty, so 
  you better have the semantics of the whitespace-ignoring merge put down 
  quite clearly).

> It would sure come in handy right now.  Is there some other way to do
> it that I didn't find searching the mailing list?

Of course, you could try to "normalize" the whitespace, and perform the 
merge after that.

Ciao,
Dscho

  
