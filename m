From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: [irq/urgent]: created 3786fc7: "irq: make variable static"
Date: Wed, 22 Oct 2008 09:39:49 +0200
Message-ID: <adf1fd3d0810220039g51d61e92l5ba254b57723d3b6@mail.gmail.com>
References: <20081022061730.GA5749@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ingo Molnar" <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Oct 22 09:41:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsYL4-0004Zq-PW
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 09:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbYJVHjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 03:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbYJVHjy
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 03:39:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:14562 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbYJVHjv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 03:39:51 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1273747ugf.37
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 00:39:49 -0700 (PDT)
Received: by 10.103.212.2 with SMTP id o2mr4986186muq.1.1224661189613;
        Wed, 22 Oct 2008 00:39:49 -0700 (PDT)
Received: by 10.103.131.8 with HTTP; Wed, 22 Oct 2008 00:39:49 -0700 (PDT)
In-Reply-To: <20081022061730.GA5749@elte.hu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98835>

On Wed, Oct 22, 2008 at 8:17 AM, Ingo Molnar <mingo@elte.hu> wrote:
[...]

> this welcome enhancement made me remember of three usage problems i had
> with Git recently:
>
> 1)
>
> Btw., it would be nice if there was an easier way to get a similar git
> log display in the ASCII space. For example i frequently ask the
> question "which topic branch did commit XYZ originate from?". All i have
> now is a pretty crude script that displays this for a given file:
>
> earth4:~/tip> tip-log --no-merges linus.. kernel/sched.c | grep ^#
> # core/kill-the-BKL: ffda12a: sched: optimize group load balancer
> # core/locking: ffda12a: sched: optimize group load balancer
> ...
>
> (see the script attached below)
>
> but it's very slow with 233 branches, obviously, so i only use it as a
> last resort mechanism.
>
> What i'd _love_ to see is just an ASCII representation of where a commit
> "came from" into the current branch. The first-hop branch it was
> committed to.
>
> it doesnt even have to be correct in the sha1 sense - i.e. it's enough
> for me if the merge commit log is parsed. (and hence it wont be correct
> if a branch ceases to exist or is renamed - but that is OK, i keep the
> branch space static)
>
> any ideas how to achieve that? I'd love to have output like this, if i
> do this from tip/master (the master integration branch):
>
>  # mockup
>
>  earth4:~/tip> gll --no-merges kernel/sched.c
>  ffda12a: [sched/core]      sched: optimize group load balancer
>  8cd162c: [sched/clock]     sched: only update rq->clock while holding
>  0a16b60: [tracing/sched]   tracing, sched: LTTng instrumentation
>  a5d8c34: [sched/debug]     sched debug: add name to sched_domain sysctl entries
>  34b3ede: [sched/core]      sched: remove redundant code in cpu_cgroup_create()
>
> ... and i dont want to embedd the branch name in every single commit.
>
> The semantics seem well-specified to me: walk down the merge tree a
> particular commit came from, and use the branch name that is mentioned
> in a merge commit's comment section 'closest' to this commit.
>
> That information is not 'trustable' in the sha1 sense because merge
> commits can be modified manually and because the momentary name of a
> branch might not be correct anymore - but with a sane topical setup this
> would be a very powerful visualization tool.
>
> It would be a nice tool that makes it easy to check the proper structure
> of topical branches, after the fact. Weird, incorrectly queued up
> commits would stick out _immediately_:
>
>  34b3ede: [x86/xen]      sched: remove redundant code in cpu_cgroup_create()
>

If you still have the tip of the branches you want to know, you can
get a similar output with:

$ git log --pretty=oneline builtin-checkout.c | git name-rev --stdin
828e32b82e3e2bb10d6d730d3abe505063b481f6 (remotes/origin/HEAD~17) Fix
mismerge at cdb22c4 in builtin-checkout.c
f285a2d7ed6548666989406de8f0e7233eb84368 (remotes/spearce/master~2)
Replace calls to strbuf_init(&foo, 0) with STRBUF_INIT initializer
048f2762007d022defceb6850a44bc1bd5ccebf7 (remotes/spearce/master~24)
do not segfault if make_cache_entry failed

(sorry if it is refilled)

HTH,
Santi
