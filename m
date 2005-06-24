From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Stacked GIT 0.1 (a.k.a. quilt for git)
Date: Fri, 24 Jun 2005 13:27:57 +0100
Message-ID: <tnx4qbo548i.fsf@arm.com>
References: <tnxy899zzu7.fsf@arm.com> <20050623175848.1cf41a52.pj@sgi.com>
	<tnxd5qc6s5o.fsf@arm.com> <20050624034743.6c3bdae4.pj@sgi.com>
	<tnxhdfo56yd.fsf@arm.com> <20050624045627.6e9cbaff.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 14:23:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlnCi-0003Wh-Ub
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 14:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVFXM2f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 08:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbVFXM2d
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 08:28:33 -0400
Received: from fw-nat.cambridge.arm.com ([193.131.176.54]:35 "EHLO
	ZIPPY.Emea.Arm.com") by vger.kernel.org with ESMTP id S261630AbVFXM2O
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2005 08:28:14 -0400
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 24 Jun 2005 13:28:12 +0100
To: Paul Jackson <pj@sgi.com>
In-Reply-To: <20050624045627.6e9cbaff.pj@sgi.com> (Paul Jackson's message of
 "Fri, 24 Jun 2005 04:56:27 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 24 Jun 2005 12:28:12.0410 (UTC) FILETIME=[2FF925A0:01C578B8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>> there is no way to modify the log history.
>
> Aha.  If that means what I think it does, then I suspect I will remain
> with quilt.  The per-patch comment is often about the last thing that
> I put in the patch.

I think you got it a bit wrong.

That was the initial idea. Anyway, in a future version you will have
one commit which is trackable via HEAD and which represents the whole
patch. This commit's log should always contain the patch description
so that people pulling your HEAD know what it is about.

If this is useful, a patch can have a second commit (or chain of
commits) refering to the same tree but not trackable via .git/HEAD but
which can be useful to track the individual changes of a patch. This
would be stored under .git/patches/<head>/<name>/ and not accessible
to anyone pulling the HEAD (well, rsync might bring the object but it
can be cleaned-up). This might be useful if you have a bigger patch
and want to track its changes, only internally.

Anyway, I think I won't implement this second commit handling and the
per-patch history would be trashed. Now I think I understand why you
mean by not caring about the commit message.

> The special thing about quilt is that the patch set in every regard
> is infinitely changeable - the selection and order of the patches,
> the contents of the patches, and the comments and metadata associated
> with the patch can all be edited trivially.

Almost all of this can be done with stgit. A patch in stgit is a just
a diff between 2 snapshots of the tree. The patch is indefinitely
changeable via commit. This weekend I will implement the proper commit
handling so that every new commit represents the whole patch and not
just the last modification.

You can easily reorder patches by popping all of them and pushing in a
different order. This is done via diff3 merging.

> Quilt is not a change management system; it's a patch set composition
> system.

I think the confusion comes from the fact that I wanted to put both
patch composition and change management in the same tool without a
clear separation.

> That stgit is layered on git (a persistent data store), and that
> it has something (the log history you mention above) that cannot
> be modified, suggests that stgit is not a 'better quilt for git',
> but some other sort of tool.

Again, the log history should only be internal, if useful, and not
visible to the outside world.

> Good luck ;).

Thanks. At least it is good that you tried it and provided some ideas
about what's needed as a quilt replacement. I will release a 0.3
version this weekend with the above things and you can try it.

-- 
Catalin

