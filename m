Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4501BC4332F
	for <git@archiver.kernel.org>; Sun, 18 Dec 2022 04:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiLREZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 23:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLREZC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 23:25:02 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7906F032
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 20:24:57 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so9883845pje.5
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 20:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IgJF6zhvfC/pLzzeKueDfjFC2rth600yOyCPif9tHok=;
        b=TbVg9re+cBLWUv2jqoSlNSsHudgMteKOSFIenuzDlpzxqbAiIDKA9aUU1gEPyibkXA
         zuutbPMMzm2aEZwUFsf00PGKq57pkec0hi4sM+QQPcokgYdofUMlGx8zxj2Gd/nuu2fi
         PW7BIoEf/O8SB7p2Ez+kBGLT88ZuKvuNCqQvsxPJ4reS9nuwr0pVaMj2FGPjTq/rZWAL
         J44RQAPm1T3Ew4swvCYU9RgAoax8b/BHJWhjN5QR8QpeZN28WGFackxExsQ6t0pdKpkE
         djqjD+qW35K8RD0HrpOQIg3YOWl4GpDFfTXMhVfIM2z5QCz0vIs3shYLMnavLqSOvqC6
         BEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IgJF6zhvfC/pLzzeKueDfjFC2rth600yOyCPif9tHok=;
        b=u/stqA0XdJMj9WQj8Ddr1tv2dnybTsYSwo3wbvIlM50X9EAoDbrxk3QZt/Kv3DlBvZ
         44vDtFZz7sTWE4QKlnu0fPDCEzy7PMs16ynhayV6l2DkMlyt11WUDvBPkcfc6gm/kVnv
         p/vNTmIWJDPdu7kzQpzyxxNnXSksWK94mdrPpQbq2hyKUNntjF83xjvY64xKDUps2xxB
         gKC0wCzPgXUnXPEuXTdoXeJMtwkmL17cl19Ev6vqqmJxUjVmclA8O8Jde2u0BLex2Et5
         M3rJk9Adwk5VuTaapFrWtUoUjB4J1cjJFe2J1oHHDF2QFCaNgt7NQvvaO86HatfSJiUj
         0R+w==
X-Gm-Message-State: ANoB5pnLT0QV6gLmjRpmTuozQCYwCH6Sac7bLikCYl4sFY0+iA/NbE43
        5DHT1WQN7QdR0HAXjanLGS4=
X-Google-Smtp-Source: AA0mqf70HWe7YGzEJCW34rIP4j10XF4tzZV0q45lzCvS/SQNlKWYzM/M7q5c9xDxcomCkHaGdFZVQw==
X-Received: by 2002:a05:6a20:7d86:b0:a7:9f6:b7e8 with SMTP id v6-20020a056a207d8600b000a709f6b7e8mr61287294pzj.46.1671337497178;
        Sat, 17 Dec 2022 20:24:57 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w10-20020a170902e88a00b001868ed86a95sm4313449plg.174.2022.12.17.20.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 20:24:56 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] format-patch: add --mboxrd alias for --pretty=mboxrd
References: <20221114094114.18986-1-e@80x24.org>
        <221114.86leodlbix.gmgdl@evledraar.gmail.com>
        <20221114205909.GA14736@dcvr>
Date:   Sun, 18 Dec 2022 13:24:56 +0900
In-Reply-To: <20221114205909.GA14736@dcvr> (Eric Wong's message of "Mon, 14
        Nov 2022 20:59:09 +0000")
Message-ID: <xmqqv8m9wd7r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> As I noted in the commit message, I think discussing --pretty=*
> in the context of format-patch would be confusing for users.

Sensible.

>> > +	if (mboxrd)
>> > +		rev.commit_format = CMIT_FMT_MBOXRD;
>> > +
>
> It could be something like this:
>
> 	if (rev.commit_format == CMIT_FMT_MBOXRD && !use_stdout)
> 		warning("mboxrd without --stdout makes no sense\n");
>
> But I'm on the fence about the warning.

Does it really hurt when generating individual files, or does it
naturally degenerate to the same as the plain old mbox, or
something?  If it does not hurt, then let's not clutter the output
with a message that may make the user worried unnecessarily.

Having said all that, if --pretty=mboxrd is usable, do we really
need the --mboxrd short-hand?  If we plan to eventually switch the
default output format to mboxrd (which I am assuming your longer
term vision), wouldn't it be the traditional format that may need a
short-hand when something goes wrong?

This change does not seem to be something we cannot live without,
and as a step in the direction to move all of us to mboxrd, this
feels somewhat a roundabout step.  I wonder if it would be more
direct to

 - declare that we will eventually switch to use mboxrd by default;

 - give a configuration knob to retain the current email as default;

 - do the usual deprecation dance.

After all, between email and mboxrd, the e-mailed patch format is
not something we choose per-invocation basis, is it?

Picking a suitable format per project and setting it in .git/config,
or picking a suitble format for yourself and setting it in
~/.gitconfig, and not having to think about it afterwards may be a
better use of our users' time.

Thanks.

