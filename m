Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9967EC433EF
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 00:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350425AbiASAY0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 19:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244782AbiASAYY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 19:24:24 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B20C061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 16:24:24 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id f21so2877444eds.11
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 16:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=zFsRwGeLoQPzmSMPdbvZzBhe1ros01x4BA+hp/qIltE=;
        b=JRacG44EUGsqTRrWg58fmQT0VVBS2IwFstl1zwsZ7RNfObpkL4aY6kRPrCqqaPWBEk
         oFDCDn1FW39Azu3zb7GdnA79uXeguemQicna8XVUUNmJaYpVj0D2sc81wZpJmVqVavga
         oBfRV+P5pScjAwvp9xv0UVWLg/cheIDfNT83dqBRNXn/3Gt5HA5FKMam31jNLu1lNeqI
         5c4MoDrxkzC6m47BiDnF03rL/ejRSbEwqMhPbzIykNS622Jy4vKWJMH1FjljXxFlvS7/
         50HIrOudtG0qxbxGJqEE1ZugjFiaHZTV3NTb8tq/UNl6AlHnOGV2bnbFpcP6JJJbLiR5
         yIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=zFsRwGeLoQPzmSMPdbvZzBhe1ros01x4BA+hp/qIltE=;
        b=XwmkBCSYJV9U98uRCujPasTDdL+PpzIRPh/BkFV6H/mV4626gTkEUe+WlcvNWZnKJl
         gMpZumfv7hGf8GHz7IWwiFY0U3FF+lGfG+Bf7C/ZnUxK8lLbLBn7a9L+gmedZMgxGUaP
         PUtzOpOti3IrpTTLq3H9ivqTD9ytfN00Bu3/edRUXYKLtZVd1rrL6EIxPLtHXzTA0XgC
         akIFSWAmjWaQrNsfLmVU0QgLG8Hwv9hrZlKDhtdRdpy9MbMfC13LlbtfjUvAFuJgxdpx
         4Dc0u8dZ/exIRZHkQIqHxVuPvhv6gaPCkOBJ+2qHHV6qjY1hEMJZ9tYWbS10yufZ2zNl
         gOCA==
X-Gm-Message-State: AOAM533hGlOz64xXjwzy5vb2bNChHmu+hjWmLpdeVPYGDZ0qH/eSvIiq
        3Un9/nvfgER0oUCYe+RIr41s3M+cs366rg==
X-Google-Smtp-Source: ABdhPJx4NkheE6iQURCdvhFCbOOxDk1nBVbNq/DVU/H24VP4Wmwr5F/ZqKuFgw5wPlQpoMtMRggA0w==
X-Received: by 2002:aa7:c3d7:: with SMTP id l23mr27365590edr.258.1642551862641;
        Tue, 18 Jan 2022 16:24:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b4sm3008937ejb.131.2022.01.18.16.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 16:24:22 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n9ylw-001gak-47;
        Wed, 19 Jan 2022 01:24:20 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v8 09/10] grep: simplify config parsing and option parsing
Date:   Wed, 19 Jan 2022 01:17:28 +0100
References: <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com>
 <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
 <patch-v8-09.10-c211bb0c69d-20220118T155211Z-avarab@gmail.com>
 <xmqq8rvcr73v.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq8rvcr73v.fsf@gitster.g>
Message-ID: <220119.86wniwo9mz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 18 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> When "grep.patternType" was introduced in 84befcd0a4a (grep: add a
>> grep.patternType configuration setting, 2012-08-03) we promised that:
>>
>>  1. You can set "grep.patternType", and "[setting it to] 'default'
>>     will return to the default matching behavior".
>>
>>     In that context "the default" meant whatever the configuration
>>     system specified before that change, i.e. via grep.extendedRegexp.
>>
>>  2. We'd support the existing "grep.extendedRegexp" option, but ignore
>>     it when the new "grep.patternType" option is set. We said we'd
>>     only ignore the older "grep.extendedRegexp" option "when the
>>     `grep.patternType` option is set. to a value other than
>>     'default'".
>
> Extra period in the middle of a sentence after "set".
>
>> As before both "grep.patternType" and "grep.extendedRegexp" are
>> last-one-wins variable, with "grep.extendedRegexp" yielding to
>> "grep.patternType", except when "grep.patternType=3Ddefault".
>>
>> Note that this applies as we parse the config, i.e. a sequence of:
>>
>>     -c grep.patternType=3Dperl
>>     -c grep.extendedRegexp=3Dtrue \
>>     -c grep.patternType=3Ddefault
>>
>> Should select ERE due to "grep.extendedRegexp=3Dtrue and
>
> Downcase "S" in "should", as this is still in the middle of the
> sentence that began with "Note that".
>
>> grep.extendedRegexp=3Ddefault", not BRE, even though that's the
>
> The second one should be "grep.patternType=3Ddefault".

