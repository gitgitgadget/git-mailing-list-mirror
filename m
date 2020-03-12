Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F34C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 12:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF70206E9
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 12:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID9/TynT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgCLMRg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 08:17:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42930 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLMRg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 08:17:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id q19so6112896ljp.9
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 05:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=5I+6NN8Inbb3O40OHIQYRwJp3iyEGeDU9NJPrMyKIXU=;
        b=ID9/TynTQt+1fIEH+0lY65oCmu9e2323y+UMUgAQhlVPW3cefScYnD3nY4bZlK33ja
         7mmBKeUHAh9ayk/DGz9LqmGxfQ3IqjqzFiAZPAMkZekW4qml3vR/e1rYVZ+8yzPogeH2
         Nc24apAlQGv15Oz3TU5QWawQ5Bxm3h0vZ1I1rmGlLZoVXJ202tMzPD39olxKfyDLQXvz
         ZPOoIwqSSRV4n+Sw4OZ8DEaz2xYpdTQn+9gXj7ySN5JdLqd4mPsaKO+/SY7PjJ4zVM9X
         ftBZLbBBRsfhcsl3tgQWOZXjuyb4izX//2SUI4iGZRCQC+8XVxg5J8cZNQ/Z91CjYq3u
         tL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=5I+6NN8Inbb3O40OHIQYRwJp3iyEGeDU9NJPrMyKIXU=;
        b=NbOhax948lTu+loW6OjcV0NUQN5qv2x6KBm6Kf8iNrVKpGVI/pgjvdZcoZHXZiRKzk
         jA1OHnUUgB7f2SsmjlE/4SHqALDo74pB0HzFUeUJrQKP+oh8enSLK1nD5GU+FyZakWI+
         Zavmo6hJZfFBYRKfWTPWNND0W8aKO9sArR0X/RzoVH5+q+CTT0TTHJNUNiUk4bkCqccH
         1RsX01X87sHS7luj6POJuTrxZUGLD9VoIgxkyXmFG6RvXgOceN9ZuDjNsYV7kTFG+7nY
         wktkls5DKiJhJ4RbctiHTzbctFQregfJo0mLGTug5w7IxVEym+9q9P4CDQyeJ4JunR+j
         8W/w==
X-Gm-Message-State: ANhLgQ0qW3LoFDwfFuZah7ai1Sdgsot5lZbI9EuSL2wzV7bd7LUjeiEv
        mx7KqiA+LHkDwJ7eHiQXooA=
X-Google-Smtp-Source: ADFU+vt31oOazlY9LUje8kBxXGBI9O3xuJ0eIkgb0vO+bu9PPtYrLtoXe0s5etwbjDepNyGE6QcOMQ==
X-Received: by 2002:a2e:3c01:: with SMTP id j1mr5018363lja.175.1584015454481;
        Thu, 12 Mar 2020 05:17:34 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id b4sm22598427lfb.47.2020.03.12.05.17.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Mar 2020 05:17:33 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [RFC] Possible idea for GSoC 2020
References: <86mu8o8dsf.fsf@gmail.com>
        <CAP8UFD31+sK5zyLLgkOvJ4fj=PC3FTa9nXcpPeM-fWm9ByoKjQ@mail.gmail.com>
        <86eety4m1m.fsf@gmail.com>
        <CAP8UFD0cLrxic6tjGC5UQjX1pNHBzZhVyoddWbhETReFaLK4nw@mail.gmail.com>
Date:   Thu, 12 Mar 2020 13:17:30 +0100
In-Reply-To: <CAP8UFD0cLrxic6tjGC5UQjX1pNHBzZhVyoddWbhETReFaLK4nw@mail.gmail.com>
        (Christian Couder's message of "Wed, 11 Mar 2020 22:48:23 +0100")
Message-ID: <868sk54vj9.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Christian Couder <christian.couder@gmail.com> writes:
> On Wed, Mar 11, 2020 at 10:30 PM Jakub Narebski <jnareb@gmail.com> wrote:
>
>>>> A few questions:
>>>> - is it too late to propose a new project idea for GSoC 2020?
>>>
>>> I don't think so. Students have until March 16 to submit a proposal,
>>> so they could still submit one based on this even if it's late.
>>
>> If I understand Google Summer of Code 2020 Timeline correctly
>> https://developers.google.com/open-source/gsoc/timeline
>> March 16 is the date when students might start to submit
>> proposals, and the deadline is March 20.
>
> Yeah, sorry about the confusion, the timeline says:
>
> March 16 18:00 UTC Student application period begins
> March 31 18:00 UTC Student application deadline
>
> So technically we could add ideas until March 31, but I think it makes
> no sense, especially as we ask students to submit proposals well in
> advance. So we should give ourselves March 16 as our actual deadline
> to add ideas.

Right.

>>>> - is it too difficult of a project for GSoC?
>>>
>>> I guess it depends on how much you as a mentor would help the student
>>> getting started.
>>>
>>> I think it's interesting and worth adding it anyway. Can you add it to
>>> SoC-2020-Ideas.md?
>>
>> All right, I'll do it.
>
> Great, thanks!

Added with some modifications in commit 6b5edec6557
https://github.com/git/git.github.io/commit/6b5edec6557930888441c626f9272dc=
2be0c769e

>> P.S. I wonder if Derrick Stolee would agree to be co-mentor (if he is
>> not too busy with working on Scalar).
>
> I am adding Heba in Cc as she said she would be ok to co-mentor. Emily
> and Jonathan T. might be interested too, so I'm adding them too.

Added Heba as possible co-maintainer in SoC-2020-Ideas.md.
If I hear from Stolee, Emily or Jonathan T, I can add them too.

Best,
--=20
Jakub Nar=C4=99bski
