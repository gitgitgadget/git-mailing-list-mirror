Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08B5C47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 15:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9B866100B
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 15:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhFGPnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 11:43:50 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:42733 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhFGPns (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 11:43:48 -0400
Received: by mail-ej1-f53.google.com with SMTP id k25so21935128eja.9
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 08:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=L2QUciirAUal/Pv2/mekzSJF/UYbdHo1YRyt72dB2cg=;
        b=AVTvYj94BcoT94/U1YhCL8cMSeRGP3aV1sDRelH2v4rPZVFdVQyQu53oDIvzKeH4vb
         TMrhzK+MP0XCBnhprSwE5fZCVhSEFPCl31AsxJNStDgFNulgjEB0Hguq9hYxpyEvleYS
         Exj0/i9XzSc5Y8VexDWRc5IsN7f9g83Z9Pyaa1l0DTK789HOoXT3kEmNFhGtNvaU+OCe
         Lwi7hobgYdLzTWwNrqsW5Q+r7PBK5eHFwl5FoCL4KtxqvIjz4Q3relX/y1YrRP4xtTqL
         bJGwPH0RlzZbpOJKOR5yekYfEolHX+Pwi/FESy7ry8I9WxYOTR+Z6S2pRM4LBs42EqrQ
         nzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=L2QUciirAUal/Pv2/mekzSJF/UYbdHo1YRyt72dB2cg=;
        b=Vg4+reB0Lv9Pm5kRAjxFDxwJmkXIhLZZwFGtSC2AhYtt+EcbtdUfq48rOc08gNfrWY
         wT4832mgLyndRt8yxFfX1L7RAJvkdaSHBWi6czdvDKqbx3qCgx4S5/iiT60VJDBG/rHR
         cGAq3dMInGFOXCfSYrjhZVzgic8ZauduFimWNe6oQSrdwyVnZqBuv8oFV5DQOnPhVV/k
         TF3s5SyE4USJ5ciw1UMmCs/MG+/IFHzHWvEFCh3yws4I2MCVAzzmrz99EhntlJI32onr
         X0A06k1BJrd4zW1THSthXlPz3h5VqXbm4U7cO+0dv1cl8vrzMKDHfmM4YrTWyVU7Gk2D
         Uf9A==
X-Gm-Message-State: AOAM530GQ+xZKtxKrKS9EolCDCNd206+2jOCaO0E2piTmwhcgH4wzdOZ
        F/4Q2d6n6nqz9jK3O/LqH90=
X-Google-Smtp-Source: ABdhPJxd5bt+8VOQPsjgzNfwvHZOXZlUlYlDQgBcJQ/xcfNUjPbseZUebLO/LQknv+K32YeDmVF/DQ==
X-Received: by 2002:a17:906:6dc5:: with SMTP id j5mr18275536ejt.364.1623080456695;
        Mon, 07 Jun 2021 08:40:56 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id di16sm7684328edb.62.2021.06.07.08.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 08:40:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Coppa <dcoppa@openbsd.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] t0001: fix broken not-quite getcwd(3) test in bed67874e2
Date:   Mon, 07 Jun 2021 17:38:07 +0200
References: <cde6c1a5-3dfc-9710-bab9-b847a5dd960b@web.de>
 <patch-1.1-c70791bbd3-20210601T003743Z-avarab@gmail.com>
 <b650bef5-d739-d98d-e9f1-fa292b6ce982@web.de>
 <871r9d6hhy.fsf@evledraar.gmail.com>
 <57c2f4dc-06b9-b330-a01c-d2ae0e86df7c@web.de>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <57c2f4dc-06b9-b330-a01c-d2ae0e86df7c@web.de>
Message-ID: <87pmwx4r94.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 07 2021, Ren=C3=A9 Scharfe wrote:

