Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5691C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 10:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9F9261074
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 10:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbhIKKoJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 06:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbhIKKoE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 06:44:04 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5BFC061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 03:42:52 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id qq21so3745194ejb.10
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 03:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=wQlsv3D2pctZ+8ddGDTkeH2jRTniWr6w6Ai3Hkfo/rU=;
        b=o37I5DQsnp2U4PpIKUhEZW7tsPf7qIeX83acU2poJr5afCP7ahpmr/buwc6aGOZhHm
         q7L56WThLTwt60jXLgD7tFIUPkt6l45RfpdoU4KGAdXBea5DhXKN3EcRoBy0BPhfeyA+
         Dly2mF2etyD7rsGZmxmlmMsaLR7JSBKi9NOSoCrES0etqJ6XMbgYw48NA6REL/avC6nz
         jpurkBjXOmgSwsBbPbiUlA7MiK8vU93K6zWfT3BlVfg1Wx/wi9uXx9tTxmqoMo37tq0r
         9WjuhIIjZlU36VKahxfTxe1GVc88lEO9udaSAzEpwNUjeXcp9ZdDRb40JwfIzmfTPNsc
         66Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=wQlsv3D2pctZ+8ddGDTkeH2jRTniWr6w6Ai3Hkfo/rU=;
        b=POeGMJlUtdrdLyvVnReU1i3WYCwPVMkjYNNDxpwd4JAIsj8vkWFcll8jC0GxPj5J/I
         6SenekHMfeTiwM3TH3iCCe0FqN+iViFXAeJcVEm6d7x9Zytw9wiAdlI1UQUAvvT1uFco
         15JunQKL6GgR3s68kS4pPZHJNLW0OKjWTewFBui7KW9Gto7r1/kIa//5M5QbnOUl9wBP
         fQv+GzJpyf335fXGddDgrBXorH2x4VpjEtoUWCKCWLbsTxm8AKXUVVG+wzZHBdRLR6MJ
         gD7PDgB0SiaBx2ae2n6CZMeIL/9FYZb3v9LrRXU6cssGNgx9Xc1q+TXeOnLCnKVaptud
         zqNw==
X-Gm-Message-State: AOAM530XPjAUYLHVu1p1kl6Kr/Au8l8myRjazgcb1mJvxAtQfNdofF6R
        q8barfbAVNVTHKEepfjzd/g=
X-Google-Smtp-Source: ABdhPJyRtpEYVkbJpJ7cxUuYpvJsSYfzQV0iLitPIRxihNdWLXhirl3IVXlkBhKBP+XCJIPQ/2Visg==
X-Received: by 2002:a17:907:7697:: with SMTP id jv23mr2276178ejc.451.1631356970849;
        Sat, 11 Sep 2021 03:42:50 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ay3sm616893ejb.0.2021.09.11.03.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 03:42:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] notes: don't indent empty lines
Date:   Sat, 11 Sep 2021 12:39:31 +0200
References: <20210830072118.91921-1-sunshine@sunshineco.com>
        <20210830072118.91921-4-sunshine@sunshineco.com>
        <xmqqwno2505w.fsf@gitster.g>
        <CAPig+cQ6FA0rUnkkTDRUD5vAD3cDXW9vtR1oX0pUJK5eJB9CHg@mail.gmail.com>
        <xmqqeeaa4y0v.fsf@gitster.g>
        <CAPig+cQdXp0c+JYthvy+bbr6vLR7nq4pQY3w+CADUtzr+Ang4A@mail.gmail.com>
        <CAPig+cTFbnrPPSZbzihJ9gdGV2c4poXWyNjhK3mnr5_uRwpxbg@mail.gmail.com>
        <xmqqwnnos2jz.fsf@gitster.g>
        <CAPig+cQdAuLkZ0pDK6XOfm_WXCJAOm8Tr19oK14n-Tf7DcfW=w@mail.gmail.com>
        <878s03c1of.fsf@evledraar.gmail.com>
        <CAPig+cQ+qVNBJqHmQgk6D1fbYHHJpAxhfwyBOgevi9Hvs6JYkw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CAPig+cQ+qVNBJqHmQgk6D1fbYHHJpAxhfwyBOgevi9Hvs6JYkw@mail.gmail.com>
