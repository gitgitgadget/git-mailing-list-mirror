Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B890B1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 18:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752807AbeB1SHj (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 13:07:39 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43548 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbeB1SHi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 13:07:38 -0500
Received: by mail-pl0-f66.google.com with SMTP id f23-v6so1971748plr.10
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 10:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qppXqf+akXxgo7nMKxKH3ji0ag0dD2bYQ0K5udYD8NY=;
        b=Czm+Rhh4TjeqeWCk/8hNd221efuAvHLYhcMFveDWOB9OZoX25NKh/G83n2Vrex+r3L
         fUa1rgQTHoJWQxrC7gN1KRWUai5AX/YJGVTHWaLjyFY3RdjPFkMP1b1LC+itxbkSXAKY
         4p1HfPkENCD25c4hCRzJQmheeUlJ501uCFgptfSoPz3TfxgtbMfDrUSKZSWvvYPjyNy/
         9s63opjAEhcbEY+kE0YPKlWMgshmw2dsnI/M2KvRTd4+ZBgp75vd7Mw3duQgP7sAufwK
         9yONxi1MXWOmrlCBjMEwg6mYutk8gbhrDOR/a669E+p9sEo2fvS81FEIsNmwx7xw0OSf
         YV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qppXqf+akXxgo7nMKxKH3ji0ag0dD2bYQ0K5udYD8NY=;
        b=Bnx4qgHRZn9jJADJzdbUHegAWMlm97Qfm4ULYr+9uyvPxnkzNgzqwOUPkORNthNj72
         vUy9uhZD++ABb2k90OtnB5UuE5dUmpRCztwNPKAfIQEiYKd0/L+awKthJv1yML4MSjso
         FRM84RtWYSGKbtvYIeEQ02uBpvSbECWl7lGt282TmBkb9le5gDUN3diAwdB+UfioDoR7
         6bRzA+70sKRjT+cBVyggXTFTk8Zee3UHSbvKGDyP6hWPezqFCuzz3hZMs/gnkBrRodrM
         oXb0Q5QvnL3T6owl9Zhy6mulMrjo3e0p0w3/dPItwtBoA/2B7STFtu+irwhIA2Dh+DfD
         0kwA==
X-Gm-Message-State: APf1xPARsDiW7LcCfxsZpRwa/02MhghmYmsu7/m+DStAQlTTdDUwqVdB
        JyQkMfEMbF/CS2uNxEAPiLAKhO+E
X-Google-Smtp-Source: AH8x227nobDuNyNzpv4QbfvyKJUovRmgfHUMtuTdV2+Qb3J1OGtC9ZLD8cuqBzeGnjGwuRP1GET2wA==
X-Received: by 2002:a17:902:6909:: with SMTP id j9-v6mr18469242plk.447.1519841257683;
        Wed, 28 Feb 2018 10:07:37 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id t85sm4960807pfg.159.2018.02.28.10.07.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 10:07:36 -0800 (PST)
Date:   Wed, 28 Feb 2018 10:07:34 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] protocol: treat unrecognized protocol.version setting as
 0
Message-ID: <20180228180734.GD251290@aiede.svl.corp.google.com>
References: <20180228005059.GA251290@aiede.svl.corp.google.com>
 <xmqqbmg9m260.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbmg9m260.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> If I share my .gitconfig or .git/config file between multiple machines
>> (or between multiple Git versions on a single machine) and set
>>
>> 	[protocol]
>> 		version = 2
>>
>> then running "git fetch" with a Git version that does not support
>> protocol v2 errors out with
>>
>> 	fatal: unknown value for config 'protocol.version': 2
>>
>> In the spirit of v1.7.6-rc0~77^2~1 (Improve error handling when
>> parsing dirstat parameters, 2011-04-29), it is better to (perhaps
>> after warning the user) ignore the unrecognized protocol version.
>
> I do not agree with the analogy at all.
>
> Showing dirstat with different tweaks than the user expected to see
> is a local and read-only thing.  Talking to the other side over a
> protocol the user explicitly wanted to avoid (e.g. imagine the case
> where your upstream's protocol version 1 implementation is
> critically buggy and you want to use version 2 if you talk with
> them) by accident is a more grave error, possibly affecting the
> other side that you may not have enough power to recover from
> (e.g. damaging the remote repository to which you only have push
> access and not interactive shell).

Fair enough about the analogy being a poor one.

I disagree with characterizing using protocol v0 as a grave error,
because the scenario seems far-fetched to me.  I can imagine the
opposite scenario, wanting to use protocol v0 because a server's
implementation of v2 is buggy (for example, producing wrong
negotiation results and wasting bandwidth, or erroring out for a
request that should not be an error).  I am having trouble imagining a
broken v0 implementation doing anything worse than being slow or
erroring out.

That said, erroring out to catch spelling errors is nice and helpful,
so I would be okay with continuing to apply this as a local patch and
it not landing upstream.

The following third way would also be possible, but I'm pretty sure I
don't like it:

- As Duy suggested, allowing multiple 'protocol.version' settings.
  The last setting that the Git implementation recognizes wins.

- If there is at least one 'protocol.version' setting but the Git
  implementation doesn't recognize any of them, error out.

The reason I don't like it is that it doesn't make your example case
work significantly better.  If I have

	[protocol]
		version = 1

in my ~/.gitconfig and

	[protocol]
		version = v2

in .git/config, then that means I intended to use protocol v2 and
misspelled it, but this heuristic would ignore the v2 and fall back to
version 1.

As a side note, the exact same problem would happen if I make a typo
in the config key:

	[protocol]
		vesion = 2

Treating unrecognized values from the growing set of values as an
error while not treating unrecognized keys from the growing set of
keys as an error feels odd to me.  I think it would be useful to
document whatever we decide about this subject in
Documentation/CodingGuidelines.

Thanks,
Jonathan
