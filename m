From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: How are submodule conflicts resolved during rebase?
Date: Tue, 28 Apr 2015 18:49:04 +0200
Message-ID: <20150428164904.GA4477@sandbox-ub1410>
References: <CAHd499CSshO-929PF7fiR4hpxd9J=S+XFuE3sdQHFjPvXT_C0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 18:49:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yn8hC-0002fn-6Z
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 18:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbbD1QtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 12:49:13 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:36867 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030288AbbD1QtM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 12:49:12 -0400
Received: from [80.135.112.188] (helo=sandbox-ub1410)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Yn8h3-0002lj-Oj; Tue, 28 Apr 2015 18:49:09 +0200
Content-Disposition: inline
In-Reply-To: <CAHd499CSshO-929PF7fiR4hpxd9J=S+XFuE3sdQHFjPvXT_C0w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267930>

On Tue, Apr 28, 2015 at 09:34:06AM -0500, Robert Dailey wrote:
> Suppose I have a branch with 10 commits on it, 3 of those commits
> contain a change to the same (and only) submodule in the repository.
> When I rebase this branch onto the tip of its parent branch, I get a
> conflict in each of the 3 commits because the submodule also changed
> on the parent branch since my last rebase.
> 
> I've seen some cases where I am asked to resolve the submodule
> conflict with local or remote. I expect this behavior and it isn't
> confusing to me. However, I have also seen cases where rebase auto
> resolves the conflicted submodule.
> 
> How does Git know to auto resolve some submodule conflicts but not the
> others? I find this behavior unpredictable and I haven't found any
> documentation on it (I'm giving the git docs the benefit of the doubt
> and assuming it's there, since the git docs are very very good).

There is some logic for submodule merges, but to prevent false merges
only the straight forward case results in a clean merge. In short:
Conflicts for submodules are auto resolved when one side is contained in
the other and both changes point forward.

I.e. when merging A and B in the superproject and the submodule looks
like this:

	base---*---*---B
	\             /
	 *---A---*---*

It will result in a clean merge in the superproject.

If there is a common commit that contains both sides but that commit is
not part of any side in the superproject the merge will fail but suggest
that commit as a conflict resolution.

Hope that helps.

Cheers Heiko
