Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F979C433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 10:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4977F208B6
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 10:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bY3QpAb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgJLKSh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 06:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgJLKSh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 06:18:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA2CC0613CE
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 03:18:36 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b8so5300053wrn.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 03:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jh6RWAJU7hKOqTLs9hUpOae5JY2gp7zZNcQBJ9o1Z6M=;
        b=bY3QpAb4bc80HKUHA8yRqACB7B5xiU2s+kr+nnMdKf2FDsU+e8MkDev8SaHKIeHtdP
         LZNZMqtXdgMtk4ub+C9xqoY6ONsXC+7hoUHLQymah+c0NvQX3f6WqU7fZKwZfvQ+4Qur
         rSLh/kQG0K7wAFyAl/OG3xQqnUA9KCgZAHJoc5HbbfoyaKikX9KKiLpgxVM+AahOgP6K
         I/5voH+C+1p+RvlOcqiN3lrpalEIH7k0XZ4dyLKSOru4J7pJfrNyAjwa17a7YtMffGUh
         R/JMtRi60AIy0T64fw14F2o864TWANeYeCp9p9lQHxpwg2fc9dhyXjSEqcFbsVMdusii
         63Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jh6RWAJU7hKOqTLs9hUpOae5JY2gp7zZNcQBJ9o1Z6M=;
        b=W6+4UUcLyg519Uzqtot772bkq8sXxv7B1nhdkclAxckg00Sj3ySg4MJzB2oG+FN+rx
         kSMLG4ga/faVEz3lMI3Y2Oed0TqtY61n69CkqlaqSRSDvEw+DkGGDxg6CVMaQ6DeOdgm
         n4zvlB6IaDJxhsBAkuUy4eJC8iH+k2TMNX2xiP/3hwX7xEcP4+keltKry35G3IHjEfQH
         TFjgB84rjByj+s90soYqui8yb0dwjp72G1NDezj2GdsOFVqShegQmX//+MovFMbbwVOA
         BxtDKjHbe69zb39rXDMV4svw92VM5afaoKZVSC2NOMCSJqbRP8859OdZwDtT1igVnkgy
         fwZQ==
X-Gm-Message-State: AOAM531KOULVAsg9k9xfYc5ZQVB851G8o+RSCYExvwDoX6dAvQtbH83R
        uqPPI0gJjmKpeMrKg6MHBNUQc8PLWn4=
X-Google-Smtp-Source: ABdhPJyZP7A4VVsJizJP857TiDnzwFj5MjhknF5LSokZX4AmIesG5th9jSRy0kj+5wilF94d6g03eg==
X-Received: by 2002:adf:d4c5:: with SMTP id w5mr4492606wrk.226.1602497915270;
        Mon, 12 Oct 2020 03:18:35 -0700 (PDT)
Received: from [192.168.1.201] (39.16.7.51.dyn.plus.net. [51.7.16.39])
        by smtp.googlemail.com with ESMTPSA id 71sm23532924wrm.20.2020.10.12.03.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 03:18:34 -0700 (PDT)
Subject: Re: [Outreachy] Introduction
To:     Sangeeta NB <sangunb09@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org
References: <CAHjREB4gsyOrdnhp0_9rs0wv5q5H47-3RcB3fm5NY+L=3SYnMA@mail.gmail.com>
 <22e3d737-8621-9f20-307e-fc4c2a47ec0c@gmail.com>
 <CAHjREB59HjZAs98wMPtMANcHUaXGou7CYg9vAacc3m4uz1yUug@mail.gmail.com>
 <7d691f37-b8b7-510d-ba46-51a4a7587226@gmail.com>
 <CAHjREB6j6BqZ49wX5uqEOiysTAm8Oo7N=EFpcoovWKkBghBjxQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <eb1d6d2a-868f-7d1a-e004-30efc1950d9a@gmail.com>
Date:   Mon, 12 Oct 2020 11:18:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHjREB6j6BqZ49wX5uqEOiysTAm8Oo7N=EFpcoovWKkBghBjxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sangeeta

On 11/10/2020 12:30, Sangeeta NB wrote:
> Thanks for the help, Philip.
> 
> On Fri, Oct 9, 2020 at 11:59 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> 
>> I struggled to find the mircoprojects page - I must have missed the link
>> on the outreachy site.
> 
> In case anyone else is struggling to find the microprojects page,
> here's the link [1]
> 
> [1] https://git.github.io/Outreachy-21-Microprojects/
> 
>> As I understand it if a submodule contains any untracked files (i.e. a
>> file that has not been added with `git add` and is not ignored by any
>> .gitignore or .git/info/exclude entries) then running `git diff` in the
>> superproject will report that the submodule is dirty - there will be a
>> line something like "+Subproject commit abcdef-dirty". However if we run
>> `git describe --dirty` in the submodule directory then it will not
>> append "-dirty" to it's output unless there are changes to tracked files.
> 
> On running `git diff HEAD --ignore-submodules=untracked` the submodule
> wasn't reported as dirty.

That's great

> I guess this is what we are expecting. So should I make it the default
> behavior for diff?

I think that is a good route forward, we probably want to change the 
default for `diff-index` and `diff-files` as well

> 
> A fix for making this as the default behaviour can be:
> 
> --- a/diff.c
> +++ b/diff.c
> @@ -422,6 +422,7 @@ int git_diff_ui_config(const char *var, const char
> *value, void *cb)
>          if (git_color_config(var, value, cb) < 0)
>                  return -1;
> 
> +       handle_ignore_submodules_arg(&default_diff_options, "untracked");
>          return git_diff_basic_config(var, value, cb);
>   }
> 
> But this would also involve a lot of changes in the way tests are
> written as 12 out of 19 tests in t4027-diff-submodule.sh failed after
> adding this patch. I am working on any other workaround for this. Let
> me know whether I am on right path or not. Also any pointers on how to
> proceed would be helpful. Thanks!

We'd expect some tests to fail but only the ones that are testing if 
untracked files cause the submodule to be considered dirty.

git_diff_ui_config() is a callback that is invoked once per config key 
in the config files so I don't think it is a good place to make the 
change as it is inefficient and overrides the users' 
`diff.ignoreSubmodules` setting . It also only applies to `diff` and not 
`diff-index` or `diff-files`. I think it would be better to set the 
default in diff_setup() though we need to be careful not to override 
`diff.ignoreSubmodules` setting so we might need to add a global flag to 
remember if the user has set `diff.ignoreSubmodules` in their config

Best Wishes

Phillip

> 

