Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D15C433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 00:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66EDC61241
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 00:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbhKKAPt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 19:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbhKKAPt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 19:15:49 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4041C061766
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 16:13:00 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id f4so17119352edx.12
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 16:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=YHwvvpHMmBUSv4CZOdsAHO+b3gX0jeqt1L6IBC6lfZ0=;
        b=RH59TPMhuSZx8u5Nid0pn6/G0YTGtFzYQIfbGOtUUIZj3Y3U1idH3LlBB5XKHb4I6O
         /UgxmodeB67RKrgx/iEp4gMFzzc7U4vaiM6JOn9nBOsuAHRN4TAHIfHrgfmxIBiHLSZd
         C9idrYcVHaZu/1pMJt9+9Vs9l7En8qm5H5r1ImhUOSpeODj67OoWQe6mrwziJc9JQPw3
         DclYnGA65Xbhsgo+dk7wCviRIihrmbzS3q63T4cUckHsdZ6gFZm3adNobiTX1VCA5zfv
         X1uT+94VBkQ17N2vENLXCHJOIU1nUvPzZUBX9vemF8faZk7xz/6/k9ENTCtiHiDs8G4j
         +Cqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=YHwvvpHMmBUSv4CZOdsAHO+b3gX0jeqt1L6IBC6lfZ0=;
        b=HWCU0+9qB8X6cDXciC2OjTnIlmP0TTVqjtl4Aj8HoAcnDoM191/nohTLbvKIvkU4xE
         EgSmGQdK8Tif+zPpx8YKhpb+y9pRZWjminMQLDUR3Qjs/hs+UsFvRLEJdF5mMuGBmzVZ
         nVCXXawKitAXRNtYj0Jum3qisqk2mwxXJdizkG4pJsZTH8rS7LnLGOznSDOEnswiiELD
         oIdH8GgfhbbRz8VZPY3iFtfZ3xYBUuVdjHGCljd1dYZcaYOWfaBC4j3PlG6KOwLdFmwq
         nZl4hb7J1OVL6Pty/BXTI99Z4ei8lRtrbOXs9P0IKWuITYJiCHCoZXmU/XWv7IQvB4Uv
         UJNQ==
X-Gm-Message-State: AOAM531InNfu4fiO1pk7owIhHZfncldf/9WfDXBkKVhX692Mdm0UUHX9
        YV7Pr6B2f+RHp5rJUq1ZyxloxbMSF8oYAYNF
X-Google-Smtp-Source: ABdhPJxUuB5ybezGIPAFw9yuCVeXlYNoLcQihO5xBDTJI/5qzFkKrZbb3XFs+zpPd1ccLW86OOb2+Q==
X-Received: by 2002:a17:906:9753:: with SMTP id o19mr4023715ejy.513.1636589579302;
        Wed, 10 Nov 2021 16:12:59 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id og38sm526541ejc.5.2021.11.10.16.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 16:12:58 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkxi6-0007nU-Ey;
        Thu, 11 Nov 2021 01:12:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ivan Frade <ifrade@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com,
        git@vger.kernel.org, sunshine@sunshineco.com
Subject: Re: [PATCH v6 1/2] fetch-pack: redact packfile urls in traces
Date:   Thu, 11 Nov 2021 01:01:32 +0100
References: <a6098f98946bd9cc1186ab9c83d917566c78b805.1635532975.git.gitgitgadget@gmail.com>
 <20211108230111.1101434-1-jonathantanmy@google.com>
 <211109.86mtmedrhr.gmgdl@evledraar.gmail.com>
 <CANQMx9U2sRB9Qm3zxvpOwn8cqRYyA0S0jJ2=JsspJ5hcRd_XOA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CANQMx9U2sRB9Qm3zxvpOwn8cqRYyA0S0jJ2=JsspJ5hcRd_XOA@mail.gmail.com>
Message-ID: <211111.86tugjpn1x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 10 2021, Ivan Frade wrote:

> On Mon, Nov 8, 2021 at 5:53 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>>
> ...
>>... Let's just:
>>
>>  1. Start reading the section
>>  2. Turn off tracing
>>  3. Parse the URIs as we go
>>  3. When done (or on the fly), scrub URIs, log any backlog suppressed tr=
ace, and turn on tracing again
>
> This is a more generic redacting mechanism, but I understood that
> there is no need for it. Previous comments went in the direction of
> removing generality (e.g. not looking for a URI anywhere in the
> packet, but specifically for the packfile line format) and now this
> patch is very specific to redact packfile-uri lines in the protocol.

It's less generic, because it would live in the loop that consumes the
lines.=20

>> Instead of:
>>
>>  1. Set a flag to scrub stuff
>>  2. Because of the disconnect between fetch-pack.c and pkt-line.c,
>>     effectively implement a new parser for data we're already going to be
>>     parsing some microseconds later during the course of the request.
>
> pkt-line is only looking for the "<n-hex-chars>SP" shape. True that it
> encodes some protocol knowledge, but it is hardly a new parser.

Yeah, but why have find_packfile_uri_path() at all instead of just
moving the parsing code around?

We've already got the code that parses these lines, it's just a few
lines removed from the code you're adding...

>> That "turn off the trace" could be passing down a string_list/strbuf, or
>> even doing the same via a nev member in "struct packet_reader", both
>> would be simpler than needing to re-do the parse.
>
> Saving the lines and delaying the tracing could also produce weird
> outputs, no? e.g. 3 lines received, the second doesn't validate, the
> program aborts and the trace doesn't show any of the lines that caused
> the problem. Or we would need to iterate in parallel through lines and
> saved-log-lines assuming they match 1:1. Nothing unsolvable, but I am
> not sure it is worthy the effort now.

It would only be weird if you do :

    download_later =3D
    while (consume lines)
        download_later +=3D buffer_lines;
    log lines;

I'm suggesting:

    download_later =3D
    while (consume lines)
        raw, to_log =3D parse line
        log line(to_log)
        download_later +=3D raw

Sure, you'll need to do something in the case where the line doesn't
validate, should you redact it still, or log it as is? Anyway, that's
also a caveat you've got now.

That's not iterating in parallel, having one for-loop instead of two.

I see now that that approach would also solve at least one
bug/misfeature in the packfile-uri handling, i.e.:

        for (i =3D 0; i < packfile_uris.nr; i++) {
            [...]
            start_command(...) [... to download the URI ...]
            [...]
            die("fetch-pack: pack downloaded from %s does not match expecte=
d hash %.*s",
        }

I.e. we've already received all the URIs, but then do validation on them
one at a time, so we might only notice that the server has sent us bad
data for the Nth URI after first downloading the first N-1 URIs.
