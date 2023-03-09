Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC805C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 10:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjCIKjN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 05:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjCIKi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 05:38:58 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E071F914
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 02:38:20 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 82so1383278ybn.6
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 02:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678358299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJuHp5sbq2LShdk8ySM2Ex2ytIQ05q9OCrmA9Jm6LUU=;
        b=I5CxXBNqu6SHv0spTO4B3rP1LTZNVbAgnp7oE4vlezQXNyGApdHAmJXGKcUw5EqSAk
         ku5o6nGSvdXvC2L2PaML0h6KLAB3kOd1EMMnhx2t4vwuXd/7fXHi8ujxz+G9ZXdHowNw
         DbpR396jSu3fNegb5mo4XhhQDwfVMbBXFMfrSWCFdK8XEOD3F0+Ngr1eR6T8b/joWjQX
         MKHHhoMu/9n7YntDVKia39sZ0MDPqN+dTLj5kpW2Ty64VWMhiswX24eaeicN01A0TMXn
         5O+DPmkDUN+Y+ej2+iu5SgQ8WXEF/h1wLZjg3jsD4L4lMz28X/sV1YcepjsVIOh+mHL5
         bMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678358299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJuHp5sbq2LShdk8ySM2Ex2ytIQ05q9OCrmA9Jm6LUU=;
        b=gUcIJ/gC2Ta9MJHsob+CAZM0vtJsRnSYrJNR0QUdJXULo3XVVYUVAjpB35zcDKmYnr
         sr9hnrb2V6++OQdKM/rg+eC1+Tvm8Rz05q/3l4BJhBiVzIV3VsHlsfvL2qFLW1X3b5OI
         BYxv5L+82NG0VJnFN/+xJ3aHxxZNbrC0YjZHgwzjye4+iRdUs4Ry3ZWZugNBXpLGMbFD
         Z5S+YhjNJty4PBAknncGz89h4d1QFD9UbK0MHrMu7sg2m9UQIiL43TSs8v6QTEVsPnJ4
         rF9ZRKMkFdAElzHfXXathQQVVt9cYgPijKk/xGhTwwJboAAMSpTUfEZaMU27hCoWla2G
         Pd1g==
X-Gm-Message-State: AO0yUKU+ugF5mMZoEh+b9fCwWO0NRrWtNXMFKEWOfylb19xcgsdupc61
        OJA5GTTy4qtN5dZ/udfT1hGeLaqIp3GhgP63BkginJ28LXsHhQ==
X-Google-Smtp-Source: AK7set+93TUMFjKzWh2Mo71CLFHTxi2vRN5n4N9M4NgvO00bAXvsj9u0qMJGBZ4ujlTaYcJPuh/qfN12st9ms1hbvo0=
X-Received: by 2002:a5b:647:0:b0:932:8dcd:3a13 with SMTP id
 o7-20020a5b0647000000b009328dcd3a13mr13162587ybq.5.1678358299476; Thu, 09 Mar
 2023 02:38:19 -0800 (PST)
MIME-Version: 1.0
References: <CAOLTT8TcX6Wit=AOFGNLjA4v9HAvJJxCEtt3JhgUR+3OARycNw@mail.gmail.com>
 <CAN0heSoVBmkuEOkW3wRNXRRjG7y8UqvORie6ocYnmQRz4jEXkg@mail.gmail.com>
In-Reply-To: <CAN0heSoVBmkuEOkW3wRNXRRjG7y8UqvORie6ocYnmQRz4jEXkg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 9 Mar 2023 18:38:08 +0800
Message-ID: <CAOLTT8QAd_dzmDrkLpyVCZykb_sPzR0VzsPf_jtQqim_NpqZFg@mail.gmail.com>
Subject: Re: Question: How range-diff lapjv algorithm work
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, t.gummerer@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=88=
8=E6=97=A5=E5=91=A8=E4=B8=89 15:47=E5=86=99=E9=81=93=EF=BC=9A


>
> On Wed, 8 Mar 2023 at 07:50, ZheNing Hu <adlternative@gmail.com> wrote:
> >
> > My question is:
> > 1. In step 3, why is the matrix size (a.nr + b.br) * (a.nr + b.br)
> > instead of a.nr * b.nr?
>
> There's some explanation of that in the man page for `git range-diff`,
> under "ALGORITHM". Look for "To explain also new commits, we introduce
> dummy nodes on both sides:".
>

Thanks, I can understand why the length of the matrix is "a.nr + b.nr" now.
Patches in one collection may have no matching patches in the other
collection, this mismatch situation ("o--C" in the documentation) should
also count the cost.

> > 2. Why the cost(x,y) which satisfies "x =E2=88=88 [a.nr, a.nr + b.nr) y=
 =E2=88=88 [0,
> > b.nr) || x =E2=88=88 [0, a.nr) y =E2=88=88 [b.nr, b. The cost of nr + a=
.nr)" is set to
> > "diffsize(a or b) * creation_factor / 100 : COST_MAX"? What is the
> > role of creation_factor? [1]
>
> The `--creation-factor` command line option is also described in the
> manpage.  There was a thread on the mailing list with various
> discussions around this creation factor a while back. Maybe there's
> something interesting there [1].
>

I understand it now. Because mismatch "o--C" "1--0" cost are generally
greater than the cost of two completely different patches "1--C" "0--0".
Use the creation-factor to reduce the cost of "0-C" "1--0" make
"o--C", "1--0" as matching result.

> > 3. How does LAPJV work here? [2]
> >
> > [1]: https://github.com/git/git/blob/725f57037d81e24eacfda6e59a19c60c0b=
4c8062/range-diff.c#L310
> > [2]: https://github.com/git/git/blob/725f57037d81e24eacfda6e59a19c60c0b=
4c8062/linear-assignment.c#L15
>
> This appears to be based on work by Jonker and Volgenant. Maybe
> searching for those names online could find something. Maybe not
> git-specific, but even if it's just the general algorithm as such, it
> might be possible to find different explanations of the algorithm.
>
> I haven't really studied this algorithm, but since it's faster than the
> Hungarian algorithm, I could imagine that either
>
>   * it's super-useful to first understand the Hungarian algorithm, then
>     understand why and how the Jonker-Volgenant algorithm does better,
>     or,
>
>   * it's completely useless to first understand the Hungarian algorithm,
>     since they're so different.
>
> :-)
>

Ah, I had a look at the Hungarian algorithm earlier, because it is the most
typical algorithm in linear assignment problem, it can still be understood.
I didn't read that paper by Jonker and Volgenant, but I should try to read
it later.

> [1] https://lore.kernel.org/git/1196830250.20220726145447@yandex.ru/
>
> Martin

Thanks for the answer!

--
ZheNing Hu
