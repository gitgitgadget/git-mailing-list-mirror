Return-Path: <SRS0=iBdC=IG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBBCC433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 12:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C61E565214
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 12:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhCHMjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 07:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhCHMif (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 07:38:35 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD55C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 04:38:34 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id bm21so20047884ejb.4
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 04:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=C8sVPuXw98EXI6L9Jc1tT+T2DHFgzyg+7Mlw4ni/yT4=;
        b=DAhpBgt4rZrHHeGdQLpBLTjSiPXPS7wF2UzHlp704SITVwZt0TsiMTGgvhi5NbdhD3
         s/f/VEl/QlFfmValsr8/lAUkFpCCcKh5ROqfW5sH6lJgV+VI1sQ4YtU2muM5wAFGINbr
         0BtS4ce2bglRDim2X5ClDfsgOGc7+hL2jNk+0eNl+IM5mMUqa1hn74OT8E/Lxm3ZbOik
         xKXR60Ap2Tdzlwgm9UK9ImvHttPSojeHwA3X2OzUqcMEZYGfcPlT0ju9E2rFGfQAtb+8
         MpnNsA4yUeNJXgkeJGrAJezT+fr+BxJpB6Sh4lm0yp1r4LSK0SjHAmjIERBMBudRR6kN
         vWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=C8sVPuXw98EXI6L9Jc1tT+T2DHFgzyg+7Mlw4ni/yT4=;
        b=bOZQVnG2Go9WpMr0BWpwbRKkfTQFmeDpqHoI1+A7AiDhemfQxjAUR5xjFEj8eYISnq
         TQQHwutq24efGdXNvGN+tQtrMDjIMX+iyUo2dwsgVV0siWmXqJgXv1odGN3OryiKgrdw
         Uqc4yYdMgc/z+WTLlBX6cUv3wstkL1zuW72jXq3LcQDLIl8pg4uvs0CQjcT/cCvGyOzj
         tmCDrzKq+AWa9pcqamS+1S3ACkvyIwMezeuWhZ6MEPTFYiE0+E/3uswzseFMdbw431XI
         dIRVlju8V6VTZnD/HLToYoUPRRSDWj8pT9GKvu5x7BkwbZA/Ts2QhcIx0Qodog1rk5uR
         ZJFw==
X-Gm-Message-State: AOAM5334cZcCJze/HLFOLGBThvsYYjJ8MdBWlqU3eCzDuXLQiaeUk/RR
        xdVuMFqqHDtlWNayID4WCow=
X-Google-Smtp-Source: ABdhPJzKFRdS0r/pduEPGBeZNMvN2mfclgr9sTJ6StbYF8vCRE50f7iT42jh7L0QW0lUgAAOETbjtw==
X-Received: by 2002:a17:906:5012:: with SMTP id s18mr14225761ejj.100.1615207113279;
        Mon, 08 Mar 2021 04:38:33 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v9sm6429940ejd.92.2021.03.08.04.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 04:38:32 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Makefile: generate 'git' as 'cc [...] -o git+ && mv
 git+ git'
References: <20210307132001.7485-1-avarab@gmail.com>
 <xmqq35x68zob.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqq35x68zob.fsf@gitster.c.googlers.com>
Date:   Mon, 08 Mar 2021 13:38:32 +0100
Message-ID: <87ft15kegn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 07 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change the compilation of the main 'git' binary to not have the CC
>> clobber 'git' in-place. This means that e.g. running the test suite
>> in-place and recompiling won't fail whatever tests happen to be
>> running for the duration of the binary being regenerated.
>
> I am not sure why I would want to support the workflow this is
> trying to help.

Because it also allows me and others to do more testing on patches to
git.git.

If I'm working on a patch to e.g. git-fsck I might be doing
edit->save->some-tests, where "some-tests" are a subset of the test
suite I think is relevant to fsck.

But after doing N commits with passing tests I might notice that some
other part of the test suite I didn't expect to have anything to do with
fsck broke because I wasn't running that test.

I wasn't running that test because I'm not going to wait 10-15 minutes
for it to run while actively editing, but will wait 30s-1m for 10-50
test files to run.

So I can also have the full test suite running in a loop in some side
window that'll give me a headsup if the "while do-full-tests; [...]"
loop breaks, at which point I'm likely to investigate it sooner than
otherwise, and not waste time going down the wrong path.

You can of course do that now, but it requires having a worktree on the
side or whatever, which isn't always ideal (sometimes I'd like to have
these tests on uncommitted changes).

This change makes it mostly just work.


> I do not want to see a patch on this list claiming that "While the
> whole test suite is running, I tweaked the source three times and
> recompiled, so some tests may have used my second iteration while
> others may have used my third and the final version of the code---in
> any case, all tests passed".  And when a patch that was developed
> that way came in, I do not want to hear "Yes, the test suite used
> mixed binaries, but I KNOW the difference between my second and
> third iteration should not matter the parts of the earlier tests
> that used the older iteration".

We have a lot of existing rules in the Makefile that are of the form:

    make thing >thing+ &&
    mv thing+ thing

Where we're not doing the rename dance to avoid clobbering the file
we're reading.

As far as I can see all/most of those rules can just be rewritten like
e.g. this if this is a use-case we not only don't care about, but would
like to go out of our way to break:

    diff --git a/Makefile b/Makefile
    index dfb0f1000fa..8b57c3a5e63 100644
    --- a/Makefile
    +++ b/Makefile
    @@ -2190,2 +2190 @@ config-list.h:
    -       $(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh \
    -               >$@+ && mv $@+ $@
    +       $(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh >$@
