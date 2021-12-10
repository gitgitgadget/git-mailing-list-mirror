Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D4DC433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 17:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244567AbhLJRqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 12:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244586AbhLJRqr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 12:46:47 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E362C061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 09:43:12 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id k11-20020a63d84b000000b003252e72da7eso5520202pgj.23
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 09:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=ArUppslXOz+3y5h+HlpryuS+uedlBTH+lTZzlL1tvoo=;
        b=T46JuLCD1QYoeAJJ1SsTekkxht2qWlDTw2CusGQfY4AEhZaAu9is+lQ9L4NXBDVNl4
         2DuYEnM1m2YaqcFxnDln8KCwGaPmHJ6Xn6TnhDh0+NHRmFJQ1fgCmQrTUVcw4/xz2mFK
         NZ1q5UprMoAUTg+LcZX4qf7xMTrojqFoAjpArLRds7TCqId7gTBMQXS64/T/Azy+Nmw5
         Neyqi7wZ80KOMTYW1hkmZF19wdzy8YNUTMqgUsR/t+rPftKx5wKfygZ6iFNJrkex2oKh
         C0aIR6weYL7DkdS0+6y7E65FI1pkHmFruHfxT7nalRuV8bGCGTWBSpMwXLV/c/qEYFOP
         zxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=ArUppslXOz+3y5h+HlpryuS+uedlBTH+lTZzlL1tvoo=;
        b=t2nfiZR3ZYkVMhdK41d+kYDZRKJ7AgPj13B1YuP/h8KtdS8E1j/SBC3lAp69rR5M2R
         1DtVGe3KAk8OlZ0ZdCvPFeRpLoM5GaX4c/GecILczaMZ0kgn6Lyr6fkVShp4L6B9MduG
         A24SbDJp4AbXZkybxS2vTMACr9HHH/EA+71FcYCZt6voYf7fhzntGMCqUzfT4pK2gpg2
         FHHUoJo2Jjn1CgAVVXfV2A6zKQnfp8JZ8Wiu51//+9SFyUzQ4nrw6cuvo0st9cFd4bjH
         UE+Ya9phcNhq3Iii0zS8r7LEpG40ki0BzkR9j3Qpcq0srNmw/ibdsM9m3U8hNDKiSx88
         Z3Fg==
X-Gm-Message-State: AOAM532yqWwQpWP38gLMKUoQxPJg5l2TXHDWMimCDz0um1leTOf9pz1J
        HfTUS4izFnl+YGjvap+naAh8nzsI9T+n3g==
X-Google-Smtp-Source: ABdhPJwIWs9OxfPwZ1ybnvscp8zB5RPYq8IWWTtPLsrUczaBqfhoFLRdjVv3mQKnxusOfrbrc09DE+Awfn1a2A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:179d:b0:4b1:4aba:397b with SMTP
 id s29-20020a056a00179d00b004b14aba397bmr3782623pfg.66.1639158191963; Fri, 10
 Dec 2021 09:43:11 -0800 (PST)
Date:   Fri, 10 Dec 2021 09:43:10 -0800
In-Reply-To: <211210.86ee6ldwlc.gmgdl@evledraar.gmail.com>
Message-Id: <kl6lwnkc8ifl.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211206215528.97050-1-chooglen@google.com> <20211209184928.71413-1-chooglen@google.com>
 <20211209184928.71413-6-chooglen@google.com> <211210.86ee6ldwlc.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH v3 5/5] branch.c: replace questionable exit() codes
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Dec 09 2021, Glen Choo wrote:
>
>> Replace exit() calls in branch.c that have questionable exit codes:
>>
>> * in setup_tracking(), exit(-1) was introduced in 27852b2c53 (branch:
>>   report errors in tracking branch setup, 2016-02-22). This may have
>>   been a mechanical typo because the same commit changes the return type
>>   of setup_tracking() from int to void.
>>
>> * in validate_branch_start(), the exit code changes depending on whether
>>   or not advice is enabled. This behavior was not discussed
>>   upstream (see caa2036b3b (branch: give advice when tracking
>>   start-point is missing, 2013-04-02)).
>>
>> Signed-off-by: Glen Choo <chooglen@google.com>
>> ---
>> I don't know what the 'correct' exit codes should be, only that Junio
>> makes a good case that the existing exit codes are wrong. My best,
>> non-prescriptive, choice is 128, to be consistent with the surrounding
>> code and Documentation/technical/api-error-handling.txt.
>>
>>  branch.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/branch.c b/branch.c
>> index 305154de0b..ad70ddd120 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -324,7 +324,7 @@ static void validate_branch_start(struct repository =
*r, const char *start_name,
>>  			if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE)) {
>>  				error(_(upstream_missing), start_name);
>>  				advise(_(upstream_advice));
>> -				exit(1);
>> +				exit(128);
>>  			}
>>  			die(_(upstream_missing), start_name);
>>  		}
>> @@ -398,7 +398,7 @@ void setup_tracking(const char *new_ref, const char =
*orig_ref,
>>  		string_list_append(tracking.srcs, full_orig_ref);
>>  	if (install_branch_config_multiple_remotes(config_flags, new_ref, trac=
king.remote,
>>  			      tracking.srcs) < 0)
>> -		exit(-1);
>> +		exit(128);
>> =20
>>  cleanup:
>>  	string_list_clear(tracking.srcs, 0);
>
> Junio noted in <xmqqbl1tcptq.fsf@gitster.g>:
>    =20
>     This is not a problem with this patch, and it should not be fixed as
>     part of this series, but since I noticed it, I'll mention it as a
>     leftover low-hanging fruit to be fixed after the dust settles.  The
>     exit(1) looks wrong.  We should exit with 128 just like die() does.
>     Issuing of an advice message should not affect the exit code.
>
> I think it's good to fix these inconsistencies, but also that we
> shouldn't be doing it as part of this series, or does it conflict in
> some way that's hard to untangle?

There isn't any conflict. Probably a leftover habit from previous
projects, but I thought that this would be right time to clean up. Looks
like we think it'll be better to clean this up in a separate series, so
I'll do that instead.

> FWIW the former hunk is a perfect candidate for the new die_message()
> function[1]. I.e. we should be doing:
>
>     int code =3D die_message(_(upsream_missing), start_name);
>     if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE))
>         advise(_(upstream_advice));
>     exit(code);
>
> That we print an "error" when giving the advice but "fatal" when not is
> really UX wart, and also that the exit code differs.

Ah, thanks!

> The latter should really be "exit(1)", not 128. We should reserve that
> for die().

Thanks, this is exactly what I was looking for guidance on.
Documentation/technical/api-error-handling.txt is silent on what exit
code to use when a command does 90% of what the caller wants (so it's
not really an application error) but fails on the 10% that the user
doesn't care so much about - in this case, creating a branch but failing
to setup tracking.

> FWIW I had some local hacks to detect all these cases of exit -1 via
> the test suite, they're almost all cases where we want to exit with 1,
> but just conflated an error() return value with a return from main()
> (or exit).

Yes, this sounds like what happened here.
