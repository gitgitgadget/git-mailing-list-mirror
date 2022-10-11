Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CFEC433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 07:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJKHaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 03:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJKHaW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 03:30:22 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C6A399C2
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 00:30:19 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e18so18885185edj.3
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 00:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a9w1sbUJznAbYMWNyXIJIO7h9eqABOn+Yi6b6RAqTsw=;
        b=ihwQvK0uZrMIbCMv95SE1GkMx55t72Xscptx5XjrB2+nxdB+zZ5nsI9Uy/H1/DFhzM
         XSY34Va1e+EMY4w1I8xvcLCG1hP0wYcVlVYeqQUtnPVb/G+jppheMc+w0QYPaPrfxVW6
         6cFwScDTv0oSbie/CiWaR3QyBT4VvPphilpXH0T0icc24S29HeIXu2r1s6uDdPLnpBJu
         FBzeNZ0CWflCPZfmzLKBs5Wdau290M6UWi6e5TSRw5lWubGJuQaOgpdT+E2Nw1zpKi+x
         zUy6meRn09h0Y8sAb9UoFymWs9royx529U1jRTmHrXL+ws3EOUFEuwfLJKX+BgtQXklN
         4Dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a9w1sbUJznAbYMWNyXIJIO7h9eqABOn+Yi6b6RAqTsw=;
        b=fTMijVd0JY9S2+b5gnxP9q4Qzjb+JLtCoL794r3PFLL42Icn7s9ZtV9EjGBLctAsnN
         4PFdYegYP0Lju8YQtX8EX0MpcpLB9qqf9+3giDanP3Qtv9WiETHiaNYZ9unl8cXwfnHb
         tYOK5PdRxf3+/egd7PetxHdfr+04Kepx4q/maRfZr7jXCVpK+cOmFROZl4DWNHCSviZl
         9yHiH31V8F7gHhjWOzMzYmXjMS66nDKJFQKVlHk+s1bhxCmdq434Kxbk698+wv2VRhof
         vJUYaHm4dBXpPwm7VK98nDKBtYqIViuiA/XKXt+3FUGf+ifarNzBoeYjk0ParI7HpJOA
         ebpA==
X-Gm-Message-State: ACrzQf3tgjmUn7J+Tu07G/qoYxDWRMwobExEDyXMbQHdJQbzz/GM1Nqk
        LlT3ZvwSpBAVOcOAPMJ1UlA=
X-Google-Smtp-Source: AMsMyM6hVoZBPfH75u5heGbQjUq/liE9eo1JuSOPybKtZmK2loH0lr+soklidMtrAqxfzzuZgMv3gQ==
X-Received: by 2002:a05:6402:ca6:b0:458:60af:6875 with SMTP id cn6-20020a0564020ca600b0045860af6875mr21390160edb.295.1665473417570;
        Tue, 11 Oct 2022 00:30:17 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id z1-20020a50eb41000000b00457c85bd890sm8497346edp.55.2022.10.11.00.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 00:30:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oi9iR-003juT-29;
        Tue, 11 Oct 2022 09:30:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] bisect--helper: plug strvec leak
Date:   Tue, 11 Oct 2022 09:29:01 +0200
References: <5c6a4c30-d454-51b6-ec57-9af036b9c4e0@web.de>
 <221005.8635c2u3k5.gmgdl@evledraar.gmail.com> <xmqqy1tunjgp.fsf@gitster.g>
 <221006.86a668r5mf.gmgdl@evledraar.gmail.com> <xmqqk05cipq8.fsf@gitster.g>
 <1965b54b-122a-c965-f886-1a7dd6afbfb4@web.de>
 <Y0TXTl0gSBOFQa9B@coredump.intra.peff.net> <xmqq35buykz1.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqq35buykz1.fsf@gitster.g>
