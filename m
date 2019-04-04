Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AB5F20248
	for <e@80x24.org>; Thu,  4 Apr 2019 09:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbfDDJcj (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 05:32:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38353 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732795AbfDDJci (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 05:32:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so2857149wro.5
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 02:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kHucCFByV8wgravKwQg1iq43bPq2NAR91PY+b1HEPio=;
        b=Q35PPwhEkE8xx2qwbdQyayUH5Ed27Sq1Sc2uTtMZdpAG3csFxKiBDkaEx+qLMFNQJA
         hZhzMAMN3RY3h99nx4rDJzgrVijagvMcnoza/o8UAnfiVNvCRdfPq/wx5GSRVbFontUh
         3m6y6m4+iBSk9m710glIC+IpHQFEEQ5i/D+Tmq1aN5EowPbIw+g1Cb2InTbDV57I6EnW
         z7vtRAvAcDcmZHBwt5d+/QlH6LvR6xe9qiHplpM7cLSGQHQMc8XLcYICptlJ8jLaFNuN
         r3b6qS6qYTP6eHZW7QG6kC7ogGJvGnlcCGZYr82L8wByYEKVwnqyBUvTxrRHUoGGfYZG
         +nRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kHucCFByV8wgravKwQg1iq43bPq2NAR91PY+b1HEPio=;
        b=n/Uyu6hsX4kTAbBSSS+l6rgAeFIL9qdSLmFmyrHibLEskxAfjqA/SwSKkCNccz4IZM
         opRSh4TxyWJT0hErK4+xI1H29bTw/dl9i0C06c3gss4yKOwYi9SsmmGBPUEF9BuseNiJ
         tXEb77i12DncqJq5E7XXpEt8R4QOk/+Lpg2jLMIxbOiiClTX+YHz7iPIZBWxnkvpbcZo
         K0TzquGtD87QxVc+xjvE+PPRz5NkPgBLFUTyK454lKBmrIDLsA6tHQlfnGGpIUapGH6l
         gfJdqIDgBD6simt89uE0NL/pUo2zNikRxcSaZHrM4w90/r7C31wNDJ3qfoOhbpg322dU
         if4g==
X-Gm-Message-State: APjAAAU9rN1dtWJPA7inPB5xwMuCihbgD3k+T6zRW5Sa1uGlS5a8/mmt
        VsC7A8zmQV3nADUzfNZJjrJAnnNxrpY=
X-Google-Smtp-Source: APXvYqwtr6fQ0m+QymxYSerj07GZlp7SylJ5blKeFgKzYMyjs/EQKNd/42ty4v8c5SnD+ZQ9OtmJAQ==
X-Received: by 2002:a5d:6706:: with SMTP id o6mr3489737wru.36.1554370356450;
        Thu, 04 Apr 2019 02:32:36 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 84sm33645602wme.43.2019.04.04.02.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 02:32:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2.5 2/2] tag: prevent nested tags
References: <1bd9ee28bc8726490ec0a93286056beeb147fc49.1554183429.git.liu.denton@gmail.com>
        <20190402230345.GA5004@dev-l>
        <xmqqzhp7sfw4.fsf@gitster-ct.c.googlers.com>
        <xmqq7ecbscay.fsf@gitster-ct.c.googlers.com>
        <CAHd499C9g3yPvs=wuaSuLrW=R09yjT5DcKHfpH9=PYYkAcpuhg@mail.gmail.com>
Date:   Thu, 04 Apr 2019 18:32:35 +0900
In-Reply-To: <CAHd499C9g3yPvs=wuaSuLrW=R09yjT5DcKHfpH9=PYYkAcpuhg@mail.gmail.com>
        (Robert Dailey's message of "Wed, 3 Apr 2019 13:26:51 -0500")
Message-ID: <xmqqbm1mf74c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Dailey <rcdailey.lists@gmail.com> writes:

>> > more clear in the doc and/or in the proposed log message what
>> > practical downside there are to the end users if we do not stop this
>> > "mistake", that is.
>>
>> Having said all that, I can sort-of see that it may make sense to
>> forbid tagging anything but a commit-ish, either by default, or a
>> "git tag --forbid-no-committish" that can be turned on with a
>> configuration.
>
> I don't really understand what part of the change is a negative for
> you. Are you saying that `git tag` should peel the tags for you? Or
> are you saying you don't like nested tagging to be opt-in and an error
> otherwise?

No, no and no.  I am saying "git tag -a -m 'message' tag anothertag"
that creates a tag that points at another tag is perfectly fine.
