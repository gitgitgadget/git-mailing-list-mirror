Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE3FC19F20
	for <git@archiver.kernel.org>; Tue,  2 May 2023 21:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjEBVmE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 17:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEBVmD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 17:42:03 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A37D1724
        for <git@vger.kernel.org>; Tue,  2 May 2023 14:42:02 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b87d23729so3137939b3a.0
        for <git@vger.kernel.org>; Tue, 02 May 2023 14:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683063722; x=1685655722;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izPIH5ZZD3W+BSxmMm4NqoHD3//zkbyJ6tE008AnJK4=;
        b=UnsiwuhvssYImiUk905ewQRq5BKK3yMoqcgTvAurAQCt8CEx/lYYIr0/xcn8mDpc+X
         +4XkpXtHDyPA77eEDFdtB05PGtJzZz0MDke5d2YR6LI2Ec7kMqcYoefroMF98CchesU9
         IZh10F6aeN1H+OZ2rC4cLvGm3wB2JWDjvLgTD+QE6VVDOJR9FGwKwp7+JoxUQTS5O7HQ
         hVynpZMYqvBkdCjF0VWef0de2XvoW3Jj1r+SWFjdTynoqkawrwPGNvUZDO5ipzan1O20
         3+7OK1MnZOIIzDpl1qC6sPlCpfFItuGSfKxO7Hw/5ftRRInbm2vSaQmFJ+fi2rNL++jE
         jUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683063722; x=1685655722;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=izPIH5ZZD3W+BSxmMm4NqoHD3//zkbyJ6tE008AnJK4=;
        b=d0p1ibiKU+21axXTZW505oFk8941romxbYQctkSiFencpYWx/cmv7uEPMbunvfXVF7
         XXVEuvnnSu5aMQ1NIHemDGdGGVgB/YKAUGMSIjhAH8iEi9U4hzWnRvX/cEnKFynzV5UN
         EGE7j1CyqawmWRdgEHeBVxZlGruse3ux7GcR99rsT2+pvboPGRNwqRaLczhOlwBVGIjf
         dfKQN8HFHlbwG11GideScEarP9EmqxCuxccEz8SODpPzgTbJs72PoWyiiKBSEq/DNPSR
         78v+UgTmnXbwGRigxQSuWwv3J+fvN1IFlk7+WgyZ3a3dsqr4DTAcyKXvFm99bKv5faON
         JyGw==
X-Gm-Message-State: AC+VfDxVr5EBajJBfJc07RwNjP8Wl9GExWtu+M2z2W27KOJesxJqRFmA
        2jM4C3h9Mhbt083O0Mup+h0=
X-Google-Smtp-Source: ACHHUZ4xFWbXmHwEFNK8pkz0jHFbZhcKJUPFP2w0kguG98ftSu69Vs8upkgy8/FYApddUmF7BHax2w==
X-Received: by 2002:a05:6a00:1791:b0:63a:ece0:48d0 with SMTP id s17-20020a056a00179100b0063aece048d0mr26062250pfg.28.1683063722067;
        Tue, 02 May 2023 14:42:02 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id fc9-20020a056a002e0900b0062e63cdfcb6sm23000819pfb.94.2023.05.02.14.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 14:42:01 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com
Subject: Re: [PATCH 1/6] abspath: move related functions to abspath
References: <20230502211454.1673000-1-calvinwan@google.com>
        <20230502211454.1673000-2-calvinwan@google.com>
Date:   Tue, 02 May 2023 14:42:01 -0700
In-Reply-To: <20230502211454.1673000-2-calvinwan@google.com> (Calvin Wan's
        message of "Tue, 2 May 2023 21:14:49 +0000")
Message-ID: <xmqq7ctqz9zq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Move abspath-related functions from strbuf.[ch] to abspath.[ch] since
> they do not belong in a low-level library.

Given a relative path and turning it into absolute is still
low-level enough, but that apparently is not what you meant.

It would be nice to define what you mean by "low-level" here, and
update the comments at the beginning of <strbuf.h> with that
definition.

I think what you are trying to do is to move anything that does more
than straight string manipulation out of "strbuf.c"; roughly, things
that have system dependencies that are more than malloc/realloc.

For this particular step, I think it is a natural thing to move a
function that computes an absolute version of a given path to
abspath.[ch] that already exists.  The same goes for its realpath
counterpart.
