Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7ABAC32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 11:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjARLmp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 06:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjARLmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 06:42:25 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3CF69231
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 02:59:51 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id b4so29588654edf.0
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 02:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nEHIE2jglY7Nja9/JMIp5VBobbHn2INWi9z6IxhdHOw=;
        b=GqoEIwEO0ujpfFCnjBoBEsUjU0TcR1G5wyKM0x2sk2iKzfsoxIGRoYXsxREZweoVFK
         FTVfoLtr6obOVLvc/2cUE3/UbC6RZRuhaiPrWQg+KhqBD5kmTfQfTJFxDpUyXyXCXWrA
         rIgCx29S+eRRV7Uub9puxAwZn8EeYwM5BKjlJw0zFnJRQvGqT+xOUQ7ryLPK4wJTZrAl
         +e7+DPalIilpKdWLLtpNT0vwGzWjfXu4lTfJRnIB+Wggw3HaD+Pa5xtkWKNzgSKy3Bs+
         X1KKnR7ACmdXOEggd/mhy9RTS43RsSqcLytdWI9x7TRV9sYEqdHwtBJs0vyekb6+btOY
         JJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nEHIE2jglY7Nja9/JMIp5VBobbHn2INWi9z6IxhdHOw=;
        b=sDcT+ueZdirK7XNHg8bQXkUeQuDTfSYTv9Dk0wFBCqtbAT3VuS+IpS8/+O/tn+HJ7W
         Ykzkfg5lDT62TE1utf/i1DFwj6+p7aynFxRG+/gHaCQyJ+PD9aqiZXdqNiH9wztflRYD
         KZgITc9C2DiW4DJTXYjQhK83Mmwi18Dr0AQv5NDyqyaUVWPZ6/lbFt2WGhDwIGex7Nzb
         9aYtnM6IVKqzHld/4ucCndBwpU5RM2RzgM7cecv7tAGY0376nl9N8yepPaKHLb7CG4Dp
         A/crKc5Oi3AjNeJ/2SBFSG0rPNRyVUnBKaNPxHk8skeeymEKyUnA/1j4pEez3DdnBG1Y
         ONBA==
X-Gm-Message-State: AFqh2kp4R4ZYU2yt4O1ArZ3AQ2zIdb0fS1tuTYkg5CaYVKnHs19Nzor+
        mEONPtS4cKlPMY2cD6s8Nm/k7NLGF8A1/A==
X-Google-Smtp-Source: AMrXdXuBdgr4Lz7yBZd3E33rgthel9aHnk1I+6pb582DIoe3iqzLtyoEiV+djaqgdzoaxqlNtqc3eQ==
X-Received: by 2002:a05:6402:5110:b0:49d:32d0:126 with SMTP id m16-20020a056402511000b0049d32d00126mr7859843edd.20.1674039587343;
        Wed, 18 Jan 2023 02:59:47 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id m17-20020a50ef11000000b0049c4e3d4139sm6438113eds.89.2023.01.18.02.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 02:59:46 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pI6AT-002nZW-2E;
        Wed, 18 Jan 2023 11:59:45 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 08/19] worktree: fix a trivial leak in prune_worktrees()
Date:   Wed, 18 Jan 2023 11:57:16 +0100
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
 <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
 <patch-v4-08.19-1fe25bc6981-20230117T151202Z-avarab@gmail.com>
 <xmqqedrs8igj.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <xmqqedrs8igj.fsf@gitster.g>
Message-ID: <230118.86o7qwxg4e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 17 2023, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> We were leaking both the "struct strbuf" in prune_worktrees(), as well
>> as the "path" we got from should_prune_worktree(). Since these were
>> the only two uses of the "struct string_list" let's change it to a
>> "DUP" and push these to it with "string_list_append_nodup()".
>> ...
>> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
>> index d34d77f8934..ba8d929d189 100755
>> --- a/t/t3203-branch-output.sh
>> +++ b/t/t3203-branch-output.sh
>> @@ -1,6 +1,8 @@
>>  #!/bin/sh
>>=20=20
>>  test_description=3D'git branch display tests'
>> +
>> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>>  . ./test-lib.sh
>>  . "$TEST_DIRECTORY"/lib-terminal.sh
>
> This is wrong, isn't it?
>
> t3203 uses --points-at, which populates filter.points_at by calling
> parse_opt_object_name().  Various members of the ref-filter
> structure is never freed (and there is no API helper function in
> ref-filter subsystem).
>
> Other tests that use --points-at (e.g. t6302 and t7004) are not
> marked with "passes_sanitize_leak", and this one shouldn't be,
> either.
>
> With the following squashed in, the branch seems to pass, but I am
> not sure which is lessor of the two evils.  From the point of view
> of the code maintenance, UNLEAK() to mark this singleton variable is
> far cleaner to deal with than selectively running the leak checks
> with the "passes_sanitize_leak" mechanism (which always feels like a
> losing whack-a-mole hack).
>
>  builtin/branch.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git c/builtin/branch.c w/builtin/branch.c
> index f63fd45edb..4fe7757670 100644
> --- c/builtin/branch.c
> +++ w/builtin/branch.c
> @@ -742,6 +742,7 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
>  	if (filter.abbrev =3D=3D -1)
>  		filter.abbrev =3D DEFAULT_ABBREV;
>  	filter.ignore_case =3D icase;
> +	UNLEAK(filter);
>=20=20
>  	finalize_colopts(&colopts, -1);
>  	if (filter.verbose) {

I'll send a v5 re-roll without this change, sorry.

This is a case where the version of GCC I was testing with doesn't
report the leak, but clang does (and probably other versions of GCC),
sorry.
