Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F42C433E9
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 16:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E12022B49
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 16:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405958AbhARQAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 11:00:48 -0500
Received: from mout.gmx.net ([212.227.17.20]:45087 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406187AbhARQAg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 11:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610985535;
        bh=aT1zLkGbmaSgl4qocSemLhlbIRibwKFWVe5OacYp9Og=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KJtKb4e4Ods1+PEJx2GO1V0d7Hbflp3GWcr5vSfC8k3sx66rRQD0s3vsd6x/3N7G5
         DchG9je7FL5kHsPdw4x7iOS3dm9pB3UCxtNCbD9K2gfGWBXvV1jRe1ZOEi/n5pMYdG
         7iVKpyzwMRT4Qg7fhV/vhM1AT3+1NB0EEbMUPgkg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.115.203] ([89.1.215.22]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N79yG-1m6WEl0Kya-017Wfo; Mon, 18
 Jan 2021 16:58:55 +0100
Date:   Mon, 18 Jan 2021 16:59:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v2 2/7] bisect--helper: reimplement `bisect_replay` shell
 function in C
In-Reply-To: <20201221162743.96056-3-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2101181609480.52@tvgsbejvaqbjf.bet>
References: <20201221162743.96056-1-mirucam@gmail.com> <20201221162743.96056-3-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oXoHn2Kq6kIMAEpEsPhflTOy0VcZi8rq+PFM9ipj2biKTl0Ta56
 FgNw+R7PrFlaW6U32aJnxk6wK1k5AXlGOeleIoEtPWmmXWMEbQDZfFstLrgf682WHAEWF9p
 /QBu+fIm80TGlt7Sc/8MEubVOUkLbfsXIb2mzY27Al3EHJNi2GcRW2eBDn9rPybqJa96ITB
 nSBjh1nxGl/20TT4hA/0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jrhzqU9zqKU=:NQmne5Ws0GB6EFO9P7RD7p
 E0Ymcc0uMCYR+smHyN1Be5bn4gSyKBY9Oi2NYAMvISvzpZwZLHXverZIm9yrPMp6ljLoopsHH
 yyXeA6t9dXtiMMdVcA8HaC43Fq8Q6TyvZIo/TIT2TyaYOnG4jjCVSeVlF3OjrN8+sdDGLsp6o
 nzSPkZXcl0Krxu/olC0U7gJuxSOyVRb3VPtYL26FhJAgN59qm2We2ZherNWmUbJkSBbDfZw0I
 IshNUQ56t3e2oByu9EZSAiCpYgL8zBsSUYvBa8TjsW5FP5/EQhDQZulCrOOSJ4tiIyYZcusZZ
 Wuz3ezP7J+cnfww6hcTmVkZF+maLnEU3EyOUlkdNLe8M68tBRRJWkQqKg8bXTqq4Py4cHe2Wl
 saRoBXnqZ2hPT1k465U0MPxGCqVBtLHopNDTOk45ObqEh238DDtebyyEp8ooNAsTo35GMIJ+G
 eHiZStSvh+LcNTeHoLxJiOyRUpcOZ1tPUZ/BpuZCJmejkjs0yDFINiaLlg3MSSitI+jFh/IcU
 sjFzYAsHiakDZYcpEjFre+uj+HaTYjp6SZ4ef4gsBWA4k32W7oR0EGtcu8L1L0wvGyReftGeM
 YzYAvjGwKIOJLHDWuQakq7hymB1+6ObSwh8Xu52/LQotsyuvRRwJqsOZ+eoC7mdh/asVMhnqy
 XET2teHtNZ8CJJiA0m/lVpXuYANsZlmPkpHhCKcxuWIYQNd5TIPLFHtyXLUq8zRcfve1OzeYq
 9dlHO3d3bvovjsRU0hZYHVlWXEq5oaV5KO0uECTIC/hcgvQcGwl+MmYYy2PpLzOTQgmUpHjj7
 ICUNIwwlrvdbN6rWY8Cw/XJTh3iCYQN2CHxofhNecySrVX+o/l0U+gdaTKT0VhGYTuyIZf9mf
 deEaBypUWFmx79+GV6wtKASqeCWp7pF5IJ7dTXkjQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

this patch looks pretty good to me. I just have a couple
comments/suggestions:

On Mon, 21 Dec 2020, Miriam Rubio wrote:

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 1854377fa6..92c783237d 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -916,6 +917,121 @@ static enum bisect_error bisect_log(void)
>  	return status ? BISECT_FAILED : BISECT_OK;
>  }
>
> +static int get_next_word(const char *line, int pos, struct strbuf *word=
)
> +{
> +	int i, len =3D strlen(line), begin =3D 0;
> +
> +	strbuf_reset(word);
> +	for (i =3D pos; i < len; i++) {
> +		if (line[i] =3D=3D ' ' && begin)
> +			return i + 1;
> +
> +		if (!begin)
> +			begin =3D 1;
> +		strbuf_addch(word, line[i]);
> +	}
> +
> +	return i;
> +}

While I have different objections than Rafael (the function seems to want
to left-trim, but does an inadequate job at it), I do not even think that
we need this function. See below.

