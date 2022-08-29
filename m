Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755F0ECAAD5
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 16:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiH2QgT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 12:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiH2QgR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 12:36:17 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7283C4DB07
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 09:36:16 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id f4so6445107qkl.7
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 09:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=J32yyZ6LXMK30bCB/4prlFBlBWelEMT/BSZZFD6iIUU=;
        b=Ni0Gmj2Kd4WDgwwHCBBtCHMjP+LhdRKeD3LageJUlrPJKBDXJcFo0cY7zMspz3BlPU
         HUyG6hdpArXso2o5Mms9Py8crKOKpu2ApcCmAByCw5pzPBTOkIsuYay/8yH1e6LFtQgH
         AjG1Bf45BXs63Td7cCQf4CLbvbL0PB/aE/SQ2Pu6qSwHl3HgU/qsOXyEedbWOo4+s01d
         e+zbsijbwzleK4P9ebkHa3UXXBLZwnzG7oRhy/uMyjCFerwob7ZssUyrwDSKFLX21RaM
         JqEfRPEnwzraT7UdhgTE0DopNx31JJtXsQh8ET0vfSTVOk5rhvUvcvBMWTBamYIMKjO9
         WS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=J32yyZ6LXMK30bCB/4prlFBlBWelEMT/BSZZFD6iIUU=;
        b=lVyGRdUbHPMSHOifa023+hAt9ML1fNG8UNJQVYS0qC7hzFtUU8kYZwc2ZmNkK3gKDf
         gqd1oV1tE+G9moTg892VNDy9BVoXdqxTbXKVdmqHlhE+D22YueUP/3EtupKBRvb+T9EF
         6R4/X0ndrEIOEfYF2B8ArulpDDYlzzde9n73UHfncdoUDSn6+7E+ndOZhn6Izg+UmV2j
         KyC7cLBbGOs7yxitqBlB7hkB/JCyGrgetvvus7cal17jZ9h8byXfHqEUH+J9eoTFsb42
         9qaitEMP1M26rN9lis0NAQFJhZLCaOAxgb9PCj6QTbPzDYmdN2PmyfOWNI8fiMixW+MX
         tSBQ==
X-Gm-Message-State: ACgBeo2XJfPXGVM6VO0ni/xqxywjwZWqFmAeUKpr3vMV4Tqxb7+WUgYc
        Tcwf9W/1bWfD+Z0oqeJS5zmkvms/iOc=
X-Google-Smtp-Source: AA6agR5aASuC731Xvs/arkonoG1pJuLBcV+P3Rr0b3ZgtvQtuKKTmYNUHT17PR+ZDdgj3Fjaijoe4A==
X-Received: by 2002:a05:620a:4407:b0:6ba:f3cc:49a3 with SMTP id v7-20020a05620a440700b006baf3cc49a3mr8759856qkp.699.1661790975406;
        Mon, 29 Aug 2022 09:36:15 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id bp8-20020a05620a458800b006b93ff541dasm6424850qkb.8.2022.08.29.09.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 09:36:14 -0700 (PDT)
Subject: Re: Bug in 'git log --remerge-diff' when used with '--find-object'
 and '--submodule=log|diff'
To:     Elijah Newren <newren@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
References: <43cf2a1d-058a-fd79-befe-7d9bc62581ed@gmail.com>
 <CABPp-BEkC8xEkNa+hyKFKhO=cbBZqNqGWehqxbRzE6-BVR27NQ@mail.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <b19c7090-109c-8988-56cf-4f8887de3845@gmail.com>
Date:   Mon, 29 Aug 2022 12:36:20 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEkC8xEkNa+hyKFKhO=cbBZqNqGWehqxbRzE6-BVR27NQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

