Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC4EC77B71
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 20:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjDMUeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 16:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjDMUeF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 16:34:05 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862E24C3C
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 13:34:04 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j8so14782634pjy.4
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 13:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681418044; x=1684010044;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1vLQpC5nJlbwVnmQEYIAYp5lms1UeZ2zmABJhlK9Zc=;
        b=NvTYvXPfWQvpgppUJV9mGOeLxkR7Hvagq+uL/hfdAnn1mHMPQdH/3fzLjMBg8T+rcA
         xTCd/k8TTWcCuR60ykrLQ9SYX+MXM5ropC0c64ukwMRAKyiNqxV/CxmCVVZd3JUNHd70
         KpbXutRQv91dnwyPIlygfnKtjc/SGM0fHTq4E60Rx9vYMGP3qkLS/7sBsaMsx4pweuQy
         XzeSO+b6yjRU3FfeuDkdpq9Mt6t+kck12adnCrWRaaXkLq096SQmWFH3XZCNog0WwZKY
         fXp8nvRH19ObM0LASd3AVo4u0XeQit08xGWHNsyatujSTpKKWSXo1DPOzLg2QhK98+Jn
         +n9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681418044; x=1684010044;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1vLQpC5nJlbwVnmQEYIAYp5lms1UeZ2zmABJhlK9Zc=;
        b=JVhLl2qIJnZ1T2FI3gz/LI1mQ+Ze8L0ibqikaO7f2o3qKK3grpG3iFTulWj4845tlw
         frDET8P2E4qrSLruTkloDGn/BqjClW7VxvH6NEj3gkYfon7O6PT2ctMMobUeu7Htw+5P
         tg5HL/isGhsrpQnHmL/GTM5XP8u1rjxw6AhfaoGJFVLgtbcAIVUe7O7ugL8QgxigEW9W
         p1riKoPjT16+A+DikrCjwFOF6obMncy1h9aYMfjaXiwO8WNJqQWYL9LrGta7QQ4D0LNL
         XIxJWfHvxoaEYOn8w9lxOXudMuByUE0uJ1y8uEbhEcdQrJyXOxjkxwnIgucrfGaZLsCu
         R+iw==
X-Gm-Message-State: AAQBX9f+pIRa2+QyhnZ+Lbs+A8O2qRRJycF6244Na5VbL7AGGOw8uhUC
        6deQlmK7ClWUGO2dPT5uAP8=
X-Google-Smtp-Source: AKy350YgI+0vo2seVNzCrC9DBmX1N3jUCgUHppQnnmv2ZlTjxpQEx/xpnYcuj5sg7T2ak2gpt8qRxg==
X-Received: by 2002:a05:6a20:3950:b0:ec:674e:5551 with SMTP id r16-20020a056a20395000b000ec674e5551mr3832485pzg.26.1681418043958;
        Thu, 13 Apr 2023 13:34:03 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id 9-20020a630309000000b0051b460fd90fsm1785379pgd.8.2023.04.13.13.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 13:32:32 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Ilya Kamenshchikov <ikamenshchikov@gmail.com>, git@vger.kernel.org
Subject: Re: Git branch capitalisation bug?
References: <CAAp-DqK=CPxpH0ZhA=k8GRFvSz3odoOLhOgAqfYSBpz28JK+hg@mail.gmail.com>
        <20230413190302.drmmdrkv7vfps3qg@tb-raspi4>
Date:   Thu, 13 Apr 2023 13:31:13 -0700
In-Reply-To: <20230413190302.drmmdrkv7vfps3qg@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Thu, 13 Apr 2023 21:03:02
 +0200")
Message-ID: <xmqqfs93y166.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> I am not sure, where this Capitalizations comes from.
> I don't have an account on boschdevcloud.com to test.
> Is it possible to reproduce it with a public repo ?
> Otherwise, should we suspect boschdevcloud.com for it ?
>
> Any other thoughts from anybody ?

In the transcript I do not see any "git pull" done from the other
side, so the "origin/Feature/macos_tests" in the commit decoration
that can be seen in the last part of the transcript may have been
created locally.  Output from

 $ git ls-remote origin | grep macos_tests

might be a way to see which end of the connection has the issue.

