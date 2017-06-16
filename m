Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A33520401
	for <e@80x24.org>; Fri, 16 Jun 2017 06:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbdFPGYX (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 02:24:23 -0400
Received: from resqmta-po-02v.sys.comcast.net ([96.114.154.161]:46110 "EHLO
        resqmta-po-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751815AbdFPGYW (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Jun 2017 02:24:22 -0400
Received: from resomta-po-06v.sys.comcast.net ([96.114.154.230])
        by resqmta-po-02v.sys.comcast.net with SMTP
        id LkgAdNlpXRJJCLkgAdWgI3; Fri, 16 Jun 2017 06:24:22 +0000
Received: from vm-fedora21.eagercon.com ([IPv6:2601:647:4d04:5190:20c:29ff:fe70:d3be])
        by resomta-po-06v.sys.comcast.net with SMTP
        id Lkg8dCxAgufs1Lkg9dUhTc; Fri, 16 Jun 2017 06:24:21 +0000
Subject: Re: Best practices for updating old repos
To:     Michael O'Cleirigh <michael.ocleirigh@gmail.com>
References: <59432BCC.2040901@eagerm.com>
 <CAGUfqurYdFJDT4+XzyPvo3sxeT=zjXqZGCPpDbUFwjqG1B3pBw@mail.gmail.com>
Cc:     git <git@vger.kernel.org>
From:   Michael Eager <eager@eagerm.com>
Message-ID: <59437994.4010609@eagerm.com>
Date:   Thu, 15 Jun 2017 23:24:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <CAGUfqurYdFJDT4+XzyPvo3sxeT=zjXqZGCPpDbUFwjqG1B3pBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHx8EZfNnpoRXBR64s0rXximTdf23Jh8kX7+9XjU08tuZMXWZ8SpHALy4O+w+xAJbFqPndeFYF1b6SZ3Gajnf65pFMcgZUhCb7/t6jfsFktJCuSZ36Dd
 brk0TXdZP41JxpSUN8OJNi3stRON2zFjT9Yf08n4Q6DLmZC2+P1AK4n+oXyY+D+5VPYrEoDATn/f/Jafyo+DTcHFNYPxEcfd7zE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your comments.

On 06/15/2017 07:57 PM, Michael O'Cleirigh wrote:
> Hi Michael,
>
> In git if you don't merge often then you get these merge conflict hell situations.
>
> In my experience the main conflicts come not from the unified diff of those 130 commits but from
> differences in the surrounding code.
>
> Merging/rebase/cherrypicking directly to the latest upstream sounds impossible to me.
>
> These conflicts come from the distance between the local fork branch and the upstream branch.
>
> You need to merge through closer commits first to have a hope of getting something automatic to work.
>
> Something like getting the list  of releases made in the upstream in the last 5 years and merging
> them in order into the fork branch.
>
> i.e. merge v1, merge v2, ... merge v300
>
> I went through something similiar with a subversion repo we converted to git.
>
> In subversion they were cherry picking done work into a release branch.
>
> In git a feature branch mode was being used.
>
> It turned out some commits were never cherry picked and bringing them to the latest release was hard.
>
> We tried many of the approaches you outlined, took what git would give us automatically and in the
> most hairy cases recreated the changes on the latest upstream by reading the diff of the original
> commit and rewriting it on the latest code.
>
> In terms of how the history looks after the merge conflicts are resolved you could internalize the
> fixups into a single commit applied onto the original fork branch.  So that history would show the
> 130 commit branch directly merged into the upstream.
>
> You would use the git-commit-tree command to reuse the merged tree id and then use it as a merge
> commit between the 130th commit id and the upstream commit id.
>
> Regards,
>
> Michael
>
> On Thu, Jun 15, 2017 at 8:52 PM, Michael Eager <eager@eagerm.com <mailto:eager@eagerm.com>> wrote:
>
>     Hi All --
>
>     I'm working with code that is based on a five year old repository.
>     There are 130 local commits since the repo was forked.  Naturally,
>     the upstream project has moved on significantly.
>
>     I'm wondering about best approaches to updating the repo to the
>     current upstream version.  Here are the approaches I've considered:
>
>     - Rebase from upstream.  Likely almost every patch will fail with
>        multiple merge conflicts.
>
>     - Merge local branch into upstream.  Likely many merge failures, but
>        fewer than with rebase.
>
>     - Apply individual patches from the old repo to the upstream repo.
>        Fix merge conflicts, rebuild, fix build failures.  There may be
>        some duplication and additional merge problems created, where a
>        later patch from the old repo fixes the same conflict or build
>        failure.
>
>     I've tried each of these approaches on various projects.  Each has
>     problems. After resolving merge issues there are build failures which
>     need to be resolved and additional patches created.  The result is
>     that the patch history is a bit chaotic, where there are later patches
>     which fix problems with early patches.  I've tried to sort the fix
>     patches to follow the patch they correct, so that the fixes were
>     together and I could merge them, but that can be difficult.
>
>     I've used Stacked Git a little, but don't know if it will make
>     any of this easier.
>
>     On some projects, I've reimplemented changes in the upstream repo,
>     abandoning the patch history from the old repo:
>
>     - Create diff of old repo and upstream.  Apply only the changes
>        to add new functionality, which are in the patches to the
>        old repo.   Fix problems caused by API changes, renamed files, etc.
>
>     - Re-implement the changes on the upstream repo.  Some of the old
>        code would be re-used, but modified to fit in the current upstream.
>        Some new code would be written.
>
>     One other variant of the rebase approach I've thought of is to do
>     this incrementally, rebasing the old repo against an upstream commit
>     a short time after the old repo was forked, fixing any conflicts,
>     rebuilding and fixing build failures.  Then repeat, with a bit
>     newer commit.  Then repeat, until I get to the top.  This sounds
>     tedious, but some of it can be automated.  It also might result in
>     my making the changes compatible with upstream code which was later
>     abandoned or significantly changed.
>
>     Anyone have a different approach that I should consider?  Or maybe
>     offer advice on how to make one of these approaches work better?
>     What is best practice to update an old repo?
>
>     --
>     Michael Eager eager@eagercon.com <mailto:eager@eagercon.com>
>     1960 Park Blvd., Palo Alto, CA 94306 650-325-8077 <tel:650-325-8077>
>
>


-- 
Michael Eager	 eager@eagercon.com
1960 Park Blvd., Palo Alto, CA 94306  650-325-8077
