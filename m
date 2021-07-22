Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFD0C4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 139B460EB6
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhGVUit (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 16:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbhGVUin (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 16:38:43 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D5DC061757
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:19:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gn11so802746ejc.0
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=j7F60ohAokFcfDgpCuE1af7gKqlhpx20Lee2Dkj4NXM=;
        b=W5I61MOj2Pj1//kdjG9A+4+i8N08MpikETthlALSqbLTUdc0rYfa7qxjCBQQDV6A4V
         8DcNlItAjGpgXuop0MJUMDCAbEVTXEOVK9kQO0oTx+9ge9bAGBSDddVtDtjmKLYX8QgR
         bmPn1yxKPuM9EfnkWb/5IJiYPLk/anx4y6ffsA4gQeO1n8pO+KxtcA43JcAZIGHy1z5z
         4Jmx7lYRgDVo00O7ND19PC7vsUBD4ok9EMWSIpiZvL4G8Hc51cXHE5hIGgo2sxC1pY3x
         XdMHfY396mr4S362aqfnIzdZz8gQvYa1/BC2lMLQa75BSdSGBY84mpS5jMsoLwt1HIj8
         vgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=j7F60ohAokFcfDgpCuE1af7gKqlhpx20Lee2Dkj4NXM=;
        b=CF8GBzsBtL5DarH7m0pXeu2XjvkkQQVBkbhld2EDElu6iLr5wbiHOP5rkGWsif/WYN
         jIX2jj5iRJmlaYkuaGbrTcbAyU3ewL8fO6nq3dbQepTp7ZhZx26aI2cd/iLib/8vqDdz
         mEJ52EB6dxPJrPkecj0zldIsS07He867m+rXJgS8LaEw60HC9TI7jGzbrCxBLx62evjC
         C6Z0LLzzfZWFcsLZmZHrMBq6RS8C3r/AbcQdcmJuKV+LwUt5T0ovdzBxsux0tyHk3UhZ
         zplXBxjceOBc82xJM/ubhJfeyid7qeBxNQXmnmzeBGPkVyaN34vj2w9OZ2Rmk4PECy31
         3xVA==
X-Gm-Message-State: AOAM533di9cXRfQGCBpLCfikf4ZYQWhhDCy9jfnw6uX9rJLIwsdx3Jxb
        w+Hapdhx5z/rqd/c5rBWkw8=
X-Google-Smtp-Source: ABdhPJxlgMBUpScMcEC1UtTUJ9XkOvkbM8eRs+mkNtdjKWJcqsAzwv3vPr8QO1RQS9f+FlUlF4Knzw==
X-Received: by 2002:a17:907:2079:: with SMTP id qp25mr1634373ejb.207.1626988755238;
        Thu, 22 Jul 2021 14:19:15 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id z6sm9941769ejo.77.2021.07.22.14.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:19:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Tom Cook <tom.k.cook@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] setup: only die on invalid .git under RUN_SETUP
Date:   Thu, 22 Jul 2021 23:08:23 +0200
References: <CAFSh4Uyr5v9Ao-j0j7yO_HkUZSovBmSg7ADia7XCNZfsspFUYg@mail.gmail.com>
 <patch-1.1-fc26c46d39-20210722T140648Z-avarab@gmail.com>
 <xmqq5yx29nj3.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqq5yx29nj3.fsf@gitster.g>
Message-ID: <87mtqet5aw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 22 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change RUN_SETUP_GENTLY to stop dying if e.g. the .git is "not a
>> repo". This means that we now recover in cases like:
>>
>>     $ echo "gitdir: /foo/bar" > .git
>>     $ git ls-remote https://github.com/torvalds/linux
>>     [... ls-remote output ...]
>>
>> But not (as intended):
>>
>>     $ git rev-parse HEAD
>>     fatal: not a git repository: /foo/bar
>
> I am of two minds.  ls-remote is benign in that it behaves more or
> less identically when given certain types of args, and the above may
> be a strict improvement (but it does fail if you did not use URL but
> use a remote nickname you thought you configured in the repository
> in such a situation).  There however are a few niche commands that
> work inside and outside a repository and they work differently.  For
> example, if you do
>
>   $ git diff file1 file2
>
> in such a corrupt repository, I'd prefer to see the command _fail_
> to nudge the user to look into the situation, instead of taking the
> output (which degenerates to "git diff --no-index file1 file2"
> outside a repository) blindly as a patch that shows the changes
> relative to the index for these two paths.

Yes it comes down to what we think RUN_SETUP_GENTLY and
setup_git_directory_gently() should be doing.

I.e. is &nongit_ok supposed to be a binary "repo you can use"/"[...]
can't use", or a tri-state of that plus "this looks like it's supposed
to be a repo, but it's broken, so let's die".

Anyway, if you're not happy with this pretty much as-is consider it
dropped from my side, because I think the next step would be to do some
more work on e.g. split up RUN_SETUP_GENTLY into a mode that makes sense
for "diff", and another for "bugreport" and "ls-remote". I figured this
was an easy bugfix, but if not perhaps Tom Cooks wants to pick this
up...

I guess another easy alternative would be to issue a warning() in this
case, which is a relatively light refactoring of passing an error
message up from the relevant function(s) instead of having it die()
directly.
