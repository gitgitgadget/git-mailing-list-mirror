Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB76C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 16:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjDXQjn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjDXQjm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 12:39:42 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6933526E
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:39:41 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a66911f5faso39059915ad.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682354381; x=1684946381;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPqTvKVhUkewf1C/LvsKFTRoyyX/WhOSGOXT4QYotWM=;
        b=enzpdAey807RknWXmWL4JhwwiQh4VBgPcbBMrQ7QBk5cSIMpehzyppp/IYYbbZZICA
         Q5zTZVINRftdEU6D/8Z/I7ut6/4XkmpUE6AoMkdAAFhOpJTfs1wYIIHegv1ykEsTeOXZ
         F54mmXmwWLOLZJqNpgsaBIXf3iWqh//PEDs/qQKTCeakWYsq4FRtJ7q1xjINJAkrpJ20
         p119dUhVoYCw1EiqrNF5Trzz3fhzBDcY5njmhoOM+LKy0RVyBpVNRnBlFAeWfZmVp8tI
         lzclJBHLZgsUxs6YNqQBV+pKabB8cTNs1DniSBWEy7Y5yDTIJ8agm/1NfaEsAcHgSLb8
         rOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682354381; x=1684946381;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NPqTvKVhUkewf1C/LvsKFTRoyyX/WhOSGOXT4QYotWM=;
        b=Tc8GSFh8a8ESTXx2pSIZRviCzZ5k4FdtboPybWORA43NC3hqqT0/M0CQKUVfUWt5qA
         AFwJSrXgT0cYsI+O+JaMz2fJmZKmtkvi1akK/yQWLhqTkV9BZ1czGTO/TEXoBXrt/ds5
         SNfNj+BV1ejXxWuoBSH6nMlPfJlXhAIPlgdngehY9dzo8d0eueOW59frxh2V9/iINEYG
         MvUVR2pnCeK7rEAVRqkprc7NibWM046oS4DTcT/qbWioXSCXhol8dBPLwirwP4ksaR/V
         DbegUJpJdeii0QXqKH5NaRNsIKHYQkGLg6Hc8AcfQsvtPrADvFb7n4tbP5fB4btI9KrW
         Uohw==
X-Gm-Message-State: AAQBX9cgZtO9xkL/A4vq/MQidjyocRlwTF8hJ23Ke/kxvjQs3wt56hpD
        vHA/U7yy5s9MepdOGW2upCs=
X-Google-Smtp-Source: AKy350b9Z/ET1W5cHof60DG63hCuNbYOIYToQquv11uewG6n6a2B0jMrUykjslkynAMUF26i/3EHsg==
X-Received: by 2002:a17:902:c793:b0:19f:87b5:1873 with SMTP id w19-20020a170902c79300b0019f87b51873mr12646878pla.62.1682354381142;
        Mon, 24 Apr 2023 09:39:41 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id je4-20020a170903264400b001a217a7a11csm6805062plb.131.2023.04.24.09.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:39:40 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] fixing some parse_commit() timestamp corner cases
References: <7728e059-d58d-cce7-c011-fbc16eb22fb9@cs.uni-saarland.de>
        <20230415085207.GA656008@coredump.intra.peff.net>
        <xmqqa5z6q1jl.fsf@gitster.g>
        <20230418041253.GD60552@coredump.intra.peff.net>
        <7bbcfbc0-f9da-09ef-9441-5e4b13780841@github.com>
        <1153e31d-2f89-c9dc-8551-adf4d3822487@cs.uni-saarland.de>
        <20230422134150.GA3516940@coredump.intra.peff.net>
Date:   Mon, 24 Apr 2023 09:39:40 -0700
In-Reply-To: <20230422134150.GA3516940@coredump.intra.peff.net> (Jeff King's
        message of "Sat, 22 Apr 2023 09:41:50 -0400")
Message-ID: <xmqqo7ndfd4j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Apr 21, 2023 at 04:51:03PM +0200, Thomas Bock wrote:
>
>> Even though the affected commit objects are malformed, it would be very
>> helpful if this problem could be solved somehow, from a user perspective.
>> Such malformed objects can potentially occur also in other comparably old
>> projects, where searching for commits that have been made in a specific time
>> window in the past could be useful or even necessary in some cases.
>
> Yeah, after sleeping on it for a bit, I think it is worth fixing. I also
> found another parsing bug in the same function. ;)

Nice.  Thanks.

>
> So here's the result.
>
>   [1/3]: t4212: avoid putting git on left-hand side of pipe
>   [2/3]: parse_commit(): parse timestamp from end of line
>   [3/3]: parse_commit(): handle broken whitespace-only timestamp
>
>  commit.c               | 29 +++++++++++++++++++++-------
>  t/t4212-log-corrupt.sh | 44 ++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 64 insertions(+), 9 deletions(-)
>
> -Peff
