From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Right way to import a repo
Date: Sat, 22 Dec 2012 18:57:40 +0100
Message-ID: <50D5F494.7060200@drmicha.warpmail.net>
References: <1530104.jO5zzzN8PS@horus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Florian Lindner <mailinglists@xgm.de>
X-From: git-owner@vger.kernel.org Sat Dec 22 18:58:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmTKm-0000ni-Sf
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 18:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945Ab2LVR5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 12:57:47 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35562 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751883Ab2LVR5q (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Dec 2012 12:57:46 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A6BF8207F0;
	Sat, 22 Dec 2012 12:57:45 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Sat, 22 Dec 2012 12:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=c2TPyrGBZuRbi0P+gSFnBZ
	1e5xY=; b=bK7cdtj8Uam4W7KuEGwpcy1W1xo9nIn3TGDp8jSwCnSRBHiTsebIEy
	doY6m4hq4RnVAOjkXfRdq0pnrJjArUD0iK/gMBkUTnckvvWMztlgiaO14G7SYe0c
	q69aa8ozsDzDYHtsFoUSbsj5LwiGFEgzHuIcmuTCd7c0udrIVX418=
X-Sasl-enc: YEZCCEiOahhKtiF1V0sAMn8YhN6jo5CNuyYoYHNeGhTV 1356199065
Received: from localhost.localdomain (unknown [88.70.134.107])
	by mail.messagingengine.com (Postfix) with ESMTPA id 119F28E06FC;
	Sat, 22 Dec 2012 12:57:44 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <1530104.jO5zzzN8PS@horus>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212062>

Florian Lindner venit, vidit, dixit 21.12.2012 17:11:
> Hello,
> 
> I have two repositories. tools and flof. I want to merge flof into tools (and 
> flof will be deleted after that) while keeping history intact. Of course I've 
> googled that and found a number of different solution which all seem to be 
> pretty komplex, so I just tried it myself. It seems to work.... are there any 
> problems with my approach?
> 
> ~/software/tools.test (git)-[master] % git remote add fl ~/flof
> 
> ~/software/tools.test (git)-[master] % git fetch fl
> warning: no common commits
> remote: Counting objects: 475, done.
> remote: Compressing objects: 100% (460/460), done.
> remote: Total 475 (delta 251), reused 0 (delta 0)
> Receiving objects: 100% (475/475), 190.40 KiB, done.
> Resolving deltas: 100% (251/251), done.
> From /home/florian/flof
>  * [new branch]      master     -> fl/master
>  * [new branch]      v2-rewrite -> fl/v2-rewrite
> 

Two disjoint histories, nothing wrong with that.

> /software/tools.test (git)-[master] % git checkout -b import fl/master
> Branch import set up to track remote branch master from fl.
> Switched to a new branch 'import'
> 
> Doing some mkdir und git mv for reorganisation.

Here avoid possible problems from both projects using the same root (in
the filesystem/tree sense).

> ~/software/tools.test/flof (git)-[import] % git commit -m "Reorganize flof."
> [import a00ab54] Reorganize flof.
>  152 files changed, 0 insertions(+), 0 deletions(-)
>  rename {doc => flof/doc}/common.rst (100%)
>  rename {doc => flof/doc}/conf.py (100%)
>  [...]
> 
> ~/software/tools.test/flof (git)-[import] % git checkout master
> Switched to branch 'master'
> 
> ~/software/tools.test (git)-[master] % git merge import
> Auto-merging .gitignore
> CONFLICT (add/add): Merge conflict in .gitignore
> Automatic merge failed; fix conflicts and then commit the result.
> 
> Resolving the conflict.
> 
> ~/software/tools.test (git)-[master|merge] % git add .gitignore
> 
> ~/software/tools.test (git)-[master|merge] % git commit -m "Merged flof."
> [master b8c85be] Merged flof.
> 
> ~/software/tools.test (git)-[master] % git remote rm fl
> 
> Are thery any problems with this procedure? The history seems to intact. I'm 
> quite unsure since still being a git beginner. 

It works in the sense that git follows the renames (moves) you had to do
prior to the merge.

Other tools like git-subtree do that history implanting in one step, by
putting the added project into a subtree (rewriting the history). That
way you don't have reorg commits in the history.

Michael
