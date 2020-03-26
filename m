Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035C7C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 13:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C768A20737
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 13:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOp3rUHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgCZNC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:02:27 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44092 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgCZNC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 09:02:26 -0400
Received: by mail-qk1-f196.google.com with SMTP id j4so6146258qkc.11
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 06:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TecwYHhTEdaz9bmYlM3n8NtkgfdRrFk0OAjBks9FmOI=;
        b=KOp3rUHzgr0caOyTUoRlY7NW6lsFFEPZKKh8zJ6scNaHz8K6T9EmLG/x8msL2g7VTa
         j0c8tmg85atmmgdd4KYqm+3Jy8RhC7OT9DT/SURQpAvxExsTMQY+vx+FC1lJevT68DxN
         XS6Mq4X35CwV4dp4TfOOUU+ClQBPwALx2wYWP+AGyvexTgbo3uuygOULvvgRPYX0r1xg
         H4Ae4I32vRqCIWbbj6XhSBkd4tmxn9mozqEJ8mPHafrEXBxCmVmrdGA8nSMYj3UA1Zz6
         uAzWqxWupkxeIPYmhDH9UqYiocYD6R4DjKBIfjWiwHcT2j69XSxqRcgsdBxCoR1dr4Qd
         EqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TecwYHhTEdaz9bmYlM3n8NtkgfdRrFk0OAjBks9FmOI=;
        b=o4kCqb0cYaJcfA6lmuzALUumkYiKDowIty0lX5Xu00piCq4sd3iZIeWrnSHEZtGf9r
         wUQ/qsCDIQ9SSXB+cDCghmhxOprc5L2u/df/IfkruARsqTfrsaOk8LpyXgLqDFVRpFKV
         yx6C0uvQTV2w9CgdfCOXkzL0nYq2j/CMLcWTSj/SyjiNWq/4VdTNthhnVabGGNqB7/gS
         eeRwVtCjWoFBzJsr1F73iATa40F837QMpHPuMHog0kPOO+uBqVD4hX20sBhJ9nJ1XgZ3
         QirzntKt7gSVcm/drK14sjqAm6pYORKStEZy7+s8gQwdBOc196XJSfqCF9i8b1iVW8FQ
         tAjw==
X-Gm-Message-State: ANhLgQ3dShj+hLWnbrO/SGJXmTGgxj7Bc9g9HoYhqZ+adk4gmsNwKcWG
        PRj2ku7cXrRiIEHjHJ5OuGg=
X-Google-Smtp-Source: ADFU+vv5AI+xTraQAyxz3UQfuqE5/6mhZq+ECzJ4DMihjT68nhaU76l7lfN7rgUeU8ttf5mb29qvhg==
X-Received: by 2002:a37:844:: with SMTP id 65mr7308849qki.15.1585227745715;
        Thu, 26 Mar 2020 06:02:25 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id c6sm549872qtd.4.2020.03.26.06.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 06:02:25 -0700 (PDT)
Subject: Re: [PATCH v3 1/7] t7063: correct broken test expectation
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>
References: <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
 <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
 <d4fe5d335771e89dad40f717bf4623854d1efa9e.1585164718.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7ba7311c-08b8-8383-0281-79e58798e0be@gmail.com>
Date:   Thu, 26 Mar 2020 09:02:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <d4fe5d335771e89dad40f717bf4623854d1efa9e.1585164718.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/25/2020 3:31 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> The untracked cache is caching wrong information, resulting in commands
> like `git status --porcelain` producing erroneous answers.  The tests in
> t7063 actually have a wide enough test to catch a relevant case, in
> particular surrounding the directory 'dthree/', but it appears the
> answers were not checked quite closely enough and the tests were coded
> with the wrong expectation.  Once the wrong info got into the cache in
> an early test, since later tests built on it, many others have a wrong
> expectation as well.  This affects just over a third of the tests in
> t7063.

Wow. Good find.

> The error can be seen starting at t7063.12 (the first one switched from
> expect_success to expect_failure in this patch).  That test runs in a
> directory with the following files present:
>   done/one
>   dthree/three
>   dtwo/two
>   four
>   .gitignore
>   one
>   three
>   two
> 
> Of those files, the following files are tracked:
>   done/one
>   one
>   two
> 
> and the contents of .gitignore are:
>   four
> 
> and the contents of .git/info/exclude are:
>   three
> 
> And there is no core.excludesfile.  Therefore, the following should be
> untracked:
>   .gitignore
>   dthree/
>   dtwo/
> Indeed, these three paths are reported if you run
>   git ls-files -o --directory --exclude-standard
> within this directory.  However, 'git status --porcelain' was reporting
> for this test:
>   A  done/one
>   A  one
>   A  two
>   ?? .gitignore
>   ?? dtwo/
> which was clearly wrong -- dthree/ should also be listed as untracked.
> This appears to have been broken since the test was introduced with
> commit a3ddcefd97 ("t7063: tests for untracked cache", 2015-03-08).
> Correct the test to expect the right output, marking the test as failed
> for now.  Make the same change throughout the remainder of the testsuite
> to reflect that dthree/ remains an untracked directory throughout and
> should be recognized as such.

I wonder if we could simultaneously verify these "expected" results match
using another command without the untracked cache? It's good that we have
the expected outputs explicitly, but perhaps double-checking the command
with `-c core.untrackedCache=false` would help us know these are the correct
expected outputs?

Thanks,
-Stolee
