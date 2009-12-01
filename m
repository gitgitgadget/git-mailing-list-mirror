From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/RFC] Add a --bouquet option to git rev-list
Date: Tue, 01 Dec 2009 09:09:43 +0100
Message-ID: <4B14CF47.5020808@drmicha.warpmail.net>
References: <4b143a9c.c401be0a.364f.ffffba5b@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 09:11:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFNp8-0002cX-AS
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 09:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbZLAIKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 03:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753141AbZLAIKu
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 03:10:50 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:36251 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752557AbZLAIKt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 03:10:49 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 714AFC448D;
	Tue,  1 Dec 2009 03:10:56 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 01 Dec 2009 03:10:56 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=VCgt+wa1VxfKwNecn26yQfNM2vU=; b=eoLYnU8gohIwzNke51vSx4yLsAHug3TU7AkmofQXHDm7LOJo8NCVL7X3Cun1MLpDeItHgvnxA3+MHSEFGqMHy+sMfy70rFHWG3JiwdWQrM+aa75blzcDLmEPFnlCGu5hC5L7/5WHZATfpPaqdvw/PqbyBG/4EkouzF4IOICVXH4=
X-Sasl-enc: hcm5qmztEH24Ih5IyGD9t9cCfncZoPpvGeD61h5EobwJ 1259655056
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D9D6149ED7E;
	Tue,  1 Dec 2009 03:10:55 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091127 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <4b143a9c.c401be0a.364f.ffffba5b@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134176>

Nathan W. Panike venit, vidit, dixit 30.11.2009 21:55:
> Add a command line option to rev-list so the command 'git rev-list --bouquet'
> shows all revisions that are ancestors of refs which share history with HEAD.
> 
> Signed-off-by: Nathan W. Panike <nathan.panike@gmail.com>
> ---
> I have a repository with the following structure:
> 
>       B
>      /
> A'--A--C
>      \
>       D
> 
> E'--E
> 
> Thus the command 'git merge base E A' returns nothing, as there is no common
> history.  The E history contains stuff that is derived from the other history
> (A, B, C, or D).  Often I find myself doing the following:

Either I don't understand the diagram or your term "derived". If
"derived" means "on some branch of a merge" and E is derived from A, B,
C, or D, then (since B, C, D is derived from A, and from A') E is
derived from A', and they will have a merge base.

Are these diagrams really disconnected from each other?

> git checkout C
> gitk $(include_forks) &
> <View history, make changes, merges, et cetera>
> git checkout E
> <go back to gitk, only see history for B, C, etc>
> 
> Now the 'include_forks' command is a bash function in my .bashrc:
> 
> include_forks () 
> { 
>     local head="$(git show -s --pretty=format:'%H' HEAD)";
>     echo "HEAD $(git for-each-ref --format='%(refname)' \
> 	refs/heads refs/remotes | while read ref; do \
> 	if test "$(git merge-base HEAD ${ref}^{commit})" != ""; \
> 		then echo ${ref}; fi; done)"
> }
> 
> The shell thus intercepts my command and I must restart gitk to see the history
> of E. 
> 
> With this patch, I can issue the command 'gitk --bouquet' and when I checkout
> E, I can 'reload' in gitk and see the history of E automatically.

What would your patch do in the example you gave above? Which refs would
it cause gitk (rev-list) to show?

Michael
