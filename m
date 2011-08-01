From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: tracking submodules out of main directory.
Date: Tue, 2 Aug 2011 00:12:04 +0200
Message-ID: <20110801221203.GA31614@book.hvoigt.net>
References: <1309180056.2497.220.camel@Naugrim.eriador.com> <7vvcvrxlol.fsf@alter.siamese.dyndns.org> <4E08C89E.5020109@web.de> <7vvcvrw0vn.fsf@alter.siamese.dyndns.org> <BANLkTimsfR4LqDAci0Vr+m9uUE_W-7OSAw@mail.gmail.com> <4E0A08AE.8090407@web.de> <1311792580.2413.82.camel@Naugrim.eriador.com> <1311843465.3734.40.camel@Naugrim.eriador.com> <4E3192D4.5000504@web.de> <1311932377.3734.182.camel@Naugrim.eriador.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Alexei Sholik <alcosholik@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: henri GEIST <henri.geist@flying-robots.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 00:12:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo0ia-00049u-IY
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 00:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612Ab1HAWMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 18:12:07 -0400
Received: from darksea.de ([83.133.111.250]:36743 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752933Ab1HAWMG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 18:12:06 -0400
Received: (qmail 23952 invoked from network); 2 Aug 2011 00:12:04 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 2 Aug 2011 00:12:04 +0200
Content-Disposition: inline
In-Reply-To: <1311932377.3734.182.camel@Naugrim.eriador.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178420>

Hi,

On Fri, Jul 29, 2011 at 11:39:37AM +0200, henri GEIST wrote:
> Let say a concret exemple
> 
> 3 different teams work on libtiff, libpng, and libjpeg they are totally
> unrelated.
> 
> One more team is working on the "gimp". And they need those 3 libs in
> specific versions not necessarily there heads.
> 
> One other unrelated team is working on "gqview" and need the same libs
> in other specifics versions (Why should they know what te gimp team
> does)
> 
> Neither "gimp" and "gqview" project will contain directory with those
> libs inside. They just depend on them.
> 
> And the last team work on the gnome project which need the "gimp" and
> "gqview". It will be this team witch have to care about having both
> "gimp" and "gqview" sharing the same libs version>
> And has well the gnome project will not contain "gqview" and "gimp" in
> its own tree.
> It will also depend on them.
> 
> It is just the same with aptitude on debian.
> Each package know there dependency by themselves, does not contain there
> dependencies, and do not need a bigger superpackage to tell them what
> are there own dependencies.

As Jens mentioned already in this example you have a

        somemodule A needs a version of lib C higher than X
	somemodule B needs a version of lib C higher than Y

relation. Which in the case of submodules is A points to X and B points
to Y. Lets assume X is contained in Y. Since only the superproject knows
about both A and B its the only instance that can resolve this conflict
of dependence on C and can choose Y. In your example aptitude would be
the superproject containing everything.

This is actually (simplified) the way submodule merge is implemented. So
you see if you want both A and B to use the same version of C you need a
superproject recording this knowledge.

Adding the ability to point to git repositories outside of the worktree
does not solve anything but rather creates more problems. Resolving such
dependencies can not be achieved if only A knows that it needs version X
and only B knows that it needs version Y.

Cheers Heiko
