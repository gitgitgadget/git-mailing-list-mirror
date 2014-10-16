From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH 0/4] Multiple worktrees vs. submodules fixes
Date: Thu, 16 Oct 2014 23:54:53 +0300
Message-ID: <20141016205453.GA8441@wheezy.local>
References: <1413090791-14428-1-git-send-email-max@max630.net>
 <CACsJy8BUtkWKE+P_sHgpAY6wJ9tpzxZRtZHULiLoO=dGnBjkHQ@mail.gmail.com>
 <543D58D9.5060606@web.de>
 <xmqqoatezhnx.fsf@gitster.dls.corp.google.com>
 <20141014183431.GA8157@wheezy.local>
 <543D7EBA.4040206@web.de>
 <20141014221509.GA10580@wheezy.local>
 <543EC390.4000709@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Oct 16 22:56:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xes5n-0006bp-V8
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 22:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053AbaJPU4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 16:56:05 -0400
Received: from p3plsmtpa07-10.prod.phx3.secureserver.net ([173.201.192.239]:42731
	"EHLO p3plsmtpa07-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753028AbaJPU4D (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Oct 2014 16:56:03 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa07-10.prod.phx3.secureserver.net with 
	id 3wvo1p00R5B68XE01wvva1; Thu, 16 Oct 2014 13:55:59 -0700
Content-Disposition: inline
In-Reply-To: <543EC390.4000709@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 15, 2014 at 08:57:20PM +0200, Jens Lehmann wrote:
> Am 15.10.2014 um 00:15 schrieb Max Kirillov:
>> I think the logic can be simple: it a submodule is not
>> checked-out in the repository "checkout --to" is called
>> from, then it is not checked-out to the new one also. If it
>> is, then checkout calls itself recursively in the submodule
>> and works like being run in standalone repository.
> 
> But when I later decide to populate the submodule in a
> "checkout --to" work tree, should it automagically also
> use the central storage, creating the modules/<name>
> directory there if it doesn't exist yet? I think that'd
> make sense to avoid having the work tree layout depend
> on the order commands were ran in. And imagine new
> submodules, they should not be handled differently from
> those already present.

Like place the common directory to
$MAIN_REPO/.git/modules/$SUB/ and worktree-specific part to
$MAIN_REPO/.git/worktrees/$WORKTREE/modules/$SUB, rather
than placing all into the socond one? It would make sense to
make, but then it would be imposible to checkout a diferent
repository into the same submodule in different superproject
checkouts. However stupid is sounds, there could be cases
if, for example, at some moment submodule is being replaced
by another one, and older worktrees should work with older
submodule, while newer uses the newer submodule.

Maybe, there could be some options to tell the command which
populates submodules (which commands that are? "submodule update"
and other submodule subcommands? or there is something
else?) to use the curent checkout space or the main one. But
I would still leave it depend on what user explicitly calls
and where the initial submodule update is executed.

Also, could you clarify the usage of the /modules/
directory. I did not notice it to affect anything after the
submofule is placed there. Submodule operations use the
submodule repositories directly (through the git link, which
can point anywhere), or in .gitmodules file, or maybe in
.git/config. So there is actually no need to have that
gitdir there. Is it correct?

-- 
Max
