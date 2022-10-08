Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A37C433F5
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 17:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiJHRLR convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 8 Oct 2022 13:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiJHRLO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2022 13:11:14 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6FF4620F
        for <git@vger.kernel.org>; Sat,  8 Oct 2022 10:11:11 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id y4so1183621iof.3
        for <git@vger.kernel.org>; Sat, 08 Oct 2022 10:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWOogsSpt4vkSae+6CUOEDRy7ecHJJx9SpZJGQVCh+U=;
        b=SCqensRPA0DMTBK2fwHj450NwEnLNi67gMAetFZsrBk5shsrtWWxQTX4UXW2Fz3WKg
         V5v72XbKCmOJWbdgpU6gno1ZyO4rEKi19wSk86vTUkCOBJzrcErJpIazO4hI+gKugROt
         DLudM1y/xhYxYJLeiS8AnCsNe1gofU+U2DTXYVS7SCI1I4KhEdIveJZTF65UhVk6pJec
         aXlHVTKJEJzX/4Q1zzxKL9d7JXbKtjzWw/wLy9WvMR+BDIkm7Kfk07iIe/yc1zwUidPh
         4/RLlllicPaV7Wm138uXFI55wLLWwJKhKWwhzxp61W/9gyYtrNCEsAKljxgeki1Fwboz
         l0BQ==
X-Gm-Message-State: ACrzQf0nCDocjLmcYM32il2SwKIGx0knLbbdIHzUzt8exVTPyCdz+ACf
        twtfHdintzI7j6pldxVXKdmC3lhZVQmrsW15m0I=
X-Google-Smtp-Source: AMsMyM47n+4METeel+5DgDDN7rf2kjdVISYFcqeNG+uZzLwI3p1i9wnR4D2HaEzBHXaJxWbG7Xq3zvdFo8K0L2RJMdw=
X-Received: by 2002:a05:6638:4495:b0:363:1e09:57e5 with SMTP id
 bv21-20020a056638449500b003631e0957e5mr5280473jab.177.1665249070794; Sat, 08
 Oct 2022 10:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
 <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com> <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
 <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com> <CAPig+cSX9jSPc_fJc0tuiER1-AqnbFGOk0r1tXEkv9gycVH-CA@mail.gmail.com>
 <f24837e9-7873-c34c-bd78-8ae3be0fc97a@gmail.com> <CAPig+cSn29Fq4ywC9zXoJYRVG8KUEhHuDdwEUSioFMUVs+S-ow@mail.gmail.com>
 <a7aca891-dd37-7e5e-61fc-8012fec18ae9@gmail.com>
In-Reply-To: <a7aca891-dd37-7e5e-61fc-8012fec18ae9@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 8 Oct 2022 13:10:59 -0400
Message-ID: <CAPig+cRxy5C+CqUOzmhe16j+hssxsygha3huVga8tLJ+imM4Hw@mail.gmail.com>
Subject: Re: [PATCH v4] branch: support for shortcuts like @{-1}, completed
To:     =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 8, 2022 at 5:12 AM Rubén Justo <rjusto@gmail.com> wrote:
> On 8/10/22 9:23, Eric Sunshine wrote:
> > On Sat, Oct 8, 2022 at 3:07 AM Rubén Justo <rjusto@gmail.com> wrote:
> >> Oops. Thank you! I'll reroll back to using "git stripspace".
> >
> > `git stripspace` is perhaps unnecessarily heavyweight. Lightweight
> > alternatives would include:
> >
> >     printf "Branch description\n\n" >expect &&
> >     [...]
>
> Yeah, I thought about that.  What convinced me to use "git stripspace" was
> that maybe that '\n' tail could be removed sometime from the description
> setting and this will be fine with that.  I haven't found any reason for
> that '\n' and it bugs me a little seeing it in the config :-)

That reasoning occurred to me, as well, and I'd have no objection to
git-stripspace if that's the motivation for using it. I don't feel
strongly one way or the other, and my previous email was intended
primarily to point out the lightweight alternatives in case you hadn't
considered them. Feel free to use git-stripspace if you feel it is the
more appropriate choice.

> But I agree with you about the unnecessarily heavyweight, though all
> involves a new process, probably echo, cat or printf are lightweight than
> another instance of git for that.

In most shells, `printf`, `echo`, `cat` are builtins, so no extra
processes are involved (and `test_write_lines` is a shell function
built atop `printf`). As a matter of personal preference, given the
lightweight options, I find that `printf "...\n\n"` shows the
intention of the code most plainly (but if you go with git-stripspace,
then `echo` would be an idiomatic way to create the "expect" file).

> All of this involves two files and that is how it is done almost everywhere
> except in some places where it looks like an 'older way' (test_i18ngrep) of
> doing it.  Is there any reason to do it this way and not using variables,
> process substitution,..?

An invocation such as:

    test $(git foo) = $(git bar) &&

throws away the exit-code from the two commands, which means we'd miss
if one or the other (or both) crashed, especially if the crash was
after the command produced the correct output. These days we try to
avoid losing the exit command of Git commands. It's possible to avoid
losing the exit-code by using variables:

    expect=$(git foo) &&
    actual=$(git bar) &&
    test "$expect" = "$actual" &&

but, if the expected and actual output don't match, you don't learn
much (other than that they failed). You could address that by showing
a message saying what failed:

    expect=... &&
    actual=... &&
    if test "$expect" != "$actual"
    then
        echo "expect not match actual"
        # maybe emit $expect and $actual too
    fi

However, `test_cmp` gives you that behavior for free, and it emits a
helpful "diff" upon failure, so these days we usually go with
`test_cmp`.

> Anyway I'll switch to one of your suggestions, as it is definitely easier
> to read, understand and therefore change if needed.

It's fine to use git-stripspace if you feel it's more appropriate for
the situation.
