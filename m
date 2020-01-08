Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336D2C282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 22:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0098420692
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 22:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdLVMCPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgAHWgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 17:36:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39152 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgAHWgD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 17:36:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id 20so649128wmj.4
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 14:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VYIY9gX9HqupqljaUKl+IKIWTZQ5w9AFwoABodhBxrE=;
        b=JdLVMCPBJ7K9SOXTQSGnXvtwrNxb72zKgZq+VnskXEB79Z6k9EDgqUtV/nIYibE6vP
         CNsgkSV7V0VejTOHCM3wmh3gLs8/g0xavO8MMgheF3x0iDsm+BwUjvZsVH57ibV4Gbvm
         oTWXDVmlsWhBAAsQnMuc6HBBCy6iQrTU8kfWerOTnWm10npPS/vaO/dDVpSZz0m2uCfE
         03i+nlpAZJrCo3EMwgClXUGtXYtjemBkYSXrsLAxuD/vJgVmlouQsFBA6v9+z02UpPTT
         nq/I9TUVxCzh2uKX3dWbqlHA7MVuln5v1ErFKyfWwnRl/fidmE9nubWWHUnTF38arzG9
         P6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VYIY9gX9HqupqljaUKl+IKIWTZQ5w9AFwoABodhBxrE=;
        b=TWsbG1U0Tf4Ejae9GxR8CR0m4wsolxW+LPEKs3hBaPadfn3Yc3JRoiTbSsmCpSr6rl
         e93PvAGH81A8tJ8jkcacOT+ePP4olxX/k2WMX29fYcrgCbimtfeBEVnojdRqOHxGeNDn
         HBZVJ3YrHfqvaTudgB6Dk4uK6IuPTwmYxaaEukYeriNZSKil44zfN4OfQFvbxEXFsI4D
         DIcl4+MFDJ8bXwgPfVtnaZWllCa3pkNV5TPwE1JJJpdx2fh/7lf8YO0GxdEWnwSLW62/
         t0k8zChSntlyJcpvGtWWsgZOJJhZIAQ8y9fg80kfvKi0FjglGWLR6m3USoQdMMfmT3t3
         dvlg==
X-Gm-Message-State: APjAAAUe6Su1S/FKlG+M5Fo40Yft75NBgfCcLQBNAdz47Cr6bWq5jD2f
        0K9xWtgG0GCihmJm9qw6k3w=
X-Google-Smtp-Source: APXvYqyh4ryetPh9nepOkx3gVOQI55MJmSC4wBmLDHWRSbXq6hLX6/kU22CU5VybZkn+9bh+NEuYvA==
X-Received: by 2002:a1c:2504:: with SMTP id l4mr944757wml.134.1578522960769;
        Wed, 08 Jan 2020 14:36:00 -0800 (PST)
Received: from szeder.dev (x4db69c09.dyn.telefonica.de. [77.182.156.9])
        by smtp.gmail.com with ESMTPSA id c5sm683688wmb.9.2020.01.08.14.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 14:35:59 -0800 (PST)
Date:   Wed, 8 Jan 2020 23:35:57 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Elijah Newren <newren@gmail.com>
Cc:     gitster@pobox.com, peff@peff.net, avarab@gmail.com,
        git@vger.kernel.org, Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: Unreliable 'git rebase --onto'
Message-ID: <20200108223557.GE32750@szeder.dev>
References: <20200108214349.GA17624@lxhi-065.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200108214349.GA17624@lxhi-065.adit-jv.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 08, 2020 at 10:43:49PM +0100, Eugeniu Rosca wrote:
> Hello Git community,
> 
> Below is a simple reproduction scenario for what looks to be a bug (?)
> in 'git rebase --onto' (v2.25.0-rc1-19-g042ed3e048af).
> 
> I would appreciate your confirmation of the misbehavior.
> If the behavior is correct/expected, I would appreciate some feedback
> how to avoid it in future, since it occurs with the default parameters.
> 
> 1. git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> 2. ### Cherry pick an upstream commit, to contrast the results with
>    'git rebase --onto':
>    $ git checkout -b v4.18-cherry-pick v4.18
>    $ git cherry-pick 463fa44eec2fef50
>    Auto-merging drivers/input/touchscreen/atmel_mxt_ts.c
>    warning: inexact rename detection was skipped due to too many files.
>    warning: you may want to set your merge.renamelimit variable to at least 7216 and retry the command.
>    [v4.18-cherry-pick bd142b45bf3a] Input: atmel_mxt_ts - disable IRQ across suspend
>     Author: Evan Green <evgreen@chromium.org>
>     Date: Wed Oct 2 14:00:21 2019 -0700
>     1 file changed, 4 insertions(+)
> 
> 3. ### In spite of the warning, the result matches the original commit:
>    $ vimdiff <(git show 463fa44eec2fef50) <(git show v4.18-cherry-pick)
> 
> 4. ### Now, backport the same commit via 'git rebase --onto'
>    $ git rebase --onto v4.18 463fa44eec2fef50~ 463fa44eec2fef50
>    First, rewinding head to replay your work on top of it...
>    Applying: Input: atmel_mxt_ts - disable IRQ across suspend
> 
> 5. ### The result is different:
>    $ git branch v4.18-rebase-onto
>    $ git diff v4.18-cherry-pick v4.18-rebase-onto
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index b45958e89cc5..2345b587662b 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -3139,8 +3139,6 @@ static int __maybe_unused mxt_suspend(struct device *dev)
>  
>  	mutex_unlock(&input_dev->mutex);
>  
> -	disable_irq(data->irq);
> -
>  	return 0;
>  }
>  
> @@ -3162,6 +3160,8 @@ static int __maybe_unused mxt_resume(struct device *dev)
>  
>  	mutex_unlock(&input_dev->mutex);
>  
> +	disable_irq(data->irq);
> +
>  	return 0;
>  }
> 
> 
> In a nutshell, purely from user's perspective:
>  - I get a warning from 'git cherry pick', with perfect results
>  - I get no warning from 'git rebase --onto', with wrong results
> 
> Does git still behave expectedly? TIA!

This is a known issue with the 'am' backend of 'git rebase'.

The good news is that work is already well under way to change the
default backend from 'am' to 'merge', which will solve this issue.
From the log message of aa523de170 (rebase: change the default backend
from "am" to "merge", 2019-12-24):

  The am-backend drops information and thus limits what we can do:
  [...]
    * reduction in context from only having a few lines beyond those
      changed means that when context lines are non-unique we can apply
      patches incorrectly.[2]
  [...]
  [2] https://lore.kernel.org/git/CABPp-BGiu2nVMQY_t-rnFR5GQUz_ipyEE8oDocKeO+>

Alas, there is unexpected bad news: with that commit the runtime of
your 'git rebase --onto' command goes from <1sec to over 50secs.
Cc-ing Elijah, author of that patch...

