Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 038E21F404
	for <e@80x24.org>; Wed, 15 Aug 2018 18:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbeHOVXP (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 17:23:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47032 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbeHOVVi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 17:21:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id h14-v6so1893796wrw.13
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 11:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zgjVLBGLkmxIqIJYycBORVlZ87PbxyfPdVdEGSVW0w0=;
        b=CAxQNTwhCGx1zreIR8MDsYnqkgymYQ8dHW5SlCmMHADPsJ5mEYhBeN6FhWVmwJgnGM
         UjD7u7stYPI55aQqd6c9q3u1xXeteCDTKNGf31BrR0GMCxMnIs/9WcZQkuixnZGFKPU2
         vwZ9s2TqkiwO1QJ95A6+YjWFIOuob4ns4wP9p41oXnWLpS/qdT3uR6U4qdMKWSioxDgA
         TWZ4D9WjqB16FB+fAui1ucvL07kw8+i3rNOmWn9bySVu8lzaC+3YyFBSGGP9ZKgbyJiW
         ZYOTUEnzNrKhbiDxOBNDU8RfjvBgREtS1Rsp5JJLIiryfeAnDD06sYQEdMxlpkvn5XkM
         KSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zgjVLBGLkmxIqIJYycBORVlZ87PbxyfPdVdEGSVW0w0=;
        b=E6l4JCOSpn6C4L15VhTLE0J1ARSrEHpv5xYAwJmBqT9ysfv5znPvSkCxoxXhnbDhVE
         yMvMF+Up1BG+d++1B9I4kzK2/RqqeiiWe4MVo668YyIqAsJkFkLlocCJhgicw/itQKUI
         6joyfwCWIEHGl0qI7BUmDs0ULpYhRm6eicjF7PVxax37VrTYvp3LPw06CyNb6clApuoB
         G7vuipFiINJZKr1lhoE3tTlXiIh+LDI/Mh7sR220uNdTg0H/PsihQPs21r29JRlTSfJ9
         hzXe9PE+X2PnM9jdFbTmT6GsiM+efAAZGVTTjMWuVJEfQIRz2CsPIi3D7sUriLVubzdE
         WmQQ==
X-Gm-Message-State: AOUpUlFGJTQ+m+hTWaMpcuw3f2lYSRIv5MIrHVYxUWj9J0SIyAuhbeJd
        nby0+135nQkZdv/h3NAyVOo=
X-Google-Smtp-Source: AA+uWPwUrl9Sn0y4pCOJDtbYsSqxx2K+NWnnQ98I9KGezRKipHa3O732/6aY6XrqBcqu7alh8JRlvQ==
X-Received: by 2002:adf:8541:: with SMTP id 59-v6mr17758583wrh.223.1534357702113;
        Wed, 15 Aug 2018 11:28:22 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m129-v6sm13019613wma.1.2018.08.15.11.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 11:28:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 2/5] unpack-trees: add performance tracing
References: <20180804053723.4695-1-pclouds@gmail.com>
        <20180812081551.27927-1-pclouds@gmail.com>
        <20180812081551.27927-3-pclouds@gmail.com>
        <20180813192526.GC10013@sigill.intra.peff.net>
        <xmqqk1ot3n4h.fsf@gitster-ct.c.googlers.com>
        <90d1bbf7-91a3-74ac-de65-1eb8405dc1f7@jeffhostetler.com>
        <CACsJy8DQmOCD2a5QFUiyPuoPZLq-QEejLhWACKpsJLvK5ERAMg@mail.gmail.com>
        <CAGZ79kZwVpCBMkBKuYpwZFgAN50wZub_fyzWrAsE=ksuc-aCgQ@mail.gmail.com>
        <CACsJy8CTNeR8Bchj37yNL+mWp1Y5rhD6QV2Gf06CPLHVXd8TDQ@mail.gmail.com>
        <xmqqeff0zn53.fsf@gitster-ct.c.googlers.com>
        <CACsJy8C5xPOa26q_dvGgrmkV+C-k2kmc8_nQbwzcDVNue4ehYw@mail.gmail.com>
Date:   Wed, 15 Aug 2018 11:28:19 -0700
In-Reply-To: <CACsJy8C5xPOa26q_dvGgrmkV+C-k2kmc8_nQbwzcDVNue4ehYw@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 15 Aug 2018 18:32:35 +0200")
Message-ID: <xmqq36vfiiws.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Aug 14, 2018 at 10:52 PM Junio C Hamano <gitster@pobox.com> wrote:
>> > It's not just sampling points. There's things like index id being
>> > shown in the message for example. I prefer to keep free style format
>> > to help me read. There's also things like indentation I do here to
>> > help me read.
>>
>> Yup, I do not think that contradicts with the approach to have a
>> single unified "data collection" API; you should also be able to
>> specify how that collection of data is to be presented in the trace
>> messages meant for humans, which would be discarded when emitting
>> json but would be used when showing human-readble trace, no?
>
> Yes. As Peff also pointed out in another mail, as long as this
> structured logging stuff does not stop me from manual trace messages
> and don't force more work on me when I add new traces, I don't care if
> it exists.

I am hoping that we are on the same page, but just to make sure,
what I think we would want is to have just a single set of
annotations in the codepath, instead of "we can add annotations from
these two separate sets, and they do not interfere each other so I
do not care about what the other guy is doing".

IOW, I found it highly annoying having to resolve merges like
7234f27b ("Merge branch 'nd/unpack-trees-with-cache-tree' into pu",
2018-08-14), taking two topics that try to use different tracing
mechanisms in the same codepath.
