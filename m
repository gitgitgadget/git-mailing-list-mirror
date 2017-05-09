Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C97661FC44
	for <e@80x24.org>; Tue,  9 May 2017 01:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbdEIBdm (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 21:33:42 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33640 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbdEIBdl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 21:33:41 -0400
Received: by mail-pg0-f47.google.com with SMTP id u187so35677486pgb.0
        for <git@vger.kernel.org>; Mon, 08 May 2017 18:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mOv1OfmTx1lZWtn2DlIwq4Yvk+oCAe6tfIhhRTyzqFI=;
        b=Sns82p9y7XqkRovQHrG31if4mR38+RU3hrALck4aoQOfSX0ckvb5UHk37D14P+Q4gl
         3r59oPqZWCYNIk9Q7c6pCftVO0LdfsqEo/YOjnDfoR/LxwSuzkLUw5ffzbeATz9izZrU
         eZOuhEz/TaLdo/57Rk1A/prMApgmmAooET2olciLffaZWBhdosgg43s1NiY4UXUCZtq7
         maNqJeOVvacUK0s1JEwgNQBKXd6KTfouNHbqLBzgWw729NEiZKUiozD40HilaerLEzkv
         eHbyMK/9R5xBcPV6pRoCHAhObP4je1ZsrMMy8e0CEKBdZG0eu+Hx9P8hK64fTf4R7UaT
         YIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mOv1OfmTx1lZWtn2DlIwq4Yvk+oCAe6tfIhhRTyzqFI=;
        b=ekaqji5nlIYUkkek4I8vUur1j7pdwUnjQur2/o0Xx12mNvWIQyN6Jmjt4uIzDHjeaw
         oeoyHBXACR9lBVoJkyTHTz6ulEE1InODAd0QXCib4MeipbbWeUMOi/JzAaE4LtQqNgit
         HhyhN3L0pif5oIa7hX3/h4ky6J0CxZwRrcJeKq6m7BHTo1zEoTuK5pvfRelMkp8VKp8D
         iNr0l40h9PFGPXJzkYQkcd/XlFphYpB8iY0YcnnZCDcfF4iojVKBe6wimOauyAgog+dL
         npjOxZ6xIeRtgTnssOU/sQwcWEHeB10rS1feTh27jOz6gQAIP/us9CqV9N/1UoWW6kCh
         Dqfg==
X-Gm-Message-State: AODbwcAmLZvGIB4sXuq1BajQHp0YX9OwpvdpCUZb+f3ws9nhyUdgtz87
        +l0+uC3Ya+qNGA==
X-Received: by 10.98.192.143 with SMTP id g15mr6843773pfk.219.1494293620978;
        Mon, 08 May 2017 18:33:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id r73sm28013391pfa.65.2017.05.08.18.33.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 18:33:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: git-clone --config order & fetching extra refs during initial clone
References: <robbat2-20170225T185056-448272755Z@orbis-terrarum.net>
        <20170225205052.j3p7obbf4onf6cbf@sigill.intra.peff.net>
        <xmqqd1e3xx4c.fsf@gitster.mtv.corp.google.com>
        <20170227211217.73gydlxb2qu2sp3m@sigill.intra.peff.net>
        <CAM0VKj=rsAfKvVccOMOoo5==Q1yW1U0zJBbUV=faKppWFm-u+g@mail.gmail.com>
        <20170315170829.7gp44typsyrlw6kg@sigill.intra.peff.net>
        <CAM0VKjnjMEThuMvLEQByxWvxVvdzMSVsFKKstKLMweEx5UwTcg@mail.gmail.com>
        <20170503202224.arjszzbruxjgpkt5@sigill.intra.peff.net>
Date:   Tue, 09 May 2017 10:33:39 +0900
In-Reply-To: <20170503202224.arjszzbruxjgpkt5@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 3 May 2017 16:22:24 -0400")
Message-ID: <xmqq4lwu7r0s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Good point. We can't really consider clone to be a blind "init + config
> + fetch + checkout" because those middle two steps sometimes overlap
> each other.  It really does need to be its own beast.
> ...
> The right solution there is probably pushing that logic down into the
> transport layer. Or at the very least abstracting it into a function so
> that both clone and fetch can call it without replicating the logic.
>
>> My patch deals with 'remote.<name>.refspec', i.e. 'remote->fetch'.
>> Apparently some extra care is necessary for 'remote.<name>.tagOpt' and
>> 'remote->fetch_tags', too.  Perhaps there are more, I haven't checked
>> again, and maybe we'll add similar config variables in the future.  So
>> I don't think that dealing with such config variables one by one in
>> 'git clone', too, is the right long-term solution...  but perhaps it's
>> sufficient for the time being?
>
> I think your patch is a strict improvement and we don't need to hold up
> waiting for a perfect fix (and because of the --single-branch thing you
> mentioned, this may be the best we can do anyway).

OK, so where does this patch stand now?  It already is too late for
the upcoming release, but should we merge it to 'next' once the
release is made, cook it in 'next' and shoot for the next release
as-is, or do we want to allow minor tweaks before it hits 'next'?

Thanks.
