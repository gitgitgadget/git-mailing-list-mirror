Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E817AC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 07:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiBPHLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 02:11:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiBPHLI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 02:11:08 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4653E1EF
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 23:10:42 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id ml24-20020a17090b361800b001b8877a4b6eso902754pjb.5
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 23:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=tfspPWcA9rArS5OLWmkuAV+/ZyNzcdpEl+YX+WjwbIU=;
        b=MHA7NeuUDGEXPAJV3gffWDSr0cZxaRWY7i96jHVGXgjpgfr4LV+ADIOuUGj+FiYI7d
         8ZPjMv34GmFM2F/bHfCY1ROpDobn2HF0zA+jEsb4cPK4S19Xa5oQRm33Ys4GUqvqRxb/
         njnhc3JCBTnG+IQJdHe4b5nie+ZmN+mIW5Ou15tP3u5ZH9WZyfDhMw6ilGRJSmCN/Ghr
         19uAZMbIsNKNZeIHvo57QuW39lDYJvcN1M0hEwFwe/MJtb8VfaOJN8FPY4XZ9I2CCXoe
         CZiG5jNmOjLPiwm+UvtVQgNk2P3g5Q7ZZglaTf1AXflM14iui7gq/KbdSKKFr3yAouC5
         d0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=tfspPWcA9rArS5OLWmkuAV+/ZyNzcdpEl+YX+WjwbIU=;
        b=NauBlGwsbYKZqtBoHRQKOhlfjb8dTHcAMogy9rd4wt47YlFecCxf7Bl4tnLI8/p/ZC
         T8SxFRjmT70CyYLs8SGB4QrwAoabg0kFJLFSt6rOCFQVC8Ui+xhkli/npWZC/HQ5nHdu
         sR38UCPDjeCmtjW8+eIvwjehjioqbuyjmvBoxSKtZ+W6LYJ+Jgzuia4gMYhhE7D9zU9B
         XPsFNQi6GTn63os3LQHRwkzQFt29w/NCYyV07euQ5OME0D4XHvAnT9XsH787/2H/enGa
         wBKzvO7kvYPzVyl72EUifV4QSqcL21dSUM5edzyZJO4EOQT72RjSpb9B4BUIJCFO7Cf1
         mLfw==
X-Gm-Message-State: AOAM531XeLLpda2O3naliawkUyxCs6YK/T1tZ7HGOMJUYfxAhoFSWHtq
        shC5lxNiujr2d9h8nSMAQ85MvfAyAT40Ow==
X-Google-Smtp-Source: ABdhPJy0tzWt9Bay6qQpw+c9UmC10YVhL+Eo+OkchywO6OhK46/qXbZbzIN79qVh+7lC7YWF3Cggaqo54/ACgg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:134c:b0:4bc:9423:96b2 with SMTP
 id k12-20020a056a00134c00b004bc942396b2mr1325750pfu.45.1644995325705; Tue, 15
 Feb 2022 23:08:45 -0800 (PST)
Date:   Wed, 16 Feb 2022 15:08:44 +0800
In-Reply-To: <220215.86mtirwzzo.gmgdl@evledraar.gmail.com>
Message-Id: <kl6lh78z5lvn.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220210044152.78352-1-chooglen@google.com> <20220215172318.73533-1-chooglen@google.com>
 <20220215172318.73533-4-chooglen@google.com> <220215.86mtirwzzo.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH v2 3/9] submodule: make static functions read submodules
 from commits
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Feb 16 2022, Glen Choo wrote:
>
>> diff --git a/submodule.c b/submodule.c
>> index 5ace18a7d9..7032dcabb8 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -932,6 +932,7 @@ struct has_commit_data {
>>  	struct repository *repo;
>>  	int result;
>>  	const char *path;
>> +	const struct object_id *super_oid;
>>  };
>
> ...
>
>> -	struct has_commit_data has_commit =3D { r, 1, path };
>> +	struct has_commit_data has_commit =3D { r, 1, path, super_oid };
>
> FWIW I wouldn't at all mind the tiny detour of just turning this into
> designated initializers while we're at it, instead of having to keep
> track of the positionals. I.e.:
>
> 	[...] =3D {
> 		.repo =3D r,
> 		.result =3D 1,
>                 .path =3D path,
>                 ,super_oid =3D super_oid
> 	};

Since I'm touching the line anyway, this seems like a reasonable change.
