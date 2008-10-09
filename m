From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Fwd: git status options feature suggestion
Date: Thu, 09 Oct 2008 17:12:24 +0200
Message-ID: <48EE1F58.2060707@drmicha.warpmail.net>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com>  <20081009061136.GA24288@coredump.intra.peff.net>  <81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com> <81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com> <alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 09 17:22:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnxCw-0002BZ-Ln
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 17:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893AbYJIPMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 11:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754092AbYJIPMa
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 11:12:30 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:38876 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753658AbYJIPMa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Oct 2008 11:12:30 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 676A8177F4B;
	Thu,  9 Oct 2008 11:12:29 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 09 Oct 2008 11:12:29 -0400
X-Sasl-enc: /eCF8GaN/C3D+SqIjNWxFTSyhEM9QLoBQE5wk1sdysP5 1223565148
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 539BB273F6;
	Thu,  9 Oct 2008 11:12:28 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97858>

Johannes Schindelin venit, vidit, dixit 09.10.2008 11:03:
> Hi,
> 
> On Thu, 9 Oct 2008, Caleb Cushing wrote:
> 
>>> How about "git ls-files -o"?
>> doh... hadn't even heard of that command.
> 
> Which is good!  As ls-files is listed as plumbing.  Users should not need 
> to call ls-files, so I like your idea about adding --new, --untracked etc. 
> to "git status" (I do not agree with others that "git status" has to stay 
> that non-existant "git commit --dry-run").
> 
> Could you list exactly which options you want implemented?

Requests for stuff like that keep appearing recently (I'm to blame
partially only ;) ). There are 3 issues at hand:

- people are used to "svn status [-v]" like output which can include
untracked as well as tracked unmodified files; there are other valid
reasons why you would want that info

- porc can't do it: git status can't show ignored files, doesn't use
status letters, can't show files with specific status; git diff
--name-status can't show ignored nor untracked files
[In fact, the description of "git diff" says "files which you could
add", which should include untracked files, but doesn't.]

- plumb uses conflicting letters: git ls-files output conflicts with git
diff --name-status output

So I guess it's time for a usability effort in this area. A few
questions before going about that:

- I think change of existing behaviour is unavoidable (make ls-files and
diff --name-status consistent). Is that something to do now or rather
before 1.7? Is porc (diff) supposed to be changed or plumb (ls-files)?

- How strong should the tie between git status and git commit be?
Current git status is basically git commit -n, with the usual meaning of
"-n" (such as for prune etc."), not with the current meaning of git
commit -n, sigh...

A few radical suggestions might be:

1. make ls-files and diff --name-status use compatible letters

2. rename git commit -n to git commit -b (as in bypass), make git commit
-n do what's expected ("--dry-run", n as in duNNo yet)

3. rename git status to git commit -n

4. make git status generate git diff --name-status like output

(3+4)'. make git status -l generate git diff --name-status like output
(l as in status Letter) as an alternative to 3+4

Michael
