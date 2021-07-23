Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB205C432BE
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE27A60EC0
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhGWIxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 04:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhGWIxF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 04:53:05 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665A3C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:33:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g3so961650edv.5
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=kx2krWJxlg1HYrRRSSCQ5UAA9O+klprirDXTRpzx3ho=;
        b=lmN3xeH3/tGNTC2YTF6hC4FRE8TZFpvE8hDw5pqSVVXIEmZhhLolCPn4HDYo7oRU4Y
         nrB0W9aAVDRQ4Mg6soWpjkwrhvaTv5IYWWkN8kfYXJwfCgSj/6sEx7o95ZkyhLci0md2
         pUONd55TtOxBwLOY6nQYONsln/AigcyBKKO6nwdcpK97q8lJ7Az6idok5xSeUPHlN1/X
         E3q1kmUkInvuw3yzLKHAn6Fwapv05OJcKgzCTItEcMkoHrKIFV/cY/YHwv1Gny6A5eJd
         cxw5fP64PCq7UXQ6NR0c4hmB8kDU2u24bBt/EMH2G2PL6guMM/YRniJSyZcip4I7qlFQ
         RHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=kx2krWJxlg1HYrRRSSCQ5UAA9O+klprirDXTRpzx3ho=;
        b=lmNprEt1iBvhN37Bf43uasCgsxlszVOOyLHpHU62dwwI2fZKeTyv7cJTm7sChngkYo
         6e7HvzuWyOajbJQVoGnAKSSRUTjeSlbdHKMz7f5ohZGrsz+RhJp3SKDUbYQKo4kfymxg
         OZQnQ1e0mo8vkSf5al1+HZjrw3dywoO35wgorjHZ2K8I3iDqCgGgCiiB5E95wK02B3N5
         jmctPBw2IsQosflvZ8vSW+LKCdkzVGqeJfXElxbjXDb+oNF4Q2F+rivocVzLSlVIfyRM
         NCt4c/aEu6szDgvhM+dpDLbh12UpYhRKc3SQcER6JQe86r14/WjXdWCct6h2/NOJrj5w
         7Pyg==
X-Gm-Message-State: AOAM533oGkaOWFXGfeeJVgKENHeWjVYJf2rlE1YUapnMhhlSLIsU4PSG
        ZSydu6SGF79nPdaKI7n5wKpL9FHbG/km0w==
X-Google-Smtp-Source: ABdhPJyrw9CbAPbRBzfHmRYAp/ovOK7RBxPad3ukgvhJIf72OCbc2HWMoBxIt+AYeggObh/WGaVxBA==
X-Received: by 2002:a05:6402:752:: with SMTP id p18mr4493405edy.281.1627032816770;
        Fri, 23 Jul 2021 02:33:36 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b22sm12356081edj.24.2021.07.23.02.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 02:33:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Tom Cook <tom.k.cook@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] setup: only die on invalid .git under RUN_SETUP
Date:   Fri, 23 Jul 2021 11:33:30 +0200
References: <CAFSh4Uyr5v9Ao-j0j7yO_HkUZSovBmSg7ADia7XCNZfsspFUYg@mail.gmail.com>
 <patch-1.1-fc26c46d39-20210722T140648Z-avarab@gmail.com>
 <8fbf200c-2d88-dce2-84c3-ead330e975e8@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <8fbf200c-2d88-dce2-84c3-ead330e975e8@gmail.com>
Message-ID: <87tukls7ax.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 22 2021, Andrei Rybak wrote:

