Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1568FC433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 23:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF2BF619F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 23:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344543AbhI3X1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 19:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhI3X1b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 19:27:31 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A9CC06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 16:25:47 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ba1so28086324edb.4
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 16:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cEGEK+AWKlXYTnWXMMFykNUNLHuzY5aZuVyuWWCkBdc=;
        b=Fb2a0YieyGxpDQ+JUI0T8EDkZaeVywUsziJct4zyU8oMpzBj717Zbjg8aDWyOHbvDl
         NfLB3pVbTquXS1G2vTy5W7Dixru3zPsEg8ORFwXMx3hGIU9trV+djk6vvOSql51CPW4W
         NXUipxnGEJ1M2MM2FZuuqDA7T2Qqoy6T6gSWeoA6j9BOjHIc1urpQM48khqZbFQreMPS
         jKq+Y3wBIeqhgBBKjMQWBKzlYBqeOkbv/rZEHdMOlLDP2W1E87OBNwO5gH3NX/f1iLhq
         uP4tRKzpEn1exNlpNStYCiuikEfiEcPzsyMK3QrAUdE9PIPSJ8sUCAEPcNwmMne9vRNv
         M7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cEGEK+AWKlXYTnWXMMFykNUNLHuzY5aZuVyuWWCkBdc=;
        b=GmIPHSt8S0Smd2n3wcYWss5aNiNxUx/X1YJP6DVTdASsrFRXncCsIgw143NsXqiPjh
         3ucbILp8jJO33uCkyq2FnMfBfSzqxGmg4CgD+I+AwL6igZP4TkBK5qSlaVXPI3V97pYr
         jbmVB3PvUM5fXDRZNmZFMkQxd6iWy8fDlGrec49WFkIj+YKVebZKQCAn/h/8pZfM9GKh
         HWrYF5WSGMpZgPgixBijybfjZMfS0KW+WFWLTJb4q1HbkoUzr10x9HlQIk6/HhVrbuSy
         hBAc0URCeDlyfEwuMhMnUN+ElugaIZ/Yk2c++iAQCAXjhmdmFuHpwDmuXGphpK3V3t1c
         m8JQ==
X-Gm-Message-State: AOAM531n3AieK+H1p/k5qK7fvkv23dekf620uNtovVtEzjOUrRMjTQ2M
        kypte4q7IHw+AoOJcTcaYAg9/hB0E/1lrDUeXWg=
X-Google-Smtp-Source: ABdhPJyU/ByGa/iZ9czqa9KKG4fZ7cK7MtMcTem7lhwPbZjhBgp8MZgjopnGfyDmRRJ/d8dsLbMIip7vihsdGnsRjBE=
X-Received: by 2002:a17:906:1c0e:: with SMTP id k14mr2439884ejg.286.1633044346277;
 Thu, 30 Sep 2021 16:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210930170146.61489-1-davvid@gmail.com> <20210930170146.61489-3-davvid@gmail.com>
 <xmqq7dexafch.fsf@gitster.g>
In-Reply-To: <xmqq7dexafch.fsf@gitster.g>
From:   David Aguilar <davvid@gmail.com>
Date:   Thu, 30 Sep 2021 16:25:10 -0700
Message-ID: <CAJDDKr41qzbUudAHgokRARK-kEG4araFwJ0UhLmJ4Pca=xFZRA@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] difftool: avoid returning -1 to cmd_main() from run_dir_diff()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 3:06 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> David Aguilar <davvid@gmail.com> writes:
>
> > difftool was forwarding the -1 result from error() to cmd_main(), which
> > is implementation-defined since it is outside of the 0-255 range
> > specified by POSIX for program exit codes.
> >
> > Stop assigning the result of error() to `ret`. Assign a value of 1
> > whenever internal errors are detected instead.
>
> Many existing codepaths take advantage of error() returning -1 and I
> do not see anything is wrong to keep that "negative is error"
> convention for the value of "ret" variable.  Most lines in this
> patch however split that "ret =3D error(...)" pattern into two
> statements and I do not see a very good reason for it.
>
> Worse yet, after applying this patch, there still are at least three
> assignments to "ret" that can give it a negative value:

Indeed.

>
>         if (!mkdtemp(tmpdir.buf)) {
>                 ret =3D error("could not create '%s'", tmpdir.buf);
>                 goto finish;
>         }
>
>         ret =3D run_command_v_opt(helper_argv, flags);
>
>         strbuf_addf(&buf, "%s/wtindex", tmpdir.buf);
>         if (hold_lock_file_for_update(&lock, buf.buf, 0) < 0 ||
>             write_locked_index(&wtindex, &lock, COMMIT_LOCK)) {
>                 ret =3D error("could not write %s", buf.buf);
>                 goto finish;
>         }
>
> Among them, the return value from run_command_v_opt() eventually
> come from wait_or_whine(), I think, so it may be generic -1 or
> it may be WEXITSTATUS() of the child process.
>
> But I am not sure if this particular caller cares.  It is not

The property I was trying to maintain is that we would forward the result
from the child process in most situations, so we should try and forward
the result from run_command_v_opt() whenever possible.

But for the others we would have to add an "ret =3D 1" there,
and that doesn't seem worth it since it's too hard to maintain.



> prepared to handle -1 and positive return from run_command_v_opt()
> any differently.  So I think a single
>
> -       return ret;
> +       return !!ret;
>
> at the end would be much easier to reason about and maintain.

Hmm I don't think we can use "return !!ret".

In C this does a bool cast so we lose the positive value from the
underlying diff tool when the value is quantized to 0/1 via !!ret.

That suggests that =C3=86var's sug is better...

    return (ret < 0) ? 1 : ret;

If that sounds good I can send a replacement series that squashes this into=
 the
repeated-symlinks patch. It doesn't seem like we'll need a separate
patch for this.

--
David