Le 2022-08-24 à 03:36, Elijah Newren a écrit :
> Hi Philippe,
> 
> On Mon, Aug 22, 2022 at 4:58 PM Philippe Blain
> <levraiphilippeblain@gmail.com> wrote:
>>
>> Hi Elijah,
>>
>> I found two bugs in '--remerge-diff' when combined with both '--find-object' and
>> '--submodule=log|diff'. I don't know if they have the same cause.
>>
>> When using these flags together, *all* 2-parents merge commits are shown (even in a repo with
>> no submodule!)
>>
>> Moreover, for merges with conflicted paths, all conflicted paths are shown as "(new submodule)",
>> even if they are not a submodule (in fact, even when no submodule is present
>> in the repository!).
>>
>> This artificial example reproduces the bug:
>>
>> ```bash
>> #!/bin/bash
>>
>> set -euEo pipefail
>>
>> repo=repro
>> rm -rf $repo
>>
>> TEST_AUTHOR_LOCALNAME=author
>> TEST_AUTHOR_DOMAIN=example.com
>> GIT_AUTHOR_EMAIL=${TEST_AUTHOR_LOCALNAME}@${TEST_AUTHOR_DOMAIN}
>> GIT_AUTHOR_NAME='A U Thor'
>> GIT_AUTHOR_DATE='1112354055 +0200'
>> TEST_COMMITTER_LOCALNAME=committer
>> TEST_COMMITTER_DOMAIN=example.com
>> GIT_COMMITTER_EMAIL=${TEST_COMMITTER_LOCALNAME}@${TEST_COMMITTER_DOMAIN}
>> GIT_COMMITTER_NAME='C O Mitter'
>> GIT_COMMITTER_DATE='1112354055 +0200'
>> export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
>> export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
>> export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
>> export HOME=
>>
>> git -c init.defaultBranch=unimportant init $repo
>> cd $repo
>> echo i>file
>> git add file
>> git commit -m file
>> git checkout -b side
>> echo s>>file2
>> git add file2
>> git commit -am side
>> git checkout -
>> echo m >>file
>> git commit -am main
>> git merge side -m clean
>> git checkout side
>> echo c>>file
>> git add file
>> git commit -am side2
>> git checkout -
>> echo cc>>file
>> git commit -am main2
>> git merge side || true
>> printf 'i\nm' > file
>> git commit -am conflicted
>> # look for a dummy object
>> git log --oneline --diff-merges=r --submodule=log --find-object=2c042ac4213768e55791098110d2ef2ef845881a
>> # same output with --submodule=diff
>> ```
>>
>> This is the output I get from the 'git log' call:
>>
>> b4f1be9 (HEAD -> unimportant) conflicted
>> Submodule file 0000000...0000000 (new submodule)
>> a4ef223 clean
>>
>> Notice both merges are shown despite none of them changing the number of occurences of
>> 2c042ac4213768e55791098110d2ef2ef845881a, which does not even exist in this repository,
>> and also that the conflicted merge shows 'file' as "new submodule".
> 
> Thanks for the report, and the steps to reproduce.  Very helpful.
> 
> After some digging, it appears the remerge-diff headers are
> misinterpreted by the submodule code.  They transform what would have
> been the following output:
> 
>     b4f1be9 (HEAD -> unimportant) conflicted
>     diff --git a/file b/file
>     remerge CONFLICT (content): Merge conflict in file
>     a4ef223 clean
> 
> into what you saw, namely
> 
>     b4f1be9 (HEAD -> unimportant) conflicted
>     Submodule file 0000000...0000000 (new submodule)
>     a4ef223 clean
> 
> We can recover the intended remerge-diff header with the following simple patch:
> 
> diff --git a/diff.c b/diff.c
> index 974626a621..be23f66057 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3429,14 +3429,16 @@ static void builtin_diff(const char *name_a,
> 
>         if (o->submodule_format == DIFF_SUBMODULE_LOG &&
>             (!one->mode || S_ISGITLINK(one->mode)) &&
> -           (!two->mode || S_ISGITLINK(two->mode))) {
> +           (!two->mode || S_ISGITLINK(two->mode)) &&
> +           (one->mode || two->mode)) {
>                 show_submodule_diff_summary(o, one->path ? one->path :
> two->path,
>                                 &one->oid, &two->oid,
>                                 two->dirty_submodule);
>                 return;
>         } else if (o->submodule_format == DIFF_SUBMODULE_INLINE_DIFF &&
>                    (!one->mode || S_ISGITLINK(one->mode)) &&
> -                  (!two->mode || S_ISGITLINK(two->mode))) {
> +                  (!two->mode || S_ISGITLINK(two->mode)) &&
> +                  (one->mode || two->mode)) {
>                 show_submodule_inline_diff(o, one->path ? one->path : two->path,
>                                 &one->oid, &two->oid,
>                                 two->dirty_submodule);
> 
> In other words, when we have information about something other than a
> submodule, don't attempt to treat it as information about a submodule.

Thanks for digging into this.
From what I understand in the case of a remerge-diff, both modes are all-zero, and this is
not expected by the submodule diff code. Were you planning to submit a proper
patch ? I could get to it eventually, but not before mid/end of September...

> 
> Now, whether the remerge-diff header should be shown is an interesting
> one -- it's a carry on to the discussion in the thread at [1], and
> isn't simple to answer.
> [1] https://lore.kernel.org/git/CABPp-BHjU+wDXNnf-rsGy86GvOFWH6qVLPEfAA2JDfLFRU4WSA@mail.gmail.com/

Thanks for a link to a very interesting discussion! However I'm not exactly sure 
what you meant here. Are you saying that:

- we use '--remerge-diff', so we are interested in seeing 
  (re)merge diffs
- we do not use '-p', so we are not interested in seeing diffs
- to reconcile both of the above, the code shows only the remerge diff header ?

Because if I do add '-p', (in my reproducer) I still do not get any diff content. But if I remove
'--find-object', then I do...

> As for the first bug, the showing of any 2-parent commits, yes that's
> true.  But it's not limited to remerge-diff; you can change
> --diff-merges=r to --diff-merges=c or --diff-merges=cc and see the
> same thing.  I'm not sure if that means that my looking at the
> do_diff_combined() logic when developing the do_remerge_diff()
> function meant I copied a bug, or if I independently came up with it
> on my own.  But, for now, I need some sleep.  Just thought I'd give
> you an update on what I have found so far, though.
> 

Yes, I had noticed that I had the same behaviour with --cc or -c, I forgot to mention it.
With 'separate' or 'first-parent', though, no commits are shown (as expected).
To be clear, this behaviour is independent of the use of '--submodule=short|log|diff'.

Thanks for your answer,

Philippe.
