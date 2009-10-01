From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git push over git protocol for corporate environment
Date: Thu, 1 Oct 2009 11:06:28 -0700
Message-ID: <20091001180628.GQ14660@spearce.org>
References: <76c5b8580909301613m283c4bfdne8de449ca0fd0987@mail.gmail.com> <873a64gfa6.fsf@sanosuke.troilus.org> <20091001000620.GN14660@spearce.org> <4AC44C55.6080807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Poole <mdpoole@troilus.org>,
	Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 01 20:06:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtQ31-0005zA-3X
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 20:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573AbZJASGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 14:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755078AbZJASGZ
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 14:06:25 -0400
Received: from george.spearce.org ([209.20.77.23]:58617 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471AbZJASGY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 14:06:24 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C006F381FE; Thu,  1 Oct 2009 18:06:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4AC44C55.6080807@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129406>

Marius Storm-Olsen <mstormo@gmail.com> wrote:
> Shawn O. Pearce said the following on 01.10.2009 02:06:
>> Michael Poole <mdpoole@troilus.org> wrote:
>>> (Others have mentioned Gerrit.  I use that at work, and my only
>>> major wish is that it had per-branch rather than per-project
>>> access controls.  It is a vast improvement over the Subversion
>>> system we had before.)
>>
>> You'll be happy to hear _everyone_ is demanding per-branch
>> controls, I have to do it before the end of the year, maybe even
>> before the end of the month...
>
> Ugh, any pointers on this one? Does this mean that you're planning to  
> add this sort of control in git itself, or just some way to facilitate  
> the setting of owner/group on individual ref files? What about packed  
> refs?

I guess you don't know how Gerrit Code Review works, or missed that
I was talking about Gerrit and not git.

Gerrit behaves like Gitosis, it owns the repositories under its care,
and (in general) nobody else is allowed to read or write to them
except the Gerrit daemon process.  That process is running JGit,
not git.git, which means I have full control over the entire code
that serves that repository.

We already have write level control to branches in that JGit has
per-ref hook support similar to what the update hook provides in git.
It doesn't actually use the update hook, its an interface API the
server implements and pushes down into the JGit library, and it has
more control over the response issued to the client, but we get the
same result.  I'm just missing a UI that allows an administrator to
configure that implementation's decision making on a per-ref basis.

We don't yet have read level control to read branches, but this
is fairly trivial to implement.  I just need an interface API
that can filter the refs before we advertise them to the client.
Given my expand refs protocal extension that I started working on
(but have not yet finished) I'd need something like that in JGit
anyway just to implement the expand refs behavior.  Teaching it to
further filter refs by who can read what is then trivial.

-- 
Shawn.
