Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDDBC00144
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 07:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbiHDHHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 03:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbiHDHHF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 03:07:05 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360AD61D4D
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 00:07:04 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s11so12736677edd.13
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 00:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=Q7FNj2LyfSsgx2egDtLhuMJDKmYEQmp+IGTLTVUZEhI=;
        b=YgrhXRb67dIEAq8kXQZC1y5s4/fY5qG6GtGAVfeXyT0qTfn5Tfv5rGC5PT5ToQsno1
         bpktbQfK00EF3efaeP7UUchFfyp2kmKeSXcjdn5myLjoSJxu/Vp9vGP91M5AE7HGTMSD
         94qDSgoWK3cmATVk+g9uVtl+S1eNN+qRQxbRYeN/oW63bheM5szldDxKFAoat60r7nG/
         0JwyNmdG4Zu1QFHtlVPP1bN5bkxVQRocByboWBLhK/0fjmkpzWRp+JXcwtNJf2SdICEi
         dnT2fICr4aqbpLoIVnvWRJ/IBMudyXaOORa92ij1NXdEdUd0kczwGkQHuv9xN6+eTP6Y
         bvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=Q7FNj2LyfSsgx2egDtLhuMJDKmYEQmp+IGTLTVUZEhI=;
        b=AfuVVrLihMPwrGj0S5nN4qxkl7RF4AyD+Nc4jstNJqvPmTgFkWLCwwkRTV1d8o2jQX
         WNIEsYdGXnMGk5kTkVvOE/zb7MRxhv/MUEI7AqGtom1XOVxpP17sjnG+rDNLnPjPJhMY
         Al7BU0k4Szj4XPWODraD1p5rsjnBlYjDfJE/JNrAmd+3WGHWMVt7PY9NSe4RS5OjRJlH
         0cCnBOr4bL3kyS5rhQGRgna8VuD1HThXRLxWao9znTPlAtF9xW8aTpAYSnnG5qMQxZNg
         mRHOfpRr+BnaddK9vfKPUwsDiVuBSMD5DBv4kBmI4KnZHyNrWN5dRXIJlPWF6Clgd4iY
         mx+w==
X-Gm-Message-State: ACgBeo1xJoa1hUlA2qie32cFn91wwmM8MfTY4WxCLCTIYBvPxi2YqYcm
        TGqTGlFzt2GjruEanZzDQRY2fAyhcUQ=
X-Google-Smtp-Source: AA6agR7uLu0TzIliYJpgeGLW0dbph1ckQCW84yNxPyayjvZfH1gl1KkLJFVHKpAG30VZz0941y3/AQ==
X-Received: by 2002:a05:6402:4303:b0:43d:94f5:8081 with SMTP id m3-20020a056402430300b0043d94f58081mr601121edc.288.1659596822629;
        Thu, 04 Aug 2022 00:07:02 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ca11-20020a170906a3cb00b007308812ce89sm3280ejb.168.2022.08.04.00.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 00:07:02 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJUwf-009enW-0j;
        Thu, 04 Aug 2022 09:07:01 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH v5 03/17] submodule--helper: fix most "struct pathspec"
 memory leaks
Date:   Thu, 04 Aug 2022 09:04:02 +0200
References: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
 <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
 <patch-v5-03.17-1f90348d61f-20220802T155002Z-avarab@gmail.com>
 <kl6lbkt1szlk.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <kl6lbkt1szlk.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220804.86mtckebca.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 03 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Call clear_pathspec() at the end of various functions that work with
>> and allocate a "struct pathspec".
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/submodule--helper.c | 74 +++++++++++++++++++++++++------------
>>  1 file changed, 51 insertions(+), 23 deletions(-)
>>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index d958da7dddc..92d32f2877f 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -367,7 +367,7 @@ static void runcommand_in_submodule_cb(const struct =
cache_entry *list_item,
>>  static int module_foreach(int argc, const char **argv, const char *pref=
ix)
>>  {
>>  	struct foreach_cb info =3D FOREACH_CB_INIT;
>> -	struct pathspec pathspec;
>> +	struct pathspec pathspec =3D { 0 };
>
> Out of curiousity, does this zero-initialization do anything for us
> leaks-wise?

No, because if we leak module_list_compute() must have filled the
pathspec with something it allocated, but...

>>  	struct module_list list =3D MODULE_LIST_INIT;
>>  	struct option module_foreach_options[] =3D {
>>  		OPT__QUIET(&info.quiet, N_("suppress output of entering each submodul=
e command")),
>> @@ -379,12 +379,13 @@ static int module_foreach(int argc, const char **a=
rgv, const char *prefix)
>>  		N_("git submodule foreach [--quiet] [--recursive] [--] <command>"),
>>  		NULL
>>  	};
>> +	int ret =3D 1;
>>=20=20
>>  	argc =3D parse_options(argc, argv, prefix, module_foreach_options,
>>  			     git_submodule_helper_usage, 0);
>>=20=20
>>  	if (module_list_compute(0, NULL, prefix, &pathspec, &list) < 0)
>> -		return 1;
>> +		goto cleanup;

...if we don't initialize it then we can't "goto cleanup".

Now, right now this is redundant, we could just "return 1", as we don't
have a pathspec yet.

But it's generally worth just using the same "cleanup" pattern
everywhere, and not worrying about in your cleanunp code that you only
init'd N/TOTAL variables already.
