Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FACC433DF
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 19:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22FF1207D3
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 19:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltKgRv30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgFDT0e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 15:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbgFDT0d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 15:26:33 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F637C08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 12:26:33 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id jz3so1567286pjb.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 12:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5+BAaBQeC+LS8Ezx0amMTrBULCiOFzFLTR0YXxKu4+c=;
        b=ltKgRv30I/M5Sc/lazZuVwxvsZ81ALE0179gpillTN9GM7185xW/8aOiD2xy5TbSiL
         e8tHY9X0jpsF6gCwqvzYBePwcPKljG0CgPRBilVAxkYfwQ1kr0j/i7kNNATJnr0L2LiA
         GDt+WfN4AocxVIbtdZSnXcls7wDPzArv1drUw77Z2zf4cAamdUqFcSoSFbJ9i/DuIkGZ
         y+bd8uWxFWp0IrjSahQ8PPV3pdDu8Kkvqe08H1zqt+IuKgFe3wgsVJBP9l//RckgFzkc
         Ou663GotLYz1bwICqLbP7mJI8grJE+GjYXRsYlob66kPKmwwb1CT8Mkv2x/brosbwy9k
         R3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5+BAaBQeC+LS8Ezx0amMTrBULCiOFzFLTR0YXxKu4+c=;
        b=dRwwzLII6nolJ4Xwbzb9K3NXUiloGCRQ029XC16VnGDHY3b97BplBrgzkbmUy3gRj0
         rT1qd4fieo2zXDNzB9XnbwM5BSuhSEArIC4612S83xi0rB2+i0kspNqTGFv09XZMJ+vV
         QUPiR3httqkxJaLAZjHkc2X6SwPTh5D2XbzFv+ZDd2CgRHU5W/xQrL8/SH3kBPZs5zde
         nxdoMAXjVo/nbMDZIWW8ov5eA0UXnrywTI4g9TZ3SvyjJNAuXvw82XrI6ZpJOOAHjHi3
         48flyekkrHkAls0STV7+Ag2KbCh5n5VSc6rCUNJXD67oCTl/9lxW48dz0ybY+u6Yqcuy
         QwCw==
X-Gm-Message-State: AOAM530ftDTcU2f660HK6SbZv6bH6K2/Q15yOOp4Y8L1mJT7e3ldshxn
        amplD35kaUdNtdpl/S8L/NCEH7q9
X-Google-Smtp-Source: ABdhPJxISEVP6AZG1GU2/DjCykm4PsCllyeLyiVn9omFJ7ffyzg49/zhCag3XZNn3qry7Qe/kzgfVA==
X-Received: by 2002:a17:902:9686:: with SMTP id n6mr6137844plp.186.1591298792941;
        Thu, 04 Jun 2020 12:26:32 -0700 (PDT)
Received: from [192.168.208.37] ([49.207.141.8])
        by smtp.gmail.com with ESMTPSA id b16sm5121729pfd.111.2020.06.04.12.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 12:26:32 -0700 (PDT)
Subject: Re: [GSoC][PATCH v5] submodule: port subcommand 'set-branch' from
 shell to C
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20200523163929.7040-1-shouryashukla.oo@gmail.com>
 <20200602163523.7131-1-shouryashukla.oo@gmail.com>
 <1b851e49-3bb1-3b59-7f24-b903c5514391@gmail.com>
 <CAP8UFD3Qe3iDe+ymKsqv9HarFLYDohXmUGbkNwZ4MdVQ=XP7yQ@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <92bad281-dd38-aef2-9910-659b41cdd830@gmail.com>
