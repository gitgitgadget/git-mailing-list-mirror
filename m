Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40C5C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 08:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiEXIQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 04:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbiEXIQw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 04:16:52 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD6E10FF4
        for <git@vger.kernel.org>; Tue, 24 May 2022 01:16:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ck4so29435308ejb.8
        for <git@vger.kernel.org>; Tue, 24 May 2022 01:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Dx/pCTeK3Z/yahhwOJ1q9l4PKMiIStrJe7p6YytbQps=;
        b=YgI6cA+N9FDxZ5Szea+djCcs/77NWlBnouFhhSjYqExh4qYGNnuNh8ewk0pIefjFE9
         Kg+1xT1jAsPeMmQk4GDpCPozkz/m4I5TF16698gkb/K75CWEeYg51lQriBFZs2FIDw9J
         XzHLsFx4vXCVIg4t0Htx3ZN0iACuBgrpXSX6LNsxjx+gCAHMtSaF9rpwDVMvEaV40iqG
         MfeoT7S4ClQ20A+ChKv5o0b7cVxhqWrem/LloS/2RDq1sTii1PcZxn4Bv+i23Sny2DGj
         HSburHinIGlwEcAH52Sh1ONoGz/K/QziYzC0wj0hWgTQlQ9iVlKTLf0EzwebFFahViex
         2d/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Dx/pCTeK3Z/yahhwOJ1q9l4PKMiIStrJe7p6YytbQps=;
        b=bLcN8zZOHlM6ikLEV+fBEbZix2HxAQ0XgzOzh/fO6bfNMZb/UCA5aRTJhQo2sPIRKl
         l5+SlhscT8gfNxK7bZk/U/aGL3mDYTwDqrS6HrGhSHFsF5o7zZ9iu2sXhFiy32o06zLV
         9X23B7QKu1omk3HT2zzMkIE43tk8urOlR+DNN/UMDeYJ4hYH0+TUlT0qMjkSR+5+BtdD
         82nzaWVTKWkNc5uqDsK37ov1BcIrMKYVPikGHclWYntQoJfI+6g0putNf5NNRhJjoj3i
         2Tleaxq7P8B13VyZ9fsSqp8m6k5feeQtjVkCd4xi9RGLwYQ3AcanCvA+eXTZZ0z6s79D
         zxAg==
X-Gm-Message-State: AOAM5301C+plmZw/tx4NlOne4lCY7AjxtpqUWET/quHfBL8gosA3D2fV
        usJ5FsvYyHQXTeBFtEJ5FWJkJ8Bk8HC5wA==
X-Google-Smtp-Source: ABdhPJxeWCHZhZ0J2VNgOAR1lCePCr1OLznfxD/q0ddmzJFJgbIwqE58B8akUNQP+e6jRgAjfpOeZg==
X-Received: by 2002:a17:907:16ac:b0:6fe:b7db:8af5 with SMTP id hc44-20020a17090716ac00b006feb7db8af5mr14534176ejc.433.1653380208996;
        Tue, 24 May 2022 01:16:48 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id mj9-20020a170906af8900b006feb7b1379dsm3840920ejb.181.2022.05.24.01.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 01:16:48 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntPih-0039PA-Ls;
        Tue, 24 May 2022 10:16:47 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] revert: optionally refer to commit in the "reference"
 format
Date:   Tue, 24 May 2022 10:12:15 +0200
References: <xmqqsfp2b30k.fsf@gitster.g>
 <220523.86wnecxqol.gmgdl@evledraar.gmail.com> <xmqqy1yrnado.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqy1yrnado.fsf@gitster.g>
Message-ID: <220524.867d6bxs40.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 23 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> +		if (!opts->commit_use_reference) {
>>> +			strbuf_addstr(&msgbuf, "Revert \"");
>>> +			strbuf_addstr(&msgbuf, msg.subject);
>>> +			strbuf_addstr(&msgbuf, "\"");
>>> +		} else {
>>> +			strbuf_addstr(&msgbuf, "DESCRIBE WHY WE ARE REVERTING HERE");
>>
>> Having seen how people use git in the wild, this *WILL* result in a
>> bunch of history where people don't edit that at all.
>
> It was done very much on purpose.  A pressure from other project
> participants against the ugly all caps content-free message will
> help instill better behaviour.

In some cases that will happen, but from experience of working with a
bunch of novice git users some people won't edit these at all,
particularly when they're in a rush (e.g. reverting something because a
thing broke production).

So making the default subject less useful is something that will be seen
by others, and thus result in worse UX.

AFAICT all of the goals you're suggesting here will be even better if
it's commented out, then you will need to edit it, and we'll error out
by default if you don't. Why not use that?

> A solo developer also will learn
> after making reverts with content-free titles (and if they do not
> find it inconvenient for their development purpose that their
> history is full of content-free titles shouting in all caps, then
> more power to them---if they are happy, we are happy, too).

The subject you're replacing isn't content-free, it at least includes
the OID, this one doesn't, so you won't see it in --oneline. That's less
useful.

> If we leave something like
>
> 	# Add one line above and explain not *what* this revert did,
> 	# but *why* you decided to revert in 50-70 chars.  Did it
> 	# break something? Was it premature?
>
> 	This reverts commit 8aa3f0dc (CI: set CC in MAKEFLAGS directly, 2022-04-=
21)
>
> presumably, stripspace will make the "This reverts commit ..." the
> title of the reverted commit.  It would invite people not to edit it
> out out of laziness.  Since the whole point of this change is to
> encourage people to describe the reason behind the revert on the
> subject line, such an invitation is counter-productive.

If that's the concern we could also comment the "This reverts" line.

> Doing the first two lines like so:
>
> 	Revert 8aa3f0dc (CI: set CC in MAKEFLAGS directly, 2022-04-21)
> 	# Edit the above line to explain not *what* this revert did,
>
> would have pretty much the same effect, I am afraid.
>
> So...

Ditto, so just present a buffer like:

    # Revert 8aa3f0dc (CI: set CC in MAKEFLAGS directly, 2022-04-21)
    #
    # This reverts commit 8aa3f0dc (CI: set CC in MAKEFLAGS directly, 2022-=
04-21)

Along with some advice that the user can uncomment those template lines
& adjust them.
