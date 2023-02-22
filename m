Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE781C636D6
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 23:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjBVXYL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 18:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBVXXw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 18:23:52 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D4538E88
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 15:23:49 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id y19so5149996pgk.5
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 15:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUX7vNMrMfAbnt9C4QZ/Pbuk1zhTnNoyRB0OaUHnz1s=;
        b=NZXof2D76dwog2UosRoa+yESKCD7oS36gZcSnVhgNITEFw60Ws8jUt+v4Wgz9yWLFA
         GLlucGuWVyptmuE3bKlvUR8Gjg8scar/wLy7jdmDaCgJVOD+F0KfaiZuaQeBmMfYFTNJ
         IglLP9O0LrWDMtzKojMR/O8wmbDdUeib7Y1u2E9UZ+nPo//72LkGuk7pKJyBYDfNhj8G
         4jl0w6r8iGz+zSzHEagwY64ObvGw92Uygc5d+cQIrGmKaahimLoqAkOEXmFZOUCT0W0K
         DB9VePALh9Th6K0jAl+QSEA13miGvX+cmzUTpg4On9HZ1aTUMOTgvd2Z2fHjBKmr+GLS
         lCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aUX7vNMrMfAbnt9C4QZ/Pbuk1zhTnNoyRB0OaUHnz1s=;
        b=1vFubIcv9appCxa3CgEfVp9o5EYKpmbUvodtDXYfb7ASSX1Wbj73C/TyLAciCkX9LU
         WZJMuougdKQL6vQUx/+XS3Winb3yZCtGItKjxfYUN54nH4Y3dXAH/tw1LGNzhMkTcWQ5
         3CpxvCzyX5/Iw+1h/X9Vc3XTKzJ7MJEQQCssvzeMgcIks2BJLyxeRULj2H7durQwXFFn
         Z5gl0qrVoK2maKznRG5agK6noD0/cm1ybmYVCKMX5FuWZ5qWWkawDBE8Rvq5oLXyhEfr
         6nTgNNCKMnUtwY3GkFsojE7F20DiUWSU+gW/2uwOizGlqHDi4w+5LMgtpJuFxIl1QP+Q
         yqUg==
X-Gm-Message-State: AO0yUKVGLdqcPb46CewCg3eudv1yWp3H9eKFll0gHBkRZRGwrSV8kP+0
        XsM8iey4jUIQ9tobviAyR6o=
X-Google-Smtp-Source: AK7set9SZyw8lj8qXrO17x1/TrbmQHP7P6SFJh8FGKQimjzIbWccuf/0J/hqYttJK62HSCtDKhLaog==
X-Received: by 2002:a62:4ec9:0:b0:5ad:9f47:885b with SMTP id c192-20020a624ec9000000b005ad9f47885bmr7385742pfb.31.1677108229072;
        Wed, 22 Feb 2023 15:23:49 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b005d6dff9bbecsm1728738pfn.62.2023.02.22.15.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 15:23:48 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Raul E Rangel <rrangel@chromium.org>, git@vger.kernel.org,
        demerphq <demerphq@gmail.com>
Subject: Re: [PATCH] archive: add --mtime
References: <Y+6G9n6cWRT9EKyl@google.com>
        <91a73f5d-ca3e-6cb0-4ba3-38d703074ee6@web.de>
        <xmqqilfykhsf.fsf@gitster.g>
        <57b6643a-b9ff-3ea4-d60d-1a434d9ea75e@web.de>
        <xmqqlekrh94h.fsf@gitster.g>
        <Y/ZyNNMFmafz8YvE@coredump.intra.peff.net>
Date:   Wed, 22 Feb 2023 15:23:48 -0800
In-Reply-To: <Y/ZyNNMFmafz8YvE@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 22 Feb 2023 14:51:16 -0500")
Message-ID: <xmqqsfexb7y3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> My biggest concern with the patch I showed is that it gives no escape
> hatch if people don't like the change.

Yeah.

> Like I said earlier, I don't
> think anybody has grounds to complain about the byte-for-byte output
> hash changing, as it would be changing once per second. But they may
> complain about the cosmetic problem.

Yeah, they may complain "it no longer is possible when I took the
archive out of a tree".  To be honest, I didn't think of that line
of complaints before.

> The more obvious one at the Git level is to have
> "--current-mtime" or something to get the old behavior. But at that
> point, you may as well support "--mtime=now", which is the same amount
> of work, and much more flexible.

Yup.  Let's merge it down to 'next' then.

Thanks.
