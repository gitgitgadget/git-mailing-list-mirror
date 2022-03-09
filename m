Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3EBC433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 18:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbiCIS5b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 13:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbiCIS5a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 13:57:30 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CB1125516
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 10:56:31 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g3so4144592edu.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 10:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=n1o9F+kllVAc6cbxtGPxpvuVtYCcok3Zqp8DAhVljuw=;
        b=kMyiJAlHM7u3qAMcKpQk7iy8h6sfax99Ms4CEijtOq1CgpkbZfCQJDi/k/hyN+7mTv
         g33bYU6b2Lah+ha82kavnq+UgcbZJRgRJuTFBGbarcB8AK4Wt47VqTeCOFXk/IUJHB2A
         Z/6ZKBY2nInFpfywqjxDXbCVVv3TrS4z3hrcJFNvt66RlLjHGjP/BI6X01D9OftCBMmk
         xrRKgbhG/JiSQetxWpksNs1eHuWOx10JEHa6vqRYBd+GFpQsOTWAGm6JwSxZ501TbHnL
         qfZd/AliGI8n7VZQ1qjqqAOZVc17WIspSnySUvISPGAz9NAgIgWfaH7k5SBs30QteWDn
         3dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=n1o9F+kllVAc6cbxtGPxpvuVtYCcok3Zqp8DAhVljuw=;
        b=QeafTnONK12I7cFfswqWpVk2bmDH0TSAal7Mag/8HLAGr8MGq3HJJJX1Zig1uctmgi
         J9NKJ9qfySdiYsttV8rMfC+e8ZA083OWfphKmLHWdWyvRCMpbiq2m5F0tI7rDvGR8BHf
         CdNW54spR4hMyc/hUIOn5JARTFvfr54La0p9PJn4Jb544+PpVyFNywJPuflVxa9Q35Jk
         HyyxZVbhTfAcl52XJnKybhsmCJrkiSbHHG3LG/XpuPXflrvzuk1YW8rmK8HlJ8en8QVi
         amBWb0k1Dz6MrNmXENqesghoGi/08/RZW0WrJN86xrCxyhzDxTY46GceS8QEiDkj7sHB
         zVGg==
X-Gm-Message-State: AOAM533dHS/zt4LlYpusIzIp36qfC4c1/fvuLl81kAxdSMfC6Ph7gvGa
        26Q/eR0UaQCjEBStCQ/FWf8=
X-Google-Smtp-Source: ABdhPJzoEXeky1ccjoRjswX2iSVCiHGGgO5qpMS3a8cTsDPqN3COE0NMPJMpHPR0SWcC6Pi1mFPc+w==
X-Received: by 2002:a50:fd09:0:b0:416:1a9c:d7b with SMTP id i9-20020a50fd09000000b004161a9c0d7bmr912701eds.78.1646852189507;
        Wed, 09 Mar 2022 10:56:29 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ky5-20020a170907778500b006d1b2dd8d4csm1027568ejc.99.2022.03.09.10.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 10:56:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nS1U3-000C7P-Hq;
        Wed, 09 Mar 2022 19:56:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v4 2/4] core.fsync: introduce granular fsync control
Date:   Wed, 09 Mar 2022 19:50:15 +0100
References: <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
 <7a164ba95710b4231d07982fd27ec51022929b81.1643686425.git.gitgitgadget@gmail.com>
 <xmqqr18m8514.fsf@gitster.g> <xmqqy22u6o3d.fsf@gitster.g>
 <CANQDOdfVg4e=nLLAynm261_R5z+rjZV3QgE8nLwGEmj1wQm_uA@mail.gmail.com>
 <xmqqczjt9hbz.fsf@gitster.g>
 <CANQDOdcRM-GdxQ6iiV6pSBZifzpn+vJrBi0f88um9Rk4YJMFng@mail.gmail.com>
 <xmqq35kp806v.fsf@gitster.g> <Ygn/GvLEjbCxN3Cc@ncase>
 <xmqqh7914bbo.fsf@gitster.g> <YiiuqK/tCnQOXrSV@ncase>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <YiiuqK/tCnQOXrSV@ncase>
Message-ID: <220309.867d93lztw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 09 2022, Patrick Steinhardt wrote:

> [[PGP Signed Part:Undecided]]
> On Mon, Feb 14, 2022 at 09:17:31AM -0800, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > To summarize my take: while the degree of durability may be something
>> > that's up for discussions, I think that the current defaults for
>> > atomicity are bad for users because they can and do lead to repository
>> > corruption.
>> 
>> Good summary.
>> 
>> If the user cares about fsynching loose object files in the right
>> way, we shouldn't leave loose ref files not following the safe
>> safety level, regardless of how this new core.fsync knobs would look
>> like.
>> 
>> I think we three are in agreement on that.
>
> Is there anything I can specifically do to help out with this topic? We
> have again hit data loss in production because we don't sync loose refs
> to disk before renaming them into place, so I'd really love to sort out
> this issue somehow so that I can revive my patch series which fixes the
> known repository corruption [1].
>
> Alternatively, can we maybe find a way forward with applying a version
> of my patch series without first settling the bigger question of how we
> want the overall design to look like? In my opinion repository
> corruption is a severe bug that needs to be fixed, and it doesn't feel
> sensible to block such a fix over a discussion that potentially will
> take a long time to settle.
>
> Patrick
>
> [1]: http://public-inbox.org/git/cover.1636544377.git.ps@pks.im/

I share that view. I was wondering how this topic fizzled out the other
day, but then promptly forgot about it.

I think the best thing at this point (hint hint!) would be for someone
in the know to (re-)submit the various patches appropriate to move this
forward. Whether that's just this series, part of it, or some/both of
those + patches from you and Eric and this point I don't know/remember.

But just to be explicitly clear, as probably the person most responsible
for pushing this towards the "bigger question of [...] overall
design".

I just wanted to facilitate a discussion that would result in the
various stakeholders who wanted to add some fsync-related config coming
up with something that's mutually compatible, and I think the design
from Neeraj in this series fits that purpose, is Good Enough etc.

I.e. the actually important and IMO blockers were all resolved, e.g. not
having an fsync configuration that older git versions would needlessly
die on, and not painting ourselves into a corner where
e.g. core.fsync=false or something was squatted on by something other
than a "no fsync, whatsoever" etc.

(But I haven't looked at it again just now, so...)

Anyway, just trying to be explicit that to whatever extent this was held
up by questions/comments of mine I'm very happy to see this go forward.
As you (basically) say we shouldn't lose sight of ongoing data loss in
this area because of some config bikeshedding :)
