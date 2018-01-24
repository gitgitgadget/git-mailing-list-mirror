Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D72C1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 22:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932745AbeAXWYB (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 17:24:01 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:41450 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbeAXWYA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 17:24:00 -0500
Received: by mail-pg0-f53.google.com with SMTP id 136so3707111pgd.8
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 14:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1nyMIgiQK276DZIvtd4bKOsF8jdWHsR8ZLluf/x9r5U=;
        b=bOrpo4szSidLzggYIybauV0nazS0oLVlmUAgwQIUOP9YN42KBkY9nBXdbKlOSV5eTM
         moK4wfYAqE2JQDpDJEGnkOpo7XbhhtjnDz1mfMxrtYIPkVVEgv4H5gLso2kKwCs2gSC8
         w77WebZ2hWSGSR525w5olQAqjMXXiVZlkkQi93McBqdQRrZbORV0WvGM/9GLX5f0P827
         XvcjtNbAcFmrxnqYOSc6S9N292pdSaaH7kWxvpusKJOUxcX7rhPAWJ3a0aT0Q10FyYc0
         +Zf1B1vFqy/j2fBgtYJrkPP+hmaobDm2AYpZW06fov7gBJpU48RPNa+kdPiy5B0cyr5+
         jf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1nyMIgiQK276DZIvtd4bKOsF8jdWHsR8ZLluf/x9r5U=;
        b=WLQKP5bn9u925T1ar0c5lt+stO/QRoGxoRyc6vUkYxhD4KbPsgjtIWj28O7JBugSov
         jYzoPOHFCHIhCgDykNGPpnf4p1+S/QxRGfJWBxqBmpvT59rCL2qJm9f9lYB6dRxSzST6
         8MCDTPSP1DOWGoeW73XQixsdsOGb3Tf5Se3uFu5oe1DyWzSMetM4NztLyl2e9mL4k6we
         gBjNY3x9gdCFbZZeKYrjMZCxd3p4wScQfMLita2ETdWuCxjwgo8VL6QxIxW4/ao3blsT
         gqyenskGnoxXFS6zEXeM8ykKbeC03EKX6viv1QfeYZZETdva6fhOUIoKZfquttY+HeDn
         XQQg==
X-Gm-Message-State: AKwxytc5/nVx2l41vLT1JEHL7AL1m0AVp9sFj4EyWFB06XHwfGIo7h+r
        CUtxSzzCtNjQ12kwlOftBjo=
X-Google-Smtp-Source: AH8x2247tOs1BgHCGPASzaqfr5+Kzt9h+u7OYIdWzqXdNByKw2ZDft/AIoeVoPeWgTMoOrIE9PpH0Q==
X-Received: by 2002:a17:902:102:: with SMTP id 2-v6mr9357305plb.178.1516832639454;
        Wed, 24 Jan 2018 14:23:59 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f924:a479:e3c:a7cc])
        by smtp.gmail.com with ESMTPSA id m9sm11264646pff.59.2018.01.24.14.23.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 14:23:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: Git packs friendly to block-level deduplication
References: <87bmhiykvw.fsf@evledraar.gmail.com>
        <20180124221932.v6up7j67llwhjox4@glandium.org>
Date:   Wed, 24 Jan 2018 14:23:57 -0800
In-Reply-To: <20180124221932.v6up7j67llwhjox4@glandium.org> (Mike Hommey's
        message of "Thu, 25 Jan 2018 07:19:34 +0900")
Message-ID: <xmqq607qc2v6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

> FWIW, I sidestep the problem entirely by using alternatives.

That's a funny way to use the word "side-step", I would say, as the
alternate object store support is there exactly for this use case.
