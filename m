Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED45A1F4C0
	for <e@80x24.org>; Fri,  4 Oct 2019 22:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbfJDWEE (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 18:04:04 -0400
Received: from mout.gmx.net ([212.227.17.22]:59639 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbfJDWED (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 18:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570226638;
        bh=7qO5ed6QySn8DWKzwiTxwoY1uuzkdoNWUq10QyIhKUY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=E4vC2E4OW/rra8NeRs4Oc1iYiKvgAPo3YB1ly4oDxxTG1uK3GOIhIsrGR896QcSLp
         nf0wZfSxNMAP0L8gqnZ3mIdIl5kq9280lzYYt5BtGBtMQaaWiPNo0jke5twusKsJsQ
         a5qUtxiwAec/tsnd5HoTPSKRtFDarB2nrFjY3VnU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4z6q-1i6RUA0XtE-010tIR; Sat, 05
 Oct 2019 00:03:58 +0200
Date:   Sat, 5 Oct 2019 00:03:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] fetch: let --jobs=<n> parallelize --multiple, too
In-Reply-To: <xmqqftk9870h.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910042356450.46@tvgsbejvaqbjf.bet>
References: <pull.369.git.gitgitgadget@gmail.com> <818936f1e0389820fdfa31f36c6f75e8a4bb1a07.1569930816.git.gitgitgadget@gmail.com> <xmqqftk9870h.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FbGvTe7JOmn6G6taZTlWOYV/FNJD6MqIKxTChfmYHO7UBQ61AVC
 syfuTF/1l+DRvtT1JeifZ1ZsFRU5Q3xde9uBjvaGp5aGjEj7ixP7D/4PfGAiXQgHAXBIWRo
 xJY5KXcXaa8qkeUxzvdzM396nsg0luf6/3M/uShS+s9QyvHzv3qnoXQqAAk84QlPkeZjt4C
 6vsf/Qn53JBNyfRaOmX1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vdpgqczbwOI=:IkOYhFLErcCLL+8rsH5WJa
 1XGPpNlUeuwz6Jz4Fm8vjACw2GD2mhVL2J7ia3ijsuRhy74yJ7c6RqnkJZtu5LalBM5KQv3nO
 dgVoNopHdEqp3CZc8/kn2mLp9qgmvl9mdF89SC2DNJMjzltF45NYZ9NPTAycBM9VeL10EmQkY
 T2QieY3wvQgED2VsbHYvxDq6qkD56eyY96ZTYR9EVEwhG9g6X6/oRAt1KUFO7VLmTSCl/brNJ
 KCW/I+N8PdJCFSASOfWLydGdMsWlXRbotSnOdMhyJ1X1y58LsX4j5mJgw+xLOjClnIwyK7DWL
 q1yXr7Ws4OfTVj41GP6Zp3Ye7KX16Swv9lkyX829AZzOvCJOpqVl2trLEa0xWVlJy/vpRPlXN
 CldMhJ2ow2wuz43BsDcByaJILGPQed3BlhFJ2TLMf+tRwifnPcYboZosZC1cighU6rtYorVXe
 CCKJ8utWw+n+YOWvSnyQbYslGZEw+BCSYJSgBKqAtWl+xutwH7Rzv5uADvdqq0buElN9tkXV7
 a3qDM+LIsJNpUL5bQobAPKWeQBuXWS7Or2/wusMAaHTqodgY+tIwAmM8tH/LZkEw7AO507zHr
 FZ2bFId184SDHc9Op0+vzmUYHVUJpa+hT+gSBlTlwkfZXXKiY8wKyBnrrhdRkRwoHpMWzWbox
 LQcWBd9slzp9jtaMXrJeMWi3WwYJ6cn+b3pbm9cAAQqsjDy5g/rc+VOjcj8XlSo2Rx4IQUVKn
 ST78b1oCb3HPVjApqFz+jcqaj2rGzUjUNP8BfratOFaraBfOeFX5zcsvTF3s4XTOP7Mg37a7M
 +jq4ru+UHm6dmSLdIq8iOOvcaIWUPG9c1JMD3AuykbLa5LhO9SGdPXR0ZSdwwqSPN3KFCRj57
 oUSW6raRsYbkAqSEQ5rC1H14k3i79Zf7eglZv8dwBg5tSVDykrj3+28L8nHN/XBOufnW5Eo0r
 AtCCav0n2oz5yO/6grTBi5uQu9ZeuMRh/0i6472e7AyIZHhgTD07pKVuGlyy6c9ewRyWGs2v0
 sD/7BsH6zK9VVM/HG0c45lDFj1Eytl6F3Ap5DlNUnX1/pB9aCimt4mOTukkq4OV9j8v9GHkgx
 TY3qhLQZSXnaJ9fxJQYeReTpV2PVaCgRh+M+7+3Emz6pQz7ySbPF5ee5EIPIX2HgGelxKR6Wb
 8KX/RUd17Dg6pNFooq77Y+nHLHwa+VIf9Cs1/MGZ07eitYh4OwkimmHcinurJd/lSRzXc2k06
 489tc9rL6i40ZYttdWBErO/4tCGUZNbxUvJkHeavcn9pB0mv9iXat59hiA/0=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 4 Oct 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > +test_expect_success 'parallel' '
> > +	git remote add one ./bogus1 &&
> > +	git remote add two ./bogus2 &&
> > +
> > +	test_must_fail env GIT_TRACE=3D"$PWD/trace" \
> > +		git fetch --jobs=3D2 --multiple one two 2>err &&
> > +	grep "2 tasks" trace &&
>
> I think this one expects to match this in run-command.c:
>
> 	trace_printf("run_processes_parallel: preparing to run up to %d tasks",=
 n);
>
> > +	grep "one.*128" err &&
> > +	grep "two.*128" err
>
> and these expect to match this in fetch.c
>
> 		strbuf_addf(out, _("could not fetch '%s' (exit code: %d)\n"),
>
> It would have been nice to fellow contributors, if the grep patterns
> were written a bit more tightly.  It would allow people who debug
> test failure to more easily identify which message the patterns are
> trying to catch.

This is a two-edged sword: when those messages change (for whatever
reason), the regression test will fail, too, but it actually wants to
test the parallel fetch, not the trace message of
`run_processes_parallel`.

So I tried to prevent such an unactionable regression test failure. But
I see your reasoning, and I now thought about it and consider those
error messages to be rather stable.

Will fix.

> In any case, the latter two needs to be guarded against
> gettext-poison, I would think.  Without addressing the vagueness of
> the pattern, at least the following needs to be squashed to help the
> CI.

Indeed. I missed this because the GitGitGadget PR build was all green.
My guess is that I messed up the definition of that PR build (it is
_not_ what's in `azure-pipelines.yml` because that would not work
correctly when PRs target older commits). I _think_ I fixed it by
setting `export GIT_TEST_GETTEXT_POISON=3Dtrue` explicitly (previously I
only set the `jobname`, expecting `ci/run-build-and-tests.sh` to pick up
on that.

Thanks,
Dscho

>
> Thanks.
>
> ---
>  t/t5514-fetch-multiple.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
> index cce829b989..33f5220a53 100755
> --- a/t/t5514-fetch-multiple.sh
> +++ b/t/t5514-fetch-multiple.sh
> @@ -190,8 +190,8 @@ test_expect_success 'parallel' '
>  	test_must_fail env GIT_TRACE=3D"$PWD/trace" \
>  		git fetch --jobs=3D2 --multiple one two 2>err &&
>  	grep "2 tasks" trace &&
> -	grep "one.*128" err &&
> -	grep "two.*128" err
> +	test_i18ngrep "one.*128" err &&
> +	test_i18ngrep "two.*128" err
>  '
>
>  test_done
> --
> 2.23.0-686-g3bf927a9c0
>
>