> Am 07.06.21 um 13:24 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Tue, Jun 01 2021, Ren=C3=A9 Scharfe wrote:
>>
>>> Am 01.06.21 um 02:38 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>> With a54e938e5b (strbuf: support long paths w/o read rights in
>>>> strbuf_getcwd() on FreeBSD, 2017-03-26) we had t0001 break on systems
>>>> like OpenBSD and AIX whose getcwd(3) has standard (but not like glibc
>>>> et al) behavior.
>>>>
>>>> This was partially fixed in bed67874e2 (t0001: skip test with
>>>> restrictive permissions if getpwd(3) respects them, 2017-08-07).
>>>>
>>>> The problem with that fix is that while its analysis of the problem is
>>>> correct, it doesn't actually call getcwd(3), instead it invokes "pwd
>>>> -P". There is no guarantee that "pwd -P" is actually going to call
>>>> getcwd(3), as opposed to e.g. being a shell built-in.
>>>>
>>>> On AIX under both bash and ksh this test breaks because "pwd -P" will
>>>> happily display the current working directory, but getcwd(3) called by
>>>> the "git init" we're testing here will fail to get it.
>>>>
>>>> I checked whether clobbering the $PWD environment variable would
>>>> affect it, and it didn't. Presumably these shells keep track of their
>>>> working directory internally.
>>>>
>>>> Let's change the test to a new "test-tool getcwd".
>>>
>>> Makes sense.
>>>
>>> If /bin/pwd can figure out the path to the current working directory
>>> without read permissions to parent directories then it might be possible
>>> to teach strbuf_getcwd() the same trick, though.  How does it do it?
>>>
>>> Perhaps it falls back to $PWD; POSIX says the behavior of pwd is
>>> unspecified if that variable would be changed, so a compliant
>>> implementation would be allowed to do that.  I think that way is not
>>> interesting for strbuf_getcwd(), though, because if we trust that
>>> variable then we can read it directly instead.  It gets stale if any
>>> parent directory is renamed.  E.g. the following commands would print a
>>> string ending in "stale":
>>>
>>> 	mkdir stale
>>> 	cd stale
>>> 	mv ../stale ../fresh
>>> 	chmod 111 ../fresh
>>> 	/bin/pwd -P
>>
>> Yes, AIX prints "stale" here, but e.g. my Linux box prints "fresh".
>
> OK, thanks for checking.  I find it weird: Why would they add a command
> that basically prints $PWD when callers can easily access this variable
> directly?  Anyway, it is what it is.

Not so much them but POSIX sayeth:

    If an application sets or unsets the value of PWD , the behavior of
    pwd is unspecified.
    -- https://pubs.opengroup.org/onlinepubs/007904875/utilities/pwd.html

And you can't be POSIX-compatible without a pwd(1) command. Ergo a
system like AIX needs a pwd utility, whether it'll return the same thing
as "$PWD" in some scenarios or not.

By they way: I don't know how AIX implements pwd(1), and whether it's
purely redundant or whatever in this case.

>>> Perhaps it asks the kernel, like getcwd() does on FreeBSD.  It would
>>> be a bit weird to expose this functionality in a command line tool, but
>>> not in the library function, so this is unlikely.  You seem to say that
>>> /bin/pwd is a shell builtin on your system, which is also weird, though.
>>> The commands above would print a string ending in "fresh" with the
>>> syscall method.
>>>
>>> An evil way would be to temporarily add read permission to all parent
>>> directories.  It would also print a string ending in "fresh".  You'd
>>> probably see chmod calls when running /bin/pwd using truss in that
>>> case, and it would fail if chmod is not allowed.
>>>
>>> That's all I can think of.
>>>
>>> If strbuf_getcwd() were to learn any of these tricks, then so would
>>> "test-tool getcwd", via its xgetcwd() call.  At that point we'd better
>>> rename GETCWD_IGNORES_PERMS to XGETCWD_IGNORES_PERMS.
>>>
>>> But I guess we need none of that because we never got a request from
>>> an AIX user to support a /home directory without read permissions,
>>> right?
>>
>> I don't really see the point of trying that hard. Yes, we could make
>> some forward progress if we bent over backwards and got the current
>> working directory, but what would we be left with? A git repository the
>> user can't "ls" inside of.
>
> The reason would be support for execute-only (e.g. 0711) /home, which
> some systems have for privacy reasons.
>
>> So any number of other thing after that now-working xgetcwd() call would
>> fail, we couldn't list any files in the working tree or .git directory.
>
> Users own their /home/directory in that scenario and have full
> permissions in their repositories.  They cannot verify the name of their
> /home/directory using readdir(), though.

Ah, I think I'd earlier misunderstood the test-case and thought it was
merely about a "git init xyz" where xyz itself is in that state..

>> Why not just fix the bug in there being disconnect between pwd and
>> getcwd() here and move on?
>
> If you mean the false assumption that /bin/pwd uses getcwd(): I still
> think that your patch makes sense, as I wrote in my first reply,
> implying that I agree it should be applied.

Ah, thanks. I wasn't quite clear or that, i.e. whether the
strbuf_getcwd() was a suggestion of some follow-up work or that this fix
should take that alternate route. Thanks!
