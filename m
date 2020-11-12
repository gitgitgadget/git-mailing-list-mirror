Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B351C2D0A3
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 14:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2159622248
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 14:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NExMLzE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgKLOJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 09:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbgKLOJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 09:09:28 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BB8C0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 06:09:28 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id i19so7887110ejx.9
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 06:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=PxBeOXv0v25C/SKYGP/pcpT8wL/Xp9LRyAUDvbWrOxM=;
        b=NExMLzE9b3wfifUst9IF7+9SApAZ+IqQ7hflukH1MYUvqddyigIz78HWCHbxGFvyvP
         JjIDI45cwOBrYMNnm3BFoUYJT+k5HZXcH7PDcrWxDpnYdlkC77/oDdpLmhJtYMcnBHSb
         npug9IyQzXgrI0I1fGlVqpHg+wZBJ1wE5QAMXe7ai1Edl4tVOz2othxR06vToAatbp0B
         8cfsjTe0LQqWCFno7EEQVRRpKIbe0hmy1l37Ebby3AHZvmnuogJz7Ingi041qQp3Nja3
         yvyFXDugHG4X7rxuek9BuhSvG1Gm3a1gz+9dNcruB0Qbeo4lAR2cilLKZ29EoN5CuFnh
         vaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=PxBeOXv0v25C/SKYGP/pcpT8wL/Xp9LRyAUDvbWrOxM=;
        b=H2VUPrhc4E2F3uNeSTKa9F5amD72o55SJH9qfYT8mCv3xMiSuMWOd8Qbfdcu3SyLnX
         d9oV2D0J7MdCPpybZoNRuGxVccRZmzb8e9R4poWYoAnSFJbSpOkqUdhSGYKLsPTdvXw/
         ECARtM3VcqE5WFueu0u26qa4aQe0us6jFohcwz+wODVQWq2z+sr3cCp4AiyRSVNhEA9n
         m5BUaJ3cLCYT6lHyUQQ0p4Ri+g6jsxuPS5nlt3q990d52BFLWP0NiRb6e12NUc3vqV3x
         sRKnbZ9CMn8f6+2VYlCHdTyzYQZDlBr0tpvX4qQuiM7NXQXSJ2YKaG007T7vMB6yX9Aw
         dbbQ==
X-Gm-Message-State: AOAM532XtranSxFxftQ7D20qUvAbl3U24j34KjlvAeIDgWYBTxz20Y53
        IxxlZqzW26LWXqloQw1IkCo=
X-Google-Smtp-Source: ABdhPJzX8aabq8YFlhfyT7B6BSovZgmkGpg0vb5A04ivo3ibZ3L7EEOIm5SCz8mz/msnyi+B1ndxfA==
X-Received: by 2002:a17:906:180b:: with SMTP id v11mr30181020eje.466.1605190166741;
        Thu, 12 Nov 2020 06:09:26 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id zm12sm2187645ejb.62.2020.11.12.06.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 06:09:26 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH 0/5] Remove now-unused git-parse-remote
References: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com> <20201111151754.31527-1-avarab@gmail.com> <20201111173738.GB9902@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <20201111173738.GB9902@coredump.intra.peff.net>
Date:   Thu, 12 Nov 2020 15:09:25 +0100
Message-ID: <87a6vmhdka.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 11 2020, Jeff King wrote:

> On Wed, Nov 11, 2020 at 04:17:49PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> I started poking at removing .git/branches from the default template,
>> which I had a patch for until I noticed Johannes's old[1] series.
>>=20
>> In any case, this is one thing that came out of that
>> investigation. The code we're keeping by moving it to git-submodule.sh
>> can also be replaced by some C code we have, but I wanted to leave
>> that to another submission (if I'll get to it), and make this simply a
>> code removal.
>
> I'm happy to see unused code go away in general, but this raises a
> question: what promises have we made to end-user scripts about this
> library being available?
>
> We do install it, including a manpage which claims you can do:
>
>   . "$(git --exec-path)/git-parse-remote"
>
> though it does not actually document any particular functions being
> available. It looks like we've removed functions before without warning
> (e.g., 1a92777504 (git-request-pull: open-code the only invocation of
> get_remote_url, 2011-03-01)).
>
> I'm just wondering if we need to have any kind of warning or deprecation
> period.
>
> To be clear, I find it pretty unlikely that anybody is using the rather
> esoteric functions in this file, but that's usually when I get most
> surprised. :)

I think it's fine to just remove it, I'll note that in a v2 commit
message. I.e. the convention at the time was just to create these *.sh
libraries as documented, but I don't think anyone used them outside of
git.git.

If they did maybe we should move them to contrib and ... create the same
bitrot as with the *.sh builtins :)

So I think it's better just to "git rm" it, if it breaks things for
anyone they can just get the last version and maintain it themselves.

>>  .gitignore                         |  1 -
>>  Documentation/git-parse-remote.txt | 23 -------
>>  Makefile                           |  2 -
>>  command-list.txt                   |  1 -
>>  git-parse-remote.sh                | 98 ------------------------------
>>  git-submodule.sh                   |  8 ++-
>>  6 files changed, 7 insertions(+), 126 deletions(-)
>>  delete mode 100644 Documentation/git-parse-remote.txt
>
> I expected to see a "delete" line for git-parse-remote.sh here. I
> thought at first maybe you were leaving the empty shell so that people
> could continue to source it (keeping the promise in the manpage, but not
> providing any actual functions). But it looks like the final patch stops
> building it at all, leaving the now-useless source file.

That was just a mistake on my part, I meant to "git rm" it but
forgot. Will fix it v2.