> +
> +static int process_line(struct bisect_terms *terms, struct strbuf *line=
, struct strbuf *word)
> +{
> +	int res =3D 0;
> +	int pos =3D 0;
> +
> +	while (pos < line->len) {
> +		pos =3D get_next_word(line->buf, pos, word);
> +
> +		if (!strcmp(word->buf, "git"))
> +			continue;
> +		else if (!strcmp(word->buf, "git-bisect"))
> +			continue;
> +		else if (!strcmp(word->buf, "bisect"))
> +			continue;

This is not quite correct, as it would skip arbitrary amounts of "git" and
"git-bisect" and "bisect", even in the middle of the line.

Besides, this `while()` loop iterates over the characters of the current
line, while the original loop iterated over the _lines_:

	while read git bisect command rev
	do
		test "$git $bisect" =3D "git bisect" || test "$git" =3D "git-bisect" || =
continue
	[...]

As you can see, lines that do not start with "git bisect" or "git-bisect"
are simply ignored by `continue`ing to the next line. In the C code,
`continue` would continue to the next _word_.

I'd like to strongly suggest a very different approach, where no `while()`
loop is used in `process_line()` (BTW can we please rename this to
`process_replay_line()` to 1) make it less generic a name and 2) convey
via the name what this function is about?):

	const char *p;

	if (!skip_prefix(line->buf, "git bisect", &p) &&
	    !skip_prefix(line->buf, "git bisect", p))
		return 0;

As the original code used `read git bisect command rev` to parse the line,
which automatically trims white-space, we might want to do something
similar to that:

	const char *p =3D line->buf + strspn(line->buf, " \t");

	if ((!skip_prefix(p, "git bisect", &p) &&
	     !skip_prefix(p, "git-bisect", &p)) ||
	    !isspace(*p))
		return 0;
	p +=3D strspn(p, " \t");

> +		else if (starts_with(word->buf, "#"))
> +			break;

Please note that the original shell code is _a lot_ more forgiving: it
ignores _anything_ but "git bisect" and "git-bisect" at the beginning of
the (white-space-trimmed) line. Not just comments starting with `#`. I'd
like to return to the shell script's behavior.

> +
> +		get_terms(terms);

Do we really have to read the terms for every line we replay? I guess we
do, as every time we use new/old after good/bad (or vice versa), the terms
file gets rewritten.

We might want to address this awkwardness in the future: in C, we do not
have to read and write the terms file _all_ the time.

> +		if (check_and_set_terms(terms, word->buf))
> +			return -1;
> +
> +		if (!strcmp(word->buf, "start")) {

Let's use `skip_prefix()` here, too:

		char *word_end =3D p + strcspn(p, " \t");
		const char *rev =3D word_end + strspn(word_end, " \t");

		*word_end =3D '\0'; /* NUL-terminate the word */

		if (!strcmp("start", p)) {
			struct strvec argv =3D STRVEC_INIT;
			int res;

			sq_dequote_to_strvec(rev, &argv);
			res =3D bisect_start(terms, argv.v, argv.nr);
			strvec_clear(&argv);
			return res;
		}

> +			struct strvec argv =3D STRVEC_INIT;
> +			int res;
> +			sq_dequote_to_strvec(line->buf+pos, &argv);
> +			res =3D bisect_start(terms, argv.v, argv.nr);
> +			strvec_clear(&argv);
> +			if (res)
> +				return -1;
> +			break;
> +		}
> +
> +		if (one_of(word->buf, terms->term_good,
> +			   terms->term_bad, "skip", NULL)) {
> +			if (bisect_write(word->buf, line->buf+pos, terms, 0))
> +				return -1;

Apart from using `p` as above instead of `word->buf`, and `rev` instead of
`line->buf+pos`, why not returning directly what `bisect_write()`
returned?

		if (one_of(p, terms->term_good, terms->term_bad, "skip", NULL))
			return bisect_write(p, rev, terms, 0);

> +			break;
> +		}

> +
> +		if (!strcmp(word->buf, "terms")) {
> +			struct strvec argv =3D STRVEC_INIT;
> +			int res;
> +			sq_dequote_to_strvec(line->buf+pos, &argv);
> +			res =3D bisect_terms(terms, argv.nr =3D=3D 1 ? argv.v[0] : NULL);

We should probably error out if `argv.nr > 1`.

> +			strvec_clear(&argv);
> +			if (res)
> +				return -1;
> +			break;

Let's `return res` directly.

> +		}
> +
> +		error(_("Replay file contains rubbish (\"%s\")"),
> +		      word->buf);

The shell script version does this instead:

		die "$(gettext "?? what are you talking about?")" ;;

We should do the same, if only to make life easier on the translators.

> +		res =3D -1;
> +	}
> +	return res;
> +}
> +
> +static int process_replay_file(FILE *fp, struct bisect_terms *terms)
> +{
> +	struct strbuf line =3D STRBUF_INIT;
> +	struct strbuf word =3D STRBUF_INIT;
> +	int res =3D 0;
> +
> +	while (strbuf_getline(&line, fp) !=3D EOF) {
> +		res =3D process_line(terms, &line, &word);
> +		if (res)
> +			break;
> +	}
> +
> +	strbuf_release(&line);
> +	strbuf_release(&word);
> +	return res;
> +}

A lot of this function is just boiler plate. I'd prefer to merge the code
into `bisect_replay()` instead.

> +
> +static enum bisect_error bisect_replay(struct bisect_terms *terms, cons=
t char *filename)
> +{
> +	FILE *fp =3D NULL;
> +	enum bisect_error res =3D BISECT_OK;
> +
> +	if (is_empty_or_missing_file(filename))
> +		return error(_("cannot read file '%s' for replaying"), filename);
> +
> +	if (bisect_reset(NULL))
> +		return BISECT_FAILED;
> +
> +	fp =3D fopen(filename, "r");
> +	if (!fp)
> +		return BISECT_FAILED;
> +
> +	res =3D process_replay_file(fp, terms);
> +	fclose(fp);
> +
> +	if (res)
> +		return BISECT_FAILED;
> +
> +	return bisect_auto_next(terms, NULL);
> +}

The rest looks good to me!

Ciao,
Dscho
