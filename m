Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C387201A9
	for <e@80x24.org>; Thu, 23 Feb 2017 07:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751165AbdBWHTs (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 02:19:48 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35803 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751144AbdBWHTr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 02:19:47 -0500
Received: by mail-pg0-f67.google.com with SMTP id 1so3614495pgz.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 23:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JCqfFjnpr66LkMvJ7r5r3v3nYoK1QlSaTk8A5ZsULLk=;
        b=HKpO4rbFmTo8Ms8C3/EYjn1RMY8d6vsVqfn0Y+HGZqCWMjA1YGLZYZN/tojts9kOgS
         DoDeDMxwStBYFPQ7zzjh86lY8hrdbJecm8o0CPDr44i2h6R2I0NEQKQvuo9CvqlAZhk6
         lakuQivzYzIxNqtjYL7GEYJt7Zk9Soe0sLNjGmIFBIddd2fEqbmM9L2rzHlni44g5vkf
         /m7dUUk7X1sTRGYIupaJVv95IrRD9bqecUgPfca6XU4rJirD7lpj49KD1PqdVmklIB5Z
         7XvN3/hRqYZkb6lSjbQHA1jjPFdqg+4MzTxuKrBqN8WBth5Hk3P6CCXbtIQE3W5CzALF
         Uc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JCqfFjnpr66LkMvJ7r5r3v3nYoK1QlSaTk8A5ZsULLk=;
        b=ORCUY0tcJJpPmIqb4x44hdDo88EPivBGV1c3RKoB/sG9RLv5LrqU4gIF/xWXsdqZbu
         l3VoOsvcRqPOxLGhFhOqfDZYhSuH4acAN5L3rLgZzUHGdCTSRUEZM7S6RdrbXR3+1hSO
         /6cYlgw0eBvDc54LMHTbMrOa/TynUtYkAHp7W7oMH0Q4nRWIm3TydYBjDGdPmg0Zzip7
         iyP0pPhfg+iE1K0S0jJomONvjTZ3yLiLTZbv3S5ZgNoCp15qmuVJgidP0mvzbG2zfWRx
         u8qfAEkc/JGsmnrEa1g6xq6TUvwDFiGhKR5guB3IIGpy9LvnPzvsTHj/fgrJKubSZOmH
         Qs7A==
X-Gm-Message-State: AMke39kV01ERG5/bwUcfOgjocWreWY7KoyAHhFCpzvUqyyzM5Ph1O9vO0f8WLxOP1MPsgQ==
X-Received: by 10.84.176.100 with SMTP id u91mr53253862plb.112.1487834386257;
        Wed, 22 Feb 2017 23:19:46 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:21a0:716b:e013:d129])
        by smtp.gmail.com with ESMTPSA id g194sm7556688pfb.19.2017.02.22.23.19.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Feb 2017 23:19:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] config: reject invalid VAR in 'git -c VAR=VAL command'
References: <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
        <xmqqa89n10df.fsf_-_@gitster.mtv.corp.google.com>
        <D0CDD1AC-05CA-47F3-8CB5-61EA1C6515A8@gmail.com>
        <20170216232730.xsx3xks5ppjws5rg@sigill.intra.peff.net>
        <xmqqwpcptxps.fsf@gitster.mtv.corp.google.com>
        <xmqqino5jia8.fsf@gitster.mtv.corp.google.com>
        <xmqq37f7gyuj.fsf_-_@gitster.mtv.corp.google.com>
        <CAGZ79kbR2QQyYO1dnQ0jW3-ztKEFj1MtJfDqEc0xoftMFeN=WA@mail.gmail.com>
        <xmqqlgszffm0.fsf@gitster.mtv.corp.google.com>
        <xmqqd1ebfd9l.fsf_-_@gitster.mtv.corp.google.com>
        <20170223055831.u3yofkby3c56t7l4@sigill.intra.peff.net>
Date:   Wed, 22 Feb 2017 23:19:44 -0800
In-Reply-To: <20170223055831.u3yofkby3c56t7l4@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 23 Feb 2017 00:58:31 -0500")
Message-ID: <xmqqo9xt8jcf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> FWIW, the code looks OK here. It is a shame to duplicate the policy
> found in git_config_parse_key(), though.
>
> I wonder if we could make a master version of that which canonicalizes
> in-place, and then just wrap it for the git_config_parse_key()
> interface. Actually, I guess the function you just wrote _is_ that inner
> function, as long as it learned about the "quiet" flag.

Hmm, I obviously missed an opportunity.  I thought about doing a
similar thing with the policy in parse-source, but that side didn't
seem worth doing, as the config-parse-source callgraph is quite a
mess (as it has to parse the .ini like format with line breaks and
comments, not the simple "<string>[.<string>].<string>" thing, it
cannot quite avoid it), and it needs to take advantage of _some_
policy to parse the pieces.

We could loosen the policy implemented by config-parse-key interface
(e.g. change config-parse-source to let anything that begins with a
non-whitespace continue to be processed with get_value(), instead of
only allowing string that begins with isalpha(); similarly loosen
get_value() to allow any non-dot non-space string, not just
iskeychar() bytes) and first turn what is read into the simple
"<string>[.<string>].<string>" format, and then reuse the new
"master" logic to validate.  That would allow us to update the
"master" logic to make it tighter or looser to some degree, but the
source parser still needs to hardcode _some_ policy (e.g. the first
level and the last level names begin with a non-space) that allows
it to guess what "<string>" pieces the contents being parsed from
the .ini looking format meant to express.

But you are right.  config-parse-key does have the simpler string
that can just be given to the canonicalize thing and we should be
able to reuse it.



