Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6516AC43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 12:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiGGMrH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 08:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbiGGMrG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 08:47:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBADF23BEA
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 05:47:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v12so10368423edc.10
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 05:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Wk7frbMREct9lPijIkLq5KJDSYaF9pJKe0u39Vfv0Fs=;
        b=PN9RODLsu5vm73/1rbqiw4hncIaoytP8u1+aTb5cJlcCZ0VxrAlSqelzOTks7uO0Aq
         m5mvf9uVwM3xMbKc6PJabB0vuxT3jKHQErAqnat69Sc49CgRw7LvzC4b4fGHU2nho5MN
         wGhcC+rVj3EewMp7MHZH41cwOHyL2agTuvuSE0v4ZsAgWIcJpG4nJYQKJPNhQR8AfyCj
         Uis5S/aMSm/jQN9e+91RD/NgzTYpubj04XpS3qP+MDk9dFdzBCY6eTmct6nGLlnrMe92
         /z2PGsHX432piEBCJyIkWCI82/BQoyzZfqAkqhCzsGerqfuc9j6K8+NE31VQfjRfvp8r
         8jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Wk7frbMREct9lPijIkLq5KJDSYaF9pJKe0u39Vfv0Fs=;
        b=3wLEI0fcPiP3eVCUZF3uDThUsYC9KVu/VXZ7/SPi1M+r89cQ0okTTbzGSVpadQHPEx
         MsFnBq/a3GEgzxsF0d4EikIHb3dKFJJahnetGgONEo5ZXe3yJwD9IeQn0NWFVvbjFA9/
         5Fk8nnvTmGba4s/eARXCukePqV7i0YFTyp00rRmq5ruPnetoI8lmSeR0BVKJXX2vMhGP
         ESuxXJJ0IBCw1SqDipNfgXWVKbfSHP5PEQx2cKnhVYYNEE1GmCXe4y6sCIEODhzxQxUB
         r5CZbWdFEJ0kREdLRoNFzYJKuJS0ZuAA29qDmPWKDNAXFAveU7QtqpzLU7mWxF6SyL0L
         b+8A==
X-Gm-Message-State: AJIora+Myn2H8hININygiAC0vqbqAmCxJgh0ThXn70Dv74hlykRYMedu
        GRZL+kILPqm960UiYhBQYqcV3CCTyFg=
X-Google-Smtp-Source: AGRyM1tpRjDmcOM0pSbR1DcLH6UpizBKLepHWaf1inLwgYEYPSWnY1R/V2Xa4GhCXEGqTqopJMU1GA==
X-Received: by 2002:a05:6402:2a08:b0:437:cdc9:d120 with SMTP id ey8-20020a0564022a0800b00437cdc9d120mr61243516edb.129.1657198020226;
        Thu, 07 Jul 2022 05:47:00 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id e10-20020a056402148a00b0043a1255bc68sm11374905edv.94.2022.07.07.05.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 05:46:59 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o9QuJ-004How-0x;
        Thu, 07 Jul 2022 14:46:59 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Adam Zethraeus <adam.zethraeus@includedhealth.com>
Subject: Re: bug report: pre-commit & pre-push hook output is redirected
 differently
Date:   Thu, 07 Jul 2022 14:40:49 +0200
References: <CAP4e5TNdvE1gmt9bERT5sL+D3r4Fbypk57KJJ+wYHD=M=T+uWA@mail.gmail.com>
 <xmqqa69mgdde.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqa69mgdde.fsf@gitster.g>
Message-ID: <220707.86tu7t84zh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 06 2022, Junio C Hamano wrote:

> Adam Zethraeus <adam.zethraeus@includedhealth.com> writes:
>
>> What did you do before the bug happened? (Steps to reproduce your issue)
>>
>> Installed identical pre-commit and pre-push hooks:
>>
>> ```
>> #!/bin/bash
>>
>>>&1 echo "stdout"
>>>&2 echo "stderr"
>> exit 1
>> ```
>>
>> What did you expect to happen? (Expected behavior)
>>
>> `git push` and `git commit` should have the same hook behavior.
>>
>> What happened instead? (Actual behavior)
>>
>> The pre-commit hook was run with stdout redirected to stderr but the
>> pre-push hook's output was unaltered.
>
> Without looking into it very much, the output of hooks is an area
> with known regression at 2.36, so let me redirect it to those who
> are likely to know it ;-)
>
> Thanks for a report.

I may be missing something, but I think this report has nothing to do
with any recent changes or regressions, but is merely noting a behavior
change between pre-push and some other hooks that we've had since 1.8.2,
or since the "pre-push" hook was added in ec55559f937 (push: Add support
for pre-push hooks, 2013-01-13).

I tested this with a local v2.30.0, and the behavior was the same.

This will "fix" it:
	
	diff --git a/transport.c b/transport.c
	index 52db7a3cb09..0cc7d05e0da 100644
	--- a/transport.c
	+++ b/transport.c
	@@ -1225,6 +1225,7 @@ static int run_pre_push_hook(struct transport *transport,
	 	strvec_push(&proc.args, transport->url);
	 
	 	proc.in = -1;
	+	proc.stdout_to_stderr = 1;
	 	proc.trace2_hook_name = "pre-push";
	 
	 	if (start_command(&proc)) {

But whether that's a fix or not depends on whether we think we should
make this behavior consistent. I tend to think so, but it would be a
behavior change to long-established behavior in pre-push.

It *is* something we need to be careful of when converting the rest of
the hooks to the hooks API, i.e. we need tests for how stderr/stdout is
handled for each one.

But this being different is just because some hook use the hook.c API
(and before that the helper in run-command.c), and others use "struct
child_process" or whatever explicitly (such as "pre-push").

Since it's up to each callsite to set up the "proc" (or equivalent) some
supply "stdout_to_stderr", some don't.

From some quick grepping it seems the odd ones out are pre-push and
proc-receive, but I only skimmed a "git grep" to find the second one,
and may have missed others.
