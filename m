From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Automatically remote prune
Date: Thu, 5 Nov 2009 16:19:40 +0300
Message-ID: <20091105131940.GF27126@dpotapov.dyndns.org>
References: <43d8ce650911040242l44bbf87dm35494e04ce9039aa@mail.gmail.com> <7v639qi2un.fsf@alter.siamese.dyndns.org> <43d8ce650911041741w4b39d137ha2a1529a15256d27@mail.gmail.com> <7viqdpemki.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 14:19:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N62Fm-0001RR-SI
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 14:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756342AbZKENTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 08:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756314AbZKENTk
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 08:19:40 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:49417 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756327AbZKENTj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 08:19:39 -0500
Received: by fg-out-1718.google.com with SMTP id d23so2399353fga.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 05:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NA6/fdeHnD4eIacm9im1628JStI7OIO9M5+VW11ymLk=;
        b=amodJjvuTRAGO+854sfisHFJhqfiEiZbRsNWaGPe3XjctmYguUSVZNC6f+Ed1a4BUY
         KdD4aFrX0Q8tEckbFiDRr3vKO44qcZE/PPNkZLLOCrUgrPJrCYdWHHEHt9na51NK/QGp
         PCmrlG7nVY50bILVexcqO5L5IPBd8scvk1iqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qgUS9KkJv9m20W5tbaXAFULBKC/GSdPnaUoiTLy7JtqQQTqwPTwRAga9EFbdwzicK/
         XDMhRNtuUicjZ7k8clBEG43WSbkbhpgq7hGmrug9fg08h5ZK3t7/HQHIBVf/FGVL2Kzx
         nEzY43W7BoVo1+LXQCV4FeEqj/khfiXoQeEm0=
Received: by 10.86.203.35 with SMTP id a35mr4878456fgg.44.1257427183524;
        Thu, 05 Nov 2009 05:19:43 -0800 (PST)
Received: from localhost (ppp91-76-18-216.pppoe.mtu-net.ru [91.76.18.216])
        by mx.google.com with ESMTPS id d4sm3967057fga.6.2009.11.05.05.19.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Nov 2009 05:19:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7viqdpemki.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132227>

On Wed, Nov 04, 2009 at 06:23:57PM -0800, Junio C Hamano wrote:
> 
> There are two reasons I could think of that the user might want to know
> this.
> 
>  (1) The user wants to keep the remotes/<origin>/* namespace clean (iow,
>      the user does not care to keep old commits that were deemed bad by
>      the remote side) by removing stale tracking refs.  But in this case,
>      it is very unlikely that the user would use "git branch -d -r" to
>      remove stale ones one-by-one after seeing '[Deleted]' label in the
>      output from "git branch -r".  Rather he would run "git remote prune
>      origin" to blindly remove them all.
> 
>  (2) The user does want to be careful not to lose commits that now only
>      exists in his repository.  Perhaps he saw something worthwhile to
>      base his topic later on.  But these stale remote tracking refs are
>      not removed until the user runs "git remote prune origin".  As long
>      as we give him a way to check what will be pruned before running "git
>      remote prune", there is not much point in showing that information in
>      output of "git branch -r".  There is no need to keep extra info by
>      creating a new file in .git by "fetch". Nor showing that to the user
>      when he does "fetch" either, for that matter.
> 
> A better approach to please the first class of audience may be to
> introduce an option that tells fetch to cull tracking refs that are stale.

'git remote update' already has the --prune option, so it would be only
logical if 'git fetch' has it too... Perhaps, it would be useful to add
a configuration option to automatically prune remote branches on fetch.

> Such an option won't be very useful for the second class of audience,
> though.  For them we would need something else, and it would likely be an
> enhancement to "git remote".

'git remote prune' has --dry-run:

$ git remote prune --dry-run origin
Pruning origin
URL: git://git.kernel.org/pub/scm/git/git.git
 * [would prune] origin/offcuts
 * [would prune] origin/old-next

(Hmm... I did not know I had them in my git repo....)

So, it is possible to do now, but personally, I would prefer if 'git
fetch' would tell what references are removed. It may appear a bit too
chatty if someone has a lot of deleted references in a remote repo, but
I really do not see any good reason to keep stale branches. If you think
that some reference is useful and you want to preserve it then you can
create a local branch, but in 99.9% cases people want just to remove a
stale branch.

Actually, accumulation of stale branches is only half of the problem.
In some cases, the stale branch can mislead people. For instance, some
feature has been implemented and was merged to 'pu'. After that, this
feature was re-worked and later merged to the 'master' branch, after
that the feature branch was removed. Yet, some users may have the stale
branch pointing on the original version and may think that it is still
not merged and buggy...

BTW, the current behavior of 'git fetch' does not really protect you from
losing commits. It protects commits only in the case when the branch is
deleted, but not when it is force-updated, which feels inconsistent to
me. Personally, I would prefer if 'git fetch' removed branches, but when
it removes or force-updates some branch, it adds a record to the reflog.


Dmitry
