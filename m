Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FABFC433EF
	for <git@archiver.kernel.org>; Thu,  5 May 2022 14:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377567AbiEEOQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 10:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380469AbiEEOQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 10:16:28 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5742E5A08B
        for <git@vger.kernel.org>; Thu,  5 May 2022 07:12:48 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x18so4510420plg.6
        for <git@vger.kernel.org>; Thu, 05 May 2022 07:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=519mHQKjHFeZPuy4y0rSgEjae/G9OM6D/iV1f8eAdeI=;
        b=DgbHoiksA83FuxIKgrJgH7xAOsB+QPxsCHVdhFMSya+RdZsgATYuYyMusXYEW6Ii6W
         EC/cnvFKOkTHn1Kr3DKqCfQ9Qk41yHhAsvyQOnAh0VTOLOtinAFpvvO7uFP/JM9IWb0p
         nCtLVduo0o8nbkoOfwa88xj+qp40uAehR/Lwtq7GHkYhKTCIC3HPeoThgajdDT30grsz
         j7YrLZd0vFLo8X2vRUPjOjFExRkUF6rTbaaN3O8zJM3bLx/VyqNMWHcanzoHMIDfWzr9
         TGFUBFuYr0XGkwRMm7T1FsV91SbHjFvPKsq862+wX7BaQUhdbkMIj7YYa8jQsD1nwE7R
         x7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=519mHQKjHFeZPuy4y0rSgEjae/G9OM6D/iV1f8eAdeI=;
        b=Y7WmiECMVSX1Lbgg+QuPzM/9CzUddkvDvtDjupGn8mADAHH5zspjJGchEW7rP0CgnS
         5pGcVzko0+k5gcCSFQvwo0/ovHMzoPbYPa8uaL53+4igGNPx8aaaXd5ZEkubO4bbohO1
         w4JFbpRjy+9Kf1odpjqF7JHpH9d97jPF17Az2izp6WZP/YGxTg8qYwrXBb7bAoGLFHOV
         V0q4BZFb9LsH0iLS9A6Ug0Ia1EvqAbWBvntr3uNywNUsKCxTx55vJu0qZ+GJgaofeRsF
         SiQPDlsgp17eHvOPP8XQ2l7Sxg6xJyWoxCGzmIQkO16fXBK2QO8qDjOlOQuKWFjvAAiu
         5ykA==
X-Gm-Message-State: AOAM533/6/BMRkRVZOk0WsEIfEv5zLObKmPPPjPp0QoPgJwj2nZx84Zv
        3avL8d22mjrpIRvPviwx8b8=
X-Google-Smtp-Source: ABdhPJwUuOcGzqb2nFzUjBOKM0o8NqhrvZ5rxqD6+exicYfuRSVGrhaFcYIJStC3TttDmIiusFTEEg==
X-Received: by 2002:a17:902:e5c8:b0:15e:c2e2:bff6 with SMTP id u8-20020a170902e5c800b0015ec2e2bff6mr10014206plf.74.1651759967683;
        Thu, 05 May 2022 07:12:47 -0700 (PDT)
Received: from localhost.localdomain ([2409:4061:49e:32a3:69b6:a111:7008:b042])
        by smtp.gmail.com with ESMTPSA id 4-20020a620604000000b0050dc76281d5sm1408737pfg.175.2022.05.05.07.12.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 May 2022 07:12:46 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>, Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2] builtin/remote.c: teach `-v` to list filters for promisor remotes
Date:   Thu,  5 May 2022 19:42:02 +0530
Message-Id: <20220505141202.65106-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <xmqqr159mdfh.fsf@gitster.g>
References: <xmqqr159mdfh.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> Broken indentation.  You can save embarrassment by double checking
> what you committed by sending e-mail to yourself (or checking output
> from "git show") before sending it to the list.

Thanks for the suggestions. Will keep it in mind next time.

> I doubt that these "grep" do what you think it is doing.  It would
> say "I am happy" on any line that has one of these characters listed
> inside the [].
>
> Do not clean up with an extra "&& clean up" step at the end of
> &&-cascade.  Instead use test_when_finished to make sure that after
> any failure in the cascade the clean-up step would still trigger.
>
>	test_expect_success 'title' '
>		test_when_finished "rm -fr pc2" &&
>		git clone ... &&
>		...
> 		grep "srv.bare (fetch) \[object:type=commit\]" out
> 	'
>
> or something.
>
> Having tests that show how this new feature works is of course
> necessary, but we must have negative tests that ensure that it does
> *not* trigger when it should not.  E.g. the new [filter-spec] should
> not be given for a remote if the user didn't ask for "-v", or the
> remote is not a promisor.

Got it. Will send the necessary changes by the day after tommorow.

Thanks :)
