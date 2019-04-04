Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 288B720248
	for <e@80x24.org>; Thu,  4 Apr 2019 21:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbfDDVyL (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 17:54:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40133 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730743AbfDDVyI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 17:54:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id z24so5118070wmi.5
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 14:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VztEUlpV8zDsFzNQYRGfDaPcGsHwJdhN5D593jj3WPg=;
        b=Us4Q1ffN5ZkfsZb8PG8ZovV6vsHFDJyfkxVQEhpoJ4IJIloDaYQXezjpbRywsgatzX
         ZN91vmBpYKoPU5mO4zrRToaSiwb/IUcTYT3pjgD/DvClVM8Q3xkbKJ+wGP41iiEGI7B2
         ngs8EhLbw8nJ5SMIEvPtiQgkuhR+qqHHLgRaoD7Jt4RAD2ex+crYTwC7nYQatG8tm9u0
         xH2m3v3l5eLf9DcywXJQRJENW54zZQ9ZU2EVm8nrlsljr1vNztEzuwaDkQB3+MYyQgHG
         mnDKzocN1jqaYVw1h+XR93/Cy6NP51gHzTzJ/r3MQd5ljE8mT4lxqLHNZ4hpnb1jSyUD
         RtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VztEUlpV8zDsFzNQYRGfDaPcGsHwJdhN5D593jj3WPg=;
        b=SJI1GUYEVf9iiO8k7HEd0Ke5tlKt9WqY9uWMaimvPfBGvBT9rSmEgBsLVYMqjiuWiG
         6uGx4wpB3Ix+/p+uoxmWC+Y21Wt6BXnvrBgb0I3oM8KLzmZWsKjSweI6Impc8SHNBOPC
         6hJjsvqVfIkG+b+g4n0vK+PSjGjhUDO1ropsJ0/v/X13z+7BAPPirV9WYmsw/q7KAA9e
         WLfPM8y9o3Ffa99l06Ksrm0PuQshNlCgnzDJj3FrNyaJijZ9sXPsb0qT5t3jy6LKPoVK
         ADWFaB2Gn/iQ2K/OnRk1EQF4C5dnfkqgUpMayq/oAvIkGee+D1aHlJ5iL2XWxz9H2xDe
         UkGw==
X-Gm-Message-State: APjAAAU0iLSIwIZpC3FM5HYQxhw8SasDUJHAIvaquLtOjdXbp+sSKBg3
        Bhb20ffvw+jWNSsJrQnGgqA=
X-Google-Smtp-Source: APXvYqxM3fhjLeZIzdFnCM2wUBMhZuQXgHCbqia3T9VEqpTOKE+gwU79kzWif1JSBzHu63mxWSlOYQ==
X-Received: by 2002:a1c:55c3:: with SMTP id j186mr5671098wmb.127.1554414847184;
        Thu, 04 Apr 2019 14:54:07 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z1sm17734673wrs.52.2019.04.04.14.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 14:54:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2.5 2/2] tag: prevent nested tags
References: <1bd9ee28bc8726490ec0a93286056beeb147fc49.1554183429.git.liu.denton@gmail.com>
        <20190402230345.GA5004@dev-l>
        <xmqqzhp7sfw4.fsf@gitster-ct.c.googlers.com>
        <20190403213318.GA14137@dev-l>
        <20190404020226.GG4409@sigill.intra.peff.net>
        <xmqqftqyf76a.fsf@gitster-ct.c.googlers.com>
        <20190404122722.GA23024@sigill.intra.peff.net>
Date:   Fri, 05 Apr 2019 06:54:06 +0900
In-Reply-To: <20190404122722.GA23024@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 4 Apr 2019 08:27:22 -0400")
Message-ID: <xmqqef6he8sh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> but you have to take pretty specific steps to get a tag of a blob or
> tree, like:
>
>   git tag mytag HEAD:path
>
> or
>
>   git tag mytag HEAD^{tree}

And the way to ask for commit and tag are

    git tag mytag master
    git tag mytag v1.0.0

I do not see why only the last one should either be forbidden or
automaticallly peel.  Each of these four names an object of a
specific type, and singling out a tag as "curious" makes the
interface uneven.

