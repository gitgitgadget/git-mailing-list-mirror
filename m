Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10F6C433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 20:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B4B764EB2
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 20:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhBRUQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 15:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhBRUP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 15:15:26 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7EAC0613D6
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 12:14:46 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id p12so1563327qvv.5
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 12:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SrEgpJaKxHAoXdITWEZ6YxDkpRUTOsoySIyf/NgvNS8=;
        b=g39Y78zHXCpGP6biYueQZ0mqfPY7cVlxKjouERfIutvZZP38SAdh/7GA581rlehn7Z
         K4bEIckndYUopWDb2ahKuLPGJM1a6/A5NIC+hGz3DUmM855T7SHHhM0+/73BeVDyigNY
         U3MJH4IU07f1adTs2rx3JjJILR+UAijNDvQZoBPHp97n9/eXTo/uCvF5NGbXI0B+r36Y
         hJS/SHarg3BRjux6ClisSPIPBo1WqAvpkVNpbfALOoPe4MwtLD1ksMvDQMwHDhNZhiOP
         vOqqucTYMHSGTFKEWgbYE8wJK3hWEgQnJNfHTuTkRFsMvr5ELGdq34f8E8kdR5lmN2uS
         la2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SrEgpJaKxHAoXdITWEZ6YxDkpRUTOsoySIyf/NgvNS8=;
        b=dcFJR3nq1YQSgh923bOvoYEugzsG3kbtFrYCo6erfXIrDXBDDCdxQuqCFSCljIDVi0
         NUvbbY7PZh0GuPEoGXQXzNcuP9Bw58VoZKcj3PDU+BC+nbLoVjdoI30WjIEvts1Sj0V9
         VcGZZRbOnhIFYrnlVCjHob98eV0RPMnrDVKhrCjVX9lDx22Lvz5JLfAAoXAAcvmphQWp
         YWqUn4PIZqWcETEWzF89ekJ5PiIDHNr84LmdGOLjvEGQxOk4NywF9ez07hrhM5juf12k
         AsvZkeFBuAjKuydPZcNbBZE0R+pFFsU+4Dkc1Z0tzKTI4CsIgR4pGhyq77Okt8lvWa7h
         9uwg==
X-Gm-Message-State: AOAM5306/wu2boollT6anKJkF+G6lUrQf2nED76PsulbTx8Co4xQkppB
        YHcylt0MqNR+X5gbbQeBTRQ=
X-Google-Smtp-Source: ABdhPJzP0HROr71EjtPhUO+E6dXpI87bOA8Hg32A63/PN2OsR9lhfR1NUDL6EncWVOk4vlZKDhM8EQ==
X-Received: by 2002:a05:6214:20a1:: with SMTP id 1mr6128326qvd.30.1613679285841;
        Thu, 18 Feb 2021 12:14:45 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id o194sm4666422qke.101.2021.02.18.12.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 12:14:45 -0800 (PST)
Subject: Re: [PATCH 1/2] rm: changes in the '.gitmodules' are staged after
 using '--cached'
To:     Shourya Shukla <periperidip@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        Javier Mora <javier.moradesambricio@rtx.com>
References: <20210218184931.83613-1-periperidip@gmail.com>
 <20210218184931.83613-2-periperidip@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <0577f84b-f594-6b8a-76a2-29fb9453ee25@gmail.com>
Date:   Thu, 18 Feb 2021 15:14:43 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210218184931.83613-2-periperidip@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Shourya,

Le 2021-02-18 à 13:49, Shourya Shukla a écrit :
> Earlier, on doing a 'git rm --cached <submodule>' did not modify the
> '.gitmodules' entry of the submodule in question hence the file was not
> staged. Change this behaviour to remove the entry of the submodule from
> the '.gitmodules', something which might be more expected of the
> command.

We prefer using the imperative mood for the commit message title,
the present tense for describing the actual state of the code,
and finally the imperative mood again to give order to the code base
to change its behaviour [1]. So something like the following would fit more
into the project's conventions:


     rm: stage submodule removal from '.gitmodules' when using '--cached'

     Currently, using 'git rm --cached <submodule>' removes submodule <submodule> from the index
     and leaves the submodule working tree intact in the superproject working tree,
     but does not stage any changes to the '.gitmodules' file, in contrast to
     'git rm <submodule>', which removes both the submodule and its configuration
     in '.gitmodules' from the worktree and index.
     
     Fix this inconsistency by also staging the removal of the configuration of the
     submodule from the '.gitmodules' file, leaving the worktree copy intact, a behaviour
     which is more in line with what might be expected when using '--cached'.


However, this is *not* what you patch does; it also removes the relevant
section from the '.gitmodules' file *in the worktree*, which is not acceptable
because it is exactly contrary to what '--cached' means.

This was verified by running Javier's demonstration script that I included in the
Gitgitgadget issue [2], which I copy here:


~~~
rm -rf some_submodule top_repo

mkdir some_submodule
cd some_submodule
git init
echo hello > hello.txt
git add hello.txt
git commit -m 'First commit of submodule'
cd ..
mkdir top_repo
cd top_repo
git init
echo world > world.txt
git add world.txt
git commit -m 'First commit of top repo'
git submodule add ../some_submodule
git status  # both some_submodule and .gitmodules staged
git commit -m 'Added submodule'
git rm --cached some_submodule
git status  # only some_submodule staged
~~~

With your changes, at the end '.gitmodules' is modified in both the
worktree and the index, whereas we would want it to be modified
*only* in the index.

And we would want it to be staged for deletion (and only deleting the config
entry and keeping an empty ".gitmodules' file in the index)
if the user is removing the only submodule in the superproject.


> ---
>   builtin/rm.c | 48 +++++++++++++++++++++++++++---------------------
>   1 file changed, 27 insertions(+), 21 deletions(-)
> 

Once implemeted correctly (leaving the worktree version of '.gitmodules'
intact), that patch should also change the documentation to stay up-to-date,
since the "Submodules" section of Documentation/git-rm.txt states [3]:

     If it exists the submodule.<name> section in the gitmodules[5] file will
     also be removed and that file will be staged (unless --cached or -n are used).


Cheers,
Philippe.

[1] https://git-scm.com/docs/SubmittingPatches#describe-changes
[2] https://github.com/gitgitgadget/git/issues/750
[3] https://git-scm.com/docs/git-rm#_submodules
