Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA06C48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 10:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F252608FE
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 10:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbhFIKeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 06:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbhFIKd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 06:33:58 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F9CC061574
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 03:31:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id k15so18061026pfp.6
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 03:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=laxRGubYXbzHUhaxWXpsNkRWtLfG/+J1AA4WVIJU3IE=;
        b=HBLg0MnBUovQ8t8XfNofYWwTwQR1MnvA+X2YtmENBgPczVtSEfYW72OIF6Y8DISwDY
         JbduqWJVvbMljruaMiFjEpMQ+bYPgHWOcwnhDeWX1+DuajA7ps8VSkiJi/pXN+yqhgZY
         /znVlxAYIjVpfcobNweZOOgrMJuVT0lpX+puOeh5mbosarPy4MxOOUenxfJalJh0dn2V
         rH5FDVhlSD0GCKg2m2AyFGEI9F5s5KT4lTS7i3cqJ4CYxKKuT5cFKhQnAU66GI+y0Rn1
         luHdSd8s4SlumXE9yL+ZFRRxr2qIyjVc3UcR1ec5VMUHS8rjnz+kkIs2Xe6Iur4exTkn
         2YiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=laxRGubYXbzHUhaxWXpsNkRWtLfG/+J1AA4WVIJU3IE=;
        b=YGNNMG81IJks8Qq152uVTemnGa4pwBfYqUC6olzoHOZrODz7b4yxNnGl8A8XYsoyXr
         Z5vifb0hb5jbY7rR2Q50OpB+gMLiDDBpXVurkowowkazJfB6xoYNB94MGXVS4rzOjq3i
         KN+BWrBlfK2o0DFBHOTwNLoYyeNqSyy/dU4bnF1CPS8RWyLq4Po4E2rrTzXj0R84veSY
         wEDcA1HxbhPrAXZXq2WYNbQsyjxg0UttO9qI0Xa/plfQRWafnSroZ8zj7JYdFRbsODe5
         +wZVQYu7BTxQZAf2rhIxa5srnB7vPLBszEPAfTx5BQjrcjoD7H07KdpQlIeyWm5iHa/2
         L2Ag==
X-Gm-Message-State: AOAM531tRChjiGJ/W0GzC+h8BoYEHLljNzhS5pkgKQRffwv3hDuvY5EX
        UQlNV6YfbbqjSo4bvbWioR0=
X-Google-Smtp-Source: ABdhPJyVm0A2LiV5EpsM8WBx7Euct6itWobtFFQFMgBqkLOKrdBwNyvPn/frfe4eWXH2z3WQaIg0Yw==
X-Received: by 2002:a62:3003:0:b029:28e:74d9:1e16 with SMTP id w3-20020a6230030000b029028e74d91e16mr4765607pfw.21.1623234707404;
        Wed, 09 Jun 2021 03:31:47 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id j7sm4935662pjf.0.2021.06.09.03.31.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 03:31:47 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSoC] [PATCH v2 1/2] submodule--helper: introduce add-clone
 subcommand
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <xmqqh7i7ll6h.fsf@gitster.g>
Date:   Wed, 9 Jun 2021 16:01:42 +0530
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <25A3EBAB-AD9A-4FF4-8E6E-63E8ACFF2739@gmail.com>
References: <20210605113913.29005-1-raykar.ath@gmail.com>
 <20210608095655.47324-1-raykar.ath@gmail.com>
 <20210608095655.47324-2-raykar.ath@gmail.com> <xmqqh7i7ll6h.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09-Jun-2021, at 09:54, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Just a bit of random comments, leaving the full review to mentors.
