Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DBCC43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 20:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79081208E0
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 20:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Teb4E3mQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbgCaUCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 16:02:50 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37044 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgCaUCu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 16:02:50 -0400
Received: by mail-qk1-f196.google.com with SMTP id x3so24515582qki.4
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 13:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3MUyVgfCGmETaejbxjqKaWEWXrI0h5jWwjSFe/GWCLw=;
        b=Teb4E3mQjEuc7qrWTYwCkuibC4dAaKXou5XAdAkRtRvZgx9CXK9Ry/Oebkfo15NpNp
         Xk6tUDNd1a6w81Q5BgMRw0GG7YEHPrJLgMjbT1X9rXiJLPmX+a+tf3IC9BX0NBqTlpqQ
         ih3j5kvvC3H882oEua1mtND40SszAhfZohp/8cJ97vuGWh4t1IRUWq2xnTcwUYOXxH1z
         RUljrEfCsAZ20MXn6NYbSWnl7T5gDzB9JbTdjeIGP/5x1nhskXoZt+WcvC1OPBFNcZ3t
         90o1v3O0nDs91RPXZlcl14/8b13cih7DU3jeP36vwknLFaQcfNWAlj4ESy4KzWnT4Jq3
         LQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3MUyVgfCGmETaejbxjqKaWEWXrI0h5jWwjSFe/GWCLw=;
        b=JmjM+8weBv4fHuQ61dzGdY4e6Tsp30rJ5VAgj/v2RRn3QbKOqs2iEZVg+zq6rewHu2
         y+woVogTGTslQ+ohfeDftYl0YKgH0NEr4GqS/xaoHJLWmjQfSXAV46pA/W55ZJjVME5t
         aGpPw7YBmb89F247ZEZ0jTvu1PGFtzgRQvk84wIPZ7o5OdI8c+KBu2O0EdgNe23XGQX9
         Ydiip152I16AKdREC04R6VH7H+A3niyJWcKqg6yKX5+hOUmQnJgsf1eFqoJm2lj9CkEx
         C9RYCmIT+ESoDoQhFre57W0uX7gxSw+i3TS3kt1L3In07Nn4HTppQesHB+Qri2wspIRs
         ykxw==
X-Gm-Message-State: ANhLgQ2FCxxb4U16A/0YIJfY4OvsmYCIBq4hKZ4w+39VXbG0TgJSykd9
        G4V1WDFTlqxaMBeeMc/aI8o=
X-Google-Smtp-Source: ADFU+vtTB6WozyC1Cwz/UnMdcl4ssckSTIg2l1vPf0r4+ZT3QFHGU8o3Mm2+NQ/Z1KPFQ4qU+z9HoA==
X-Received: by 2002:a37:393:: with SMTP id 141mr6650248qkd.393.1585684968719;
        Tue, 31 Mar 2020 13:02:48 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f93sm13823733qtd.26.2020.03.31.13.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 13:02:47 -0700 (PDT)
Subject: Re: [RFC PATCH 3/3] grep: add option to ignore sparsity patterns
To:     Elijah Newren <newren@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <cover.1585027716.git.matheus.bernardino@usp.br>
 <a76242ecfa69cf29995bd859305dc2ab1bc1a221.1585027716.git.matheus.bernardino@usp.br>
 <CABPp-BEbNCYk0pCuEDQ_ViB2=varJPBsVODxNvJs0EVRyBqjBg@mail.gmail.com>
 <xmqq7dz938sc.fsf@gitster.c.googlers.com>
 <CAHd-oW5qq=dtaSmqcSyxoHd3HPipxjfaiCXtdBQwk9yNVe9okA@mail.gmail.com>
 <CABPp-BE6zW0nJSStcVU=_DoDBnPgLqOR8pkTXK3dW11=T01OhA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <49c1e9a5-b234-1696-03cc-95bf95f4663c@gmail.com>
