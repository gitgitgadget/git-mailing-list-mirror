Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8EBC4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 00:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiLBA3x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiLBA3d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 19:29:33 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121C9E51DB
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 16:24:36 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id k79so3431977pfd.7
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 16:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfzxrS/mIsLe/knxqFhsOVxwfcwJOJ6e8HJz0Hh2CMk=;
        b=ZR0VLpjYmUE4e/08xBVAq0eeiJaNx4FSCC7aKAKxRKuH9wK2cLJy4kYqN/YCST55wE
         Zw+g+SjWVL8BnvEYLHVhUFiGSSg0HQAzNs8xcAYLDGlG/B5MpA8DZ1Gu0vtke2Ap5w4u
         qt6FMuebfj7ZOiNJ/9GVmeyiqAor40RJ86u0AjjpvYIQQ3udFqTZIS0QlbROJAYMAxVB
         ZKUlZMvLZaF3Gv2BIKmWWpW2H7H88+vahyrHSqh03fr9sY1mqOaUsBUMLq1idzUyRKNo
         qbfT+veVpI2j012UUdxF8KtK7vBNsDCZkMae1Xuh71PJ47sm3UC9LelJvO1eM+IHTFg3
         pSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfzxrS/mIsLe/knxqFhsOVxwfcwJOJ6e8HJz0Hh2CMk=;
        b=lKlkj6r2mgXH3OIg0rqlMN0+Hs2Z1dZUY4kjqYswTeB23qGpMNiLwgpeqaYl9s7YSN
         tOlZ7kXqmHF/YdYqwve6Aelaa+J6m1szacVpXj5ct3jumOYwvuugZMvitN0D+fjjEeEM
         CbqH4bPkDM+CXfG+GYYJGGPnaKFIQshMo/qCJrKMhSUvCw/J3ZQMcqKT7Ji0b5mjTQ3k
         hfDRxDhLgmtrFhnxKlzDmZWg9QztNIOFEFj/lxYYSZZXalUL4t+PIiVg2xjUt6jpYO9R
         8JTJaBYHIdKDH6MnLbSgY/X7dnF4O5AX+VRfFkw8ZhyB4uyeNR9ymsreJeSPfHFpnCL9
         kUTg==
X-Gm-Message-State: ANoB5pmjYD/Db6hQkBe3QSREFghkOO585JzJw+w44KeJORsroTsH8ug8
        Js0NoLnn9fkM3/P3fDcW79Nz+0KD0XBGsQ==
X-Google-Smtp-Source: AA0mqf6H6kTt89G1Ajd6eeZiiaDfgb2FM7S08kn2GEYiT6SovbqvxO+FLrQG6p/h444Q6Y0asQVDkQ==
X-Received: by 2002:a62:54c6:0:b0:56d:4b31:c4d9 with SMTP id i189-20020a6254c6000000b0056d4b31c4d9mr50016459pfb.44.1669940675409;
        Thu, 01 Dec 2022 16:24:35 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b001873aa85e1fsm4168319pli.305.2022.12.01.16.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:24:34 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Sven Strickroth <email@cs-ware.de>, git <git@vger.kernel.org>,
        "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH] Don't pass -v to submodule command
References: <FR3P281MB21416B718C4C052A28C319B1E90F9@FR3P281MB2141.DEUP281.PROD.OUTLOOK.COM>
        <1ff185c5-4a9e-36e3-3141-8b149c1c7bb0@cs-ware.de>
        <cad05012-7bf9-5975-3add-253b11c7bcc8@cs-ware.de>
        <221130.868rjsi6bn.gmgdl@evledraar.gmail.com>
Date:   Fri, 02 Dec 2022 09:24:34 +0900
In-Reply-To: <221130.868rjsi6bn.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 30 Nov 2022 20:17:23 +0100")
Message-ID: <xmqqiliur6t9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Wed, Nov 30 2022, Sven Strickroth wrote:
>
>> "git pull -v --recurse-submodules" propagates the "-v" to the submdoule
>> command which does not support "-v".
>>
>> Commit a56771a668dd4963675914bc5da0e1e015952dae introduced this
>> regression.
>
> We refer to commits in commit messages like this: a56771a668d
> (builtin/pull: respect verbosity settings in submodules, 2018-01-25);
>
> Which also shows that this regression is quite old.

Good point.

While we are commenting on the proposed log message, this subject

> Subject: [PATCH] Don't pass -v to submodule command

is not sufficient to identify the change and remind readers what it
is about when it is shown among "git shortlog --no-merges".  We give
"<area>:" prefix before the title to help that, e.g.

    Subject: [PATCH] pull: don't pass -v to "git submodule update"

or something like that.

>> Signed-off-by: Sven Strickroth <email@cs-ware.de>
>> ---
>>  builtin/pull.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/builtin/pull.c b/builtin/pull.c
>> index 1ab4de0005..b67320fa5f 100644
>> --- a/builtin/pull.c
>> +++ b/builtin/pull.c
>> @@ -256,7 +256,7 @@ static struct option pull_options[] = {
>>  /**
>>   * Pushes "-q" or "-v" switches into arr to match the opt_verbosity level.
>>   */
>> -static void argv_push_verbosity(struct strvec *arr)
>> +static void argv_push_verbosity(struct strvec *arr, int include_v)
>>  {
>>  	int verbosity;
>>
>
> It looks like you're getting somewhere with this, but you never use this
> "include_v", so the bug is still there. We just have the scaffolding
> now.

What is the plan to cope with the evolution of "git submodule
update" command, though?  Will "-v" forever be the single option we
may get at "git pull" level that will never be supported by "git
submodule update"?  I am guessing that the reason we want to call
this flag "include_v" is because it is the author's intention that
"git submodule update" will not change in this regard, and am
wondering if that is a healthy assumption.

> Did you forget to add that part to this commit?
>
> In any case, that serves as a comment on the other thing this patch
> really needs: tests, please add some.

Good advice.

> I think the right longer term fix here is to simply make "git submodule"
> support "-v" and "--verbose".

Yup.
