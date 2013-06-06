From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Thu, 06 Jun 2013 14:52:54 +0200
Message-ID: <vpq61xr8kpl.fsf@anie.imag.fr>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<51AEBAEF.6090402@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 06 14:54:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkZhc-00047f-50
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 14:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933315Ab3FFMyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 08:54:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41201 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933044Ab3FFMx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 08:53:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r56CqqMt031390
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 6 Jun 2013 14:52:52 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UkZgU-0004Ue-Cp; Thu, 06 Jun 2013 14:52:54 +0200
In-Reply-To: <51AEBAEF.6090402@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 05 Jun 2013 06:13:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 06 Jun 2013 14:52:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r56CqqMt031390
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1371127976.54986@Psfj+9OdPdTs1fPT9n1fMg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226502>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> * at the source-code level, a tool in contrib can take advantage of some
> of the Git build/test infrastructure, though I don't know whether they
> currently do.

They do not do much AFAICT. For example, contrib/subtree/t/Makefile is
essentially copy-pasted from Git's equivalent.

But they can do to some extend, for example "make install" in
contrib/mw-to-git/ re-uses Git's Makefile to hardcode the PERL_PATH in
the file, find Git's exec-path & so. I'd love to be able to use
Documentation/Makefile and t/Makefile too for external programs meant to
be used as a Git command.

That does not strictly imply that these commands be maintained within
git.git, as we could imagine:

* Ask the user to build external programs with

  make GIT_ROOT=where/git/lives/

* or, ask users to checkout the external program as a subdirectory of
  git.git to build it (for example, clang's build installation ask you
  to put clang as a subdirectory of LLVM's tree).

> But my main point is that I think it would be easier to phase out
> contrib/ if there were a good alternate way of providing visibility to
> "satellite" projects. [...] Perhaps ranking
> the tools based on the results of the Git user surveys would help bring
> the most popular to the top of each category.

I think this is the most important point. A good example would be
git-multimail: for now, the shell version in contrib/ is somehow
considered as the official hook to send emails, just because it is in
contrib, while git-multimail is clearly superior (unless you don't have
a python interpreter on your server).


I also see contrib/ as a "safe" place to live, in that the likeliness
for the project to be abandonned is rather small. Especially for small
pieces of code, it's easy to create a repo and throw the code somewhere
on GitHub, but maintaining it is harder. Take again the example of
post-receive-email, the code was originally written by Andy Parkins, but
the community took over it (Andy's last commit on the script was in
2008). I'm not sure this would have been so easy with a script hosted on
an arbitrary repo.


I'm not opposed to Junio's proposal to restrict contrib/ (although a bit
reluctant), but I think this should be done with care, at least to give
potential users a way to chose which tool to use (really, nobody want to
go use https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools
to pick the right tool. It's a great list, but not a guide).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