Message-ID: <87wnnn8kba.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 11 2021, Eric Sunshine wrote:

> On Fri, Sep 10, 2021 at 9:59 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> >> Eric Sunshine <sunshine@sunshineco.com> writes:
>> >> > Have we made a decision about whether this patch series -- which
>> >> > avoids indenting blank notes lines -- is desirable? Or are we worri=
ed
>> >> > about backward-compatibility?
>>
>> This change per-se seems nice, but even having reviewed it to the point
>> of rewriting parts of it, I didn't really look into what the whole
>> workflow you were trying to address is.
>>
>> So e.g. just to pick a random commit of your for show:
>>     $ git show c990a4c11dd | sed 's/$/Z/'
>> Here we end up also adding the whitespace indenting to the empty lines,
>> whereas if we were trying to feed this to an editor we'd place those
>> later Z's at the start of our line.
>
> I'm not sure what you mean by "feed this to an editor". Do you mean
> sending the output of `git show` to an editor? I'm guessing that's not
> what you mean, and that you instead are talking about editing the
> commit message in an editor (say, via the "reword" option of `git
> rebase --interactive`).

Feed it to whatever, maybe I have a commit message in my terminal I
highlight and copy/paste, my shell/terminal is highlighting line-endings
etc.

I've got a default bias towards trimming this whitespace, I'm just
wondering why notes are a special-case as opposed to our more general
log/notes etc. output.

>> Are notes different? Or are they just similarly indented? For commits we
>> don't insert that leading whitespace in the commit object, do notes get
>> that part wrong too?
>
> Notes don't store the indented blank lines; it's only at output time,
> such as with `git format-patch --notes` that the blank lines get
> indented along with the rest of the note text (just as is happening in
> your `git show` example in which the entire commit message is being
> indented, including the blank lines).

Ah, so with your change we'd end up with trimmed notes, but not the
trimmed main body of the commit message?

We don't have to fix everything at once, just establishing context,
maybe it's useful for format-patch etc. in isolation...

>> It might be showing, but I've only used notes a few times, my main use
>> of them is Junio's amlog.
>
> I also have only used notes a few times.
>
>> So even for someone experienced in git, I think some show & tell of
>> step-by-step showing in the commit message how we end up with X before,
>> and have Y with this change would help a lot.
>
> This all came about due to two unrelated circumstances: (1) a few
> months ago, I configured Emacs to highlight trailing whitespace, and
> (2) I decided to use `notes` to add commentary to a commit since,
> although I normally just write the commentary directly in the patch
> itself after running `git format-patch`, in this case, it likely will
> be weeks or months before I finish the series, and was worried that
> I'd forget the intended commentary by that time, thus recorded it as a
> note. Since I've almost never used notes, I ran `git format-patch
> --notes` as a test and was surprised to see the trailing whitespace on
> the "blank" lines when viewing the patch in the editor.
>
> This submission started as a single patch which just "fixed" the bug
> and added a test. Only after that was complete (but before I submitted
> the patch), did I discover that other tests in the suite were failing
> since the "fix" also changed git-log's default output format which
> includes notes (indented). Since I so rarely use notes, I had either
> forgotten that git-log showed notes or didn't know in the first place.
> The submission grew to multiple patches due to fixing those
> newly-failing tests.
>
> Anyhow, since then, I've discovered that `git format-patch
> --range-diff` also indents blank lines. And you've now shown that `git
> show` does, as well, so the behavior which triggered this "fix" turns
> out to be somewhat normal in this project, rather than a one-off "bug"
> in need of a fix.

Per the above I wouldn't mind this just being changed for all of them,
even one at a time.
