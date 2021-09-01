Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14928C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 09:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7ADD60243
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 09:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243472AbhIAJYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 05:24:34 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:8357 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243420AbhIAJYd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 05:24:33 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mLMT1-000Agj-4t
        for git@vger.kernel.org; Wed, 01 Sep 2021 10:23:35 +0100
Subject: Re: Concept question about push/pull stashes
To:     git@vger.kernel.org
References: <8d2f05e6f4ff9855460402e8cdafd7e7@posteo.de>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <204f8fdb-2e98-f1d2-b01b-d1e0fb0cf8b2@iee.email>
Date:   Wed, 1 Sep 2021 10:23:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8d2f05e6f4ff9855460402e8cdafd7e7@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a bit of 30,000ft thinko.

On 01/09/2021 08:44, c.buhtz@posteo.jp wrote:
> Hello,
> my question has to goals. I want to understand the design decisions
> behind a (missing) feature and and wan't to explore the needs of other
> users before I start to implement something.
>
> There is no usual way to exchange stashes with other repos/users.
> Stashes are code snippets that are unfinished and not clean enough to
> commit them anywhere not even in another branch.

I suspect that this "not even in another branch" is where the confusion
may arise. I've always understood git branches to be lightweight and
ephemeral. We usually fail to take that mental model to its rightful
conclusion.

While some branches are rock solid release branches, that does not
preclude their use for whimsical, unfinished snippets of code. There can
be reticence to create local wip branches (a trap I often fall into)
when we should be far more free with our branches - they take up no space!

Ultimately stashes are branches, their _extra_ capability is that they
can handle un-staged changes and other _local_ changes to allow for
interruptions.

>
> Why? What is the concept behind this? I am sure this was well thought.
> I just try to understand.
>
> A feature like this is often asked by users when you asked the search
> engine of your trust.
>
> One workaround is to simply commit the stashed code, push/pull it,
> checkoutit into the other repo and delete the last commit.

If the commit was on a new [wip] branch then a later branch deletion and
`gc` will clear it.

Isn't this an XYproblem for how to exchange snippets? And how to
decide/indicate what should be in the snippet?

>
> The other workaround is to create a patch-file from a stash. But then
> the question is how to exchange this file?

`send-email` ?
>
> Why not use the git infrastructure itself?
>
> I have workaround in my mind. I couuld use a script wich creates patch
> files for each existing stash and commit them into the repo. Thats
> all. To keep the repo "clean" the path files could be archived into a
> hidden (dotted filed) tar file. Or the tar file could be stored inside
> the ".git" folder if there is a way.

The stash does manage to combine the selection of the code change files
and creation of a branch [aka stash]. Maybe `commit` needs a --wip
option that will create the branch while adding the selected files.  The
'transmission' method would also need resolving as there are too many
ways folk interact these days - we already have patches, tar files,
remote push/fetch, then there will be web browsing methods..

>
> I am interested in your thoughts about this.

There is always (after checking the manual) `git stash branch
<branchname> [<stash>]`  - not used it myself, so it may not do what I
think I read.. Sounds like it needs combining with an initial `stash
push` to allow the new branch (containing the stash snippet) to be
exchanged using the regular methods for on-branch code.

-- 
Philip
