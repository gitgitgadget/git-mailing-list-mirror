Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E9EC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 18:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240342AbhLGSKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 13:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbhLGSKO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 13:10:14 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F0CC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 10:06:43 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id e3so60520750edu.4
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 10:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=MQShruV+cJDnoB0hj6auE+KrWpkk8WpkZtCh9h5CX9c=;
        b=OPACcQdKisx4BxynVYiolSiDaUlqLpsEjFgMMrkgVpS3AbF1E9ULwF3aLTmkdujp2P
         0t/taBwGTPWKC8N5wU5O+IdYW6eEx+EWjzDNq4Db/c+zKBnm8GxLzgxyUwKBwWnabrcO
         nKpB6eOkkfLtzZXPmSsmQTHuNnonUa3B/54k+rEpN3GRJRSJcuscXQG3P0VXec9YDI2R
         EOIsI4BQy5TYvlSKw99nU/Qw0Yjta0LDlFuDZmIFTKeOjyqUwko5YGTT7qhnvKBF6Fk1
         r6vZ0OL2URRcGkrTzvt2RBgP+z8lN66ZTUkNn2dwtk+fCj5g0ABVb62tL6t3xpzsl8//
         cpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=MQShruV+cJDnoB0hj6auE+KrWpkk8WpkZtCh9h5CX9c=;
        b=Mvh66pvVFkjZ11MybFy2+jdmz6YwKE0jckXsOQbM+J/zqR66+K7ma8veHlfM2X7Gyp
         CdHXaUz50c/iBMLx+vt+kcs6iKQcWNgLWOr1d7DO+gSOpNAeDhdpPDYMCujyF1/y7MEw
         e7roWMt+X2pknvflsSIPQ3ltHGrHKD+itc5uvAl+EahRXPVfBkaIEOvLWruChSWzbdRx
         0cAmR70hiJZPjdVH01C7z6m83IxicKnYGAjLp7tdLtPsZ5C51LrVd3Q9fAvz++gKihCr
         vwyjfBgMcqY5aPgOKp8rfL+EzUDsN4s5p3ZXzm6+uQ797yUgOvuhKmusDB4goXLSOoY0
         oAAg==
X-Gm-Message-State: AOAM53107z8AxISIqNAT1KExekhxGWeL0i5Jyzeq/kYG4UN2qfMTLzuV
        V4gi/tFA2zYNvy8dxMGDVWxWHlWhtWI/bw==
X-Google-Smtp-Source: ABdhPJzeuV0M9Jpup1zuV5gqapaIeJWp+xHv78KUocMAaLW8QPfvx3bRh9YXL374dLO4DEdPTe5JwQ==
X-Received: by 2002:a17:906:4c95:: with SMTP id q21mr1041405eju.485.1638900402043;
        Tue, 07 Dec 2021 10:06:42 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sa3sm147955ejc.113.2021.12.07.10.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 10:06:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1muerP-001F2r-PZ;
        Tue, 07 Dec 2021 19:06:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/4] config API: don't use vreportf(), make it static in
 usage.c
Date:   Tue, 07 Dec 2021 19:05:39 +0100
References: <cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com>
 <patch-4.4-e0e6427cbd3-20211206T165221Z-avarab@gmail.com>
 <xmqqfsr5e87e.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqfsr5e87e.fsf@gitster.g>
Message-ID: <211207.86fsr4nvbk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 06 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> In preceding commits the rest of the vreportf() users outside of
>> usage.c have been migrated to die_message(), leaving only the
>> git_die_config() function added in 5a80e97c827 (config: add
>> `git_die_config()` to the config-set API, 2014-08-07).
>>
>> Let's have its callers call error() themselves if they want to emit a
>> message, which is exactly what git_die_config() was doing for them
>> before emitting its own die() message.
>
> I do not quite get this.  If git_die_config() has been showing the
> message for them, and if the existing callers can just use error(),
> why not git_die_config() call error() on behalf of these callers?
>
>> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
>> index 2b2e28bad79..4e2432bb491 100644
>> --- a/builtin/fast-import.c
>> +++ b/builtin/fast-import.c
>> @@ -3456,9 +3456,10 @@ static void git_pack_config(void)
>>  	}
>>  	if (!git_config_get_int("pack.indexversion", &indexversion_value)) {
>>  		pack_idx_opts.version =3D indexversion_value;
>> -		if (pack_idx_opts.version > 2)
>> -			git_die_config("pack.indexversion",
>> -					"bad pack.indexversion=3D%"PRIu32, pack_idx_opts.version);
>> +		if (pack_idx_opts.version > 2) {
>> +			error("bad pack.indexversion=3D%"PRIu32, pack_idx_opts.version);
>> +			git_die_config("pack.indexversion");
>> +		}
>
> This is exactly what triggered the question above, and the pattern
> repeats elsewhere, too.
>
>> @@ -2550,18 +2552,12 @@ void git_die_config_linenr(const char *key, cons=
t char *filename, int linenr)
>>  		    key, filename, linenr);
>>  }
>>=20=20
>> -NORETURN __attribute__((format(printf, 2, 3)))
>> -void git_die_config(const char *key, const char *err, ...)
>> +NORETURN
>> +void git_die_config(const char *key)
>>  {
>>  	const struct string_list *values;
>>  	struct key_value_info *kv_info;
>>=20=20
>> -	if (err) {
>> -		va_list params;
>> -		va_start(params, err);
>> -		vreportf("error: ", err, params);
>> -		va_end(params);
>
> I get that we do not want to expose vreportf() to this caller, and I
> agree with the goal, but wouldn't it be the matter of calling
> get_error_routine() and calling it with err and params here, instead
> of losing the whole block?  Is that insufficient to avoid toucing
> all the callers?

I'll fix that in the incoming re-roll. This really didn't belong in this
series but a later one.

FWIW that change was because like this we'll accurately report the
source of the "error" when the function learns to spew <file>:<line> at
the user.

But for now I'll just have it do as you suggest...
