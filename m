Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B280AC433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 09:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91E9C610A6
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 09:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbhIQJoD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 05:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhIQJn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 05:43:59 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90273C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 02:42:34 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id v5so27466297edc.2
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 02:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=3SmPtfJk02sD1QrsrJw+MEvuuxz37925vb7sKrEnC8k=;
        b=edmCw9PEIga+86JHSx2z5cyNg4iTQfay8H9LHGFg9kIepZLn4OIfHF1JgADiuYoWV2
         KYocoNwsb62PM3fk0pBYX9dJUGZWlVxQ3oE9dUbG4j4H3S/BpvXCMVCKqhc9weo3/bVm
         d4o5AJMpdPs53ie1PiIsIeWklWqK8aafOHYdnlvjzHaexykaqDaziybkjrSkVqoTAxQr
         0jBnpHrRVmZMinI95SOH/bFtIfizmoMnQN2GxRIjncozQWgYcIIvPDEeJ5YvmI8pv7Ql
         e6tWc/uQnfLlH2GzCsm/giY1EE2DNwf7FMBnKqj8qmvIhFU6ZVNOlcGbxY3CtyxIvTsV
         r9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=3SmPtfJk02sD1QrsrJw+MEvuuxz37925vb7sKrEnC8k=;
        b=znDn7tR8dOVRBvdbr4QvhEhE4TG06Nwu8xmBpukFzVF21Magw2ri29rFgJApbECJeM
         fUixudsVC3KbtA4MZCkC8QAelI0EN2xN5qQJMyeJ5UrCHdUcPrOmeQd0QTc1jpIWWrMn
         UXKMuLdtUkEAMRfp1rvtjBKLRK7+4NanfSKMjYJFKwGx5zKHnWDiCdrfHKbVKSMfEvUM
         uVkeDSRolHJwhmY0zqiY8PKMqIJ7OnZ0nsPJPhniwTErHVUGx65jLEn2GWbtfKlsWhnj
         /PvG+7j0MZ0zTUHWgsyzG4oOJUQ3sr6JgK/KEDkKOtZ1i3pITBX4KTCvZ+O5rKyt+bRs
         NjIg==
X-Gm-Message-State: AOAM533MeK4xqkVZnNnrOpsOII6NC1AdRXPnq42m96FhFrdoo5g0pgKP
        FQdEm9yzf7EUIRfLJ00T0LU=
X-Google-Smtp-Source: ABdhPJwB8WebeljyhaDV+bOMQKBnGgK7TrayLjCa8ToVlKenPq8bYxCVkOaWZNwB+naHFVrZY7pT1w==
X-Received: by 2002:aa7:d7c8:: with SMTP id e8mr11522854eds.381.1631871752698;
        Fri, 17 Sep 2021 02:42:32 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r2sm2305260edo.59.2021.09.17.02.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 02:42:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v6 02/22] fsck tests: add test for fsck-ing an unknown type
Date:   Fri, 17 Sep 2021 11:39:02 +0200
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
 <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
 <patch-v6-02.22-9072eef3be3-20210907T104559Z-avarab@gmail.com>
 <YUOgKKRf9ZpMzNaS@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUOgKKRf9ZpMzNaS@nand.local>
Message-ID: <87pmt7edx4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 16 2021, Taylor Blau wrote:

> On Tue, Sep 07, 2021 at 12:57:57PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Fix a blindspot in the fsck tests by checking what we do when we
>> encounter an unknown "garbage" type produced with hash-object's
>> --literally option.
>>
>> This behavior needs to be improved, which'll be done in subsequent
>> patches, but for now let's test for the current behavior.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  t/t1450-fsck.sh | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
>> index 7becab5ba1e..f10d6f7b7e8 100755
>> --- a/t/t1450-fsck.sh
>> +++ b/t/t1450-fsck.sh
>> @@ -863,4 +863,16 @@ test_expect_success 'detect corrupt index file in f=
sck' '
>>  	test_i18ngrep "bad index file" errors
>>  '
>>
>> +test_expect_success 'fsck hard errors on an invalid object type' '
>> +	git init --bare garbage-type &&
>
> I wondered whether it was really possible to not cover this, since I
> figured such a test may have just been hiding elsewhere. But we really
> do seem to be lacking coverage. So, adding this test is good.
>
>> +	empty_blob=3D$(git -C garbage-type hash-object --stdin -w -t blob </de=
v/null) &&
>> +	garbage_blob=3D$(git -C garbage-type hash-object --stdin -w -t garbage=
 --literally </dev/null) &&
>
> I'm nitpicking, but I find the -C garbage-type pattern less than ideal
> for two reasons:
>
>   - It makes every line longer (since "-C garbage type" is wider than an
>     8-wide tab, even indenting this in a subshell would take up fewer
>     characters visually)
>
>   - It pollutes the current directory with things like "err.expect" and
>     "err.actual" that have nothing to do with the current directory (and
>     much more to do with the garbage-type repository within it).
>
> So I don't care, really, but it may be better to just put all of this in
> a subshell.

Yes, it does look much nicer like that. Thanks!

Some aspects of style I use I have some informed/strong opinion about,
like the teardown/setup pattern noted in [1], but for some other stuff
like this ... I think I was just following the pattern of some recent
test I'd read or something.

Well, one advantage of using "git -C" is that if it fails you can cd to
the trash directory and run the command you saw fail as-is without
cd-ing further, and in that case the "polluting" is a feature, you can
cat the top-level expect/actual consistently.

But I think on balance having the test itself be easier to read is more
important, so I'm going with the subshell.

1. https://lore.kernel.org/git/87y27veeyj.fsf@evledraar.gmail.com/
