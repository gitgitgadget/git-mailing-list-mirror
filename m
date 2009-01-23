From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: Short "git commit $file" syntax fails in the face of a resolved
 conflict
Date: Thu, 22 Jan 2009 21:55:25 -0500 (EST)
Message-ID: <alpine.DEB.2.00.0901222101520.14992@vellum.laroia.net>
References: <4978202C.3090703@viscovery.net> <alpine.DEB.2.00.0901211549070.15860@vellum.laroia.net> <49779521.9040208@drmicha.warpmail.net> <c1a864630901211346j4b702fb3tcc5a098ed7e1541d@mail.gmail.com> <20090123094509.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Nathan Yergler <nathan@creativecommons.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 03:57:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQCEb-0000Pm-Ep
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 03:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756162AbZAWCzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 21:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755851AbZAWCzd
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 21:55:33 -0500
Received: from rose.makesad.us ([219.105.37.19]:33311 "EHLO rose.makesad.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755275AbZAWCzc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 21:55:32 -0500
Received: from vellum.laroia.net (localhost [127.0.0.1])
	by rose.makesad.us (Postfix) with ESMTP id E5C83A0104;
	Thu, 22 Jan 2009 21:55:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by vellum.laroia.net (Postfix) with ESMTPS id A547A3A62B9;
	Thu, 22 Jan 2009 21:55:25 -0500 (EST)
X-X-Sender: paulproteus@vellum.laroia.net
In-Reply-To: <20090123094509.6117@nanako3.lavabit.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-OpenPGP-Key-ID: 0x70096AD1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106825>

On Fri, 23 Jan 2009, Nanako Shiraishi wrote:

> Your explanation is a good answer to Nathan's misunderstanding; "git add 
> path && git commit" and "git commit path" are different.
>
> But Nathan's first sentence is a different matter.

Thanks for seeing this!

> I do not think it is coming from the same confusion, and I think the 
> question is a valid one. Your answer does not explain why it is a bad 
> idea to change the behavior of "git commit path" to what "git commit -i 
> path" does during a merge.

During a merge where the file called "file" is in conflict, I don't see 
why the internal mechanism of how a merge gets resolved is important to 
users like Nathan.

Sure, the index is nice, but let's look at the choices here.  When he runs
$ git commit file -m 'fixed conflict'
git can do one of two things:

(a) Fail with an obscure (or less obscure) error message, or
(b) Succeed.

The way in which it can suceed is unambiguous. Now, in the case of more 
than one file being in conflict, it makes sense to abort; success isn't 
possible. But in this case, no one really benefits from the user having to 
type something else to have the command actually succeed.

Those are my thoughts.

> The answer of course can be "because it changes the behavior people are 
> very much used to."

I don't think anyone is "very much used to" this error message, or that 
making something succeed in the only possible way is going to confuse 
anyone. If you're worried about confusing people, git could print a note 
like:

 	$ git commit file -m "Fixed conflict"
 	NOTE: Merge was in progress. If you have more than one file in conflict
 	in a future merge, be sure to "git add" each file separately and then
 	commit them all at once.
 	Created commit 12ede36: Fixed conflict
 	 0 files changed, 0 insertions(+), 0 deletions(-)
 	 create mode 100644 file
 	$

-- Asheesh.

-- 
In the Spring, I have counted 136 different kinds of weather inside of
24 hours.
 		-- Mark Twain, on New England weather
