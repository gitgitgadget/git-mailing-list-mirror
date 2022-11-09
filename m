Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1657BC4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 23:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbiKIXzz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 18:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiKIXzr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 18:55:47 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897C524F33
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 15:55:41 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id x23-20020a634857000000b0043c700f6441so39302pgk.21
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 15:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4NKxwmqxEPHexXqr1ngf/0/IOoYOynDpHVluDpLclUo=;
        b=aKKEnuBjNOCuqupPbFrXBGJwBiZErzvh3w6JvQSWSoW4o244XQ3f8aZC/SMR/DUxr7
         eqUD7AfyjFKu5iZ0xInWpbGH91iewmU4Oc1E/GNunWAvRXy997Zha+BnLzjiIHALItZs
         o9WMgiywqnt7hUURiRKIal3FOevSVBox5zjtiXsbZu4PkxkSTthjuk2B00V99B2x3WXg
         R+/tNUPT77/DsMFrdkF+FFXuR/hiXXE5+eU6sY+VK/qW9mw5j4x0njWpVf6H/FvQo8aQ
         ipIN4yJR7WCK+sa/uqI8lX3M+Kf1IekeWPRIWWlHaflGOoWNrz13FgBUQmHKVwyiR82M
         qyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4NKxwmqxEPHexXqr1ngf/0/IOoYOynDpHVluDpLclUo=;
        b=CQED+4grTIagv55QFyuWPFJF1U8VT3seL9aLOKL7yllnSzLzHd5VJMtMIRtDkJqYYj
         wa6ON9pxOv2ioesMz7iNprD+IWc/sHGTKNpuE+q9kFWb/2f0Qt0/8U9CdXrsIQDMExLt
         VeJTQMQ1XRWHZDKopJvrTUjzQpbfZIyFTozYiwsTIMJ5mshzB1jMr3qz2zyrYb7HyaIk
         VcYxnpsLA+dfJIirAtbo1zNYJS9NUd2p1SzUjisxM2ILfhfRn4azt1dEq3QVbgEhlYuW
         nkxWlDceKyzw0Q4w4PBk2Sj2s/4coqktqAJJ9isSoftTzXgOiWczZrNPKudwPQpcFDFg
         MuvA==
X-Gm-Message-State: ACrzQf27DQz49YeI+nfpkVt1GVYsVHOV+sSq/7KULvn8a1T93iC10fwu
        mS4Ulu4cpt0c3D6dkEeQR53QxQSDhun5+A==
X-Google-Smtp-Source: AMsMyM7gL3bjWJYjBxoXPKeKN/Kr9B+wNe4SMk3JRwWsI1OgytFGLwEnF6YQ9tRI7W29XBVKS5p+EM4P7AsVIw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:806:b0:213:473e:6fab with SMTP id
 bk6-20020a17090b080600b00213473e6fabmr62421716pjb.245.1668038141166; Wed, 09
 Nov 2022 15:55:41 -0800 (PST)
Date:   Wed, 09 Nov 2022 15:55:39 -0800
In-Reply-To: <Y2wYnpASncR2E0Ja@nand.local>
Mime-Version: 1.0
References: <20221109004708.97668-1-chooglen@google.com> <Y2wYnpASncR2E0Ja@nand.local>
Message-ID: <kl6lwn833cp0.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH 0/4] git: remove --super-prefix
From:   Glen Choo <chooglen@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Nov 08, 2022 at 04:47:04PM -0800, Glen Choo wrote:
>> *Note to maintainer*: See "Interactions with other series".
>
> Thanks for the heads up ;-).
>
> It looks like this series is broken, at least in my application of it.
> On the first patch, running t7401, for example, I get:
>
>     BUG: builtin/submodule--helper.c:121: cannot have prefix 'sub/' and toplevel_cwd_prefix ''
>     Aborted
>
> after running the first test (-x shows that it happens after running
> 'git submodule summary', unsurprisingly).
>
> I pushed out the result of what I have to the 'gc/remove--super-prefix'
> branch of git@github.com:ttaylorr/git.git. As you'll see, the base is
> 'master' (as of 319605f8f0 (The eleventh batch, 2022-11-08)) with a
> --no-ff merge of 'ab/submodule-helper-prep-only'.
>
> Let me know if I'm holding it wrong.

No, the problem seems to be entirely on my end. (I could've sworn I sent
this to CI..)

Given that we have another competing RFC, it doesn't seem like a great
use of time to reroll this just to unbreak "seen", but let me know if
I'm missing somthing.

>
> Thanks,
> Taylor
