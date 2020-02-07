Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDD4C04EB5
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 15:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34C5217BA
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 15:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+csYQOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgBGPso (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:48:44 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40090 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbgBGPsn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 10:48:43 -0500
Received: by mail-qt1-f194.google.com with SMTP id v25so2157113qto.7
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 07:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MBsYMuBsA5t8svE+NcB6xyjYQflLIrPpY7vkuGt0oBI=;
        b=C+csYQOhqcwAwyn0JCwenF7mgged4dlABbj3DjQlF1MO3ZOI80etKC3Bj/ONENWlf1
         8b/Kg7LiJD0ai9+dQ9THUpHd8fCceTtznILj+ytLC0JFAWgiYZK8vsyvAt5/NbAQqeEz
         UcZrSqmhru61S3bUw3O0NEudkuNjBCWi493Di7BHdvgTQNU9eFHlIh+C+lBeHeY9uJyn
         UVM4/z6q98qhaLJKycqJH6AEMpoLpB2MXguoVBUY1hn6T1K1OZIZIn8AyedG7Cbs76B7
         TOvFAdnT/A+ke5ZMcM2THSUhSW7ntt+qEVFQ16av6tClOBcj00TbdNGSvQ03I3U0d58f
         nnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MBsYMuBsA5t8svE+NcB6xyjYQflLIrPpY7vkuGt0oBI=;
        b=EhOLSZqd7JILGYpmCItaHzvHuXQ+juPVRxcIhoqy2aAv2maeAqqdcRnMd11gbuWaAi
         g3Io0dwaaCcKvZHRUI9md7i6dx+3+SkHvps+QBz/ENPpkq2oAbEj5d4a9f7tAf5xEKmZ
         yfQ+8Hyf04mQf3FLFd/qKkeu2FnQJHJwOGDAGWQbS3mVa+wJ+mSZsO2QZ3FtJoUlg9vq
         GSlLPZwBfPMk1CmHGm5CbjYlZFD6Doe/+x3lKkgGCJkAcGVwUQYbXHGcj9IRqE5SDP3R
         3l+pjjn/jvHYoSwj5fS9Bqh4bTfTBxywrydWaC8Ex/Pza6CXkYwFBZKNhpuHjqNJcc6w
         MLgg==
X-Gm-Message-State: APjAAAXYA9GY7oru22IE3BYedIr3EmDKmhzymO40THoI1kdnBB40EF0N
        RrUc4nIhWOOSOSFVcm4Uol4=
X-Google-Smtp-Source: APXvYqzBQc0Gl0uS7kfn0NBOXH4JUTUQ/FYDSa9sWk1IEhdZfE+fR204gLrx3+L8awX97Pwo82VOyw==
X-Received: by 2002:ac8:6708:: with SMTP id e8mr7732208qtp.215.1581090522583;
        Fri, 07 Feb 2020 07:48:42 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:439:e50b:6e3c:1277? ([2001:4898:a800:1012:b56c:e50b:6e3c:1277])
        by smtp.gmail.com with ESMTPSA id y26sm1589691qtc.94.2020.02.07.07.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 07:48:41 -0800 (PST)
Subject: Re: [PATCH v2 1/3] builtin/commit-graph.c: support
 '--split[=<strategy>]'
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1580430057.git.me@ttaylorr.com>
 <cover.1580862307.git.me@ttaylorr.com>
 <3e19d50148c8d53b30f8f0036a2d3af9f4bb3499.1580862307.git.me@ttaylorr.com>
 <CAN0heSrXZd7ktBTHaYFWjhW=NcGx5gL52-unSDaC4ZoNf96HFA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3acac399-9476-e4ad-556e-e0138380eeb0@gmail.com>
Date:   Fri, 7 Feb 2020 10:48:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSrXZd7ktBTHaYFWjhW=NcGx5gL52-unSDaC4ZoNf96HFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/6/2020 2:41 PM, Martin Ågren wrote:
> On Wed, 5 Feb 2020 at 01:28, Taylor Blau <me@ttaylorr.com> wrote:
>>  * If `--size-multiple=<X>` is not specified, let `X` equal 2. If the new
>>  tip file would have `N` commits and the previous tip has `M` commits and
> 
>> -               OPT_BOOL(0, "split", &opts.split,
>> -                       N_("allow writing an incremental commit-graph file")),
>> +               OPT_CALLBACK_F(0, "split", &split_opts.flags, NULL,
>> +                       N_("allow writing an incremental commit-graph file"),
>> +                       PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
>> +                       write_option_parse_split),
> 
> 
> I keep getting back to this -- sorry! So this actually forbids
> "--no-split", which used to work before. Unfortunate?

That certainly is unfortunate. Hopefully no one is taking a dependence on
this, which only means something if they had a `--split` previously in
the command-line arguments.

> I have to ask, what is the long-term plan for the two formats (split and
> non-split)? As I understand it, and I might well be wrong, the non-split
> format came first and the split format was a user-experience
> improvement. Should we expect that `--split` becomes the default?

In some ways, the split is now the default because that is how it is
written during 'git fetch' using fetch.writeCommitGraph. However, I
don't think that it will ever become the default for the commit-graph
builtin.

> In
> which case `--no-split` would be needed. Or might the non-split format
> go away entirely, leaving `--split` a no-op and `--split=<strategy>` a
> pretty funky way of choosing a strategy for the one-and-only file
> format?

In some ways, the --split=merge-all is similar, except it writes a one-line
commit-graph-chain file and puts a .graph file in
.git/objects/info/commit-graphs instead of writing to .git/objects/commit-graph.

> To try to be concrete, here's a suggestion: `--format=split` and
> `--split-strategy=<strategy>`.

Why --format=split instead of leaving it as --[no-]split? Is there a reason to
introduce this string-based option when there are only two options right now?

Perhaps using --split-strategy=<strategy> is the most backwards-compatible
option, especially because we won't need --split="" to substitute for
"auto-merge". However, I wonder if this is a case where we should make the
hard choice to sacrifice a narrow backwards-compatibility in favor of a
simplified set of options?

Thanks,
-Stolee