*nod*

>> "default" patternType. We can determine this as we parse the config,
>
> Drop "even though that's the default patternType".  You've already
> explained that it is not what "default" for the "patternType" (which
> any reader who has been following so far would take as a reference
> to "grep.patternType") at all.  You can also drop ", not BRE," while
> doing so.
>
>> because:
>>
>>  * If we see "grep.extendedRegexp" we set the internal "ero" to its
>>    boolean value.
>>
>>  * If we see "grep.extendedRegexp" but
>>    "grep.patternType=3D[default|<unset>]" is in effect we *don't* set
>>    the internal "pattern_type_option" to update the pattern type.
>>
>>  * If we see "grep.patternType!=3Ddefault" we can set our internal
>>    "pattern_type_option" directly, it doesn't matter what the state of
>>    "grep.extendedRegexp" is, but we don't forget what it was, in case
>>    we see a "grep.patternType=3Ddefault" again.
>>
>>  * If we see a "grep.patternType=3Ddefault" we can set the pattern to
>>    ERE or BRE depending on whether we last saw a
>>    "grep.extendedRegexp=3Dtrue" or
>>    "grep.extendedRegexp=3D[false|<unset>]".
>
> That sounds complex enough, doesn't it?  The statement that opens
> the proposed log mesage is "gets rid of complex parsing logic that
> isn't needed", but the above sounds more like a complex logic is
> being traded with another.

The complexity this series is addressing is that you couldn't treat this
like most other built-in / library APIs, where we instantiate defaults,
do config, then CLI parsing.

>> diff --git a/grep.c b/grep.c
>> index 60228a95a4f..bb487e994d0 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -48,6 +48,12 @@ static int parse_pattern_type_arg(const char *opt, co=
nst char *arg)
>>=20=20
>>  define_list_config_array_extra(color_grep_slots, {"match"});
>>=20=20
>> +static void adjust_pattern_type(enum grep_pattern_type *pto, const int =
ero)
>> +{
>> +	if (*pto =3D=3D GREP_PATTERN_TYPE_UNSPECIFIED)
>> +		*pto =3D ero ? GREP_PATTERN_TYPE_ERE : GREP_PATTERN_TYPE_BRE;
>> +}
>> +
>>  /*
>>   * Read the configuration file once and store it in
>>   * the grep_defaults template.
>> @@ -56,17 +62,22 @@ int grep_config(const char *var, const char *value, =
void *cb)
>>  {
>>  	struct grep_opt *opt =3D cb;
>>  	const char *slot;
>> +	static int ero =3D -1;
>
> Is this new reentrancy issue worth it?  I think it makes the whole
> thing unnecessarily complex, compared to a more na=C3=AFve "we keep track
> of the last-one-that-won for grep.extendedRegexp and
> grep.patternType separately during option and config parsing inside
> the grep_opt structure, and then combine the two when we compile the
> pattern string into regexp or pcre object" approach.

I can move back to using the variable in the struct. The post-image here
is from incrementally working on that, until I saw that it wasn't needed
outside the config parsing step itself.

Is a reentrancy issue a practical concern? This part of the grep API is
explicitly called by the whole init-once/config-once/getopt-once step in
builtin/grep.c (and revision.c).

> Let's ask it in a different way.  What is this static, that is way
> separated from all the members in the grep_opt structure, buying us?
> Certainly not the ease of understanding what the code is doing.  Not
> the size of the overall grep_opt structure (which we do not allocate
> tons anyway).  Other than that fact that you can say "I did it my
> own way, ignoring reviewer suggestions, I won!!!", I do not see any
> upside with this code.

The ease of understanding that the state isn't needed outside of the
config callback, but that's in the eye of the beholder I suppose. That's
not true of the other remaining struct members.

Then downthread you mention:

> Another problem is that there are those corporate server-side folks
> who are interested in giving an endpoint that lets clients to ask
> performing Git operations (like grep and blame).  Adding more statics
> instead of keeping track of dynamic runtime structure like grep_opt
> is deliberately making things more difficult for them, isn't it?

IIRC I'm the only person who's been advocating that as an eventual neat
thing to do, and I don't see how this would make it harder.

If we had a grep IPC call of some sort we'd surely limit it to the
"modern" config of grep.patternType, and take the opportunity to
deprecate grep.extendedRegexp from that interface.

Or it would take explicit parameters, instead of allowing the passing of
config from a remote process.

In either case the required surgery and scaffolding to make that work
will at most be trivially impacted by these changes, and likely not at
all.