Date:   Fri, 5 Jun 2020 00:56:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD3Qe3iDe+ymKsqv9HarFLYDohXmUGbkNwZ4MdVQ=XP7yQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03-06-2020 01:15, Christian Couder wrote:
> On Tue, Jun 2, 2020 at 9:01 PM Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
>>
>> I'm having second thoughts about my suggestion[1] to include
>> the short option for '--quiet' in the usage. This is the only
>> usage in submodule--helper that mentions that '-q' is a short
>> hand for '--quiet'. That seems inconsistent. I see two ways but
>> I'm not sure which one of these would be better:
>>
>> A. Dropping the mention of '-q' in this usage thus making it consistent
>>     with the other usages printed by submodule--helper.
>>
>> B. Fixing other usages of submodule--helper to mention that '-q' is
>>     shorthand for quiet. This has the benefit of properly advertising
>>     the shorthand.
>>
>> C. Just ignore this?
> 
> The `git submodule` documentation has:
> 
> -q::
> --quiet::
>         Only print error messages.
> 
> even though the Synopsis is:
> 
> 'git submodule' [--quiet] [--cached]
> 'git submodule' [--quiet] add [<options>] [--] <repository> [<path>]
> 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
> ...
> 
> So I prefer B, and maybe updating the synopsis, as I think most Git
> commands have '-q' meaning '--quiet'.
> 

Makes sense.

> [...]
> 
>> So, according to this, I think the usage should be ...
>>
>>      git submodule--helper set-branch [-q | --quiet] [-d | --default] <path>
>>
>> ... and ...
>>
>>      git submodule--helper set-branch [-q|--quiet] [-b | --branch]<branch> <path>
>>
>> ... respectively.
> 
> I don't agree. I think `git submodule--helper set-branch ...` requires
> either "-d | --default" or "-b | --branch", while for example:
> 
> git submodule--helper set-branch [-q | --quiet] [-d | --default] <path>
> 
> would mean that "git submodule--helper set-branch my/path" is valid.
> 

You're right. Even I thought about the same thing when I came up with
that suggestion after quoting that portion of the CodingGuidelines. But
it was also curious for me to observe that the original used parenthesis
to mention the short and long options of an argument:

> +	const char *const usage[] = {
> +		N_("git submodule--helper set-branch [-q|--quiet] (-d|--default) <path>"),
> +		N_("git submodule--helper set-branch [-q|--quiet] (-b|--branch) <branch> <path>"),
> +		NULL
> +	};

I've not seen such a usage before. That's what actually made me take a
look at the CodingGuidelines for this. As the CodingGuidelined doesn't
seem to be mentioning anything about this explicitly, let's see if I
could find something in the usage printed by other commands.

---
> git am -h
usage: git am [<options>] [(<mbox> | <Maildir>)...]
   or: git am [<options>] (--continue | --skip | --abort)

   <options snipped>

> git branch -h
usage: git branch [<options>] [-r | -a] [--merged | --no-merged]
   or: git branch [<options>] [-l] [-f] <branch-name> [<start-point>]
   or: git branch [<options>] [-r] (-d | -D) <branch-name>...
   or: git branch [<options>] (-m | -M) [<old-branch>] <new-branch>
   or: git branch [<options>] (-c | -C) [<old-branch>] <new-branch>
   or: git branch [<options>] [-r | -a] [--points-at]
   or: git branch [<options>] [-r | -a] [--format]

   <options snipped>

> git checkout -h
usage: git checkout [<options>] <branch>
   or: git checkout [<options>] [<branch>] -- <file>...

   <options snipped>

> git switch -h
usage: git switch [<options>] [<branch>]

   <options snipped>

---
Hmm. Looks like it's not common for us to mention both the short
and long options in the usage itself. This might be to avoid the
redundancy as the usage is usually followed by the list of options.

With this info, I think we could've just gone with the following as the
usage strings for the `set-branch` subcommand:

    git submodule--helper set-branch [<options>] -d <path>
    git submodule--helper set-branch [<options>] -b <branch> <path>

This also solves the problem with `--quiet` I mentioned earlier while
making it concise and inline with the usages printed by other commands.

All this said, I don't think it's worth a re-roll now for several
reasons.

-- 
Sivaraam
