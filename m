From: Jeff King <peff@peff.net>
Subject: Re: info: display '--' as '-'
Date: Tue, 7 Aug 2012 02:01:57 -0400
Message-ID: <20120807060157.GA13222@sigill.intra.peff.net>
References: <CANes+HZ3EH70x6KiaPsV=SQpbjr5o+pEzj2+4Xx613GPZv0SLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>
To: mofaph <mofaph@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 08:02:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sycrn-0000Gv-KK
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 08:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264Ab2HGGCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 02:02:01 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54182 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971Ab2HGGCA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 02:02:00 -0400
Received: (qmail 25053 invoked by uid 107); 7 Aug 2012 06:02:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Aug 2012 02:02:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Aug 2012 02:01:57 -0400
Content-Disposition: inline
In-Reply-To: <CANes+HZ3EH70x6KiaPsV=SQpbjr5o+pEzj2+4Xx613GPZv0SLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203018>

On Mon, Aug 06, 2012 at 11:08:39AM +0800, mofaph wrote:

> I am using Git 1.7.11.4 now. I compile and then install it from the repo.
> 
> $ git checkout v1.7.11.4
> $ make prefix=$HOME/opt/git/1.7.11.4 all doc info
> $ make prefix=$HOME/opt/git/1.7.11.4 install{,-doc,-html,-info}
> 
> Recently, I found some problem when I read the git.info.
> 
> For example, you can see it in "3.7.1 Getting conflict-resolution help during a
> merge":
> 
> $ git log -merge
> $ gitk -merge
> 
> See, it should be type like this:
> 
> $ git log --merge
> $ gitk --merge
> 
> You will see this typo almost in the whole info file.

Yeah, I can reproduce it here. The data goes through these
transformations to get to the final info form:

  user-manual.txt  (source)
   -> user-manual.xml (via asciidoc)
     -> user-manual.texi (via docbook2x-texi)
       -> git.info (via makeinfo)

The data looks OK in user-manual.texi, but "--" is converted to "-" in
git.info. So either:

  1. There is a bug in makeinfo, which should not be doing this
     conversion inside a "@display" section.

  2. There is a bug in docbook2x-texi, which should be quoting the
     contents of the <literallayout> when generating the @display
     section.

I don't know enough about texinfo to say which. But I'm sure that the
contents of user-manual.xml are correct, because I do actually speak
docbook, which means the problem happens after that step.

Cc-ing David Kastrup, who added the info version originally, and might
be more clueful about that part of the toolchain.

-Peff
