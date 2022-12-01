Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4386EC43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 13:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiLANrM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 08:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiLANrL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 08:47:11 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57986BF939
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 05:47:09 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id h184so906151iof.10
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 05:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQgELzgfIFMSc5sWzbvSXgYvEFpi/qqMOy4igleZ4eo=;
        b=GXv60PbyDME7PfbncdKuMfO8d/kvYd6ehg15JeZ9BwIE0W1kn0qPuUfNl69Y/9f/yA
         HxdC+NKkMfO3Teew6cqEMPeB1KtNjM0x6AtHo6DJCgBzwptvgLLlqhx5LOEmu+mD/qUx
         am5QAgxhv2UcvymE5azqYhueuf2woMsVpVPrK5DZdYlLcKVnVfbVrENZa524OdWd6GNk
         i28jApynGWnVxIqVg+ExIYJs+gFaOofE58d/nDPEG1TVm59oDQe5SLivPnFCeawZigW7
         KkfUcFZqhz18mkOMs2vrowjF/1IoTwn2JrEimQUXc8KduYp04sZm9w86m25Pc0fTn5Vy
         WwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RQgELzgfIFMSc5sWzbvSXgYvEFpi/qqMOy4igleZ4eo=;
        b=ONGf7vZqnUYsScDF+06Rus0P8J8oHJ7SouFWhUyQQcV0XqKFAQVVX66q+yrPVMdSse
         MBBzU7r1gvv6K51smaCtFYwJNE0DpKXZ7Sbs2Hyf5luzSVv0D3mIcVB1KtZD9VDlkrCY
         ng/9thxDeQuXxyRItCiqmRfQKd0N/DLI5Gy9H46XFpATKbvv3a56nEEC+5ETszoIeSiQ
         7NYARmc1Lg7tJb42aw6Fu/GK4t1nTCO/ODICeK8EhDTP3XVAuOmjoS1ngy4B8ZvTILG8
         KHCBnZ0WfT3IK+frJwx03CvWAg18t/7GUouNmtbhX3Ro48PXZqEXXn2/CXKD2yVBpYzq
         TQvg==
X-Gm-Message-State: ANoB5pnV6Xeg6ESKPTkQUGs+ir6Ov4Qj/Bm5zMqtQpbnFpArqqKAtXXg
        H0qL0kQef1lVIbFOlPpdYuTAhDW+Ing=
X-Google-Smtp-Source: AA0mqf6BfSEQHcXNuh6uCVSIYmBvLI4kmrl5eATx335WRHbIm/NvncdUg888ebqkhF9RkJ7R/pvEPw==
X-Received: by 2002:a05:6638:ca4:b0:389:dbc8:c058 with SMTP id x4-20020a0566380ca400b00389dbc8c058mr10701972jad.10.1669902428086;
        Thu, 01 Dec 2022 05:47:08 -0800 (PST)
Received: from stargate ([2620:72:0:a40:ae86:2b20:51ed:d36d])
        by smtp.gmail.com with ESMTPSA id x34-20020a0294a5000000b00375aa177cb8sm1674730jah.145.2022.12.01.05.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 05:47:07 -0800 (PST)
References: <878rjry5a7.fsf@gmail.com>
 <221201.86zgc7gv4x.gmgdl@evledraar.gmail.com>
User-agent: mu4e 1.9.0; emacs 28.1
From:   Sean Allred <allred.sean@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What are cherry-pick's exit codes?
Date:   Thu, 01 Dec 2022 07:38:42 -0600
In-reply-to: <221201.86zgc7gv4x.gmgdl@evledraar.gmail.com>
Message-ID: <87zgc7w811.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> In general I think you'd do well to follow the template of what I did in
> 9144ba4cf52 (remote: add meaningful exit code on missing/existing,
> 2020-10-27).
>
> In particular, I don't think we should exhaustively document exit codes
> for a given command, as we really have a hard time controlling all the
> possible values.
>
> Rather, we should define specific non-zero values as having specific
> meanings, as I did with "git remote" in that commit.

Definitely agree (this is roughly what I've had in my WIP patch), and
I'm glad to see precedent for an explicit 'exit status' section.

> We'd also ideally leave "exit(1)" alone, and if we need to disambiguate
> it start with "exit(2)", but maybe it's easy to make it unambiguous in
> this case, or it's already unambiguous...

I'm not 100% sure what you mean here, though. Do you mean that if
something returns an exit code of '1', we shouldn't touch it without
more specific review since it's more likely someone will be depending on
that value?

I think in my case, at least for what I see right now, the more urgent
need is getting exit codes documented -- but I can see where doing so
might create a situation where we can't improve the exit codes in the
future -- thus implying that the 'improving' and the 'documenting' may
need to be done in one go.

>>   - 127: fatal -- lots of reasons -- I'm guessing this is value for the
>>     'return -1' and 'return error(...)' statements speckled throughout
>>     the code, but it's been a long time since I cared about two's
>>     complement so I may be wrong here.
>
> If it's "return -1" you generally end up with 255 in your shell,
> although that's unportable both for the C language, and for POSIX.
>
> See 19d75948ef7 (common-main.c: move non-trace2 exit() behavior out of
> trace2.c, 2022-06-02) for some code dealing with that (where we fake up
> the -1 to 255, for logging).
>
> But from looking at cmd_cherry_pick() we catch any <0 return values and
> die() on them, but maybe we exit() elsewhere? Do you have an example of
> these.

No, I don't think so -- at least not by the point we hit
'run_git_command()'.

>>   - 128: fatal -- sequence is interrupted, possibly due to some other
>>     fatal error, e.g., 'commit doesn't exist' or 'mainline parent number
>>     doesn't exist'
>>
>>   - 129: fatal -- there was nothing to cherry-pick at all (e.g. empty
>>     range)
>
> I think as in 9144ba4cf52 (remote: add meaningful exit code on
> missing/existing, 2020-10-27) it's good to just leave these
> undocumented.
>
> We typically return these when we invoke die() or usage_with_options()
> (or similar).
>
> So, if we are documenting them (which would be a good change, as an
> aside) that probably belongs in gitcli(7), we could then reference that
> from other man pages.

Ah, gitcli(7) makes sense for these statuses. I'll see about submitting
a patch for review later tonight / this week; I'm cautiously optimistic
that it will be straightforward.

>>   2. If not, is the above listing the exit codes accurate and complete?
>
> I don't know, but skimming the code I don't see the "return 1", unless
> by the above " - 1" you mean "minus one", i.e. 255.

I do indeed mean 'negative one'.

> I.e. cmd_cherry_pick() calls run_sequencer(), which on error seems to
> return -1 for most things, which we then coerce to that die().
>
> But I haven't looked in much detail, so...

Seems like I (or someone) has some pretty 'fun' code tracing in my
future...

What's the next step here? Submit a patch with my best effort and suss
out the problems during review?

--
Sean Allred
