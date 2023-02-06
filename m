Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0E1C05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 20:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjBFUiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 15:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjBFUiC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 15:38:02 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545555FE4
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 12:37:55 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id f10so14420101qtv.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 12:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3iC03ScimUhaQ5QSgEgGRSSe/sXTx/+W9ebC2PVoRI=;
        b=JX95D01Ah1gjZpmKj92PKpdbyPUK+LHszvRHvb3FfBFCEAoioHFuHzlWfHe1mZn53W
         1YZTH8OefjF4eU7pKffEov7nMOPpbGgVGQFl0qb2C+ETUhzoyHl4X7eLtLHF81E/fmbW
         8SCytS/XH3vzqTvZ/ZwDEwqcNiQtWlCa6VnWXS3Zs8bvldo22L56SN7EXLyZRHbrfGfJ
         uMDMHDvfvLBWyOD4EQNI0rRhmEgm6VsBR6rNxe1jlfwi4ZR2/bCGS4xbQOT6ZHIgXIE2
         S/apBwwanJhx1QDpwFbDXrAcM0RXin1GeQYTpxlX+QY3p6X5Y6DvYDcrZCTbgCENCJUC
         g6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3iC03ScimUhaQ5QSgEgGRSSe/sXTx/+W9ebC2PVoRI=;
        b=a1uIQ6LvUzg4QDTYpTNYj8EoFafbXFsTf7T/wPlr+v7sXckqbUgzfn0f7GeuBoV99y
         jwdV2TYgVj8K6Xrm2FlPqVDw+ILV63aB8PK3WGiFlV1HnlfFb5ggovBJtgKZQ/u2RiPV
         GovFfx3Bc5TZUH0Tlh1wMNue+vFDt8AHnueB5AipwPwRRAshdkMDD87CS1SdihZAKxCf
         UYPaSghCbAj+MMdKYiA0U1rClODhL20cMXCX3m/qIWI3uj6eb7O4uobFjFIhjA1/pNDs
         fHfqVcA/26mypnpVNh7PqWZA5MRQYHd0rM6mmfZR4pbD9jluHT5iw/r9qmmQaX2djIUR
         7TOA==
X-Gm-Message-State: AO0yUKUMId9AzEGh4UVTX7my94Ku+3ZCLsUEtH35fMQfwL4iguFFYRqc
        3VDm/ljxOcqkVkNy+XZwHCdnaVcxmXU=
X-Google-Smtp-Source: AK7set/mxz7hasAMvCaojRyFE+YiLKnpz5Uv4x+a6ekfEgHsuFMdxQNzSy88fph1N8E4PdWCEVM8Eg==
X-Received: by 2002:a05:622a:ce:b0:3b6:8ece:cab9 with SMTP id p14-20020a05622a00ce00b003b68ececab9mr1490544qtw.2.1675715874123;
        Mon, 06 Feb 2023 12:37:54 -0800 (PST)
