Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277DAC433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 16:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F31F260F23
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 16:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhJLQJ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 12:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhJLQJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 12:09:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C88C061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 09:07:54 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y26so90546266lfa.11
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 09:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=46EuIhPsWNsD8X353S6QR/IJe8OqeqVFikhnARWJtHA=;
        b=WCOwK/AUlFpQ1MajOspZKJuK7f3wkCcpMgNvrjZATAFcHp2kJU+S+CWogWJpH9P2Bv
         Id5oP4UM1VJEILqbBkGx4xBQw7ifJYeLuK67rjigCnhnISXnP31/zzvM1cidEFInJnox
         NqtD8O7chVtzI4kZQGlWsIeSxZQSuqSorQ0mKRWWxnIoI9DXLLf/thfHXi5y22cPPISm
         oHnUUEqDHDhFRw+N5hodCs+5DoJRGCpc2QxlA2vpI7QafSdroyCm/qdj9lOLwzzwpAjy
         gohNsdi9+xlmH5ENzTT1k1QRP9v3EM2ceKesGvVU5gOFyK6iCinEZVGtI3WILnyjEHHh
         783A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=46EuIhPsWNsD8X353S6QR/IJe8OqeqVFikhnARWJtHA=;
        b=d/XtsVDUuiKdaf+7m6es6Lmr8l+xTX3Jp08KdxBwjcQga8ASPnCymV2xvDtjySq8mR
         dsb64E0aDUE++uS4SJiSkETYhM36EK/5g2PlpVKPj7TdUruG72eObt1Fe8UuSm5n7//F
         KOvRhDjvQ4tCleTMvBcIlb+dXmZTkhwGLDbs+2WRLAJw3ASy4vGSGorUFejPcmgFYmTj
         Ppbgpzwych0COuH0035b01mlWwc2FMgb4kkPBbxT47829QQaFXefgoXLeTXMIgC7gZth
         GJeSFChr4s2LyZ52AOtwRe9YbbLpNH+sl+GGTP8dYYV+KjUxVLXZEvECAu3z3NUv/hWP
         hUyw==
X-Gm-Message-State: AOAM531q16Xng0TcmzSFWU+rNGOhlTCZ8sF+cYfp5efNI9jAhpoSTuyw
        sWPs71vRFmYYXothkT1iwDXE1M/FNmQ=
X-Google-Smtp-Source: ABdhPJzUiAXtozA7gJeL7Tt6ta5Ts4Fvg2X5mSzxFuPlGOWuNQSnUFqBMfzGhAyzdPv0jO5Fno+94Q==
X-Received: by 2002:a2e:4a12:: with SMTP id x18mr32110758lja.309.1634054872525;
        Tue, 12 Oct 2021 09:07:52 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i27sm222399lfo.173.2021.10.12.09.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 09:07:52 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH RFC v1] stash: implement '--staged' option for 'push'
 and 'save'
References: <875yugcs3l.fsf@osv.gnss.ru> <87lf2zz59w.fsf@osv.gnss.ru>
        <CAPig+cQgZX5U0KThgSKjmgvOvEZWxPF_BovYYe=VfjDvUE5c9Q@mail.gmail.com>
        <87fst7z0oa.fsf@osv.gnss.ru> <87y26yk35r.fsf@evledraar.gmail.com>
        <xmqqa6je8n5c.fsf@gitster.g> <xmqqo87u777d.fsf@gitster.g>
Date:   Tue, 12 Oct 2021 19:07:51 +0300
In-Reply-To: <xmqqo87u777d.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        12 Oct 2021 05:34:14 -0700")
Message-ID: <87k0ii446g.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> More importantly...
>>
>> Whenever I think about a new "feature", I try to come up with a
>> story in which the feature effectively improves the end-user's life,
>> how it fits in the larger picture, and enables something that is
>> hard to do by combining other tools.
>>
>> The kind of "story" I would aim for is like this.  Suppose we were
>> selling not "git stash -S" but "git stash -k". ...
>

[...]

> So in short, I do not think I am strongly opposed to "git stash -S"
> existing, since I did find one use case story that it could be used,
> but I do think it is redundant and unnecessary.

Redundant? Yes. Unnecessary? Yes. Useful? Yes. ;-)

I took the steps to propose the new feature after yet another round of
"how do I quickly store this tiny bit of changes I just figured I need
for later, out of bunch of VIWIP changes?"

  git stash --staged

is exactly the (currently missing) answer for me, as I have pretty
interactive tool to stage diff chunks always handy.

What's your answer, I wonder?

That said, I'm also curious what story, if any, do you have for 'git
stash --patch', as exactly the same story should be applicable to
proposed 'git stash --staged', as far as I can see.

Thanks,
-- Sergey Organov
