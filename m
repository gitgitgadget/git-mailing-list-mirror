Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 002C51F803
	for <e@80x24.org>; Mon,  7 Jan 2019 17:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfAGRTo (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 12:19:44 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51558 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfAGRTn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 12:19:43 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so1612601wmj.1
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 09:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jlJYxSvubrT90pvDvn4Sk94lEbHMsV/G+ph9wyo6G38=;
        b=bE8k/6H59aMImey9QS5il/11/Ql+6Mijx6ZvQrftYD/KMAyGXOOXhr1M8aA/k2VQ55
         QDRlihwIWlWfbKiQ27G/j5cXMEzULFWaJ6NOJ34mA4N1ScFdOgOknc3yc8jueX+8K06r
         o2yLwJjd7VodYSTfqfLCHJQ4xSnf0adRyD82Zx+10Dk9zkbEooFtkF6ofUB+twfTSu4W
         l2n8Vlg6PI5J2kWbfXaAumANU95AGpY1zWmumW75CmS5b1KDqSytN5hVTLgPebwpWeGG
         7adUk5CdQde/CXpTu8ctC2QR2eiSt3WHPx7ATFWmWXSFJ7SfYpkZCbylZPQ+BJfE5PfP
         o/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jlJYxSvubrT90pvDvn4Sk94lEbHMsV/G+ph9wyo6G38=;
        b=ThClahYHDhkA70oGSnVgYoCl7DqDtC4bgOckDgEawI+nWjyobX2/wn206iwEgS3wNz
         KGUDZpnnLXA+pJHO5ApiqzjNrk70aX0AjqIpBolnKowWf3aRs+lgV1tGWsYRUA7bcj5B
         XkazlRwLUJf2d7JOy9nFFuiKte934i/e4lLahhtkv0FuhDtj0s+9zptiEVjPABzfTskH
         b/n1aBHpCsz1pCoyDT1lo9s/vEop4S7O00KpP+be2ricbrJ0QETaHKd+TvI8I/0aAUEd
         oIff9c7lUftlS9sjqf+TkGSYAka6LHA50FdoPrNdABMYaw452IIQuvvQUn0L4a9SDN06
         QNYg==
X-Gm-Message-State: AJcUukepbiu08h3oE4UCJ7WQgZhWtbDyosGf5en53SlkQQjZDId7Ri+m
        gJOBYKDLa67GYZdGWr/xCr/kHxd7
X-Google-Smtp-Source: ALg8bN69BCBIOEBdxAKwRO7OviUrsWQlGQrBHzjK37vr4ip/UGFNgnD4fY6TfPh+SuAJ2TuhCNLV2A==
X-Received: by 2002:a1c:9183:: with SMTP id t125mr8995079wmd.79.1546881581592;
        Mon, 07 Jan 2019 09:19:41 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n9sm42349887wrx.80.2019.01.07.09.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 09:19:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/4] built-in rebase: call `git am` directly
References: <pull.24.git.gitgitgadget@gmail.com>
        <2b5ece8263936f0a7dfad864c0de43d784fdaf1f.1545398254.git.gitgitgadget@gmail.com>
        <xmqqbm4wau51.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 07 Jan 2019 09:19:40 -0800
In-Reply-To: <xmqqbm4wau51.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 04 Jan 2019 15:19:06 -0800")
Message-ID: <xmqqef9o9yhf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> While the scripted `git rebase` still has to rely on the
>> `git-rebase--am.sh` script to implement the glue between the `rebase`
>> and the `am` commands, we can go a more direct route in the built-in
>> rebase and avoid using a shell script altogether.
>
>  ...
>
>>  builtin/rebase.c | 183 +++++++++++++++++++++++++++++++++++++++++++++++
>
> Now at some point as a follow-up change, we'd need to remove the
> git-rebase--am.sh that is no longer used, together with the
> reference to it in the Makefile, no?

Answering to myself.  That needs to wait until the legacy-rebase is
retired, so it's not like "immediately after this series is done"
kind of thing.

Anyway, thanks for working on this.
