From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: submodules' shortcomings, was Re: RFC: display dirty
	submodule working directory in git gui and gitk
Date: Tue, 5 Jan 2010 15:27:27 +0100
Message-ID: <20100105142727.GA83546@book.hvoigt.net>
References: <4B3F6742.6060402@web.de> <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de> <4B421F90.4090402@web.de> <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de> <4B42F425.4010901@web.de> <alpine.DEB.1.00.1001051032440.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Lars Hjemli <hjemli@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 05 15:28:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSANl-0001LK-Nk
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 15:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529Ab0AEO1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 09:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754436Ab0AEO1b
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 09:27:31 -0500
Received: from darksea.de ([83.133.111.250]:38779 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754212Ab0AEO13 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 09:27:29 -0500
Received: (qmail 13787 invoked from network); 5 Jan 2010 15:27:27 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 5 Jan 2010 15:27:27 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1001051032440.4985@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136191>

On Tue, Jan 05, 2010 at 10:46:11AM +0100, Johannes Schindelin wrote:
> On Tue, 5 Jan 2010, Jens Lehmann wrote:
> > Yes. This synchronization could be either obsoleted by only using
> > .gitmodules or automated.
> 
> I start to wonder whether the insistence that .gitmodules' settings must 
> be overrideable makes any sense in practice.

I just read this and felt the need to comment.

Yes, it definitely makes sense in practise to have it overrideable
otherwise we loose the distributed nature of git for submodules.

Imagine you fork a project and you want to work with others on a change
that involves chaning a subproject. If you can not override .gitmodules
you can only work on the central repository.

I am actually working like this in practise. I have a private clone of
all the subprojects msysgit has and commit/push locally first. Once I
sense the change is going to be useful for a wider audience I send it
upstream. This would be more uncomfortable if it is not overideable.

But I know what you mean by the general confusion about manual updates.
So how about an approach like this:

* clone will initialise all submodules in .git/config from .gitmodules

* if a change in .gitmodules happens git scans .git/config for that
  entry and in case nothing is there it syncronises the new one and
  notifies the user.

* if a change in .gitmodules happens and the entry before was the same
  in .git/config we also automatically update that entry there.

* In every other case we just leave .git/config alone.

Did I miss anything? I think you should get the idea and that it could
get rid of the confusion caused by manual .gitmodule updates.

cheers Heiko

P.S.: Additionally (for my use case) we could add a "hint mechanism"
which allows git to "guess" a new submodules address. For example in
case I have all my local clones on "git@my.server.net:<modulename>.git".
Now when a new submodule gets seen in .gitmodules it will infer the
address from the hint configuration and not take the original one from
upstream.