Received: from [192.168.1.205] (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id g7-20020a05620a40c700b007208a81e11esm7482860qko.41.2023.02.06.12.37.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Feb 2023 12:37:53 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Date:   Mon, 06 Feb 2023 15:37:53 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <B544D9E8-13C4-4682-9BDA-D6E19B51C91D@gmail.com>
In-Reply-To: <230206.865yce7n1w.gmgdl@evledraar.gmail.com>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <230206.865yce7n1w.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

On 6 Feb 2023, at 11:39, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Sun, Feb 05 2023, John Cai via GitGitGadget wrote:
>
>> From: John Cai <johncai86@gmail.com>
>> [...]
>> +
>> +		if (!o->xdl_opts_command_line) {
>> +			static struct attr_check *check;
>> +			const char *one_diff_algo;
>> +			const char *two_diff_algo;
>> +
>> +			check =3D attr_check_alloc();
>> +			attr_check_append(check, git_attr("diff-algorithm"));
>> +
>> +			git_check_attr(the_repository->index, NULL, one->path, check);
>> +			one_diff_algo =3D check->items[0].value;
>> +			git_check_attr(the_repository->index, NULL, two->path, check);
>> +			two_diff_algo =3D check->items[0].value;
>> +
>> +			if (!ATTR_UNSET(one_diff_algo) && !ATTR_UNSET(two_diff_algo) &&
>> +				!strcmp(one_diff_algo, two_diff_algo))
>> +				set_diff_algorithm(o, one_diff_algo);
>> +
>> +			attr_check_free(check);
>
> This is a bit nitpicky, but I for one would find this much easier to
> read with some shorter variables, here just with "a" rather than
> "one_diff_algo", "b" instead of "two_diff_algo", and splitting
> "the_repository->index" into "istate" (untested):
> 	=

> 	+		if (!o->xdl_opts_command_line) {
> 	+			static struct attr_check *check;
> 	+			const char *a;
> 	+			const char *b;
> 	+			struct index_state *istate =3D the_repository->index;
> 	+
> 	+			check =3D attr_check_alloc();
> 	+			attr_check_append(check, git_attr("diff-algorithm"));
> 	+
> 	+			git_check_attr(istate, NULL, one->path, check);
> 	+			a =3D check->items[0].value;
> 	+			git_check_attr(istate, NULL, two->path, check);
> 	+			b =3D check->items[0].value;
> 	+
> 	+			if (!ATTR_UNSET(a) && !ATTR_UNSET(b) && !strcmp(a, b))
> 	+				set_diff_algorithm(o, a);
> 	+
> 	+			attr_check_free(check);
> 	+		}
>
> That also nicely keeps the line length shorter.

Thanks, I think this does look better.

>
>> @@ -333,6 +333,8 @@ struct diff_options {
>>  	int prefix_length;
>>  	const char *stat_sep;
>>  	int xdl_opts;
>> +	/* If xdl_opts has been set via the command line. */
>> +	int xdl_opts_command_line;
>>
>>  	/* see Documentation/diff-options.txt */
>>  	char **anchors;
>> diff --git a/t/lib-diff-alternative.sh b/t/lib-diff-alternative.sh
>> index 8d1e408bb58..630c98ea65a 100644
>> --- a/t/lib-diff-alternative.sh
>> +++ b/t/lib-diff-alternative.sh
>> @@ -107,8 +107,27 @@ EOF
>>
>>  	STRATEGY=3D$1
>>
>> +	test_expect_success "$STRATEGY diff from attributes" '
>> +		echo "file* diff-algorithm=3D$STRATEGY" >.gitattributes &&
>> +		test_must_fail git diff --no-index file1 file2 > output &&
>> +		test_cmp expect output
>> +	'
>> +
>>  	test_expect_success "$STRATEGY diff" '
>> -		test_must_fail git diff --no-index "--$STRATEGY" file1 file2 > outp=
ut &&
>> +		test_must_fail git diff --no-index "--diff-algorithm=3D$STRATEGY" f=
ile1 file2 > output &&
>
> Nit: The usual style is ">output", not "> output".

noted!

>
>> +		test_cmp expect output
>> +	'
>> +
>> +	test_expect_success "$STRATEGY diff command line precedence before a=
ttributes" '
>> +		echo "file* diff-algorithm=3Dmeyers" >.gitattributes &&
>> +		test_must_fail git diff --no-index "--diff-algorithm=3D$STRATEGY" f=
ile1 file2 > output &&
>> +		test_cmp expect output
>> +	'
>> +
>> +	test_expect_success "$STRATEGY diff attributes precedence before con=
fig" '
>> +		git config diff.algorithm default &&
>> +		echo "file* diff-algorithm=3D$STRATEGY" >.gitattributes &&
>> +		test_must_fail git diff --no-index "--diff-algorithm=3D$STRATEGY" f=
ile1 file2 > output &&
>>  		test_cmp expect output
>>  	'
>>
>> @@ -166,5 +185,11 @@ EOF
>>  		test_must_fail git diff --no-index "--$STRATEGY" uniq1 uniq2 > outp=
ut &&
>>  		test_cmp expect output
>>  	'
>> +
>> +	test_expect_success "$STRATEGY diff from attributes" '
>> +		echo "file* diff-algorithm=3D$STRATEGY" >.gitattributes &&
>> +		test_must_fail git diff --no-index uniq1 uniq2 > output &&
>> +		test_cmp expect output
>> +	'
>>  }
>
> For some non-nitpicking, I do worry about exposing this as a DoS vector=
,
> e.g. here's a diff between two distant points in git.git with the
> various algorithms:
>
> 	$ hyperfine -r 1 -L a patience,minimal,histogram,myers 'git diff --dif=
f-algorithm=3D{a} v2.0.0 v2.28.0'
> 	Benchmark 1: git diff --diff-algorithm=3Dpatience v2.0.0 v2.28.0
> 	  Time (abs =E2=89=A1):        42.121 s               [User: 41.879 s,=
 System: 0.144 s]
> 	=

> 	Benchmark 2: git diff --diff-algorithm=3Dminimal v2.0.0 v2.28.0
> 	  Time (abs =E2=89=A1):        35.634 s               [User: 35.473 s,=
 System: 0.160 s]
> 	=

> 	Benchmark 3: git diff --diff-algorithm=3Dhistogram v2.0.0 v2.28.0
> 	  Time (abs =E2=89=A1):        46.912 s               [User: 46.657 s,=
 System: 0.228 s]
> 	=

> 	Benchmark 4: git diff --diff-algorithm=3Dmyers v2.0.0 v2.28.0
> 	  Time (abs =E2=89=A1):        33.233 s               [User: 33.072 s,=
 System: 0.160 s]
> 	=

> 	Summary
> 	  'git diff --diff-algorithm=3Dmyers v2.0.0 v2.28.0' ran
> 	    1.07 times faster than 'git diff --diff-algorithm=3Dminimal v2.0.0=
 v2.28.0'
> 	    1.27 times faster than 'git diff --diff-algorithm=3Dpatience v2.0.=
0 v2.28.0'
> 	    1.41 times faster than 'git diff --diff-algorithm=3Dhistogram v2.0=
=2E0 v2.28.0'

Thanks for this analysis. To clarify, .gitconfig's diff.algorithm setting=
 is
already an attack vector right? I see how this would be adding another on=
e.

That being said, here's a separate issue. I benchmarked the usage of
=2Egitattributes as introduced in this patch series, and indeed it does l=
ook like
there is additional latency:

$ echo "* diff-algorithm=3Dpatience >> .gitattributes
$ hyperfine -r 5 'git-bin-wrapper diff --diff-algorithm=3Dpatience v2.0.0=
 v2.28.0'                      =E2=9C=AD
Benchmark 1: git-bin-wrapper diff --diff-algorithm=3Dpatience v2.0.0 v2.2=
8.0
  Time (mean =C2=B1 =CF=83):     889.4 ms =C2=B1 113.8 ms    [User: 715.7=
 ms, System: 65.3 ms]
  Range (min =E2=80=A6 max):   764.1 ms =E2=80=A6 1029.3 ms    5 runs

$ hyperfine -r 5 'git-bin-wrapper diff v2.0.0 v2.28.0'                   =
                             =E2=9C=AD
Benchmark 1: git-bin-wrapper diff v2.0.0 v2.28.0
  Time (mean =C2=B1 =CF=83):      2.146 s =C2=B1  0.368 s    [User: 0.827=
 s, System: 0.243 s]
  Range (min =E2=80=A6 max):    1.883 s =E2=80=A6  2.795 s    5 runs

and I imagine the latency scales with the size of .gitattributes. Althoug=
h I'm
not familiar with other parts of the codebase and how it deals with the l=
atency
introduced by reading attributes files.

>
> Now, all of those are very slow overall, but some much more than
> others. I seem to recall that the non-default ones also had some
> pathological cases.
>
> Another thing to think about is that we've so far considered the diff
> algorithm to be purely about presentation, with some notable exceptions=

> such as "patch-id".
>
> I've advocated for us getting to the point of having an in-repo
> .gitconfig or .gitattributes before with a whitelist of settings like
> diff.context for certain paths, or a diff.orderFile.
>
> But those seem easy to promise future behavior for, v.s. an entire diff=

> algorithm (which we of course had before, but now we'd have it in
> repository data).
>
> Maybe that's not a distinction worth worrying about, just putting that
> out there.
>
> I think if others are concerned about the above something that would
> neatly side-step those is to have it opt-in via the .git/config somehow=
,
> similar to e.g. how you can commit *.gpg content, put this in
> .gitattributes:
>
> 	*.gpg diff=3Dgpg
>
> But not have it do anything until this is in the repo's .git/config (or=

> similar):
>
> 	[diff "gpg"]
>         	textconv =3D gpg --no-tty --decrypt
>
> For that you could still keep the exact .gitattributes format you have
> here, i.e.:
>
> 	file* diff-algorithm=3D$STRATEGY
>
> But we to pick it up we'd need either:
>
> 	[diff-algorithm]
>         	histogram =3D myers
>
> Or:
>
> 	[diff-algorithm "histogram"]
>         	allow =3D true

This would help address slowness from the diff algorithm itself. I'm not =
opposed
to adding this config if this attack vector is concerning to people.

However, it wouldn't help address the additional latency of scanning
=2Egitattributes to find the diff algorithm.

Would a separate config to allow gitattributes be helpful here?

[diff-algorithm]
	attributes =3D true

>
> The former form being one that would allow you to map the .gitattribute=
s
> of the repo (but maybe that would be redundant to
> .git/info/attributes)...
