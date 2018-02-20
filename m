Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA55B1F576
	for <e@80x24.org>; Tue, 20 Feb 2018 10:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeBTKUX (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 05:20:23 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:64151 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbeBTKUW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 05:20:22 -0500
Received: from [192.168.2.201] ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id o523eaj76LSHJo523extsb; Tue, 20 Feb 2018 10:20:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519122020;
        bh=8unZEFwU3nfadZtUAX9zJ3OaIA0ig9PI7n48WfI0GU8=;
        h=Reply-To:Subject:To:References:From:Date:In-Reply-To;
        b=OOMsgDPvy+ePTFX6PnBqvsatbsLsgxT9f/Fmu+IYqUVyEIwozhraKVmJBFkC0lsvr
         UZ59klLZ1BZEfVWYdIed91glL8rYe8B4hy/ydMB1pvXoDt0n8dKpAo0cg2UZs+Yj/l
         nUNncbgHlphI5fdESKgPnP+04R63Z7SRn5HYYBrI=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=NqehS4VJ c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=IkcTkHD0fZMA:10 a=n0aBlw83IoZ-5qFqB8EA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Is there any way to "interrupt" a rebase?
To:     Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <CAE1pOi1XtrWqG7mOdrNt10YoZG0LOAB7i9cc1Gi8oWhULxE57A@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <c1586003-1c7f-c9c9-9912-d48243305fa3@talktalk.net>
Date:   Tue, 20 Feb 2018 10:20:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAE1pOi1XtrWqG7mOdrNt10YoZG0LOAB7i9cc1Gi8oWhULxE57A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfA7Q9br2gW1ie3+ThktxRkk0IwVy3RjDpUCaGR/wEDgCSRh1ukHa+ZkFyJHZ/u+FzJrjNsZakm8qKipE4lmIL/S6GPonhaS80p6DnrLGupT88HqF9RdG
 PjrpigWvBTsS3oXk2GSZmaIqYujLGfFT9WbNJfDgV4Mo5EY1/GgOzVMC+QXNtjOpdJEr9JnibBMYxE7B8AIIIjg4+82r23Bv5hbHJJe6ehCvV8M6Rz5ASnj7
 FKDujPiqDu5tSugxGtMkSH+LwwYZnqJgAK/uKisYwEQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/02/18 19:35, Hilco Wijbenga wrote:
> 
> Hi all,
> 
> When maintaining a long running branch, I regularly rebase onto our
> active development branch so that my branch stays up-to-date. What
> happens fairly often is that during such a rebase, Git will exit
> because of rebase/merge conflicts. Nothing unexpected there, of
> course, but as it sometimes turns out, the conflict should have been
> fixed in an earlier commit. The only way that I know of to fix this,
> is to abort the rebase and start over with "git rebase ...
> --interactive" then "edit" every commit and go through them
> one-by-one. This is often overkill, though. Is there a better way?
> Perhaps I could "rewind" the rebase to an earlier commit and restart
> from there?
> 
> So a scenario like this:
> 
> my-branch : X -> A -> B -> C -> D -> E -> F -> G
> base-branch : X -> Y
> 
> git rebase --onto base-branch HEAD~7
> commit A --> conflicts
> .... lots of work ...
> commit B --> conflicts
> .... lots of work ...
> commit C (Git handles conflicts)
> commit D (no conflict)
> commit E --> conflicts
> .... er, that should have been fixed in commit C
> 
> How do I keep all the work I did for commits A and B? I get the
> impression that rerere does not help here because I did not finish the
> rebase succesfully (and that makes perfect sense, of course). Is there
> a way at this point in the rebase to "go back" to commit C (so without
> "git rebase --abort")?
> 
> (Surely, it's not as simple as doing a "git reset --hard
> sha-of-commit-C" is it?)

Hi Hilco

In the past when I've wanted to edit the commit directly rather than
create a fixup I've done something like

 git log --pretty="pick %h %s" C..
 git rebase --edit-todo
<paste the output of git log into the editor>
 git checkout C
<amend this commit>
 git commit --amend
 git rebase --continue


Best Wishes

Phillip
> Cheers,
> Hilco
> 

