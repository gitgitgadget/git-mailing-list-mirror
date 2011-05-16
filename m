From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Maint-only commits
Date: Mon, 16 May 2011 15:05:07 -0700
Message-ID: <7vliy6jo8c.fsf@alter.siamese.dyndns.org>
References: <10397477.30610.1305580263246.JavaMail.root@mail.hq.genarts.com>
 <6416457.30612.1305580526325.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Tue May 17 00:05:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM5uj-0007IO-RL
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 00:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700Ab1EPWFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 18:05:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51326 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744Ab1EPWFO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 18:05:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2FE574DFD;
	Mon, 16 May 2011 18:07:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rS8sQ0gTL+H2hr+CRUfqVwqSY3k=; b=eERueg
	eTc1Tul1ojGEYXGpgATnPDqE7GORDcHDoi5mvfiSUUTBr94EaoD7xQfdYiwjmO4e
	qtSKEndHliDKfJoEi0vz3xikIsG4PxZchsFNzPVC/Cf5Jm1G45flMM+iHizwORdl
	vm/qcEQJXYR8iGyNYwYrJLCgzB5+il7gnQfK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UJtOmvsiQ7dAHAhAqajof6bkRaDMJDgE
	6ujOCpc95JJDntzb0O/G6G17cIB8ERJf1E8JDgmd+uvNCs2lb4ST1Hisjj54iJiH
	4uQ4/tEQr56bljTpWjQleJsS2v/fcQutzdv3cfl5+E4xHnNo5JgIduwm1DvURDFr
	jlb1tl/G6u4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0CF404DF3;
	Mon, 16 May 2011 18:07:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E94114DF2; Mon, 16 May 2011
 18:07:15 -0400 (EDT)
In-Reply-To: <6416457.30612.1305580526325.JavaMail.root@mail.hq.genarts.com>
 (Stephen Bash's message of "Mon, 16 May 2011 17:15:26 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DDC22570-8008-11E0-B1DE-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173767>

Stephen Bash <bash@genarts.com> writes:

> In my office we've recently run into three separate fixes required on
> our maintenance branch that should not be included in master (our normal
> workflow is to make changes on maint, tag, release, and then merge to
> master).  Normally these "maint only" fixes are interspersed with
> commits that should go back into master.  In the past the "maint only"
> commits were rare, so I'd carefully use "merge -s ours" to avoid
> including the "maint only" changes in master.  But now I'm wondering if
> there's a better process/workflow?

I wonder what these "maint only" changes are, and the most importantly, if
you know if a change you are about to commit is "maint only" material at
the time you make it, or if it is something you would notice retroactively
only when it is time to prepare merging maint back to master.

Assuming the former, you can use exactly the same discipline you already
use to keep your 'maint' free of commits you make on 'master' to add new
features that shouldn't be in the maintenance track.

Let's think how you are already achieving that.

First you examine the change you will make, and decide if it is only meant
for master or it should go to both maint and master.

If the change is meant to go to both maint and master, you would queue to
a branch that can be merged to both maint and master. The simplest
workflow to do so is to commit the change directly on maint, later to be
merged to master along with other commits on maint. Or you may choose to
fork a topic branch from maint (or an earlier point on maint) and commit
the change on that branch. You would merge the topic branch to 'maint' and
then later either merge the whole 'maint' to 'master', or merge the topic
branch to 'master'.  Alternatively, you may even choose to first merge the
topic branch 'master' to make sure it does fix what you wanted to fix and
then merge that topic to 'maint' later.

On the other hand, if a change is only meant for 'master', you either
commit directly on 'master' or commit on a topic branch that can be merged
to 'master' and merge it later to 'master'. But you never merge that
change to 'maint'. That means you would not merge the topic branch (if you
used one) to 'maint', and you would not merge 'master' to 'maint.

How would you apply the same discipline for "maint only" situation?

First you examine if the change should only go to 'maint', and if so, you
will queue it to a branch that can only be merged to 'maint'. If a change
should go both to 'maint' and 'master', you will queue it to a branch that
can be merged to both.

Notice that the latter "branch that can be merged to both" can _NOT_ be
'maint', as your 'maint' is contaminated with commits that should not go
to 'master'. So the first thing to realize is that you no longer are
allowing yourself to merge 'maint' as a whole to 'master', nor a branch
that is forked from 'maint' to 'master'.

What follows that observation and discipline are:

 - You would keep for-both-maint-and-master, maint, and master branches.

 - You treat the for-both-maint-and-master branch the way maint branch in
   projects like git itself is treated, i.e. everything can go to
   master. Commit changes that are meant for both maint and master on this
   branch, either by committing directly on it, or forking a topic from a
   commit on that branch and committing on top of it.

 - You merge for-both-maint-and-master into maint and master at
   appropriate times.

 - You never merge maint to master, nor merge master to maint.

 - You commit changes that should only go to master on master, either by
   committing directly on it, or forking a topic from a commit on that
   branch and committing on top of it.

 - You commit changes that should only go to maint on maint, either by
   committing directly on it, or forking a topic from a commit on that
   branch and committing on top of it.
