Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882FAC636D4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 13:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjBCNcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 08:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjBCNbt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 08:31:49 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5FB8E497
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 05:31:39 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id be12so5188813edb.4
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 05:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VJiQ8zYkx/zgjIgk12C9dQAUvOFdnD+o6SdZHQZYjCg=;
        b=QoVqKSRU0Y9gvCf4IGJNSH/zoiVmmqxa2x6wUyHoBf3btS0Va+NqBcxCLUOhhFXueO
         1WXaWfAvOdNCm9uFfVZcBiGzgMxW93FSWC6G54Qfvzlr7+Lab8cDM9oNfPjMy8CazyjK
         DOnbH19vPT+oikEfKWOhLgf9N5e89CXfRbr0eEJZsswCR9Sno5KrZv277Bv+rf0jaquE
         GFRSVPIEaplYER221XwnQT6XtACz7a6hK/q2dNM7u9LrKl0Vshrr3yvWTSbWZEERFNZd
         +quvFtlvja4DhLHg0AAbw/u7Pa6Is47F4E4z6MMsDJupCEaPR6Y8XM39c8RVIOQm9cRM
         0ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJiQ8zYkx/zgjIgk12C9dQAUvOFdnD+o6SdZHQZYjCg=;
        b=x+1diYRLYSW2lrVrsNaHf3js2rD5+98s1yVbqmjdzFDC8ZyFofomXQCNb3yR8ojpBR
         5VTWzWkJDKlOmZbgVW6oHsf3LHUJrDuHfNwfv46m2U4WOwmCKdbjIFv4LADa/qf0J470
         Dvw8iFSZhMOClBF7SgYrLHt5n8KWSAGd3IPc2xZdC1QCEyte7j2/978HK4qzvJSIe7fR
         i9/cGCUaqKGdN7b+XwAudxf5sfZSaf25CjPhNgMPMFKQgz0qzdlJdpajIc7wYI2oGuuU
         4pjxCQ7jYxxAQFLSSTJ7h1amk6KDxaY9xQthhHcI1Flz75NMlHTE98gdoLqQpHmZMm6u
         cpGA==
X-Gm-Message-State: AO0yUKUaazloeaicJGOj+Q7wBdpk7sXoXQqs4y2SHvd1/xI0/SwrQlKf
        KUBLrpxIRkHhscYuyWOEZVdVft1Nj93zaWM/
X-Google-Smtp-Source: AK7set9pdUKl2Hg870BK+JJ5Nad49esV8fvac0NJ5RnRnuL1ovtCcwyAtOAikXIZMd+OltfsJypX+g==
X-Received: by 2002:a05:6402:4446:b0:49d:fff2:d4b9 with SMTP id o6-20020a056402444600b0049dfff2d4b9mr10329055edb.23.1675431097989;
        Fri, 03 Feb 2023 05:31:37 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id en14-20020a056402528e00b0049622a61f8fsm1141071edb.30.2023.02.03.05.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 05:31:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pNwAC-000Cw9-1o;
        Fri, 03 Feb 2023 14:31:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     rsbecker@nexbridge.com
Cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        'Junio C Hamano' <gitster@pobox.com>,
        'Konstantin Ryabitsev' <konstantin@linuxfoundation.org>,
        'Eli Schwartz' <eschwartz93@gmail.com>,
        'Git List' <git@vger.kernel.org>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and
 a possible solution
Date:   Fri, 03 Feb 2023 14:18:58 +0100
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
        <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
        <20230131150555.ewiwsbczwep6ltbi@meerkat.local>
        <Y9mXB1LaYSUJBlwF@tapette.crustytoothpaste.net>
        <230201.86pmatr9mj.gmgdl@evledraar.gmail.com>
        <Y9ry5Wxck4s/X2B+@tapette.crustytoothpaste.net>
        <xmqqh6w5x8i8.fsf@gitster.g>
        <Y9xAv1reHJRj7iKA@tapette.crustytoothpaste.net>
        <01a901d93760$c690d970$53b28c50$@nexbridge.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <01a901d93760$c690d970$53b28c50$@nexbridge.com>
Message-ID: <230203.86sffmc1tz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 02 2023, rsbecker@nexbridge.com wrote:

> On February 2, 2023 6:02 PM, brian m. carlson wrote:
>>On 2023-02-01 at 23:37:19, Junio C Hamano wrote:
>>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>>
>>> > I don't think a blurb is necessary, but you're basically
>>> > underscoring the problem, which is that nobody is willing to promise
>>> > that compression is consistent, but yet people want to rely on that
>>> > fact.  I'm willing to write and implement a consistent tar spec and
>>> > to guarantee compatibility with that, but the tension here is that
>>> > people also want gzip to never change its byte format ever, which
>>> > frankly seems unrealistic without explicit guarantees.  Maybe the
>>> > authors will agree to promise that, but it seems unlikely.
>>>
>>> Just to step back a bit, where does the distinction between
>>> guaranteeing the tar format stability and gzip compressed bitstream
>>> stability come from?  At both levels, the same thing can be expressed
>>> in multiple different ways, I think, but spelling out how exactly the
>>> compressor compresses is more involved than spelling out how entries
>>> in a tar archive is ordered and each entry is expressed, or something?
>>
>>Yes, at least with my understanding about how gzip and compression in general
>>work.
>>
>>The tar format (and the pax format which builds on it) can mostly be restricted by
>>explaining what data is to be included in the pax and tar headers and how it is to be
>>formatted.  If we say, we will always write such and such information in the pax
>>header and sort the keys, and we write such and such information in the tar header,
>>then the format is completely deterministic, and we can make nice guarantees.
>>
>>My understanding about how Lempel-Ziv-based compression algorithms work is that
>>there's a lot more freedom to decide how best to compress things and that there
>>isn't always a logical obvious choice, but I will admit my understanding is relatively
>>limited.  If someone thinks we can effectively succeed in supporting compression
>>more than just relying on gzip, I would be delighted to be shown to be wrong.
>
> The nice part about gzip is that it is generally available on
> virtually all platforms (or can be easily obtained). Other compression
> forms, like bz2, which sometimes produces more dense compression, are
> not necessarily available. Availability is something I would be
> worried about...

I agree with all of that, gzip is in such wide use for a reason. 

>... (clone and checkout failures).

But how would a hypothetical obscure format for "git archive" contribute
to clone or checkout failures? Are you thinking of our use of zlib for
e.g. loose objects? That's unrelated to this discussion (and I don't
think anyone relies on their compressed checksum).

> Tar formats are also to be used carefully. Not all platform
> implementations of tar support all variants. "ustar" is fairly common
> but there are others that are not. Interoperability needs to be the
> biggest factor in this decision, IMHO, rather than compression rates.

For "git archive" whether you care about interoperability depends on the
target audience of your archive, and in any case I don't see why we need
to worry about it, except to perhaps note that some are more portable
than others if we e.g. had a built-in "tar.bz2" helper method.

> The alternative is having git supply its own implementation, but that
> is a longer term migration problem, resembling the SHA-256 migration.

I've noted elsewhere in this thread that I don't see the point of
shipping a fallback "gzip" beyond the "git archive gzip" we have
already, but even if we did that the scope of that seems pretty simple,
and *much* easier than the SHA-256 migration.
