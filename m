From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: problem with cherry-picking a commit which comes before
 introducing a new submodule
Date: Fri, 7 Jan 2011 12:15:01 -0600
Message-ID: <20110107181501.GA28980@burratino>
References: <20110107172432.GA6040@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
To: Yaroslav Halchenko <debian@onerussian.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 19:15:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbGqT-0001TM-8A
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 19:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755071Ab1AGSPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 13:15:19 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44208 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754741Ab1AGSPR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 13:15:17 -0500
Received: by qwa26 with SMTP id 26so18064089qwa.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 10:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ykC2SyAzepj2i7R6F1tdaS61NmxHBMVLW0mfPyicOIA=;
        b=miw2ga3Sl4Mbd4X3hpd8/igXsJgMLpoaHk84oFu/9/vdeBMaBGqbUkA8joCMJ+q7lQ
         CKPE+YulHBMrY3Cm3INgyVdoHc8DOBJxYBb8ac6tQCWnzbAn2J1EGiwlNOv+dUPVxXGK
         It8tRh+ZjqQXCrOicCoHGj9cqkYrp4d1OzTgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ul9KiZ3aFtV2L0ZVKZZSfppws5EG3jOWby+/97H2VFgwjeZYawY3e0P9UWs8/971/w
         DvEGrPHuJfgx9CDMCfOOS/awNIP4OQRcOsYmP3IyUEb8oJ23caMjHSQuSSZSMk+xTw4r
         hKcSh2/KkZyn/Xv6mwNie+U6haU04wLCgOBVI=
Received: by 10.229.220.144 with SMTP id hy16mr21558499qcb.80.1294424117059;
        Fri, 07 Jan 2011 10:15:17 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id nb15sm14392260qcb.14.2011.01.07.10.15.14
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 07 Jan 2011 10:15:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110107172432.GA6040@onerussian.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164729>

(+cc: Elijah Newren, who has worked on some of this code)

Yaroslav Halchenko wrote:

> In our repository we had some submodules, then there was a branch off
> (call new branch todonotloose) with a single commit.  In the master we
> had some other commits and moved one of the subdirectories into a
> submodule.
> 
> Later on we decided to cherry pick todonotloose into master but
> cherry-pick fails despite the fact that 'git show todonotloose | patch
> -p1' applies just fine, ie there were no changes touching any of the
> submodules.
[...]
> $> git status
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #	new file:   poster-hbm2011_neurodebian/abstract.txt
> #	modified:   poster-hbm2011_neurodebian/jb.txt
> #
> # Unmerged paths:
> #   (use "git reset HEAD <file>..." to unstage)
> #   (use "git add/rm <file>..." as appropriate to mark resolution)
> #
> #	added by us:        frontiers/code
> #

As contrib/examples/git-revert.sh explains, the heart of "git
cherry-pick" is

	base=todonotloose^
	next=todonotloose
	head=HEAD

	git merge-recursive $base -- $head $next

Could you try that, perhaps with GIT_MERGE_VERBOSITY=4 (or some other
number from 1 to 5, larger is louder) in the environment?  For context,

	git ls-files -u;	# after the merge
	git diff-tree todonotloose
	git diff-tree todonotloose^ HEAD

would also be interesting.
