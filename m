Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC6EC433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EFB9207B7
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbhA0Pwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:52:44 -0500
Received: from mout.gmx.net ([212.227.15.15]:37743 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236322AbhA0Pi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 10:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611761805;
        bh=e/1ta7p/hiyun9QuiGKmkhUbrXcb1jpNYtMKW+pOiAs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=k5DZ1Nk/y0ll6lbgsFogqT1w+aPY6xuZp7vsMxWbRx+w5qwlJhRX2jHc7MyRA1uPk
         3pRmAKbKo93xYxMHMH1Cq5jut3k44L8usyONdHa5jtLsDAkN8KR0uglpmXimTXt0La
         D6/62qv2zdpLtAUMm9XSsTvLrE25r64YmXtZ58Sg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.88.23] ([89.1.213.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLiCo-1lMSHV1BGy-00HcPI; Wed, 27
 Jan 2021 16:36:45 +0100
Date:   Wed, 27 Jan 2021 03:57:15 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/3] range-diff/format-patch: handle commit ranges
 other than A..B
In-Reply-To: <xmqqv9bo7lwd.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2101270342140.57@tvgsbejvaqbjf.bet>
References: <pull.841.git.1611267638.gitgitgadget@gmail.com> <pull.841.v2.git.1611339373.gitgitgadget@gmail.com> <2c2744333ecf5662d4198bdddeee80ff4adf6acd.1611339373.git.gitgitgadget@gmail.com> <xmqqv9bo7lwd.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:c/HflzD3H+tHZemWOFUoMn9kWLGr11BW5Y1uNuz5kVYTP4dGV0m
 Mw2SfmBKH4xk82yjz42TcYGF/kCHx+gZs0zBUqlbo20HU4HdHLXfRAxiKDts0VXih1ViRnj
 xENGhBeBkWzWOigx8p3LSNbAS3NuqSQDo3pNoRWzxTLxyoFwhQsvryfQjTxrMpMIiXvCRL/
 955hA20I2vWNE7fEZDesA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TyReqxSCIxA=:S5jT5Zl+q1exym3USf+yNI
 5PgZX5wvJIX/YnAbPop0nuIHBVbU72bhf3SOQCKaNrmEDKCZAE+UGeAQ3Uwbfk8qH7Upoj0lW
 tC9LBDbi4/PGz1R05hNHL+N8RUq7v83Iuia9RTdhVDdAAyaMZE+YGSpLpIZhMd7xyZmpwOE2E
 Ue7Jhi2mxNo40KtduPdxfxyQa+Lv998OF+++8tcgIY7qExk0qnk8AWu/bJlm+W4qiltbBuS6z
 ak4f1fqYaVagg1l0ladABET6INJxzC+yPqK0fKGl1HSvmIhg+/9XEupN+At2fxS0UVBlvCkUA
 Vt771gGeZt45kKOrmGD9IQvLj2ram1YYqqpeeRhOwLtoAYDbLMxiFm/0CDz7BZPQFEE4NDq3R
 1EXFog4ZtcU4XmsV9uhbsatn/TEWVUnrUy6Daj4DSuXomRK/Lvf9qck3a5hRcIeu5lpQSzjgY
 fh4222wDStLxhOmygZ0nLJQ+VaLfaycT/tj4pYE4rMSZI187F/ZhPnqRJHscXZeOpgIYvemkT
 H4LN2csd76ktVFn+QXo8hGFfS6Zs3xz65/326p8zw5OcjzaDRF/FNRz5BJTD5RcYpWSsGUBmj
 ApGzHBFiR8y1fhfmevHGGa+UEsc4UdS0MdJMtymvJrkpHACB/QcleGa3aHCPv3XM5PT/wRsh8
 vPammEmaNtLp7rgi1M2o4WMZZyToqxsRmA033VVulMxvNyYXYiaCeBQ0hQvyhD1VZOI49jFzM
 AwTflt//vuPxXgEvY52vjID6QUe3Ywn4wH0iYZj4H1yiwV0JNO/gCz0tLhM5Grb5dWBuxud2C
 vfJVkD2pyq/uO7u+pQYop9XfIrkGXSTr7uN5wv0WhtSjfb4M54f5LlAMArWD3akc80RJiw3Is
 v2146R2YvRjbEn7nv4MMUpe48+1NZ0ZXnGh/p4J8w=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 22 Jan 2021, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > +	i =3D strlen(range);
> > +	c =3D i > 2 ? range[--i] : 0;
> > +	if (c =3D=3D '!')
> > +		i--; /* might be ...^! */
> > +	else if (isdigit(c)) {
> > +		/* handle ...^-<n> */
> > +		while (i > 2 && isdigit(range[--i]))
> > +			; /* keep trimming trailing digits */
> > +		if (i < 2 || range[i--] !=3D '-')
> > +			return 0;
> > +	} else
> > +		return 0;
> > +
> > +	/* Before the `!` or the `-<n>`, we expect `<rev>^` */
> > +	return i > 0 && range[i] =3D=3D '^';
>
> This is still way too complex for my liking, but at least I cannot
> immediately spot a glaring off-by-one like the previous round ;-)

Maybe I am too stuck with the idea of avoiding regular expressions after
that StackOverflow incident... Maybe

	static regex_t *regex;

	if (strstr(range, ".."))
		return 1;

	if (!regex) {
		regex =3D xmalloc(sizeof(*regex));
		if (regcomp(regex, "\\^(!|-[0-9]*)$", REG_EXTENDED))
			BUG("could not compile regex");
	}

	return !regexec(regex, range, 0, NULL, 0);

is more readable, and acceptable in this context?

> This is a tangent ([*1*]), but we often equate an omission to
> implicitly specified HEAD; e.g. "git log @{u}.." is what we did
> since we started building on top of our upstream.  I wonder if it
> makes sense to allow similar short-hand so that ^! alone would mean
> HEAD^!, ^@ alone would mean HEAD^@, and so on.

I don't know. On one hand, it would make things more consistent. On the
other hand, it would be relatively hard to explain, I think. And we
already have the shortcut `@!^`, which is hard enough to explain as it is.

Ciao,
Dscho
