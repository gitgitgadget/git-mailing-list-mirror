Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357EEC77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 21:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239537AbjELVlw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 17:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbjELVlv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 17:41:51 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DFB5FFF
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:41:49 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ac8d9399d5so96136611fa.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683927707; x=1686519707;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5jup8VwsXtNW120wo48v2rddE/ynq7Zabohk6neug+I=;
        b=iQqngAW8Z8qFuWVbcs1hF6sMx/gogb1FABWVAeNbp40KschjL6D7xYtwmrdUBEB4gs
         VWP23dTOkQXLoqiWI9rmEqsGXxvOBLZl7I6p7NGSdYLskbquQmmWXrm3nW+iYqnjSjNt
         kjUHhcljE3P8d6dnBdayiHqUqgD0AC5L+bqGvgnvdHbiiiZ/Kl7D9zeuIE/N5imylhp4
         6gF2gq5Co8wjqCELXErMs2ITk4zKLjXhCtCImRCT+RiZYoaqOZolQGtmVFVulellthwn
         br5hFZ6Sb80kw5dKmIqJFCRJsBIcF80Dxy0Cxw6pQ4IX3ZiVpLMmmTOiAsb9fOJX+eYC
         NcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683927707; x=1686519707;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jup8VwsXtNW120wo48v2rddE/ynq7Zabohk6neug+I=;
        b=W9+RZu7LDqIYcNoykAZsKc4fFlo8wAlqRVj1QTFPE9+schLZnkI1S042OnLLYyb57U
         JQc2VFj6jDZpCKbAzd/fxvhuhIN5w9Ifndn34W62BbBGed0uP8ukFH6kH+O8t7oKM8IS
         EX5fkjW+L9mvUbe6iYogQXg7i2ciBEWJvsrci+f7BZdh2y2Obhe2eexRk4LwzvBlCbVS
         36HNzb7GO+SpIZI6osENIrJm8+VTwiKxlRFMx7PozK78YZ/Hh9fdJ2a3LW42InYZaKab
         mupDdGbeL8L99hQ95+yUtBOfL183zcuKtQ+XJcCH2Bzze10i2DJhVc8ZUQ8XYYc5AAwg
         pw/A==
X-Gm-Message-State: AC+VfDwJQBx3ZVOhWGG8O9zMoIZE1REQOLqjdo3YFPtp5+/iap6tDKVm
        wJEncddtq1wlGO9/GG6f+TXVix5maCs=
X-Google-Smtp-Source: ACHHUZ4Pa5GHwW++q7rA9JWfeWfeT/i5m9Iogj/9B/83D4NBy3n0y9l87X+zNwBe0A7nnPR+O2Posg==
X-Received: by 2002:a2e:9004:0:b0:2a8:b37c:17f0 with SMTP id h4-20020a2e9004000000b002a8b37c17f0mr4678771ljg.4.1683927707086;
        Fri, 12 May 2023 14:41:47 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j11-20020a19f50b000000b004edbc0eb509sm1598279lfb.16.2023.05.12.14.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 14:41:46 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Can we clarify the purpose of `git diff -s`?
References: <645c5da0981c1_16961a29455@chronos.notmuch>
        <871qjn2i63.fsf@osv.gnss.ru>
        <5bb24e0208dd4a8ca5f6697d578f3ae0@SAMBXP02.univ-lyon1.fr>
        <4f713a29-1a34-2f71-ee54-c01020be903a@univ-lyon1.fr>
        <xmqqo7mpqy6g.fsf@gitster.g> <87h6shif6q.fsf@osv.gnss.ru>
        <xmqqv8gxpd8r.fsf@gitster.g>
        <645ea15eca6fa_21989f294f5@chronos.notmuch>
        <xmqq1qjlp98j.fsf@gitster.g>
Date:   Sat, 13 May 2023 00:41:42 +0300
In-Reply-To: <xmqq1qjlp98j.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        12 May 2023 13:47:56 -0700")
Message-ID: <877ctdi5wp.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:


> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> So your rationale to reject a perfectly logical behavior that *everyone* agrees
>> with is that it might break a hypothetical patch?
>
> Everyone is an overstatement, as there are only Sergey and you,

Sorry, do you actually expect there is anybody here who disagrees that
--no-patch logical behavior is to disable --patch? I thought you, in
particular, have already agreed it's exactly "perfectly logical
behavior". So there are at least 3 of us who explicitly agreed it is,
and nobody who stated his disagreement. No?

> and as we all saw in public some members stated they will not engage
> in a discussion thread in which you were involved. In addition, at PLC
> I've seen people complain about how quickly a discussion that involves
> you becomes unproductive---they may have better sence of backward
> compatibility concern than you two, but they are staying silent (they
> are wiser than I am).

The above statement with the word "everyone" was not about backward
compatibility, where we obviously expect different opinions from
different people.

As for the sense, maybe there are people out there who do have better
sense indeed, but then maybe some of them keep silence out of agreement?
For what it's worth, @work I do have to maintain CI that is 600-pages
long document and to take care of backward compatibility, so I do have
at least some experience in this field beyond Git, and I do sympathize
the conservatism in this field, and only argue about practical
thresholds.

As for backward compatibility itself, what I see as a problem is that
the criteria of when backward incompatibility is to be considered a
show-stopper, and when not, are unclear and look entirely voluntary from
here. At least I was not able to correctly predict the outcome so far,
that is rather discouraging.

[...]

> I am *not* shutting the door for "--no-patch";

That apparently confirms that you still do consider it "the perfectly
logical behavior".

> I am only saying that it shouldn't be done so hastily.

I won't even try to insist on immediate fix, though I still don't see
why shouldn't we just do it while we are at the issue, and be done with
it.

> Indeed "--silent" or "--squelch" is one of the things that I plan to
> suggest when we were to go with "--no-patch is no longer -s" topic.

While we are at this, may I vote against "--squelch", please? For me
it'd be undiscoverable, as it's the first time I ever hear this word in
such context. Moreover, from the meaning of the word I'd expect it to
silence output unless the size of diff exceeds some limit, that in turn
makes little sense. Or maybe it makes some sense? Hmm. "Show me only
diffs that are more than 10 lines long". It'd be entirely different
option anyway.

Thanks,
-- Sergey Organov
