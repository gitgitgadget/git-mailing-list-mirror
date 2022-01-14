Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E60FC433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 18:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242795AbiANSmh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 13:42:37 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57180 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbiANSmg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 13:42:36 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 45AA417FFDA;
        Fri, 14 Jan 2022 13:42:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=W+UqKdRP+Vpg
        TqX7eXWkAizGPdhUtxZ6wapbGSNQQqo=; b=mBCm6UyoaHj+t33bKhGeWvtvwaXM
        Lar8DxwSwQBzKlyMRli2lmw1chBe5YHIW/EbwmcNKaaLlawBSEJqVsJu0izafY5k
        5+iM0LkmnmgxtOboGCuhKw6yZZ1+nmShSSpJzU6yAz7S0EckDJee2voKzoJm6Zrz
        xYs0l+wP1C5dSOM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3D53A17FFD9;
        Fri, 14 Jan 2022 13:42:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A30CC17FFD8;
        Fri, 14 Jan 2022 13:42:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Ramkumar Ramachandra <r@artagnon.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>, "Miriam R." <mirucam@gmail.com>
Subject: Re: git bisect bad @
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
        <xmqqilus3ctf.fsf@gitster.g>
        <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
        <xmqq4k6b34h8.fsf@gitster.g>
        <bafa9564-fa48-413d-bbef-3f068c03dd31@www.fastmail.com>
        <3dade45b-494f-663b-264b-06a51ea1cf56@web.de>
        <xmqq35lsyhbf.fsf@gitster.g>
        <13e323e9-eb0c-71c3-215f-b77c91fcc4c8@web.de>
        <5be4cdad-6769-68e8-0984-5fe89668d007@web.de>
        <421215c1-f6ae-4ec2-b666-2a481056ef79@www.fastmail.com>
        <CAP8UFD3tyBhrOQzg9j4qDAT0Tb8TCTK0=J6ORsiLVuMWn+W9wg@mail.gmail.com>
        <8bc73981-589e-20e5-247b-2f74e166ae1a@web.de>
        <925ef53d-c8b2-4ef4-acee-490900e8a3b7@www.fastmail.com>
        <88899d16-5e3e-2bb2-07e9-59f7607c91a8@web.de>
Date:   Fri, 14 Jan 2022 10:42:31 -0800
In-Reply-To: <88899d16-5e3e-2bb2-07e9-59f7607c91a8@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 14 Jan 2022 08:47:05 +0100")
Message-ID: <xmqqmtjycg6g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BBF153A0-7569-11EC-97F7-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 13.01.22 um 16:16 schrieb Ramkumar Ramachandra:
>> Ren=C3=A9 Scharfe wrote:
>>> The implementation language of git bisect is not immediately relevant
>>> here, but that the shell is used to call the user-supplied bisect run
>>> script is.  If we'd run it directly (without RUN_USING_SHELL) we coul=
d
>>> distinguish error code 126/127 from execution errors.  I assume the
>>> option is used to stay compatible with the old shell version of bisec=
t.
>>
>> Sorry, my misunderstanding. I thought the external command was being
>> called from git-bisect.sh. I don't think I understand the purpose of
>> RUN_USING_SHELL (it just seems to put an "sh -c" in the beginning):
>>
>> 	static const char **prepare_shell_cmd(struct strvec *out, const char =
**argv)
>> 	{
>>         ...
>> 			strvec_push(out, "sh");
>> 			strvec_push(out, "-c");
>>
>> 			if (!argv[1])
>> 				strvec_push(out, argv[0]);
>> 			else
>> 				strvec_pushf(out, "%s \"$@\"", argv[0]);
>>        ...
>> 	}
>
> Using the shell allows the bisect run command to be any shell command,
> not just some script.  E.g. you could bisect a build failure with just
> "git bisect run make".  Quite useful.

True, but for example

	$ git bisect run make test

internally gets argv[] =3D { "make", "test", NULL } in bisect_run()
and then we are the one who make them into a single string, i.e.

	if (argc)
		sq_quote_argv(&command, argv);
	else {
		error(_("bisect run failed: no command provided."));
		return BISECT_FAILED;
	}

and that is what we run via the shell in the loop, i.e.

	while (1) {
		strvec_clear(&args);

		printf(_("running %s\n"), command.buf);
		res =3D run_command_v_opt(run_args.v, RUN_USING_SHELL);

I do not offhand recall the reason why we need to do that, instead
of using the original argv[] to invoke run_command_v_opt().

And my earlier "let's not go there" may need to be rethought.  I
somehow thought we are getting a single string from the end-user
and will become responsible for splitting it out or substituting
an environment variable with its value, but I was mistaken.


