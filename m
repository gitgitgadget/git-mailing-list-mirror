From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Clone Parameter
Date: Fri, 19 Jul 2013 08:02:13 -0700
Message-ID: <7v4nbqzj7u.fsf@alter.siamese.dyndns.org>
References: <FB572366-0B1D-4053-9255-979CB213B160@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Allan Acheampong <allanadjei@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 17:02:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0CCL-00065S-4Y
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 17:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721Ab3GSPCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 11:02:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37070 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167Ab3GSPCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 11:02:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2B5830123;
	Fri, 19 Jul 2013 15:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HS+Z7g/YhYuWgTCN0wNnvn4XQ+Q=; b=ntvQvh
	TLa7iub717YFwbO2y1DVoc4ag7+sCIFFMdU9PBQvqFXtUSokPbLX9Dx/SXGBYf4X
	iVPVXwwWClgp7ReWwPHVKOTjYl21cNKoNzDpEvX9r5te5KZnCCRG66rhHJi1TDZw
	D1hc95Jol57gulYwMxPTli64CjpJtWfXohtEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EMIXJgVO5A8fElYi1H8u/KencmDvfM/+
	hHuyktgng1PwZEpIgI4ysGsNI3mWMT80ohwMADiyA3bxtsOXeC0eOUQH7TDdHNT+
	QvEu++sfxwLvHfn0gJOX4ZT/CGE7ToJLT5FHECRlMtLm+MyNRsUbSp7Gol5obO3j
	tGs1WjbWSJI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D881B30122;
	Fri, 19 Jul 2013 15:02:15 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0BA4530120;
	Fri, 19 Jul 2013 15:02:14 +0000 (UTC)
In-Reply-To: <FB572366-0B1D-4053-9255-979CB213B160@gmail.com> (Allan
	Acheampong's message of "Fri, 19 Jul 2013 11:21:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 32A5098E-F084-11E2-A2E4-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230812>

Allan Acheampong <allanadjei@gmail.com> writes:

> ... I'm new to git, but I found it very
> confusing to understand the difference between "remote" ,
> "remotes". Is it in the cloned repo, or is it in a remote place?
> If its local, why doesn't it get shown when I do 'git branch' but
> when I do 'git branch -a'.
> ...
> For example, I create a project locally
> with multiple branches, push it, delete it locally and clone it
> back to my machine. On a 'git branch' I would only see the head
> branch.
> ...
> I'd like to know your opinions about that and what you think about
> the suggestion.

Not very interested, for a few reasons:

 (1) It is actively harmful if the aim is to blur the distinction
     between local branches and remote-tracking branches. New users
     will be in a lot of hurt if they are not aware that the
     'master' branch in their repository is unique and different
     from the 'master' branch of everybody else's repository and the
     'origin' remote repository they cloned from.

 (2) It is not necessary. You can do interesting things to the
     history on your local branch, like creating new commits to grow
     the branch, only after checking it out. And modern Git lets you
     say

     $ git checkout topic

     and it DWIMs the request to "check out the topic branch" to do
     the equivalent of

     $ git branch -t topic origin/topic && git checkout topic

     when 'topic' does not exist as your local branch and there is a
     single remote (i.e. 'origin') that has a remote-tracking branch
     of that same name 'topic'. This lets you create a corresponding
     local branch lazily any time you want to work on extending the
     work on a branch taken from the remote, and output from "git
     branch --list" to be meaningful: it only lists your local
     branch, the ones you have already said that you are interested
     in working on in this repository.

 (3) It makes "git branch --list" output less useful if you create
     local branches that correspond to all the branches taken from
     the remote.  You cannot tell which ones you have worked on and
     which ones you haven't even touched yet.

Having said that, it is fairly trivial to script it, if you really
want to do so, ignoring all of the above downsides.  Something like:

	git for-each-ref --format='%(refname)' refs/remotes/origin/ |
	sed -e 's|^refs/remotes/origin/||' -e '/^HEAD$/d' |
	while read branchname
        do
		git show-ref -q --verify "refs/heads/$branchname" ||
                git branch -t "$branchname" "origin/$branchname"
	done

But for the reasons stated, it is not a particularly good way to
work to start from many local branches that are copies of all the
remote-tracking branches, many of which you may not even touch, so I
personally do not think we would want to add such an option to
"clone".  The implementation would be fairly trivial, as you can see
from the "trivial script" above, but it would encourage a wrong
workflow.

Older Git around 1.4.x days used to conflate remote-tracking
branches and local branches, and threw everything in refs/heads/
hierarchy, which had the exact set of problems above, and that is
why modern Git uses refs/remotes/origin/ hierarchy to store the
remote-tracking branches separately, for less cluttered local branch
namespace.
