Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CADC49EA6
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 00:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1191A61351
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 00:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhFYA3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 20:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhFYA3j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 20:29:39 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEBBC061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 17:27:18 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ot9so11317303ejb.8
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 17:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=X8Jf+588T8zcYPUFPud4saDGcqoS+JdeSpHj0R9o2dQ=;
        b=qMb2LXOhAzEPg7wSzZi1szxYs3tolZBEXUNUOH/pCmytV1dS46Gdh3+MlUOL4GEIH/
         fBnboVrzXjJrXhbjgnibnST+qeGOIUlgdi8V9hTqryM6XuWcOEhaVbYpryYmt6jUmGaI
         7oLp+csTmwJgvG8p/vxqZYLo5TB+RuHQ1TvPee4bTn+v6NT/EVlIAkrfLWRPilyOkIZa
         i349IgT4aCmOvz2LmpnfkJ9cr/ZRe83+BqzINn2/ENUe6YUiP+Ipn2BhF3+Shmj0KCdn
         6GDE8ocW6iCprg2X1jyhahHVRnaXmge4Du2459+4A/48/MnPPWXuY2GAYp5QyDoebjZ5
         HbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=X8Jf+588T8zcYPUFPud4saDGcqoS+JdeSpHj0R9o2dQ=;
        b=R3LBEbiXTj8M0GxAwwnEoc8c4WZRHOYwhG0Vs1KfAIa+R/EjXu+0/1IBIAvWw8Lpzj
         7w6zjX6cT2xKoyZ8Wj7zI4Ri34dwzYMGex0wscsHSlQrmreWCMtyYc3Km55UrX7p0Y1O
         7CS5+K6h0jEFVcNucfuHNIv9dahPJnWSFDEhvjWVHK4jf5a2YEYP3rrdMIEfsdnTNY1/
         bv4smgJa7ZrHWmB2xmjKa9q0g0ZMKlwV+/cxuqtSrulE0TWc682pxlGSLd5oOFyZDg/7
         X8qIOCP/lKi8CDoUVO0r02nkqyarOoIQHoc//sfGY0RBuTttOCkVescYX8hx9Qgp8AaT
         tNoA==
X-Gm-Message-State: AOAM532lhTMNpniQ4LzJpQL+JgV7k3RZ2+b6rUqQVZvoU9uyzz3t8FRm
        rBaXJlTybcKlD5wsdwZn1Mo=
X-Google-Smtp-Source: ABdhPJzywHcO0jpsC1dJSMVrnOsnxcBmTE1SpqvWhwpK04xv5Fv48DOHavoAWEs+Y2BUdOTAZ5JMgg==
X-Received: by 2002:a17:906:3c44:: with SMTP id i4mr7948600ejg.371.1624580836696;
        Thu, 24 Jun 2021 17:27:16 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id eb8sm2867029edb.22.2021.06.24.17.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 17:27:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, emilyshaffer@google.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        peff@peff.net, sunshine@sunshineco.com
Subject: Re: Why the Makefile is so eager to re-build & re-link
Date:   Fri, 25 Jun 2021 02:11:57 +0200
References: <874kdn1j6i.fsf@evledraar.gmail.com>
 <20210624233516.23564-1-oystwa@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210624233516.23564-1-oystwa@gmail.com>
Message-ID: <87wnqiyejg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 25 2021, =C3=98ystein Walle wrote:

> Hi, =C3=86var
>
>> {command,config}-list.h (and in-flight, my hook-list.h): Every time
>> you touch a Documentation/git-*.txt we need to re-generate these, and
>> since their mtime changes we re-compile and re-link all the way up to
>> libgit and our other tools.
>>=20
>> I think the best solution here is to make the generate-*.sh
>> shellscripts faster (just one takes ~300ms of nested shellscripting,
>> just to grep out the first few lines of every git-*.txt, in e.g. Perl
>> or a smarter awk script this would be <5ms).
>>=20
>> Then we make those FORCE, but most of the time the config or command
>> summary (or list of hooks) doesn't change, so we don't need to
>> replace the file.
>
> One possible technique to fix this is to generate to a temporary file, an=
d copy
> the temporary file over the real file if it's actually different. I see t=
he
> Makefile already does create a temporary file, so how about something like
> this:
>
> diff --git a/Makefile b/Makefile
> index 93664d6714..9b2f081a2a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2216,7 +2216,8 @@ command-list.h: generate-cmdlist.sh command-list.txt
>  command-list.h: $(wildcard Documentation/git*.txt)
>  	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh \
>  		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
> -		command-list.txt >$@+ && mv $@+ $@
> +		command-list.txt >$@+ && \
> +		if ! cmp -s $@ $@+; then mv $@+ $@; fi
>=20=20
>  SCRIPT_DEFINES =3D $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
>  	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
>
>
> This seems to work fine from my basic testing. I think it can even be wri=
tten
> more terse as `&& ! cmp ... &&` but that looks a bit weird to me. In any =
case
> it looks like it can easily be added the other relevant places in the Mak=
efile
> too.

I see your downthread "oops", no worries. Just to elaborate slightly on
the comment I had in [1] (and as you've doubtless discovered) then yes,
this works the first time:
=20=20=20=20
    $ touch Documentation/git-bisect.txt
    $ make -k -j $(nproc) git
        GEN command-list.h

Without your change we'd have also had to recompile "git", but the
problem is that if you run and re-run that we'll keep making
command-list.h again and again, which is "make" getting stuck on,
because:

    $ make -d -k -j $(nproc) git 2>&1 | grep newer.*command-list.h
        Prerequisite 'Documentation/git-bisect.txt' is newer than target 'c=
ommand-list.h'.

Hence the "lowest level" comment in [1], i.e. you can only use this
"cmp" trick for things that don't themselves have dependencies.

Which at the end of the day is why make is both wonderful, and why it
sucks.

It sometimes gets hard to force your "circular" dependency graph into
the "square peg" of files and their mtimes, but it's also great for
simplicity that everyone can't write their own custom "this is what it
means for my dependencies to have changed" function (which in practice
would break way more in the hands of most programmers, including yours
truly, than files & their mtimes).

E.g. in this case we don't *actually* depend on Documentation/git*.txt
for the purposes of re-making things all the way up the graph, we depend
on the tiny bit of data we extract from those files, basically just the
NAME section at the very beginning.

The only way to represent that information in a way that "make"
understands would be to add another intermediate step where we extract
exactly that information out into intermediate files with a script, and
then in turn depend on those files.

Which actually, might not be such a bad idea as a solution to this
particular problem.

I.e. just to have individual generated versions of
git-bisect.txt.just-what-command-list.h-needs. We do something vaguely
similar with Documentation/build-docdep.perl, which is another glorious
hack of trying to get make's dependency graph to behave as we'd like.

As a practical matter it wouldn't get you very far except for doc-only
changes, since you'd still have the version.c problem, which also
changes on every (code) commit.

1. http://lore.kernel.org/git/87y2azyzer.fsf@evledraar.gmail.com
