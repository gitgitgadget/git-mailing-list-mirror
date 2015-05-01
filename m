From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Diffing submodule does not yield complete logs for merge commits
Date: Fri, 1 May 2015 19:57:57 +0200
Message-ID: <20150501175757.GA10569@book.hvoigt.net>
References: <CAHd499BqB_ZFKMNxSVCDTFx2Ge=TfCE6gexFn+rfRbS+ybLybA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 01 19:58:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoFCo-0007pK-0D
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 19:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbbEAR6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 13:58:21 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:49795 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbbEAR6U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 13:58:20 -0400
Received: from [92.76.95.20] (helo=book.hvoigt.net)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1YoFCL-00066O-CO; Fri, 01 May 2015 19:58:01 +0200
Content-Disposition: inline
In-Reply-To: <CAHd499BqB_ZFKMNxSVCDTFx2Ge=TfCE6gexFn+rfRbS+ybLybA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268167>

Hi,

On Wed, Apr 29, 2015 at 03:53:11PM -0500, Robert Dailey wrote:
> I am attempting to diff a submodule modified in my working copy and
> the only difference is a merge commit. However, I do not get the
> "full" range of commits introduced by the merge commit when I diff it:
> 
> $ git diff --submodule=log Core
> Submodule Core 8b4ec60..def2f3b:
>   > Merge remote-tracking branch 'origin/master-ah3k'
> 
> However if I go inside my submodule and run `git log` by hand, I get
> more information about the TRUE commits introduced:
> 
> $ git log --oneline 8b4ec60..def2f3b
> def2f3b Merge remote-tracking branch 'origin/master-ah3k'
> 015c961 Remove log spam in FontManager
> 7713ba1 Update third party submodule to latest
> 10aac78 Merge pull request #9 in FE/core from
> feature/FE-1348-selecting-continue-on-zero-balance to master-ah3k
> 287882f FE-1376 Nedd to remain in check detail screen when selecting
> donation after SBI
> a5a6bed Do not overwrite the current check# within loop
> dfb8547 Adding list of checks to CRspChecks before saving
> 1be280a FE-1354: Guest logged out in specific multiple check scenario
> de06d5a [FE-1348] Fix PATT exit while checks still open
> 
> It's almost as if the `git diff --submodule=log` approach is passing
> in --first-parent to git log, which would exclude commits in the range
> that I'm seeing when I run git log manually.

That is exactly the case. In prepare_submodule_summary() that option is
set before doing the revision walk.

> Is this by design? Is there a way to enable the full log history with
> `git diff` on a submodule?

This stems from the first implementation for showing submodule diffs in
commit 752c0c24. I guess this was done deliberately to limit the amount
of output you get for a submodule. At the moment this is hardcoded but I
think there is nothing wrong with adding another option to include the
full log.

Cheers Heiko
