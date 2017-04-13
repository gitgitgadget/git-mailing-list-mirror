Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C5C220960
	for <e@80x24.org>; Thu, 13 Apr 2017 18:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755650AbdDMSel (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 14:34:41 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35257 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755406AbdDMSej (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 14:34:39 -0400
Received: by mail-lf0-f68.google.com with SMTP id i3so7834240lfh.2
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 11:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aRlCduqHWvFRyuu0rKA81pR7o2SA4JTYDr/37a15EsQ=;
        b=RonI6sMXu4DhK1ez+A+nurgIAqWC8sb5vyAvaAf8K/XaZiA6zGgiBAbPGNldxkcVGU
         GCp6N26Ny2BJ+rg/BLKc/03olEmEgc2wChQS2PTIRLjFeYiygo/QkNxa1EtgspDCt7A2
         PSnWiHGhel0JuNskomDCvmhA1uzK0+AeN7xS31YQWcREbw4HTGUzbD6ofGeNroMtsIni
         ARflznVwmh6iWxinnHc1ymE+u68pMp5ppTLPQGE5AdYRxb2GK8sFycgSYEpb0360jNZr
         1cG2zuko9+hthVs6sXONxlHi3w/UcQELsLqB85+M352q2EfF9I9D1fXqS46K8vdS4GZt
         lj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aRlCduqHWvFRyuu0rKA81pR7o2SA4JTYDr/37a15EsQ=;
        b=cLS3nIpQzelcvwlFKVYdo9qOHlLnZRDBrXY4fD2WS+XZElRdzWN15QNB+mED4EOPa+
         FVf3TO5XsrOEMxqrtUl7pQrWsITNnEHz2qiN7X+TTqIPu7HUvuHSneUA8XoNGU8R8WWR
         kvZdMkrb6QIn1cYYApFp1EJiHZLeeXmiCR/kWH/gfwUjCNBc2TeZ37X0d8OPlZsx2WmT
         d8IYkKXiWi/IUdJYnrXJa6KrVylQ46qMozqYAkuCUqtc/OMl1jMKtL2IuZeRoSsSSDcE
         dDtCOr3vgX+ABI/Q2cRqUo4nFI9bRTwXHDZjKYsDtj09ZXJKim/zp6CrTyA0hOHZx9pF
         5QRQ==
X-Gm-Message-State: AN3rC/54znntmBS1RIsbiIBqxkEq5CzPCTs0WnrWQohWwipmCoPGBxq6
        6j6fRXJHFu4IcGkBBnvCRaQPtgX8tw==
X-Received: by 10.25.216.212 with SMTP id r81mr1689884lfi.66.1492108478215;
 Thu, 13 Apr 2017 11:34:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Thu, 13 Apr 2017 11:34:17 -0700 (PDT)
In-Reply-To: <CAGZ79kYi4X2cE8uF3cEwh5YndoSL6S2GUK-KYSYibqr+O2qG6g@mail.gmail.com>
References: <CA+P7+xqE-SZ5D6pk6-Dx+-VzHijmgmrUR2F=-370Rh8oKr10Nw@mail.gmail.com>
 <20170413171224.3537-1-jacob.e.keller@intel.com> <20170413171224.3537-2-jacob.e.keller@intel.com>
 <CAGZ79kYi4X2cE8uF3cEwh5YndoSL6S2GUK-KYSYibqr+O2qG6g@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 13 Apr 2017 11:34:17 -0700
Message-ID: <CA+P7+xpFVcj=Ssu6mjPs8km-GEsyhzbeVdb0ENH4bdzdqXOTsA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ls-files: fix path used when recursing into submodules
To:     Stefan Beller <sbeller@google.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 11:15 AM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Apr 13, 2017 at 10:12 AM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Don't assume that the current working directory is the root of the
>> repository.
>
> 1)  Oh! This bug might be hidden in other commands, too.
> ($ git grep cp.dir -- submodule.c)
>

Almost certainly. I'm not sure how best to audit this.

> 2) But why?
> Isn't that what most of setup.c is all about ? (discovery of the root of the
> repository, staying there, and invoking the correct subcommand with a prefix)
>
>> Correctly generate the path for the recursing child
>> processes by building it from the work_tree() root instead. Otherwise if
>> we run ls-files using --git-dir or --work-tree it will not work
>> correctly as it attempts to change directory into a potentially invalid
>> location.
>
> Oh, I see. In that case the setup doesn't cd into the worktree.
>

Yea we aren't in the worktree when we thought we were.

>> Best case, it doesn't exist and we produce an error. Worst
>> case we cd into the wrong location and unknown behavior occurs.
>>
>> Add a new test which highlights this possibility.
>>
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>> ---
>> I'm not sure that I'm convinced by this method of solving the problem as
>> I suspect it has some corner cases (what about when run inside a
>> subdirectory? It seems to work for me but I'm not sure...) Additionally,
>> it felt weird that there's no helper function for creating a toplevel
>> relative path.
>
> Do we want to run ls-files from the working tree or from the git dir?
> For the git dir there would be git_pathdup_submodule.
>

Well prior to this code we're assuming we are in the worktree. I
wasn't actually certain if we should run from within the gitdir or the
worktree. Probably we actually want to be in the gitdir so that we can
work even if we're not checked out. Additionally, we probably need to
protect this check with a "is_submodule_initialized" unless ls-files
somehow ignores the submodule already in this case.. it didn't look
like it at a glance.

> We could introduce
>   const char *get_submodule_work_tree(const char *submodule_path);
> as a wrapper around
>   mkpathdup("%s/%s", get_git_work_tree(), ce->name);
>
> Code and test look fine in this patch,
>

Yea adding a helper function seems like a good thing.

Thanks,
Jake

> Thanks,
> Stefan