>=20
>> diff --git a/builtin/submodule--helper.c =
b/builtin/submodule--helper.c
>> index d55f6262e9..c9cb535312 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -2745,6 +2745,204 @@ static int module_set_branch(int argc, const =
char **argv, const char *prefix)
>> 	return !!ret;
>> }
>>=20
>> +struct add_data {
>> +	const char *prefix;
>> +	const char *branch;
>> +	const char *reference_path;
>> +	const char *sm_path;
>> +	const char *sm_name;
>> +	const char *repo;
>> +	const char *realrepo;
>> +	int depth;
>> +	unsigned int force: 1;
>> +	unsigned int quiet: 1;
>> +	unsigned int progress: 1;
>> +	unsigned int dissociate: 1;
>> +};
>> +#define ADD_DATA_INIT { .depth =3D -1 }
>> +
>> +static char *parse_token(char **begin, const char *end, int =
*tok_len)
>> +{
>> +	char *tok_start, *pos =3D *begin;
>=20
> Make it a habit to have a blank line between the initial block
> of declarations and the first statement.
>=20
>> +	while (pos !=3D end && (*pos !=3D ' ' && *pos !=3D '\t' && *pos =
!=3D '\n'))
>> +		pos++;
>> +	tok_start =3D *begin;
>> +	*tok_len =3D pos - *begin;
>> +	*begin =3D pos + 1;
>> +	return tok_start;
>> +}
>> +static char *get_next_line(char *const begin, const char *const end)
>> +{
>> +	char *pos =3D begin;
>> +	while (pos !=3D end && *pos++ !=3D '\n');
>=20
> Write an empty loop on two lines, like this:
>=20
> 	while (... condition ...)
> 		; /* keep scanning */

OK.

> If there is a NUL byte between begin and end, this keeps going and
> the resulting string will contain one.  Is that a problem?
>=20
>> +	return pos;
>> +}
>=20
> In general, this project is mature enough that we should question
> ourselves if there is already a suitable line parser we can reuse
> when tempted to write another one.

I will keep this in mind.

>> +static void show_fetch_remotes(FILE *output, const char *sm_name, =
const char *git_dir_path)
>> +{
>> +	struct child_process cp_remote =3D CHILD_PROCESS_INIT;
>> +	struct strbuf sb_remote_out =3D STRBUF_INIT;
>> +
>> +	cp_remote.git_cmd =3D 1;
>> +	strvec_pushf(&cp_remote.env_array,
>> +		     "GIT_DIR=3D%s", git_dir_path);
>> +	strvec_push(&cp_remote.env_array, "GIT_WORK_TREE=3D.");
>> +	strvec_pushl(&cp_remote.args, "remote", "-v", NULL);
>> +	if (!capture_command(&cp_remote, &sb_remote_out, 0)) {
>> +		char *line;
>> +		char *begin =3D sb_remote_out.buf;
>> +		char *end =3D sb_remote_out.buf + sb_remote_out.len;
>> +		while (begin !=3D end && (line =3D get_next_line(begin, =
end))) {
>=20
> OK, so this tries to parse output from "git remote -v", so NUL will
> not be an issue at all.  We will get a string that is NUL terminated
> and has zero or more lines, terminated with LFs.
>=20
> If that is the case, I think it is far easier to read without
> a custom get-next-line wrapper, e.g.
>=20
> 	for (this_line =3D begin;
> 	     *this_line;
> 	     this_line =3D next_line) {
> 		next_line =3D strchrnul(this_line, '\n');
> 		... process bytes between this_line..next_line ...
> 	}               =20
>=20
>> +			int namelen =3D 0, urllen =3D 0, taillen =3D 0;
>> +			char *name =3D parse_token(&begin, line, =
&namelen);
>=20
> Similarly, consider if strcspn() is useful in implementing
> parse_token().  See how existing code uses the standard system
> function with
>=20
> 	$ git grep strcspn \*.c
>=20
>> +			char *url =3D parse_token(&begin, line, =
&urllen);
>> +			char *tail =3D parse_token(&begin, line, =
&taillen);
>> +			if (!memcmp(tail, "(fetch)", 7))
>=20
> At this point do we know there are enough number of bytes after
> tail[0] to allow us to do this comparison safely?  Otherwise,
>=20
> 			if (starts_with(tail, "(fetch)")
>=20
> may be preferrable.

This solution is definitely an improvement over what I was doing.

That said, I like Danh's suggestion[1] more, because it eliminates the
need for parsing tokens entirely.

The fundamental thing that piece of code was meant to do is:

"If this line ends with '(fetch)', print the line, but without the =
'(fetch)'"

Parsing tokens only to put them back together through fprintf() may
not be necessary for this usage, so using strchr() with
strip_suffix_mem() should do the trick.

[1] https://lore.kernel.org/git/YL9jTFAoEBP+mDA2@danh.dev/

Thanks for the comments :^)=