Message-ID: <221011.86k056q0l4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 10 2022, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> On Fri, Oct 07, 2022 at 05:08:42PM +0200, Ren=C3=A9 Scharfe wrote:
>>
>>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>>> index 501245fac9..28ef7ec2a4 100644
>>> --- a/builtin/bisect--helper.c
>>> +++ b/builtin/bisect--helper.c
>>> @@ -765,11 +765,10 @@ static enum bisect_error bisect_start(struct bise=
ct_terms *terms, const char **a
>>>  		strbuf_read_file(&start_head, git_path_bisect_start(), 0);
>>>  		strbuf_trim(&start_head);
>>>  		if (!no_checkout) {
>>> -			struct strvec argv =3D STRVEC_INIT;
>>> +			const char *argv[] =3D { "checkout", start_head.buf,
>>> +					       "--", NULL };
>>>=20
>>> -			strvec_pushl(&argv, "checkout", start_head.buf,
>>> -				     "--", NULL);
>>> -			if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
>>> +			if (run_command_v_opt(argv, RUN_GIT_CMD)) {
>>
>> This is OK with me, but note that one thing we lose is compiler
>> protection that we remembered the trailing NULL pointer in the argv
>> array (whereas strvec_pushl() has an attribute that makes sure the last
>> argument is a NULL).
>
> The first parameter to run_command_v_opt() must be a NULL terminated
> array of strings.  argv.v[] after strvec_push*() is such a NULL
> terminated array, and is suitable to be passed to the function.
>
> That much human programmers would know.
>
> But does the compiler know that run_command_v_opt() requires a NULL
> terminated array of strings, and does it know to check that argv.v[]
> came from strvec_pushl() without any annotation in the first place?
>
> For such a check to happen, I think we need to tell the compiler
> with some annotation that the first parameter to run_command_v_opt()
> is supposed to be a NULL terminated char *[] array.
>
> In the code before the patch, strvec_pushl() is annotated to require
> the last arg to be NULL, but without following data/control flow, it
> may not be clear to the compiler that argv.v[] will be NULL terminated
> after the function returns.  If the compiler is sufficiently clever
> to figure it out, with the knowledge that run_command_v_opt() must
> be given a NULL terminated array of strings, we do have compiler
> protection to make the run_command_v_opt() safe.
>
> But if the code tells the compiler that run_command_v_opt() must be
> given a NULL terminated array of strings, it is obvious that the
> array passed by the code after the patch, i.e. argv[], is NULL
> terminated, and the compiler would be happy, as well.
>
>> Probably not that big a deal in practice. It would be nice if there was
>> a way to annotate this for the compiler, but I don't think there's any
>> attribute for "this pointer-to-pointer parameter should have a NULL at
>> the end".
>
> But the code before this patch is safe only for strvec_pushl() call,
> not run_command_v_opt() call, so we are not losing anything, I would
> think.

Yes, and if we suppose a bug like this sneaking in one way or the other:
=09
	diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
	index 28ef7ec2a48..a7f9d43a6f1 100644
	--- a/builtin/bisect--helper.c
	+++ b/builtin/bisect--helper.c
	@@ -766,7 +766,7 @@ static enum bisect_error bisect_start(struct bisect_te=
rms *terms, const char **a
	                strbuf_trim(&start_head);
	                if (!no_checkout) {
	                        const char *argv[] =3D { "checkout", start_head.bu=
f,
	-                                              "--", NULL };
	+                                              "--" };
=09=20
	                        if (run_command_v_opt(argv, RUN_GIT_CMD)) {
	                                res =3D error(_("checking out '%s' failed."

I don't know a way to statically flag that, but we'll catch it with
SANITIZE=3Daddress:
=09
	+ git bisect start 32a594a3fdac2d57cf6d02987e30eec68511498c 88bcdc1839f0ad=
191ffdd65cae2a2a862d682151 --
	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	=3D=3D1734=3D=3DERROR: AddressSanitizer: stack-buffer-overflow on address =
0x7ffe6bbf5c18 at pc 0x55d31729bc7a bp 0x7ffe6bbf5920 sp 0x7ffe6bbf5918
	READ of size 8 at 0x7ffe6bbf5c18 thread T0
	    #0 0x55d31729bc79 in strvec_pushv strvec.c:55
	    #1 0x55d317232be9 in run_command_v_opt_cd_env_tr2 run-command.c:1026
	    #2 0x55d317232a3c in run_command_v_opt_cd_env run-command.c:1019
	    #3 0x55d3172329d1 in run_command_v_opt run-command.c:1009
	    #4 0x55d316c1337a in bisect_start builtin/bisect--helper.c:771
	    #5 0x55d316c17d06 in cmd_bisect__helper builtin/bisect--helper.c:1346
	    #6 0x55d316bf190f in run_builtin git.c:466
	    #7 0x55d316bf22bb in handle_builtin git.c:721
	    #8 0x55d316bf29e5 in run_argv git.c:788
	    #9 0x55d316bf375f in cmd_main git.c:921
	    #10 0x55d316e79a06 in main common-main.c:57
	    #11 0x7fceab0a0209 in __libc_start_call_main ../sysdeps/nptl/libc_star=
t_call_main.h:58
	    #12 0x7fceab0a02bb in __libc_start_main_impl ../csu/libc-start.c:389
	    #13 0x55d316bed210 in _start (git+0x1d7210)

So I'm not worried about it happening in the first place, but if it does
we'd also need to have no test coverage of the relevant code to miss it.
