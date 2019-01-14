Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC16C1F62E
	for <e@80x24.org>; Mon, 14 Jan 2019 21:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfANVoI (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 16:44:08 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44700 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfANVoI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 16:44:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so602803wrt.11
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 13:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=E38zc7t9a9umP1uOzdyc1ctV0RbFILGPlQl5Mn1jEiY=;
        b=XS+D2JB56k7LRi0t4N0Q3TflwuVL5gXkIOr2q+exKYFEualIkyuv0AAO/U881gYqIx
         w2FmqiuI1hMK1uU1E4d9wvP/w8XhoQ5z2pDWe+qpYFxlorLGdp/vsgWU/CBE7lKpLyB8
         8Cl053R34PFFRcEIm1AfLtNXDyF+ZFPMC6kCBvVPZTo4P2AmDsMvVrvpP2z5F5H6OWdE
         hhC0QVGhJd3U/ACqqDCW7WiNgtDLlR6GxZ1PDqiW/4wIzGm6oAvJJxCWcHXRs8x471XH
         cktik+CNZAThSt6euMqMxZJ+wlSep06DjnORf3JVkVOEsg0fJuxr03EXZTGm0GpIdryK
         1L5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=E38zc7t9a9umP1uOzdyc1ctV0RbFILGPlQl5Mn1jEiY=;
        b=Tyb+qcIgLCG6lfaZgkC+SGYtMsa0MXd4BR+C2pBvOFJIPcYjIE5jooJfdB35FwJfmT
         xbD6ta0Ppo/yMfIEn80/DV75LPBAXOhxUYKaCqG0zACgAoKJTMTNPGjeFt3YmdlC4UKJ
         g1DTVatmTOHyvL3EVJv3DoQkYbjkld2C4WvuGwGaIIrsrCzRISZxz3RSxvCpNK5kxhOq
         ITzzEPqq+YyLPHkatD22N8Bhj5lFL23UHrmz1C5NCrMOlvCEfzXBMxlw9V2DArNcnDAx
         SRKCqeqreuCIm978W6f6DB89xKy6vvRBeS4eIvx8TxT0yBTP3jshuItd4VcXiBeeeaXi
         A07Q==
X-Gm-Message-State: AJcUukedrV20UPBOfackMw6CvTJqkDMA7Um3qE2ZkbtypqOVA6FYqRxt
        lL1hqmKlQvp5IwS5aw/h/QU=
X-Google-Smtp-Source: ALg8bN6z50Mz0hg0IMV5M2NNmTKG478XQdYl1hDZ1RxQJKrm2kx1XjAJOV4YvXY2o6nI2JcLcqK0Ig==
X-Received: by 2002:a5d:4c8a:: with SMTP id z10mr370441wrs.75.1547502246234;
        Mon, 14 Jan 2019 13:44:06 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c13sm77436413wrb.38.2019.01.14.13.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 13:44:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] new-workdir: Never try to recurse into submodules on the initial checkout.
References: <20190114172702.19959-1-marcnarc@xiplink.com>
        <20190114213430.GC162110@google.com>
Date:   Mon, 14 Jan 2019 13:44:05 -0800
In-Reply-To: <20190114213430.GC162110@google.com> (Jonathan Nieder's message
        of "Mon, 14 Jan 2019 13:34:30 -0800")
Message-ID: <xmqqwon6ud7e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> The new workdir is empty before the checkout, so attempts to recurse into
>> a non-existent submodule directory fail.
>>
>> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
>> ---
>
> Thanks for reporting.  Can you describe the error message when it fails
> here?
>
>> Until the worktree command supports submodules I've gone back to using the
>> git-new-workdir script, but it fails if my config has
>> submdodule.recurse=true.
>
> Oh, dear.  In general, the project does a better job at supporting "git
> worktree" than "git new-workdir", but I don't blame you about this.
>
> Noting locally as another vote for getting submodules to play well with
> worktrees soon.
>
> [...]
>>  contrib/workdir/git-new-workdir | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
>> index 888c34a521..5de1dc3c58 100755
>> --- a/contrib/workdir/git-new-workdir
>> +++ b/contrib/workdir/git-new-workdir
>> @@ -102,4 +102,4 @@ trap - $siglist
>> 
>>  # checkout the branch (either the same as HEAD from the original repository,
>>  # or the one that was asked for)
>> -git checkout -f $branch
>> +git -c submodule.recurse=false checkout -f $branch
>
> nit: can this use "git checkout --no-recurse-submodules" instead
> of -c?
>
> In general, we tend to recommend that kind of option instead of
> --config in scripts.

I am not sure if either approach makes sense.  Wouldn't the ideal
endgame to allow recursive checkout if the user wants to have it,
but not enable it by default?

Stepping back a bit, if the user has recursive checkout configured
somewhere valid for this repository (or worktree), shouldn't the
initial checkout also recurse and do a "submodule init" if that is
necessary before doing so?

IOW, at the point in that script where we call "git checkout -f", if
we changed it to "git checkout --recurse-submodules -f", what breaks
and why?  Shouldn't it succeed instead?
