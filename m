Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA04C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 17:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60E7206B1
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 17:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8NZMull"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgCLRzx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:55:53 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35119 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgCLRzx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 13:55:53 -0400
Received: by mail-pj1-f68.google.com with SMTP id mq3so2968381pjb.0
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 10:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+dE/lwa92BtaSVcoPp9UfrOXDNnfhIwuCQjuj+1GCRQ=;
        b=c8NZMullxeYSy8ZoKp0/l+5/laPCcUD3CrOoOsA/qnGDP7UVqfD44d9CKvwzQTxBz+
         zMPaOaYvAod3/QHjFct4b+QuMTXpQLEu5LQWOrNC4M4EUGnBzfVJLG05XXiUUA2fNpGL
         uo9CzSabtY/21qnJkTjf2+MPc+hk97zSrYJejHqcAsAXHlj7zcBGGQcDpSfPN2eZ0vFL
         i9Jn+JoBSfhBFZXCp1bz1oA2wjSowd/1Lcx+tczeTfwTLtQ5OncVdCgKqeqi+fYfPLwj
         mV57a2xoTnfgxpvMzrx6skkhtKkPR9/nBvrBjmCLtdBSRFuz+R7mXUSkvGzHdZDMAVza
         a/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+dE/lwa92BtaSVcoPp9UfrOXDNnfhIwuCQjuj+1GCRQ=;
        b=RWfu6paZ+sAjr3pZYAkQSPXaZfgRE69Ocms/FJEgPHGCeq7sloBOZsiSvqhQhhyGCq
         1AmKD3lCvFtascshsINYSx9f2S4xc8qduWNxzLx3e/tfNhwq85/tu3BqdT01LhbGwWpE
         WukkY6WP3L75fGFB5cB/nrA5+0z1YdO5/T3so8yhHPoamA/IyL34xrfrXUbDagnq6sXV
         vcpjvxmXPoO/UsnxAYXYOhfq1shu7ljsw1RgRZAuM8+uqjq/cMLRxpwCWjtgiRmVXaza
         eYrl4JuutwXqHMMWiWf20NbivX2cEoDaSW5KOgR8aL40rI/AcJFYqINeKK8mvlxvERhv
         SRuw==
X-Gm-Message-State: ANhLgQ0bfdE1OHqNIdxDC8k3HqiGT4CS50i2g/FUdvxuOBTPxK+oH5v9
        ffmXtg3deRcL2DdF6uH538OeGqxp
X-Google-Smtp-Source: ADFU+vt96aaL9FAmHdKahh187bTzmjd4AA87LlkjFX9aFGQ7T2ErvBvGjPQmx+FEPZ0ci1obAwijWA==
X-Received: by 2002:a17:90a:7f06:: with SMTP id k6mr5355581pjl.78.1584035750890;
        Thu, 12 Mar 2020 10:55:50 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id z17sm44417170pfk.110.2020.03.12.10.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:55:50 -0700 (PDT)
Date:   Thu, 12 Mar 2020 10:55:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v5 20/20] rebase: rename the two primary rebase backends
Message-ID: <20200312175548.GC120942@google.com>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
 <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
 <ad8339aebf28ec84c22ed59cef06614d204adb55.1581802602.git.gitgitgadget@gmail.com>
 <20200312151318.GM212281@google.com>
 <CABPp-BHyNvxQZ5q=9WXXESTPmxFe4fAiE5roGeV2H+XJ_cpDmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BHyNvxQZ5q=9WXXESTPmxFe4fAiE5roGeV2H+XJ_cpDmg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Thu, Mar 12, 2020 at 8:13 AM Emily Shaffer <emilyshaffer@google.com> wrote:

>> This broke quite a few upstream users for us today when we rolled out a
>> next with this patch added on top. To shim around the post-commit hook
>> issue, we had set a system config for all our users to use
>> merge.backend=am; the machinery is pretty intolerant to a wrongly
>> configured backend name (die() rather than a warning and fallback).
>>
>> Would it make more sense to deal with an unrecognized backend by falling
>> back to the default backend, instead?
[...]
> Sorry for the pain.  The earlier part of the series had only ever made
> it to next, and was reverted there, and thus, in my thinking, in the
> new cycle no one would have ever seen the intermediate state.  (Oops,
> I forgot about cases where people tried out next towards the end of
> last cycle before it was reverted and decided to set config based upon
> it.)

Right, I'm mostly interested in this for the future: do we expect the
list of backends to only grow over time, or do we want to support
removing and renaming backends?  In the latter case, how can we support
people sharing config between multiple Git versions with their
merge.backend settings?

> I'm a little worried about ignoring the setting and just picking one;
> if the setting has been marked and they set it to e.g. "appply" (one
> too many p's), then does it really make sense to just show a warning
> but continue using the backend they didn't want, especially since they
> may miss the warning among the rest of the output?  I'd rather go the
> route of improving the message, perhaps:
>         _("Unknown rebase.backend config setting: %s")
> Would that work for you?

What if we support multiple merge.backend values, with semantics:

- last recognized value wins
- if no value is specified, use the default
- if values are specified but none are recognized, error out with a
  clear error message

?

> Also, I thought that you and Jonathan were going to be changing the
> post-commit hook handling[1][2].  Does this mean that you've punted on
> that, and I need to make some kind of change here to get you to switch
> over?

The setting was a stopgap; our interest in this upstream is primarily
from the point of view of "we ran into this, so let's take the
opportunity to help others that might run into similar issues in the
future".

Thanks,
Jonathan
