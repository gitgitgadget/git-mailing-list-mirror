Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D53C636CC
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 08:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjAaIxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 03:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjAaIxG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 03:53:06 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7E44DBC8
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 00:49:02 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ud5so39485530ejc.4
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 00:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xVny3ImcWLzAeFXkkh+XzK8WRZiAQHKSPcxxtkJkpCU=;
        b=PlAbMNJd2Ldp6+PEQUz0TxvIJY1T2MVkQ3zuAYbLlrKejiDodEXudt4Aj3+iajff2x
         t2T1j+UW83oEscgGLA/4xuofnxHrKcBeZ+lNDbWhwArti0SJ24FACx9pcP1HJQzjrhlt
         8VYGZ0txApeWR2sor9rgXhnvusK4/aMNv5DlAXerGXP3q9nmdPywZt/o2DxAwPlBYH25
         swt+coc+ORAADymaZ8EidSkW10lRk2DlEffX3jNHwgeqz/66n67WMabJ8TbtZcNAWTGT
         Z2IbTa9xnIRuW2D+Ammy/HIih/D25sJVB3yrQNdsbVOf0EJx4NdHpgpiN+AzWyBbPf67
         crXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xVny3ImcWLzAeFXkkh+XzK8WRZiAQHKSPcxxtkJkpCU=;
        b=Q05cTSWT1SPalKait3EjSICZXrc0lq9G12zS0SZgT5PWj5Et7bScxEQi/SFgWckv+l
         GACug4tvGgPR7p0EepqAnnVuZwxu4AEzBk8PeFbPua96/mA5jAKg3yzviYwJVBw+5t5n
         RuJQFMEI8+s4O6cAb/QuQIGti+mHoCXekvnErP5j6L/NMwj/RkBucZROqV8AHGbSZdzc
         SHQq+hk8SarAdZQ28PKlHEhI+iMQF3r9oEQytjsHEbt0hnIWcKj6RepObizAIhi5BlKV
         fk7Jm6Sf82yRwFw2RiaWmA6ko+I2jaifIlxUpifKTw7guVbC82uuf58x4J6MABkRae4Z
         Prkg==
X-Gm-Message-State: AFqh2ko7VZr3FEwR4npMyE2dxzjRS1m9VpmOc4r1OyCow//tWzmEPMv5
        dmUEae0Vak607vEzh8DESs8=
X-Google-Smtp-Source: AMrXdXtbArHxOScHdBJrOw0gGt42iarn6WKlwvdVjNk5IkRsH7tek7J5kN0HgXb5lJkiGaH7xm3G3Q==
X-Received: by 2002:a17:907:6c16:b0:84d:4493:c83f with SMTP id rl22-20020a1709076c1600b0084d4493c83fmr60615812ejc.6.1675154872254;
        Tue, 31 Jan 2023 00:47:52 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id q6-20020a1709064cc600b0084d494b24dcsm8050042ejt.161.2023.01.31.00.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 00:47:51 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pMmIx-001w4a-13;
        Tue, 31 Jan 2023 09:47:51 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mathias Krause <minipli@grsecurity.net>, git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2] grep: fall back to interpreter if JIT memory
 allocation fails
Date:   Tue, 31 Jan 2023 09:34:34 +0100
References: <20221216121557.30714-1-minipli@grsecurity.net>
 <20230127154952.485913-1-minipli@grsecurity.net>
 <xmqqbkmk9bsn.fsf@gitster.g> <xmqq1qnfancf.fsf@gitster.g>
 <adb5a43a-5081-4f60-d1ea-2a6511f858c0@grsecurity.net>
 <xmqqk0156z55.fsf@gitster.g> <230130.867cx4s2j4.gmgdl@evledraar.gmail.com>
 <xmqq8rhj504i.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <xmqq8rhj504i.fsf@gitster.g>
Message-ID: <230131.86y1pjqedk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 30 2023, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> If I compile libpcre2 with JIT support I'm expecting Git to use that,
>> and not fall back in those cases where the JIT engine would give up.
>
> The thing is, the reason why their Git has JIT enabled pcre2 for
> many users is not because they choose to compile their own Git for
> themselves because they wanted to play with JIT.  To them, their
> distro and/or their employer gave a precompiled Git, in the hope
> that with JIT would be faster than without JIT when JIT is usable.
>
> In that context, "Speed is a feature in itself" is correct but
> "failing fast, forcing the user to try different things" is not a
> "Speed" feature at all.  It may be interesting only for those who
> are curious to see what pattern was rejected by JIT.  It is
> especially true as (1) we are willing to fall back to interpreter in
> the SELinux senario, and (2) for normal users who want to use Git,
> and not necessarily interested in playing with JIT, there is no
> other recourse than prefixing "I do not want this JITted" to their
> pattern ANYWAY.  Why fail fast and force the user to take the only
> recourse manually, when the machinery already knows what the user's
> only viable alternative is (i.e. falling back to the interpreter)?

Because we have an issue with (1), but not (2). How would (2) happen? So
far I've only seen intentionally pathological patterns designed to
trigger the JIT's limits. I don't think it's worth DWYM-ing that path,
when we're having to assume a lot about the "M" part of that.

>> Pathological regexes are pretty much only interesting to anyone in the
>> context of DoS attacks where they're being used to cause intentional
>> slowdowns.
>
> Exactly.
>
>> Here we're discussing an orthagonal case where the "JIT fails", but
>> rather than some pathological pattern it's because SELinux has made it
>> not work at runtime, and we're trying to tease the two cases apart.
>
> s/and we're/but you're/.  And I do not think you want to.

That s/// is fair, but brings me back to my question above of why we're
trying to solve (2) here.

>> I don't think this is plausible at all per the above, and that we
>> shouldn't harm realistic use-cases to satisfy hypothetical ones.
>
> To me, what you are advocating is exactly the hypothetical ones that
> harm end-users who did not choose to enable JIT themselves.  When JIT
> fails for whatever reason (including the SELinux senario) for them,
> they do not need to be told by Git failing, when the interpreter can
> give them the correct answer.  Wanting to see the result of the
> operation they asked Git to do, while allowing Git to use clever
> optimizations WHEN ABLE, is what I see as realistic use-cases.

I'm saying that the "JIT fails for whatever reason" is
hypothetical. It'll fail because of:

 - The (1) case, where we're categorically unable to run the JIT. Then
   we should proceed as if the JIT isn't available (as we do when it's
   e.g. not compiled into PCRE).

 - The pattern is pathological enough that it's about to take eons to
   execute it (2).

   The lack of bug reports about "hey, my existing 'git grep' pattern
   failed" when the JIT was shipped with v2.14.0 shows that this doesn't
   happen in practice.

 - The case where the API is returning some new error code that's
   unknown to us, let's call that (3).

