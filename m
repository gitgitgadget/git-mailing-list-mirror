From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: gitpacker progress report and a question
Date: Mon, 26 Nov 2012 18:43:59 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121126234359.GA8042@thyrsus.com>
References: <20121115212818.GA21558@thyrsus.com>
 <CAMP44s30px2FgieC9VcGji7T+yWFo7gMSwQhtuztHrqto8B7Aw@mail.gmail.com>
 <20121126220108.GB1713@thyrsus.com>
 <CAMP44s2+NDyL2Vf=iKR09f-YUnp=G2BCiYj-+qKuP7JA-+YkmQ@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 00:44:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td8Lc-0002De-34
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 00:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757320Ab2KZXoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 18:44:04 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:52584
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755309Ab2KZXoD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 18:44:03 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id C4F9140661; Mon, 26 Nov 2012 18:43:59 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAMP44s2+NDyL2Vf=iKR09f-YUnp=G2BCiYj-+qKuP7JA-+YkmQ@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210517>

Felipe Contreras <felipe.contreras@gmail.com>:
> Might be easier to just call 'git ls-files --with-three foo', but I
> don't see the point of those calls:

Ah, much is now explained.  You were looking at an old version.  I had
in fact already fixed the subdirectories bug (I've updated my
regression test to check) and have full support for branchy repos,
preserving tags and branch heads.

> > It doesn't issue delete ops.
> 
> What do you mean?
> 
>     out.puts 'deleteall' <- All current files are removed

Yours emits no D ops for files removed after a particular snapshot.

> > Be aware, however, that I consider easy editability by human beings
> > much more important than squeezing the last microsecond out of the
> > processing time.  So, for example, I won't use data byte counts rather
> > than end delimiters, the way import streams do.
> 
> Well, if there's a line with a single dot in the commit message ('.'),
> things would go very bad.

Apparently you missed the part where I byte-stuffed the message content.
It's a technique used in a lot of old-school Internet protocols, notably
in SMTP.
 
> Personally I would prefer something like this:

There's a certain elegance to that, but it would be hard to generate by hand.

Remember that a major use case for this tool is making repositories 
from projects whose back history exists only as tarballs.  So, let's
say you have the following:

foo-1.1.tar.gz
foo-1.2.tar.gz
foo-1.3.tar.gz

What you're going to do before weaving is drop the untarred file trees
in a 'foo' scratch directory, then hand-craft a log file that might
look a bit like this:

-----------------------------------
commit 1
directory foo-1.1

Release 1.1 of project foo
.
commit 2
directory foo-1.2

..This is an example of a byte-stuffed line.

Release 1.2 of project foo
.
commit 3
directory foo-1.3

Release 1.3 of project foo
.
-----------------------------------

The main objective of the logfile design is to make hand-crafting 
these easy.  
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