Date:   Tue, 31 Mar 2020 16:02:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BE6zW0nJSStcVU=_DoDBnPgLqOR8pkTXK3dW11=T01OhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/31/2020 3:12 PM, Elijah Newren wrote:
> // adding Jonathan Tan to cc based on the fact that we keep bringing
> up partial clones and how it relates...
> 
> On Sun, Mar 29, 2020 at 8:23 PM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
>>
>> On Tue, Mar 24, 2020 at 3:30 PM Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> Elijah Newren <newren@gmail.com> writes:
>>>
>>>> On Mon, Mar 23, 2020 at 11:13 PM Matheus Tavares
>>>> <matheus.bernardino@usp.br> wrote:
>>>>>
>>>>> In the last commit, git-grep learned to honor sparsity patterns. For
>>>>> some use cases, however, it may be desirable to search outside the
>>>>> sparse checkout. So add the '--ignore-sparsity' option, which restores
>>>>> the old behavior. Also add the grep.ignoreSparsity configuration, to
>>>>> allow setting this behavior by default.
>>>>
>>>> Should `--ignore-sparsity` be a global git option rather than a
>>>> grep-specific one?  Also, should grep.ignoreSparsity rather be
>>>> core.ignoreSparsity or core.searchOutsideSparsePaths or something?
>>>
>>> Great question.  I think "git diff" with various options would also
>>> want to optionally be able to be confined within the sparse cone, or
>>> checking the entire world by lazily fetching outside the sparsity.
>> [...]
>>> Regardless of the choice of the default, it would be a good
>>> idea to make the subcommands consistently offer the same default and
>>> allow the non-default views with the same UI.
>>
>> Yeah, it seems like a sensible path. Regarding implementation, there
>> is the question that Elijah raised, of whether to use a global git
>> option or separate but consistent options for each subcommand. I don't
>> have much experience with sparse checkout to argument for one or
>> another, so I would like to hear what others have to say about it.
>>
>> A question that comes to my mind regarding the global git option is:
>> will --ignore-sparsity (or whichever name we choose for it [1]) be
>> sufficient for all subcommands? Or may some of them require additional
>> options for command-specific behaviors concerning sparsity patterns?
>> Also, would it be OK if we just ignored the option in commands that do
>> not operate differently in sparse checkouts (maybe, fetch, branch and
>> send-email, for example)? And would it make sense to allow
>> constructions such as `git --ignore-sparsity checkout` or even `git
>> --ignore-sparsity sparse-checkout ...`?
> 
> I think the same option would probably be sufficient for all
> subcommands, though I have a minor question about the merge machinery
> (below).  And generally, I think it would be unusual for people to
> pass the command line flag; I suspect most would set a config option
> for most cases and then only occasionally override it on the command
> line.  Since that config option would always be set, I'd expect
> commands that are unaffected to just ignore it (much like both "git -c
> merge.detectRenames=true fetch" and "git --work-tree=othertree fetch"
> will both ignore the irrelevant options rather than trying to detect
> that they were specified and error out).
> 
>> [1]: Does anyone have suggestions for the option/config name? The best
>> I could come up with so far (without being too verbose) is
>> --no-sparsity-constraints. But I fear this might sound generic. As
>> Elijah already mentioned, --ignore-sparsity is not good either, as it
>> introduces double negatives in code...
> 
> Does verbosity matter that much?  I think people would set it in
> config, and tab completion would make it pretty easy to complete in
> any event.
> 
> Anyway, maybe it will help if I provide a very rough first draft of
> what changes we could introduce to Documentation/config/core.txt, and
> then ask a bunch of my own questions about it below:
> 
> """
> core.restrictToSparsePaths::
>         Only meaningful in conjuntion with core.sparseCheckoutCone.
>         This option extends sparse checkouts (which limit which paths
>         are written to the worktree), so that output and operations
>         are also limited to the sparsity paths where possible and
>         implemented.  The purpose of this option is to (1) focus
>         output for the user on the portion of the repository that is
>         of interest to them, and (2) enable potentially dramatic
>         performance improvements, especially in conjunction with
>         partial clones.
> +
> When this option is true, git commands such as log, diff, and grep may
> limit their output to the directories specified by the sparse cone, or
> to the intersection of those paths and any (like `*.c) that the user
> might also specify on the command line.  (Note that this limit for
> diff and grep only becomes relevant with --cached or when specifying a
> REVISION, since a search of the working tree will automatically be
> limited to the sparse paths that are present.)  Also, commands like
> bisect may only select commits which modify paths within the sparsity
> cone.  The merge machinery may use the sparse paths as a heuristic to
> avoid trying to detect renames from within the sparsity cone to
> outside the sparsity cone when at least one side of history only
> touches paths within the sparsity cone (this can make the merge
> machinery faster, but may risk modify/delete conflicts since upstream
> can rename a file within the sparsity paths to a location outside
> them).  Commands which export, integrity check, or create history will
> always operate on full trees (e.g. fast-export, format-patch, fsck,
> commit, etc.), unaffected by any sparsity patterns.
> """
> 
> Several questions here, of course:
> 
>   * do people like or hate the name?  indifferent?  have alternate ideas?

