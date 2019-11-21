Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C990FC432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 15:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924182070B
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 15:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2EMMWjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKUPgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:36:23 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34161 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfKUPgX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 10:36:23 -0500
Received: by mail-qk1-f194.google.com with SMTP id b188so3427021qkg.1
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 07:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4ctYs1ItEmPykaQWe96JMp0N1D+haZx9KzCK+wDbcWU=;
        b=U2EMMWjTKc+Sqz9oP55EiFw3Ad87l3gSPTkkjhij5Z70tTB7yL4WVc1/9e/3rVX9G5
         wqgjew05E57U6jXy1Rok5ZqRzDGXxWaTGqlX6U/dgiPgfyUfR1BnBmE7mcpqREjENwIP
         UJi3xI4hPeQJh7RL9JlB5I+XEN8osl/E31X0YTQV988Nz15lzxYoDbYYQ4lGJI4bbGuw
         CikHC3YrS88mrgCRhRuIQNAY+8SIhEphnM4hPXXQ6qi3lKCYpllENWoDFPILenetcnaC
         mZWQtYRnwPZN2dDc5P6rii+sTxZb/jGyu+D+kuAnVNGG7etIx2YEsK3NGDslHoZvlyWe
         6UtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ctYs1ItEmPykaQWe96JMp0N1D+haZx9KzCK+wDbcWU=;
        b=rDtR95XUuOo8QmFRedx3FburoQnDLsUaXzSO6AKrtvTzgZjt0ty0neodSeaaittiTw
         tQxb2mMAweV8IazfTn0RGvfF+2zJtfXIpwfAbZInddoQG8j75C5J4TvTTJdoCDTJsXVy
         MRUt9CjRcOIfbNwskhOmoVoq107M8YMvxZTDD8vDpdB46Ye4ilEeQcJtHbf+KB8zs+02
         OcfFjrUHjVsRhLiVnpvI2+He2Wg4E0+z7cQ4Ga74+GpK7ZObjFNP9Ehh/LC3y+UKV6Hq
         po4SIZ2ynhr0GSgcTWtMupfKsTRzFe1FBCLHIUmvW1T+WXwhxERfN9CL4s8p2a5N9GTA
         vIMw==
X-Gm-Message-State: APjAAAXxAij/pxxV0N8xa2atDFOeIM6/ynXqB4crdNGG93T2SW+vP2yb
        dPwObyOTcR9BwSI5nwX1ms3xefnDuCc=
X-Google-Smtp-Source: APXvYqzyPW0eZkC7CxPH2xB0FgLP8Y4VQk4jg3gQ9qQbdtrIe3yLlyKGgAfTZbAF1L2gICoJ+s2teQ==
X-Received: by 2002:a37:4912:: with SMTP id w18mr854011qka.206.1574350581766;
        Thu, 21 Nov 2019 07:36:21 -0800 (PST)
Received: from [10.0.1.19] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id z16sm1277967qtn.24.2019.11.21.07.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 07:36:21 -0800 (PST)
Subject: Re: [PATCH v5 02/17] sparse-checkout: create 'init' subcommand
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <a161cee0dfec76e7a08253083f488e2e6d26299e.1571666186.git.gitgitgadget@gmail.com>
 <20191121114936.GR23183@szeder.dev>
 <147bf5a9-6ae5-23ea-a007-68b8046c94ea@gmail.com>
 <20191121152744.GU23183@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <72a54009-5801-c92a-f108-faf38ebbdd4b@gmail.com>
