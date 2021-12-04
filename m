Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF1CC433EF
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 10:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344355AbhLDKnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 05:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhLDKnH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 05:43:07 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B570CC061751
        for <git@vger.kernel.org>; Sat,  4 Dec 2021 02:39:41 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso4627561pjb.0
        for <git@vger.kernel.org>; Sat, 04 Dec 2021 02:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=rPx/Nfbcyd3NHTfN+Fl3jLWWd+PwgsP+Yvuhl2/qZTo=;
        b=kHAvDpMcvV/JOhLr1JEo2wgBXKowRJjm8NyyKwQBCeiqbOwaP32sHuFyts9WsRQzyn
         bTEFZy68R19ErMoSAFejvQnQVWDXb2m+BK86man9TE8R/3gpHn2T3cCg8GZ0eZBYfAtb
         08o9zYh4zxvjGweTimWf7M3qhONdekJd3OAK8abC5oLN5CUwSwALNevkEvczzxEF9smt
         tLugYxK/5RzXFBZ/c3vZH455YvwiMi6GLopMnsftRKAqVsvJDdwp/qT/JdBp9EBxLj9i
         aAoNbFBKSJGpFdHpz9l3dsnGo8ML1UWBizwOHwvZ2UBzk7K0FIc+s3rh6gcXUU3Aeu7d
         xPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=rPx/Nfbcyd3NHTfN+Fl3jLWWd+PwgsP+Yvuhl2/qZTo=;
        b=dgG8ITEcC61nqAB8t2Aa/4KhRQZlKqH+lmVa+HTjplgARUa5oJsZvLZqqhVs4CJLSi
         CFxzrhvPApxIdrZwZROzkJJodybpiWojpY/wogdFace3iHUfSxJxaey9nJBMIf7RJFjF
         ol/j2RnN3rmfYpmWDKGGf9jNEvOqOYb+siQNx66/lp64FcE9YlC5q+5IaP6fy53mkfes
         9qpmrcTsFMLzWRvCgUfdUtZAvwJnGnL4kwSFNEX65Fy8NB8sDCx2ZKRzAw3D9GGIGzZF
         aqFQ1Dfu0uSVLfCMXXkd3BVpsiZhDxSGww5dzhmFiaP+0H1YR/1DR/7/EqeSvEyPbgFU
         QfeQ==
X-Gm-Message-State: AOAM532Z5vJ0J+Hb2S4xfjIK3SX0eeMJhYzKH4p7QdEASXvIo9KnWy1f
        8fentNLULP2mJjr3HogaeiM=
X-Google-Smtp-Source: ABdhPJzhKEt6zzGmm9ZzvvDogamBzqCTP37oqygxS6JBO84s/3ScRaruUo+b5q7yxxYimuP9JZQtjA==
X-Received: by 2002:a17:902:8e87:b0:143:759c:6a2d with SMTP id bg7-20020a1709028e8700b00143759c6a2dmr28617982plb.59.1638614381203;
        Sat, 04 Dec 2021 02:39:41 -0800 (PST)
Received: from atharva-on-air ([119.82.107.61])
        by smtp.gmail.com with ESMTPSA id d17sm6206373pfj.215.2021.12.04.02.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 02:39:40 -0800 (PST)
References: <20210916103241.62376-1-raykar.ath@gmail.com>
 <20211013051805.45662-1-raykar.ath@gmail.com> <xmqqczo8eahl.fsf@gitster.g>
 <YWiXL+plA7GHfuVv@google.com> <xmqqfsr9secx.fsf@gitster.g>
User-agent: mu4e 1.6.8; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: Re: [PATCH v3 0/9] submodule: convert the rest of 'update' to C
Date:   Sat, 04 Dec 2021 16:08:41 +0530
In-reply-to: <xmqqfsr9secx.fsf@gitster.g>
Message-ID: <m2ee6swt5p.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> writes:

> Emily Shaffer <emilyshaffer@google.com> writes:
>
>> On Wed, Oct 13, 2021 at 05:05:58PM -0700, Junio C Hamano wrote:
>>>
>>> Atharva Raykar <raykar.ath@gmail.com> writes:
>>>
>>> > I have attempted to make a version of this series that is based on that topic [2],
>>> > and added the superproject gitdir caching code in C [3]. It passes the tests,
>>> > but I am not too confident about its correctness. I hope that branch can be
>>> > helpful in some way.
>>> ..
>>> The "C rewrite" of the code [3] that unconditionally sets of the
>>> submodule.superprojectgitdir varible seems straightforward enough.
>>>
>>> Emily, how solid do you think your "superproject aware submodule"
>>> topic already is?  Would it be stable enough to build other things
>>> on top, or is it a bit too premature?
>>
>> As of the version I sent today
>> (https://lore.kernel.org/git/20211014203416.2802639-1-emilyshaffer%40google.com)
>> I think it is stable enough to build on top of. There was general
>> consensus on the semantics of submodule.superprojectgitdir as it's sent
>> in v4.
>
> Does the above statement still hold true today?
>
> And more importantly, Atharva, are you on board with the plan Emily
> suggested to have this one built on top of her series?

Yes, I am on board with that. I have not been closely following their
series, but the places where it clashes with this series are minimal,
and look quite easy to port later to C. So I'm totally fine with it.

> Thanks.
