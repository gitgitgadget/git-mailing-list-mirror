From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Fri, 23 Jul 2010 11:19:59 -0400
Message-ID: <4C49B31F.8000102@xiplink.com>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> 	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> 	<4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> 	<m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 17:32:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcKEV-0004i1-8K
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 17:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760861Ab0GWPb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 11:31:27 -0400
Received: from smtp192.dfw.emailsrvr.com ([67.192.241.192]:58548 "EHLO
	smtp192.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760753Ab0GWPbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 11:31:25 -0400
X-Greylist: delayed 625 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Jul 2010 11:31:25 EDT
Received: from relay19.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay19.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id A9B5C2748F80;
	Fri, 23 Jul 2010 11:20:58 -0400 (EDT)
Received: by relay19.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id B2E4F27481DD;
	Fri, 23 Jul 2010 11:20:56 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100528 Thunderbird/3.0.5
In-Reply-To: <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151543>

On 10-07-22 03:41 PM, Avery Pennarun wrote:
> 
> 1) Sometimes I want to clone only some subdirs of a project
> 2) Sometimes I don't want the entire history because it's too big.
> 3) Super huge git repositories start to degrade in performance.

The reason we turned to submodules is precisely to deal with repository size.
 Our code base encompasses the entire FreeBSD tree plus different versions of
the Linux kernel, along with various third-party libraries & apps.  You don't
need everything to build a given product (a FreeBSD product doesn't use any
Linux kernels, for example) but because all the products share common code we
need to be able to branch and tag the common code along with the uncommon code.

So a straight "git clone" that would need to fetch all of FreeBSD plus 4
different Linux kernels and check all that out is a major problem, especially
for our automated build system (which could definitely be implemented better,
but still).  In truth it's the checkout that takes the most time by far,
though commands like git-status also take inconveniently long.

We chose git-submodule over git-subtree mainly because git-submodule lets us
selectively checkout different parts of our code.  (AFAIK sparse checkouts
aren't yet an option.)  We didn't really consider git-subtree because it's
not an official part of git, and we didn't want to have to teach (and nag)
all our developers to install and maintain it in addition to keeping up with
git itself.  Besides, git-submodule's collection-of-independent-repos model
works fairly well in our situation, though the implementation could
definitely be improved (and Jens's list is a really good start).

Neither submodule nor subtree really solves our situation, but right now
git-submodule is the only thing "official" git offers to manage
loosely-coupled code.  It would be nice to see git-submodule added to the
toolkit, but it would be even nicer if git had better ways to deal with
"vast" repositories.

Another tool folks should keep in mind in this discussion is 'repo' which
Google built for the Android project.  Android's code base is also too vast
to work well in a single git repository, and I don't think subtrees or
submodules would be a good match for them either.

		M.
