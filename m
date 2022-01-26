Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F765C433F5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 21:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiAZVGa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 16:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiAZVG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 16:06:29 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A75C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 13:06:29 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id d10so1177620eje.10
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 13:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=dkOErWQho4V9pLlm0vRIpKUONFtIkn3oPaFHq5wP6RE=;
        b=C7gQnM/x3I5bgDioqi77h+kFX7XJNvIQb3QRHGEYgOh7E09aMqj4DMGfNEkhTMQXDv
         H7FMCrM2hByiQqUbYOtNMtane6gz4qBQTi7N269uQqSh6Ukii35XDQCBD3kjwWd5OKaD
         IPBcoFp5jOfChwP7VjuP+rk+9O3LW8xqEO0mFZwMMwe5LD5F1VG0Pe8zjg43b1L1PJGB
         u/SgJzemDzwpzsJm0k4rDpFA1VmxrNLdUirLQmes065tS3Ox1qsWRyUHPPpu7oL8nuun
         X3PUxU9X/UXFreP0ZhokNko7nrUE3yd2ZFNYuyGSM2w7xeVUw+T5uU5yzxQDivE5eNhU
         ZFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=dkOErWQho4V9pLlm0vRIpKUONFtIkn3oPaFHq5wP6RE=;
        b=QtarwR/jTc+PxjLKqEWrgYqKwfem8ARML/fQKjQ7EyXT/sxamafYYU2uUJY97IF3Ui
         OhlomYyq5BZ5rB2Fa58JxbAuLI9WYuVLAEv7jI9CIBTt36jdv20I1E6Aadv3RyXkmjTu
         0054LrfBDpIa1Re33JJaZWHQvo3iWE8ZEUw1FnAPTeXO2ba73xi6f2XgH1MzsZNpV7Rz
         UTeVvBDzKjxpXAq5wyYUqNA54IfhRpiSwnzzDUaOxt25XTFGvVd2xogtSE9kMVshAi/t
         vALyGgFrhHu/qZ/NaCVa+i2oH0yp5VrO8XRZfIuuBZXkc2ZJdM770VW6zm8yzJxGZQsc
         8ZIg==
X-Gm-Message-State: AOAM531P89k/XGb2PN5pyw/DRvMaHH6GYnJ5EKKMZUUjtE3ENGiJt45Q
        UZBro9eXKI3FD+8cvpxt1xwb8LwPv3EQBw==
X-Google-Smtp-Source: ABdhPJxg9f7VvGt+lLRvGg/pBCvsPGB0vQR2OZcOf2lSvCIOtpsTVGZUMkZddgvxKEf/5FMN8F7Iag==
X-Received: by 2002:a17:907:3e0c:: with SMTP id hp12mr378045ejc.685.1643231187400;
        Wed, 26 Jan 2022 13:06:27 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id dk3sm10229605edb.33.2022.01.26.13.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 13:06:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nCpUn-003E3E-NZ;
        Wed, 26 Jan 2022 22:06:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Yuri <yuri@rawbw.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: 'git stash push' isn't atomic when Ctrl-C is pressed
Date:   Wed, 26 Jan 2022 21:47:10 +0100
References: <4493bcea-c7dd-da0a-e811-83044b3a1cac@tsoft.com>
 <220126.86bkzyfw3q.gmgdl@evledraar.gmail.com> <xmqqlez2qnfi.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqlez2qnfi.fsf@gitster.g>
Message-ID: <220126.864k5qdx66.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 26 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Tue, Jan 25 2022, Yuri wrote:
>>
>>> Ctrl-C was pressed in the middle. git creates the stash record and
>>> didn't update the files.
>>>
>>>
>>> Expected behavior: Ctrl-C should cleanly roll back the operation.
>>
>> Yes, you're right. It really should be fixed.
>>
>> It's a known issue with builtin/stash.c being written in C, but really
>> only still being a faithful conversion of the code we had in a
>> git-stash.sh shellscript until relatively recently.
>>
>> (No fault of those doing the conversion, that's always the logical first
>> step).
>>
>> So it modifies various refs, reflogs etc., but does so mostly via
>> shelling out to other git commands, whereas it really should be moved to
>> using the ref transaction API.
>>
>> Ig you or anyone else is interested in would be a most welcome project
>> to work on...
>
> I must be missing something.
>
> If I understand the problem description correctly, the user does
>
> 	git stash push
>
> which
>
>  * bundles the local changes by recording a commit (with trees and
>    blobs) that represents the new stash entry
>
>  * removes the local modification from the working tree files.
>
> And if the user kills the process while the second step is running,
> there will be files that are restored to HEAD and other files that
> are left unrestored, because the process was killed before it had a
> chance to do so.  At that point, we probably do not even know which
> ones have been restored to be "rolled back"---that knowledge is lost
> when the process got killed.
>
> My take on it is that it is not something that we can call "_should_
> be fixed".  It is in the same category as "yes, it would be nice if
> the world worked that way, and it would be nice if we had moon,
> too".
>
> And it has nothing to do with the command being written in C or
> shell, and it does not have much to do with the existence of ref
> transaction API.  If you want atomic working tree update, you'd need
> to snapshot the working tree state, record the fact that you are
> about to muck with the working tree in a secure place and make sure
> that hits the disk platter, perform the "stash push" operation
> including the working tree update, and then remove the record.  The
> record will help you discover that your earlier attempt for doing so
> failed for whatever reason (e.g. ^C, kill -9, power failure).  Then
> you'd need to arrange that the state gets restored, and possibly
> redo what you were doing.
>
> Which theoretically can be done.  But it would be not practically
> cheap enough to use in a day-to-day operation.  It certainly would
> be too much to expect a new person to be able to "work on".
>
> And the "theoretically" part is important, in that it draws the line
> between what is realistic and unrealistic.  The thing written in C
> or shell would not make much of a dent and the existence of ref
> transaction API would not have much effect on partial working tree
> updates not being restored.  They are red-herrings.

I understood this problem as being one where we do the ref work first,
which we could start a transaction for, the user then ctrl+c's after the
ref work is done, but before the working tree is updated.

Which, if we use the ref transaction API we could intercept with an
atexit() hook that would inspect our state to see if we're done, and if
not roll back the transaction. It wouldn't survive a kill -9, but would
handle being interrupted.

We'd then leave the working tree modifications in place, or not, and
roll back our ref updates, or not, depending on where we were when we
were ctrl+c'd.

The reason it being a command that's recently converted to C (in terms
of its API use) matters is because we don't have any sort of
cross-command ref transaction mechanism, if the ref-modifying command
we're invoking fails we don't know why exactly based on its exit code.

So we're not prepared to roll it back, although that could theoretically
be addressed it's easier just to move it all to in-process API use, and
it also addresses the general TODO of reducing how much we shell out to
ourselves over using internal APIs.

> I suspect that the untold thinking behind your statement was that we
> should try not to discourage new users from asking, and I agree with
> the sentiment to a certain degree.  But at the same time, I think it
> is simply irresponsible to do so without distinguising between
> asking for something realistic and unrealistic.

I must admit I'm not deeply familiar with builtin/stash.c in particular,
but I've looked at e.g. the API use in builtin/branch.c that I
referenced, and I think that (and converting to the transaction API in
general) is a very suitable task for someone who's interested in
contributing, but not deeply familiar with the codebase.

