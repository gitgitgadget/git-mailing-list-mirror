Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E529C4167B
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 23:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiL0XDp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 18:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiL0XDm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 18:03:42 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E854DF29
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 15:03:41 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso15360142pjb.1
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 15:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ML8+mGbtFqBO85IENcH5oCytltwF6FkZ9i0y7LLefs=;
        b=WeeDNBCMDVdfYMEMoS7yRcZ670CxldjsXSXP9aVVx8mply5f4IMcuSH+oB4PktTPOc
         jOTipBYOGzyQONx8HlAm67eF4TdHuV+yGIxNzgIUZ8HVmrFP7G9Uh5jUxLfHikhOCIVc
         rBTk18Nhgbc85wiTq7ktqlrw214BLcBIfgtimQOiw+hqDwmSkMt07/LR3QDxx/3KaOlc
         BNz2LAP89cnnywJHfj0JcMPXbkFpGSvmqO+ca5zIxyWtI+IikrF7OzQkPu5E2ksTa3Rd
         +q0OiCEm+qBsFxpsj0p7OfVtxsdJ78AWtUgzKOJHkFCzpJClJQ3NOa4dBBKIu2nKJ4fN
         ln6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ML8+mGbtFqBO85IENcH5oCytltwF6FkZ9i0y7LLefs=;
        b=ulVN9WPVLy08mqoD00Vf4qLiSV9Utu4w2ttUAAAoSK5E753KcXbkfSsauZyLgD1iCm
         TlEoFVFs9VS4NAz79008D//Vi4U16MsHg0YuvvFuyA8Y5SiiRDbf3rQuPUwEg0cGYqst
         GBSoL/SEayixZpHzvRUCHNgUYmv3A0l8Wup8mTjQgis/Td3BX6L0p7GR7KONB61AARkk
         6dzjuhbWvC3GoT4A/rNy5B7ellG3/syyS3MeUgxm/lXcQSoEVto8+LjtFm42saOIyO9p
         fVdSpTfmXKoHNCCXuaUiFjh3xQ7TNvrwFcWYiteamtu9ShWrMLLki4kxEj0zjpiWsaGn
         +hWA==
X-Gm-Message-State: AFqh2krkRQiP5DRyKkWEUtk4JiAmby6AvA1/TjFiBAC6rt5ouqZMXZo/
        UtKK1C2QYcq9RhaDp02/795+bzoM4CudqA==
X-Google-Smtp-Source: AMrXdXv23SOeJ2GgHzkjcivyqqQWpbHOb6kbrHiOkvtfG8b7c+UVwFEpDJvvfnAjwX6Ett0Lrv/9tQ==
X-Received: by 2002:a17:902:e845:b0:188:fc0c:b736 with SMTP id t5-20020a170902e84500b00188fc0cb736mr60504514plg.67.1672182220545;
        Tue, 27 Dec 2022 15:03:40 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902e9cd00b00188fdae6e0esm9637497plk.44.2022.12.27.15.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 15:03:40 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH v2] setup: avoid unconditional open syscall with
 write flags
References: <20221227143200.1182341-1-cgzones@googlemail.com>
        <221227.86lemsvqmb.gmgdl@evledraar.gmail.com>
Date:   Wed, 28 Dec 2022 08:03:39 +0900
In-Reply-To: <221227.86lemsvqmb.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 27 Dec 2022 15:40:59 +0100")
Message-ID: <xmqqa638sb3o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> +	fd = xopen("/dev/null", O_RDONLY);
>> +	if (fd > 0)
>> +		close(fd);
>> +	if (fd > 2)
>> +		return;
>> +
>> +	fd = xopen("/dev/null", O_WRONLY);
>>  	while (fd < 2)
>>  		fd = xdup(fd);
>>  	if (fd > 2)
>
> I don't really get this, if it's safe under seccomp to open this
> O_RDONLY wasn't it always redundant to use O_WRONLY, and this change
> should just be switching to O_RDONLY?

The first "if we successfully opened /dev/null and also found that
stdin is already connected to something above 0, then close the fd"
may be tricky to reason about.  There are four cases.

 (1) The first xopen(/dev/null, O_RDONLY) fails and returns -1.
     In this case, we go down the original codepath.

 (2) It returns 0 (upon startup, stdin was closed).  We keep the fd
     to use as the standard input, and go down the original
     codepath, but now standard input is connected, the original
     codepath needs to deal with only stdout and stderr, so we can
     safely use O_WRONLY and dup it into stdout and stderr.

 (3) It returns 1 or 2 (upon startup, stdin was open, stdin or
     stderr was closed).  The fd is closed, and we go to the
     original codepath.  Again, the original codepath does not have
     to touch stdin, so we can afford to use O_WRONLY.

 (4) It returns 3 or above, indicating that the three fd's we care
     about was already open.  We return without making further
     damage after closing the fd.

The updated code does a single system call to probe for the lowest
unused file descriptor and returns in the common case.  And that
single system call is an extra overhead for the "oops some of the
low FD were not open" case compared to the original code, but the
read-only FD may get reused when we need to.

So, I think the updated code does what it explains in its proposed
log message.  I.e.

    Check the need of sanitization with a file descriptor in read-only mode,
    keep it as replacement for stdin and open replacement file descriptors
    for stdout and stderr in write-only mode.

    v2:
      - switch to xopen("/dev/null", O_RDONLY) to stay at 2 syscalls in the
        common case and use O_WRONLY for stdout and stderr, as suggested
        by René Scharfe

