Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975E3C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 14:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiLSO3V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 09:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiLSO3U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 09:29:20 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9F7FD
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 06:29:19 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id v11so9235946ljk.12
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 06:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k1sA2cx6Vbanf6dme00N0/8km3XxTVzD+35onaRlH8E=;
        b=A/xlFXyfvrH2z+PjgacYhV3eiVpZsj34uIxDuLr/lhkU4/WKnZRVNL0K2pW+2hRjjn
         9Sjj59/2H0KC2crgo60hLAYq2u7tuFUmOrom8W8ss7kOI6Bx86ujedI/Bu9Oqk+2URJp
         cdxg8jtmSlKlfVWX+ezLSTTyQogj2iVxUF2scCZgayWvIDtzKhJDLqYEqdalkrk4aiy7
         ZZsjrvUybMxpuz2ltFn0HHRSF3MEsPFK7spwBZdM1PqG6oq0SvXZ/QOKvYQHlAYHpkJ3
         xqgfTMkK8RHXbhQLGhG6IUV4fSUlH0EQPRjosGYlm56fvRYqPptAVj/7Cw5XnMuwIE5R
         IOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1sA2cx6Vbanf6dme00N0/8km3XxTVzD+35onaRlH8E=;
        b=1QqbaPUluNtP3vv2l+h259dfG4w/EuDJlKTJZTAkylcKO39ukIur850X+WgUWEFz1w
         HsnrtoY8z9g9gMwRXSQY+IimpgN1vFVPYI5QuNBZFoO9Vx9WxSK5qr1Jkj8QeTaJHyuG
         DtzcHbuzTg4K1hyOhQtdKwzCpAAA0k8/m8mlPadVjtE2I9HkA89dsZ9/6zqDcM8cWMaF
         W/KQz4b71SEI/pEHQ74c7JHtCkxIOf7ewKbzytck6c6YuliBfb4U0RJ89YhP7RXZRYgA
         CseFKi+V4YYDgZgATlqWYp+8+0LRYk/stCNePw+z4waNtkB/0mlBG8V2RrE4al1zSe+M
         7Zwg==
X-Gm-Message-State: ANoB5pkdMfILn28OPE9KDqTTa072yiwEKlQJNMnq+zJ4avm2bdfumcNi
        grPHDsKhjhSBRyJwhfd4a7tGc477Eqk=
X-Google-Smtp-Source: AA0mqf7cnvxbdkDmsbnO+xcEeAYnCWf6L8rvU4BO2mIU/CW5auquehxmc4hcsrPNZdv6hOf0ADcl/w==
X-Received: by 2002:a05:651c:1608:b0:279:c:c1a3 with SMTP id f8-20020a05651c160800b00279000cc1a3mr9714230ljq.5.1671460156811;
        Mon, 19 Dec 2022 06:29:16 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id v9-20020a2ea609000000b0027b52a73b47sm771010ljp.18.2022.12.19.06.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 06:29:16 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v1 0/5] diff-merges: more features to fix '-m'
References: <kl6lilimepli.fsf@chooglen-macbookpro.roam.corp.google.com>
        <20221217132955.108542-1-sorganov@gmail.com>
        <xmqqbko1xv86.fsf@gitster.g>
Date:   Mon, 19 Dec 2022 17:29:15 +0300
In-Reply-To: <xmqqbko1xv86.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        18 Dec 2022 12:10:33 +0900")
Message-ID: <87bknzfow4.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> > Sergey Organov <sorganov@gmail.com> writes:
> > * implying '-p' by '-m' by default broke some legacy uses of
> >   "git log --firt-parent -m".
> 
> ... like so.  Without learning from the experience, we may repeat
> doing the same thing over and over and expecting different outcome,
> but it would not give us a very good end-user experience if it
> breaks them every time we try doing that.

The experience tells that this form was likely the only useful form of
using -m, and then it has been obsoleted for more than two years
already, since --first-parent started to imply -m:

https://lore.kernel.org/git/20200728163617.GA2649887@coredump.intra.peff.net/

[...]

> IIRC, the previous round (why is this round marked as v1, by the
> way?)

Well, everybody knows indexing always starts at 0, right? ;-)

Now, "git format-patch" has the --reroll-count=N, and as that was the
first re-roll, I've used "1" for that. Is this my mistake?

> was reviewed by some folks, so lets wait to hear from them
> how this round does better.

Yes, correct.

>
> Unfortunately, I do not think of any "solution" that would avoid
> breaking folks, if its end goal is to flip the default, either by
> hardcoding or with a configuration variable.  IOW, the other one
> among the "two problems" in the previous round sounds unsolvable.
> We should question if it was really an "issue" worth "resolving",
> though.

Dunno, but similar issue with --cc apparently was worth resolving when
you've changed its behavior back in 2015:

https://lore.kernel.org/git/1440110591-12941-3-git-send-email-gitster@pobox.com/

The '-m' not behaving as people expect is an issue that I'm trying to
solve.

Thanks,
-- Sergey Organov
