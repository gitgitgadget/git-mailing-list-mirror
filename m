Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F78FC433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 14:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347495AbiCHO6E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 09:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345631AbiCHO6D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 09:58:03 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FA34D616
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 06:57:06 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5D77A3F413E;
        Tue,  8 Mar 2022 09:57:05 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 37E2F3F4090;
        Tue,  8 Mar 2022 09:57:05 -0500 (EST)
Subject: Re: Keep reflogs for deleted (remote tracking) branches?
To:     Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
References: <CAPMMpog=qBwLrxss_ci6ZMM+AjbdrF8tszXLW7YH1Zqr+m7mPQ@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <2aa11123-5456-b0f1-6c33-302924164e98@jeffhostetler.com>
Date:   Tue, 8 Mar 2022 09:57:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAPMMpog=qBwLrxss_ci6ZMM+AjbdrF8tszXLW7YH1Zqr+m7mPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/8/22 6:27 AM, Tao Klerks wrote:
> Hi folks,
> 
> I have a practical question in case I missed something.
> 
> Imagine a small team (10ppl) working on a single centralized repo, in
> github for example. They regularly create new branches, and typically
> delete them eventually - after merging, or at other times when
> branches were a dead end or whatever. The members of this team all
> have a "simple" git remote configuration, the result of a "git clone"
> with no special configuration. One exception is that they have set
> "fetch.prune" to "true", because otherwise remote branches that have
> been deleted (in the context of completed merges, or arbitrarily by
> other team members) accumulate locally and having to explicitly prune
> them from time to time is a pain. Every time someone says "why do I
> still see these branches in my repo?", someone else replies "oh, just
> run 'git config fetch.prune true'".
> 
> Now, one day someone deletes a branch accidentally from the server,
> and the sole author of that branch has gone on vacation (or has an IT
> failure, or has left the company, or whatever). Other team members
> have seen this branch go by, it's appeared in their "fetch" output,
> but no-one remembers checking it out, so it's not in their main
> "HEAD" reflogs.
> 
> Even though the ref was at one point on every team member's computer,
> and they still undoubtedly have a dangling commit in their repos,
> they're going to have a hard time finding it - there are many dangling
> commits in any given repo.
> 
> Now my question: is there any way to (temporarily) keep a reflog for
> that deleted/pruned branch, in those team members' repos?
> 
> As far as I can tell, even "core.logAllRefUpdates=always" does *not*
> keep any reflog entries around, even temporarily (until reflog
> expiry), once a ref  is deleted - do I understand that correctly? Is
> this behavior intentional / reasoned, or just a consequence of the
> fact that it's *hard* to keep "managing" per-branch reflogs for
> branches that don't exist?
> 
> I am planning a workaround using server hooks to "back up" refs that
> are being deleted from specific namespaces, in my specific case, and I
> imagine that a system like github keeps track of deleted stuff itself
> for a while, but I find this "per-ref reflog disappearance" behavior
> puzzling / out-of-character, so wanted to make sure I'm not missing
> something.
> 
> Thanks,
> Tao
> 

Have you considered having each team member have their own
private fork of the repo?  Then their branches are theirs
alone and no one else needs to see or collide with them.

Then when their work is ready for review/publishing, do
cross-fork PRs into the company's main fork.

Jeff
