From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Re: cosmetic improvements for "git show tag"
Date: Fri, 17 Jul 2009 21:47:43 -0400
Message-ID: <20090718014743.GA16381@coredump.intra.peff.net>
References: <20090717231622.GA13511@coredump.intra.peff.net>
 <20090718011006.GB12968@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sat Jul 18 03:49:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRz35-0006wV-Mk
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 03:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755264AbZGRBrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 21:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752283AbZGRBrt
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 21:47:49 -0400
Received: from peff.net ([208.65.91.99]:35940 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752046AbZGRBrs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 21:47:48 -0400
Received: (qmail 30098 invoked by uid 107); 18 Jul 2009 01:49:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 17 Jul 2009 21:49:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jul 2009 21:47:43 -0400
Content-Disposition: inline
In-Reply-To: <20090718011006.GB12968@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123501>

On Sat, Jul 18, 2009 at 03:10:06AM +0200, Nicolas Sebrecht wrote:

> Nice. What about adding an extra newline between tags?
> 
>   $ git tag v1.6.1 v1.6.2
> 
> 	<snip>
> 
>   +  link:RelNotes-1.6.1.txt[1.6.1].
>   +
>    * link:v1.6.0.6/git.html[documentation for release 1.6.0.6]
>    
>    * release notes for
>   tag v1.6.2
>   Tagger: Junio C Hamano <gitster@pobox.com>
>   Date:   Tue Mar 3 23:37:25 2009 -0800
> 
>   <snip>
> 
> IOW, between " * release notes for" and "tag v1.6.2" here.

Hmph. I thought that should just work, because of the newline after the
commit. But it seems that you only get that if the next thing is a
commit. Hrm.. and it is even worse. The code to print that newline comes
from printing the second commit, which says "oh, we've already printed a
commit" and adds the newline.

So when you show two tags you get:

  tag foo

  message

  commit foo^{}

  message
  tag bar


  commit bar^{}

That is, the newline is actually stuck in the wrong place. So we
actually need to turn that newline off, which I'm not sure is possible.
I'll look into it more.

-Peff
