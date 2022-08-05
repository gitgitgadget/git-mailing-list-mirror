Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A215AC00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 15:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241494AbiHEP4H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 11:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241416AbiHEPzW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 11:55:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A006770E56
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 08:54:11 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gb36so5707084ejc.10
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 08:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=uyCaHziHZqb+meWhll9Uk6q12lVuVeAsPSMOyJwpWJU=;
        b=PJV6aHQuZGchkj7P8BSodIZymQlKsd0y17CClKjHs6cuwjRURvg8quIk8CTFatIdkF
         sXjJdrg1GHjQtjG7dajGtkmKhbEbwuvc1xYRu+25tuK/wN2aBT6aiT4Rfcp5n2K25gGs
         hH+RNr6MpP4Y9vJUocJg6taVCspq39QLoTZXfHZi1ZAhiqz3aQYOGVgiF8LHBZhIK2TJ
         vMzJSLxa6iCZSjodm6yHIqc2h5B07V69Ch85xvsT9KRnkfXD+pKX/Hda4AcOvnxlbV+g
         IRgNfmWhcWH6KcRFiJjAtHmUz9mfeGT4jcS60kaiul+oxSlPCkoNBMP+tFfEFkpKNNBF
         Fvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=uyCaHziHZqb+meWhll9Uk6q12lVuVeAsPSMOyJwpWJU=;
        b=gmb131TslG67jT0ucgt7mLyVokDVVPoOc7FMnletAc6d6BzGpmJ2xCaBsHjDJTrykX
         50BjdtmC+0EPCXV+FfDwe96plMxXAOmQ2x+MaGfLgZxp7yUho2lS7DgNtewnipbJcQZn
         swM34tXWrRCJQ5FGvAThSmMn4a3HPr5hc3A9eo469cK9EazQ7L49W6LMiQeJDqaEj90c
         5n1NDVs8JyzjEJLZnRwPFEjkQxOsI9vZO4e2q4sH0tBOmupA2jTwNzhuswXNlker5kyf
         j6FGk0VI+TMWdI5fpCMnBxn6tCFrcNL17LJdGkSTUXDexC0GXoNjIAJwBLRezc19dUmS
         cJvA==
X-Gm-Message-State: ACgBeo2omYA/BysJUE1IHBV769TAlLtcfiH/zbe0Se+8znQVBcGJ39mW
        MiHbhU55lJAQQKAeWfup0C/MApDc1c3rCA==
X-Google-Smtp-Source: AA6agR58wHe1sVkQkpBCKdGpG9k0waAlxMbCGfYLKwEmHxYcHTyYIFaJPOEY/YqzZonxnJ9yMec4UA==
X-Received: by 2002:a17:907:7637:b0:730:6a9b:148f with SMTP id jy23-20020a170907763700b007306a9b148fmr5948530ejc.273.1659714850196;
        Fri, 05 Aug 2022 08:54:10 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g20-20020aa7d1d4000000b0043e8334f762sm63898edp.65.2022.08.05.08.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 08:54:09 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJzeK-000gv1-2H;
        Fri, 05 Aug 2022 17:54:08 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ilya K <me@0upti.me>
Subject: Re: [PATCH] hook API: don't segfault on strbuf_addf() to NULL "out"
Date:   Fri, 05 Aug 2022 17:51:17 +0200
References: <0015309-00f1-9b44-023c-001ee3f242e4@0upti.me>
 <patch-1.1-2450e3e65cf-20220805T141402Z-avarab@gmail.com>
 <Yu08MCCoGwTxeM+g@danh.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <Yu08MCCoGwTxeM+g@danh.dev>
Message-ID: <220805.86v8r6r8in.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 05 2022, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> On 2022-08-05 16:15:33+0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> [...]
>> +test_expect_success 'git hook run a hook with a bad shebang' '
>> +	test_when_finished "rm -rf bad-hooks" &&
>> +	mkdir bad-hooks &&
>> +	write_script bad-hooks/test-hook "/bad/path/no/spaces" </dev/null &&
>> +
>> +	# TODO: We should emit the same (or at least a more similar)
>> +	# error on Windows and !Windows. See the OS-specific code in
>> +	# start_command()
>> +	if test_have_prereq !WINDOWS
>> +	then
>> +		cat >expect <<-\EOF
>> +		fatal: cannot run bad-hooks/test-hook: ...
>> +		EOF
>> +	else
>> +		cat >expect <<-\EOF
>> +		error: cannot spawn bad-hooks/test-hook: ...
>> +		EOF
>> +	fi &&
>> +	test_expect_code 1 git \
>> +		-c core.hooksPath=3Dbad-hooks \
>> +		hook run test-hook >out 2>err &&
>> +	test_must_be_empty out &&
>> +	sed -e "s/test-hook: .*/test-hook: .../" <err >actual &&
>
> If we're using "sed" here, can we also s/cannot run/cannot spawn/
> in order to have the same expectation?
>
> Otherwise, the fix looks sane to me (obviously, since I also suggest
> removing the line entirely).

We could, but then we'd miss some weird regression where we changed the
non-Windows message to "fatal: cannot spawn", which neither emit now.

We could of course do the "sed"-ing in an identical "test_have_prereq"
block, but I think we'd just be back to square one then, and it would be
more readable to just "cat" what we expect to happen there.

So I think I'd prefer to keep it as-is, it also makes a subsequent
change where we unify these error messages more obvious, i.e. we'd keep
the !WINDOWS branch of that if/else in thath case.

> Reviewed-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail=
.com>

Thanks!
