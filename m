Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FD5C433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 03:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78D2C64DD8
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 03:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhBKDBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 22:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhBKDBO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 22:01:14 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC6EC06174A
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 19:00:33 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id df22so5435526edb.1
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 19:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=HPc8x+77HSAN1NbTRTUzRlpR4snmsfMZ1Snba/HCxUE=;
        b=lN/E+pSkLxiQslt+Iy94vrqzMAryTKf7ImRTSymNgSDP3lAe5GQHVZyPStwRXEYCvU
         UsVJfttAH79PXLxUa+soFasxWs5dYs7R0+t9A04isFMGBFLhci/iYriu2F+L/T33UmmN
         XP1/RR54NDq5c/QL8RZgRtcV0MiAiV7G213CulgeIKI0KNthnDlzKYlJdWMU/D3Fh4q7
         VMj+t6NBhr0DP+qnnOJr+Dhr315EscuOr6p0tULvTx5bcPxYzkxgI14y7AaIkwbtdLeP
         970Tpe4JE07OjOSjnlH3IsDm0oZ1pai6u46H1LHcoobWp7Nh0zPYEjAJLY5083PM/Ago
         fYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=HPc8x+77HSAN1NbTRTUzRlpR4snmsfMZ1Snba/HCxUE=;
        b=DG3gqGb4qtbDmG1JPbGuKjo2dYOAqi0IObJ2qkL5pELZ4lJDizMDstG6YgnN3xxp5M
         R5VBl87FPPBtiJ/Wq4alaPCWglwtxump2WNV5GL/epWf5k+vEU+cEFln/znlMIReEBCI
         V8PPwsMebGEHJL/N1/1X8lPTmnoMxxz25HXY4sNK4WZoDqjKSKv5Qnj7RR1Fojusl+2I
         SHm3bmh5SxGqD98/xmdJwIOioTlqHa75iKvBNb0eufwgMxUzfJphzBtTnioHNnVqWqVF
         3Mic8YvT640JsKekHy0F+aeJXxRCgi5IlrshiFpFXTqCwBa2b+lEGZRygcZHc93aXo3T
         Zuww==
X-Gm-Message-State: AOAM530SB9WLhxPKqqpiUgzg3V5WPYROuF9jB05Yu7KY2R+S2WBJQkkV
        4zAn+GbHwaGjgibE5+aJ6v4=
X-Google-Smtp-Source: ABdhPJx+Rqxqox7O6t+JPDhjN8+txOMJH/NDVMCy/If3SHQHTtdRAt2pFeIhHszBvk+V4LZjPe4l4Q==
X-Received: by 2002:a05:6402:1398:: with SMTP id b24mr5869851edv.108.1613012432551;
        Wed, 10 Feb 2021 19:00:32 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id o10sm2868715eju.89.2021.02.10.19.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 19:00:32 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/2] diff: add an API for deferred freeing
References: <20201020064809.14297-1-michal@isc.org>
 <20210205141320.18076-1-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2102101557160.29765@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <nycvar.QRO.7.76.6.2102101557160.29765@tvgsbejvaqbjf.bet>
Date:   Thu, 11 Feb 2021 04:00:31 +0100
Message-ID: <878s7vcnqo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 10 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Fri, 5 Feb 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Add a diff_free() function to free anything we may have allocated in
>> the "diff_options" struct, and the ability to make calling it a noop
>> by setting "no_free" in "diff_options".
>
> Why do we need a `no_free` flag? Why not simply set the `free()`d (or
> `fclose()`d) attributes to `NULL`?

Because we're calling the diff API N times, so we need to not have those
be NULL while we're using them in a loop, and we need to not free()
them, and then flip "no_free =3D 0" at the end and free() them.

>> diff --git a/builtin/add.c b/builtin/add.c
>> index a825887c50..6319710186 100644
>> --- a/builtin/add.c
>> +++ b/builtin/add.c
>> @@ -282,7 +282,7 @@ static int edit_patch(int argc, const char **argv, c=
onst char *prefix)
>>  	if (out < 0)
>>  		die(_("Could not open '%s' for writing."), file);
>>  	rev.diffopt.file =3D xfdopen(out, "w");
>> -	rev.diffopt.close_file =3D 1;
>> +	rev.diffopt.fclose_file =3D 1;
>
> This rename makes the patch unnecessarily tedious to review, and I do not
> even agree with leaking the implementation detail that we need to
> `fclose()` the file.
>
> Let's just not?

Fair enough, I figured it would be easier for reviewers to reason about
to be guaranteed to see all the uses of the flag, but I'll drop it.

>> @@ -6399,10 +6399,10 @@ void diff_flush(struct diff_options *options)
>>  		 * options->file to /dev/null should be safe, because we
>>  		 * aren't supposed to produce any output anyway.
>>  		 */
>> -		if (options->close_file)
>> +		if (options->fclose_file)
>>  			fclose(options->file);
>
> And at this stage, we should set `options->file =3D NULL`.

Sure, why not, but unless we get rid of the need for "close_file"
there's not much point other than ease of inspection in a
debugger...[cont].

>> [...]
>> +void diff_free(struct diff_options *options)
>> +{
>> +	if (options->no_free)
>> +		return;
>> +	if (options->fclose_file)
>> +		fclose(options->file);
>
> And at this stage, we should set `options->file =3D NULL`.

...ditto...[cont]

>> +}
>> +
>> +
>>  static int match_filter(const struct diff_options *options, const struc=
t diff_filepair *p)
>>  {
>>  	return (((p->status =3D=3D DIFF_STATUS_MODIFIED) &&
>> diff --git a/diff.h b/diff.h
>> index 2ff2b1c7f2..d1d74c3a9e 100644
>> --- a/diff.h
>> +++ b/diff.h
>> @@ -49,7 +49,16 @@
>>   * - Once you finish feeding the pairs of files, call `diffcore_std()`.
>>   * This will tell the diffcore library to go ahead and do its work.
>>   *
>> + * - The `diff_opt_parse()` etc. functions might allocate memory in
>> + *  `struct diff_options`. When running the API `N > 1` set `.no_free
>> + *  =3D 1` to make the `diff_free()` invoked by `diff_flush()` below a
>> + *  noop.
>
> I have serious trouble parsing that last sentence. Would you mind
> rephrasing it?

Willdo.

>> + *
>>   * - Calling `diff_flush()` will produce the output.
>> + *
>> + * - If you set `.no_free =3D 1` before set it to `0` and call
>> + *   `diff_free()` again. If `.no_free =3D 1` was not set there's no
>> + *   need to call `diff_free()`, `diff_flush()` will call it.
>
> Again, as I mentioned before, the indicator whether things need to be
> released should be whether the attribute is `NULL` or not. And once
> released, ot should be set to `NULL`.
>
> Other than that, it looks fine to me. And I definitely like the idea of
> introducing a function to release all of the stuff in `struct diffopt`.

[cont]...I don't think it's possible in anything like the current API to
do that.

We don't want to "if (file) fclose(file)", instead we need an opt-in "if
(close_file) fclose(file)". That's because usually the "file" is
stdout. So close_file=3D1 is only set when we're opening a "real" file,
/dev/null or whatever.

That along with the "no_free" flag as noted above means we need both a
"no_free" and "close_file" flags.

Unless there's some way of re-arranging this that I'm missing.
