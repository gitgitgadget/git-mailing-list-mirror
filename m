Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD537C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 07:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA6E161390
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 07:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352584AbhJAHtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 03:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352560AbhJAHtG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 03:49:06 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ED4C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 00:47:22 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id dn26so31423199edb.13
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 00:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=1zEESvvVdSjbOSdaWL74vrBlCiMuMAogXlDDubhl/W8=;
        b=MZZPNgo7DskxNUQArRRfk0Rf5zFqCBZf47qr/Yy1Q9ilB2D8egJTSsfJ8QvMvpvmqd
         uD7m3thOdQkH5QHjJIa0+HBDgjwHyX3Iaomw6+46JPlxmHCjt/xDcaWCUxJxknrpQ5ue
         Wtya61rGTlZzTKtAqmGnwUpoXUYpEpa/REe2tJ12mls13QVwosMzMiF5F5q+mnra6o2E
         EMLvaXIIkTl1zG6btDqTj9/NZMZ/CtJmwiEYX2HBiAobZ0Xx8VEZlFmDL8Ja4VhpysWP
         krBt8x2S2mkszuRcwwpHyVulvbk+8ui2jwtt2IOZzaZHiR80djUq0XUX2GZhvPA2+jGP
         oDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=1zEESvvVdSjbOSdaWL74vrBlCiMuMAogXlDDubhl/W8=;
        b=FKPLOOxixCDc+X6GV43bfQwHYfXuHbZAKGkLyraDRa1vaPN5sprkIMR/QoDkPQAG9A
         84rDQBTqyNkJE4/b12Oo/vAgbcpgKumPWQGiLi0wGOyVJR3H9HCOgUjDeDjzJYIpJQKk
         tvFqiGV3ScUabefBRzpFfLyz2E1NBiWFCpL4f2+DDvg3wLjpBtK0GseRRlBqb+zlRC7h
         4WWEDnka3ptjzmtNfftOMLM2CTn3hAXK6+El/pWfUTvvWlF4HDbjn98xyV1mFdbhUsOu
         PtfSv43N2oMGkkIZtnBH1n2Y3GL0BrANfl6owrCz8bxVp76lA1jrzjFWejIFpYaUTFX/
         LdQg==
X-Gm-Message-State: AOAM5337PS3Onb9wUZ9XPIQQlgnjYh/GH6A5tiznl3vnUaXoYQcW2FEd
        m36PEr3pmJF0urR1DuP7fUs=
X-Google-Smtp-Source: ABdhPJz0PWERVF2yotQJT/7h37sbdmrQKYgJz3U7QHZx89m+kFXoFzb3jyVaelpbYjar/xvpz8DjKg==
X-Received: by 2002:a50:cf87:: with SMTP id h7mr12970572edk.152.1633074440777;
        Fri, 01 Oct 2021 00:47:20 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k18sm2725385edv.41.2021.10.01.00.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 00:47:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing
 primary object dirs
Date:   Fri, 01 Oct 2021 09:43:48 +0200
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
 <YVOiggCWAdZcxAb6@coredump.intra.peff.net> <xmqqsfxof2hr.fsf@gitster.g>
 <YVVoXJo3DlPQd1A3@coredump.intra.peff.net>
 <CABPp-BF20vpC4m5V4JtS91fuA+PMiEN78J9OpVEPDpnKsTcP8A@mail.gmail.com>
 <YVacUCcl6USJSY5T@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YVacUCcl6USJSY5T@coredump.intra.peff.net>
Message-ID: <87sfxlrxtk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 01 2021, Jeff King wrote:

> On Thu, Sep 30, 2021 at 09:26:37PM -0700, Elijah Newren wrote:
>
>> >  - This side-steps all of our usual code for getting object data into
>> >    memory. In general, I'd expect this content to not be too enormous,
>> >    but it _could_ be if there are many / large blobs in the result. So
>> >    we may end up with large maps. Probably not a big deal on modern
>> >    64-bit systems. Maybe an issue on 32-bit systems, just because of
>> >    virtual address space.
>> >
>> >    Likewise, we do support systems with NO_MMAP. They'd work here, but
>> >    it would probably mean putting all that object data into the heap. I
>> >    could live with that, given how rare such systems are these days, and
>> >    that it only matters if you're using --remerge-diff with big blobs.
>> 
>> Um, I'm starting to get uncomfortable with this pretend_object stuff.
>> Part of the reason that merge-ort isn't truly "in memory" despite
>> attempting to do exactly that, was because for large enough repos with
>> enough files modified on both sides, I wasn't comfortable assuming
>> that all new files from three-way content merges and all new trees fit
>> into memory.  I'm sure we'd be fine with current-day linux kernel
>> sized repos.  No big deal.  In fact, most merges probably don't add
>> more than a few dozen new files.  But for microsoft-sized repos, and
>> with repos tending to grow over time, more so when the tools
>> themselves scale nicely (which we've all been working on enabling),
>> makes me worry there might be enough new objects within a single merge
>> (especially given the recursive inner merges) that we might need to
>> worry about this.
>
> I do think we need to consider that the content might be larger than
> will comfortably fit in memory. But the point of using mmap is that we
> don't have to care. The OS is taking care of it for us (just like it
> would in regular object files).
>
> The question is just whether we're comfortable assuming that mmap
> exists if you're working on such a large repository. I'd guess that big
> repos are pretty painful with out it (and again, I'm not even clear
> which systems Git runs on even lack mmap these days). So IMHO this isn't
> really a blocker for going in this direction.

On the not a blocker: Even without mmap() such a user also has the out
of increasing the size of their swap/page file.

And generally I agree that it's fair for us to say that if you've got
such outsized performance needs you're going to need something more than
the lowest common denominator git can be ported to.

I also wouldn't be surprised if in that scenario we'd run faster if we
were using memory (and no mmap) than if we tried to fallback to the FS,
i.e. your suggestion of replacing N loose objects with one file with
index offsets is basically what the OS would be doing for you as it
pages out memory it can't fit in RAM to disk.
