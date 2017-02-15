Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A17022013A
	for <e@80x24.org>; Wed, 15 Feb 2017 20:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751299AbdBOUjB (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 15:39:01 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:44771 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750719AbdBOUjB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 15:39:01 -0500
Received: from homiemail-a9.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
        by hapkido.dreamhost.com (Postfix) with ESMTP id 8A1F48DCEB
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 12:39:00 -0800 (PST)
Received: from homiemail-a9.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a9.g.dreamhost.com (Postfix) with ESMTP id B962A5BE071
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 12:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bit-booster.com; h=
        mime-version:in-reply-to:references:from:date:message-id:subject
        :to:content-type; s=bit-booster.com; bh=FcXxjqcIU0pdKbIszHTmFQkd
        5wM=; b=hDryDhGZcMT5jyLnkgsbIsFP5evBl6ssN8eBevHPN38V0Ql76fYInvcG
        VVdQwouHztJ3zEHfTMsKDsxqDFmL6xq8EU6wKkugSNiqVeX+JSQ7Nu++CjggqUpC
        dWOL3HOqwBpWnE+ntSD4gNt8Rm7zlUgyXTJSk4FGgtx6PBuWl6o=
Received: from mail-yb0-f176.google.com (mail-yb0-f176.google.com [209.85.213.176])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sylvie@bit-booster.com)
        by homiemail-a9.g.dreamhost.com (Postfix) with ESMTPSA id 9D20B5BE06D
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 12:38:59 -0800 (PST)
Received: by mail-yb0-f176.google.com with SMTP id w194so48239085ybe.0
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 12:38:59 -0800 (PST)
X-Gm-Message-State: AMke39nDBfXSScs9mk3XWsvsxbjh52yumzva2o9JzLjevRAZ2gbi24Jky3b/uybR9Lz72t33Pobnm++xuCtzHg==
X-Received: by 10.37.114.69 with SMTP id n66mr26122260ybc.157.1487191138894;
 Wed, 15 Feb 2017 12:38:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.56.201 with HTTP; Wed, 15 Feb 2017 12:38:58 -0800 (PST)
In-Reply-To: <CAAj3zPx6uP5WbA68Co0yX_yh-e5C+jze2T1hJ0NYS7hHBzgdqg@mail.gmail.com>
References: <CAAj3zPx6uP5WbA68Co0yX_yh-e5C+jze2T1hJ0NYS7hHBzgdqg@mail.gmail.com>
From:   "G. Sylvie Davies" <sylvie@bit-booster.com>
Date:   Wed, 15 Feb 2017 12:38:58 -0800
X-Gmail-Original-Message-ID: <CAAj3zPyz8m3nGC_897k9SJOmfqvC2VczxFyphabkDho34nuPUw@mail.gmail.com>
Message-ID: <CAAj3zPyz8m3nGC_897k9SJOmfqvC2VczxFyphabkDho34nuPUw@mail.gmail.com>
Subject: Re: how are "untracked working tree files" even possible in this case?
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 12:36 PM, G. Sylvie Davies
<sylvie@bit-booster.com> wrote:
> Hi,
>
> I have a script that runs the following sequence of commands within a clone:
>
> -----
> /usr/bin/git rebase --abort (took 148ms)
> /usr/bin/git cherry-pick --abort (took 103ms)
> /usr/bin/git clean -d -f -x (took 2007ms)
> /usr/bin/git reflog expire --expire=now --all (took 106ms)
> /usr/bin/git reset --hard --quiet
> 181def85d58597dfb28729029b2ad76b9fbb09f5 -- (took 60103ms)
> /usr/bin/git merge --squash 333def1a1513f84c1eb79e5341ed6ebca0d359a1
> (took 1795ms)
> Err: '/usr/bin/git merge --squash 333def1a1513f84c1eb79e5341ed6ebca0d359a1'
> Exit=128
> error: The following untracked working tree files would be overwritten by merge:
> .gitignore
>
> [...many more files...]
>
> Please move or remove them before you can merge.
> Aborting
> -----
>
>
> I don't understand how untracked working tree files are possible after
> "git clean -d -f -x" and "git reset --hard" !
>
> I don't have access to this particular repo, but it's around 30GB when
> cloned (git directory plus working tree), and around 500,000 files in
> the working tree when checked out.  Note:  the "reset --hard" takes 60
> seconds here.
>
>

p.s.  environment is:  Git-2.7.4 / Bitbucket-4.10.1 /
Linux-4.4.0-59-generic (amd64)


>
>
> - Sylvie