It's probably time to create a 'sparse-checkout' config space. That
would allow

	sparse-checkout.restrictGrep = true

as an option. Or a more general

	sparse-checkout.restrictCommands = true

to make it clear that it affects multiple commands.

>   * should we restrict this to core.sparseCheckoutCone as I suggested
> above or also allow people to do it with core.sparseCheckout without
> the cone mode?  I think attempting to weld partial clones together
> with core.sparseCheckout is crazy, so I'm tempted to just make it be
> specific to cone mode and to push people to use it.  But I'm
> interested in thoughts on the matter.

Personally, I prefer cone mode and think it covers 99% of cases.
However, there are some who are using a big directory full of large
binaries and relying on file-prefix matches to get only the big
binaries they need. Until they restructure their repositories to
take advantage of cone mode, we should be considerate of the full
sparse-checkout specification when possible.

>   * should worktrees be affected?  (I've been an advocate of new
> worktrees inheriting the sparse patterns of the worktree in use at the
> time the new worktree was created.  Junio once suggested he didn't
> like that and that worktrees should start out dense.  That seems
> problematic to me in big repos with partial clones and sparse chckouts
> in use.  Perhaps dense new worktrees is the behavior you get when
> core.restrictToSparsePaths is false?)

We should probably consider a `--sparse` option for `git worktree add`
so we can allow interested users to add worktrees that initialize to
a sparse-checkout. Optionally create a config option that would copy
the sparse-checkout file from the current repo to the worktree.

>   * does my idea for the merge machinery make folks uncomfortable?
> Should that be a different option?  Being able to do trivial *tree*
> merges for the huge portion of the tree outside the sparsity paths
> would be a huge win, especially with partial clones, but it certainly
> is different.  Then again, microsoft has disabled rename detection
> entirely based on it being too expensive, so perhaps the idea of
> rename-detection-within-your-cone-if-you-really-didn't-modify-anything-outside-the-cone-on-your-side-of-history
> is a reasonable middle ground between off and on for rename detection.

The part where you say " when at least one side of history only
touches paths within the sparsity cone" makes me want to entertain
the idea if it can be done cleanly.

I'm more concerned about the "git bisect" logic being restricted to
the cone, since that is such an open-ended command for what is
considered "good" or "bad".

>   * what should the default be?  Junio suggested elsewhere[1] that
> sparse-checkouts and partial clones should probably be welded together
> (with partial clones downloading just history in the sparsity paths by
> default), in which case having this option be true would be useful.

My opinion on this is as follows: filtering blobs based on sparse-
checkout patterns does not filter enough, and filtering trees based
on sparse-checkout patterns filters too much. The costs are just
flipped: having extra trees is not a huge problem but recovering from
a "tree miss" is problematic. Having extra blobs is painful, but
recovering from a "blob miss" is not a big deal.

> But it may also be slightly weird because it'll probably take us a
> while to implement this; while the big warning in
> git-sparse-checkout.txt certainly allows this:
>         THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR, AND THE BEHAVIOR OF OTHER
>         COMMANDS IN THE PRESENCE OF SPARSE-CHECKOUTS, WILL LIKELY CHANGE IN
>         THE FUTURE.
> It may still be slightly weird that the default behavior of commands
> in the presence of sparse-checkouts changes release to release until
> we get it all implemented.

I appreciate that we put that warning at the top. We will be
able to do more experimental things with the feature because
of it. The idea I'm toying with is to have "git clone --sparse"
set core.sparseCheckoutCone = true.

Also, if we are creating the "sparse-checkout.*" config space,
we should "rename" core.sparseCheckoutCone to sparse-checkout.coneMode
or something. We would need to support both for a while, for sure.

Thanks,
-Stolee