> On 22/07/2021 16:07, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Change RUN_SETUP_GENTLY to stop dying if e.g. the .git is "not a
>> repo". This means that we now recover in cases like:
>>      $ echo "gitdir: /foo/bar" > .git
>>      $ git ls-remote https://github.com/torvalds/linux
>>      [... ls-remote output ...]
>> But not (as intended):
>>      $ git rev-parse HEAD
>>      fatal: not a git repository: /foo/bar
>> The relevant setup_git_directory_gently_1() invocation was added in
>> 01017dce546 (setup_git_directory_gently_1(): avoid die()ing,
>> 2017-03-13), but I could reproduce this as far back as Git v1.8.0. I
>> don't know if this ever worked, but it should.
>> Let's also use the compiler to check enum arms for us, instead of
>> having a "default" fall-though case, this changes code added in
>> ce9b8aab5d9 (setup_git_directory_1(): avoid changing global state,
>> 2017-03-13).
>> Reported-by: Tom Cook <tom.k.cook@gmail.com>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>   setup.c            | 27 ++++++++++++++++++++++-----
>>   t/t0002-gitfile.sh |  8 ++++++--
>>   2 files changed, 28 insertions(+), 7 deletions(-)
>> diff --git a/setup.c b/setup.c
>> index eb9367ca5c..6ff145d58b 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -1033,7 +1033,8 @@ enum discovery_result {
>>   	/* these are errors */
>>   	GIT_DIR_HIT_CEILING =3D -1,
>>   	GIT_DIR_HIT_MOUNT_POINT =3D -2,
>> -	GIT_DIR_INVALID_GITFILE =3D -3
>> +	GIT_DIR_INVALID_GITFILE =3D -3,
>> +	GIT_DIR_GITFILE_NOT_A_REPO =3D -4,
>>   };
>>     /*
>> @@ -1118,8 +1119,11 @@ static enum discovery_result setup_git_directory_=
gently_1(struct strbuf *dir,
>>   				/* NEEDSWORK: fail if .git is not file nor dir */
>>   				if (is_git_directory(dir->buf))
>>   					gitdirenv =3D DEFAULT_GIT_DIR_ENVIRONMENT;
>> -			} else if (error_code !=3D READ_GITFILE_ERR_STAT_FAILED)
>> +			} else if (error_code =3D=3D READ_GITFILE_ERR_NOT_A_REPO) {
>> +				return GIT_DIR_GITFILE_NOT_A_REPO;
>> +			} else if (error_code !=3D READ_GITFILE_ERR_STAT_FAILED) {
>>   				return GIT_DIR_INVALID_GITFILE;
>> +			}
>>   		}
>>   		strbuf_setlen(dir, offset);
>>   		if (gitdirenv) {
>> @@ -1209,6 +1213,8 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
>>   	struct strbuf dir =3D STRBUF_INIT, gitdir =3D STRBUF_INIT;
>>   	const char *prefix =3D NULL;
>>   	struct repository_format repo_fmt =3D REPOSITORY_FORMAT_INIT;
>> +	int die_on_error =3D !nongit_ok;
>> +	enum discovery_result discovery;
>>     	/*
>>   	 * We may have read an incomplete configuration before
>> @@ -1231,7 +1237,9 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
>>   		die_errno(_("Unable to read current working directory"));
>>   	strbuf_addbuf(&dir, &cwd);
>>   -	switch (setup_git_directory_gently_1(&dir, &gitdir, 1)) {
>> +	discovery =3D setup_git_directory_gently_1(&dir, &gitdir, die_on_error=
);
>> +
>> +	switch (discovery) {
>>   	case GIT_DIR_EXPLICIT:
>>   		prefix =3D setup_explicit_git_dir(gitdir.buf, &cwd, &repo_fmt, nongi=
t_ok);
>>   		break;
>> @@ -1259,6 +1267,16 @@ const char *setup_git_directory_gently(int *nongi=
t_ok)
>>   			    dir.buf);
>>   		*nongit_ok =3D 1;
>>   		break;
>> +	case GIT_DIR_GITFILE_NOT_A_REPO:
>> +		if (!nongit_ok)
>> +			die(_("not a git repository: %s"), dir.buf);
>> +		*nongit_ok =3D 1;
>> +		break;
>> +	case GIT_DIR_INVALID_GITFILE:
>> +		if (!nongit_ok)
>
> Variable die_on_error could be used in two `if`s above.

Re-reading my own code I think it's better just to drop die_on_error
entirely and use !nongit_ok consistently, as the rest of the function
does. What do yo think?
