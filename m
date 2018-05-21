Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB6FA1F51C
	for <e@80x24.org>; Mon, 21 May 2018 18:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751100AbeEUSnF (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 14:43:05 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:42761 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbeEUSnE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 14:43:04 -0400
Received: by mail-yw0-f194.google.com with SMTP id q7-v6so4768981ywd.9
        for <git@vger.kernel.org>; Mon, 21 May 2018 11:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H1ccxC5pMlrLIdCkoJTwuhdtOGmPeTD/tS77IRy8/B0=;
        b=tkQse//Tgq2/uykf8/3ZxLTlFlLyEZF2v3hRhFjqw0A67yRk5UakYMJkKlZpATZNBx
         odvl/6TuWW+1Oj43b7RUZcad7RajGv52t3AJg7/HIFEtMDIWhJzE4j+T90sSiygfYULe
         cdh9FNhseS5FPd+M01JcVNVlSttrCQDBbWf7Mc25QleSpEC0IWSStguO2lxJkJaADFoO
         ljkX2RE9de7UZ9hJA/Lzi9mEqJH4Xe7nUehkDrCMAsE2ntpELtNg5Pr8MrpuApxYPs59
         UDt9Y1tOroHE9uCilWSoJEWEVLPhY5NbXyjg3rtl9D+f2U81WEtHUo13ruqKAUGiqYhM
         WdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H1ccxC5pMlrLIdCkoJTwuhdtOGmPeTD/tS77IRy8/B0=;
        b=TefOtuBHooNxvKR7XU+Hb2DnmF9lT8KIlfzU9xeo6XkIEaPj3QW8OlEP2Uy5+1vs85
         py6sQtylnqedzCbJbonKheNgAsuaQBeQC8eYKaiN8llTiMrjuxgQI48PB2S6wfDe9Mrp
         iGaFCsoUH68lQmnoVbiJrc1Ye9tK462aaO2Hwms1wzesqAzP57cC6GASbLbYivPkQTvF
         06n6y1hLdDMjMABj9laAlhOMl3PCeH9pQSh2/2TcdP3yMZ5ILobFX2g5kTKF3BzwjSvX
         TPlvnZ4n4eG5SphWc+/9ZJ5SppfDyHged5uXr9gDT8joFUIFz7HkTkf3E3G7TclZmMDt
         t3Lw==
X-Gm-Message-State: ALKqPwfxNWlGhzT9IAS1pF6G9ImTsu0HY5j1AuWwaPNFJxahGe1cCSD2
        N7FMTOTSENCOnnWzqHu/x6sZul/VK/k5PLaG5i9Q9Q==
X-Google-Smtp-Source: AB8JxZq4sNouWaDfHcUnkVVjbDr1CbaXfwGCCYwBUBLIeJWkK4BWltHV/dzee6ngSTfky4r8aCKvIxB9h0ou1M265HM=
X-Received: by 2002:a81:9447:: with SMTP id l68-v6mr10461232ywg.345.1526928183543;
 Mon, 21 May 2018 11:43:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Mon, 21 May 2018 11:43:03 -0700 (PDT)
In-Reply-To: <20180520105032.9464-1-martin.agren@gmail.com>
References: <CAPig+cQaJmsJe=E6HdBw0s6eN-qW0OCezBacRcQ+UnJYMbODsw@mail.gmail.com>
 <20180520105032.9464-1-martin.agren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 May 2018 11:43:03 -0700
Message-ID: <CAGZ79kZotwAFauTkCJ6YZ_C-MuaQpNaaS8LCniL_Or=_ccfC4w@mail.gmail.com>
Subject: Re: [PATCH] regex: do not call `regfree()` if compilation fails
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 20, 2018 at 3:50 AM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> It is apparently undefined behavior to call `regfree()` on a regex where
> `regcomp()` failed. The language in [1] is a bit muddy, at least to me,
> but the clearest hint is this (`preg` is the `regex_t *`):
>
>     Upon successful completion, the regcomp() function shall return 0.
>     Otherwise, it shall return an integer value indicating an error as
>     described in <regex.h>, and the content of preg is undefined.
>
> Funnily enough, there is also the `regerror()` function which should be
> given a pointer to such a "failed" `regex_t` -- the content of which
> would supposedly be undefined -- and which may investigate it to come up
> with a detailed error message.
>
> In any case, the example in that document shows how `regfree()` is not
> called after `regcomp()` fails.
>
> We have quite a few users of this API and most get this right. These
> three users do not.
>
> Several implementations can handle this just fine [2] and these code path=
s
> supposedly have not wreaked havoc or we'd have heard about it. (These
> are all in code paths where git got bad input and is just about to die
> anyway.) But let's just avoid the issue altogether.
>
> [1] http://pubs.opengroup.org/onlinepubs/9699919799/functions/regcomp.htm=
l
>
> [2] https://www.redhat.com/archives/libvir-list/2013-September/msg00262.h=
tml
>
> Researched-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-byi Martin =C3=85gren <martin.agren@gmail.com>
> ---
>
> On 14 May 2018 at 05:05, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> My research (for instance [1,2]) seems to indicate that it would be
>> better to avoid regfree() upon failed regcomp(), even though such a
>> situation is handled sanely in some implementations.
>>
>> [1]: https://www.redhat.com/archives/libvir-list/2013-September/msg00276=
.html
>> [2]: https://www.redhat.com/archives/libvir-list/2013-September/msg00273=
.html
>
> Thank you for researching this. I think it would make sense to get rid
> of the few places we have where we get this wrong (if our understanding
> of this being undefined is right).
>
>  diffcore-pickaxe.c | 1 -
>  grep.c             | 2 --
>  2 files changed, 3 deletions(-)
>
> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> index 239ce5122b..800a899c86 100644
> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -215,7 +215,6 @@ static void regcomp_or_die(regex_t *regex, const char=
 *needle, int cflags)
>                 /* The POSIX.2 people are surely sick */
>                 char errbuf[1024];
>                 regerror(err, regex, errbuf, 1024);
> -               regfree(regex);

While the commit message is very clear why we supposedly introduce a leak h=
ere,
it is hard to be found from the source code (as we only delete code
there, so digging
for history is not obvious), so maybe

     /* regfree(regex) is invalid here */

instead?

>                 die("invalid regex: %s", errbuf);
>         }
>  }
> diff --git a/grep.c b/grep.c
> index 65b90c10a3..5e4f3f9a9d 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -636,7 +636,6 @@ static void compile_fixed_regexp(struct grep_pat *p, =
struct grep_opt *opt)
>         if (err) {
>                 char errbuf[1024];
>                 regerror(err, &p->regexp, errbuf, sizeof(errbuf));
> -               regfree(&p->regexp);
>                 compile_regexp_failed(p, errbuf);
>         }
>  }
> @@ -701,7 +700,6 @@ static void compile_regexp(struct grep_pat *p, struct=
 grep_opt *opt)
>         if (err) {
>                 char errbuf[1024];
>                 regerror(err, &p->regexp, errbuf, 1024);
> -               regfree(&p->regexp);
>                 compile_regexp_failed(p, errbuf);
>         }
>  }
> --
> 2.17.0.840.g5d83f92caf
>