Date:   Thu, 21 Nov 2019 10:36:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <20191121152744.GU23183@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/21/2019 10:27 AM, SZEDER Gábor wrote:
> On Thu, Nov 21, 2019 at 09:28:59AM -0500, Derrick Stolee wrote:
>> On 11/21/2019 6:49 AM, SZEDER Gábor wrote:
>>> On Mon, Oct 21, 2019 at 01:56:11PM +0000, Derrick Stolee via GitGitGadget wrote:
>>>> Getting started with a sparse-checkout file can be daunting. Help
>>>> users start their sparse enlistment using 'git sparse-checkout init'.
>>>> This will set 'core.sparseCheckout=true' in their config, write
>>>> an initial set of patterns to the sparse-checkout file, and update
>>>> their working directory.
>>>
>>> Enabling sparse-checkout can remove modified files:
>>>
>>>   $ mkdir dir
>>>   $ touch foo dir/bar
>>>   $ git add .
>>>   $ git commit -m Initial
>>>   [master (root-commit) ecc81bd] Initial
>>>    2 files changed, 0 insertions(+), 0 deletions(-)
>>>    create mode 100644 dir/bar
>>>    create mode 100644 foo
>>>   $ echo changes >dir/bar
>>>   $ ~/src/git/git sparse-checkout init
>>>   error: Entry 'dir/bar' not uptodate. Cannot update sparse checkout.
>>>   error: failed to update index with new sparse-checkout paths
>>>   $ cat dir/bar 
>>>   changes
>>>
>>> So far so good, my changes are still there.  Unfortunately, however:
>>>
>>>   $ git add -u
>>>   $ ~/src/git/git sparse-checkout init
>>>   $ echo $?
>>>   0
>>>   $ ls
>>>   foo
>>>
>>> Uh-oh, my changes are gone.
>>
>> Here, your changes are not "lost", they are staged, correct? 
> 
> Well, yes, the changes were staged, so they must be in the object
> database somewhere, the user just has to go through the dangling
> objects reported by 'git fsck' to find and restore it...  So from the
> perspective of an ordinary user they are lost.
> 
>> A "git status"
>> should report that your changes are ready for committing. This seems to be
>> the expected behavior.
> 
> No, unfortunately enabling sparse-checkout did throw the staged
> changes away:
> 
>   ~/test (master +)$ ~/src/git/git sparse-checkout init
>   ~/test (master)$ git status 
>   On branch master
>   nothing to commit, working tree clean
> 
> Note also the shell prompt going from "you have staged changes" to
> "working tree is clean".
> 
> But wait, I thought that only changes to files that are excluded from
> the sparse-checkout are thrown away, but as it turns out it throws
> away changes to files that are included in the sparse-checkout:
> 
>   ~/test (master #)$ echo original >foo
>   ~/test (master #%)$ git add .
>   ~/test (master +)$ git commit -m Initial
>   [master (root-commit) 04cb2a2] Initial
>    1 file changed, 1 insertion(+)
>    create mode 100644 foo
>   ~/test (master)$ echo changes >foo 
>   ~/test (master *)$ ~/src/git/git sparse-checkout init
>   ~/test (master *)$ cat foo 
>   changes
> 
> So far so good, but:
> 
>   ~/test (master *)$ ~/src/git/git sparse-checkout disable
>   ~/test (master *)$ git add .
>   ~/test (master +)$ ~/src/git/git sparse-checkout init
>   ~/test (master)$ cat foo 
>   original
> 
> This is not really sparse-checkout-specific, because this is what 'git
> read-tree -um HEAD' always does on its own:
> 
>   ~/test (master)$ echo changes >foo 
>   ~/test (master *)$ git read-tree -um HEAD
>   ~/test (master *)$ cat foo 
>   changes
>   ~/test (master *)$ git add -u
>   ~/test (master +)$ git read-tree -um HEAD
>   ~/test (master)$ cat foo 
>   original
> 
> These issues are present at the end of the patch series as well, but
> that is sort-of expected, because the later commit message states
> that:
> 
>     Remove this extra process call by creating a direct call to
>     unpack_trees() in the same way 'git read-tree -mu HEAD' does.

Thanks for the additional details.

This series intended to make the existing sparse-checkout behavior
more useful to users by not requiring manual edits of the sparse-checkout
file followed by 'git read-tree' commands. However, there do appear
to be some serious improvements that we can make in the future.

Keeping staged changes seems important, and we can address that in
the near future.

-Stolee

