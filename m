Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC76ECAAD5
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 16:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiILQ4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 12:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiILQ4i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 12:56:38 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9D02A437
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 09:56:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q3so8652259pjg.3
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=ZvV+5zWDfXa+ske3+e+TR28t/2pwOmUrIry60ZV49UA=;
        b=hkJuDVBWW81D4GsQe7ua8jPYmwypzo4OrqR8IyzKlBcBHtc+LrbN7xuBcMRDvPIAH9
         w5u16fTA1e1OnhF7rJv3hKtIe9+ryHMQGHS3AZ7Gpuo+BAVqMRNY0NwQJFeB0tHHt4ZR
         JdbQc8aA8T31u6KEpwAmKM15Pxn5Xf26FWHsMQuBw5Ehh4Q3StAnpXLl2hpsXW1ojHPm
         uTEccTAxJoWgXUpf6h2CsPg9Bye6G/i1DYG0deB4a9e/0vJr9Rwq9BeVODhpdxFhCEIJ
         4TMnui2BcYs6ey+sh5p0b5pmScpQNS3kQYmJcqGZqQ4sNjwd8UdcJo+KAjLejspCzd+p
         akdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=ZvV+5zWDfXa+ske3+e+TR28t/2pwOmUrIry60ZV49UA=;
        b=pxCfpEtLbtTomxhfINm1us+8tO0BRHbxKLqDntb9O/MukMb92nxH834+pedq+pAGkn
         6hvkmXx5DKugWLc4jgFb9F03/EacsCiQV7OZspohIwCko6ZsNf+pEPO2eciXTIGUlRc1
         uKMLXfGHpb93U+JY4MZ/z73WV4iCAtvuJNa6Y+5Y4ATwddiBD+x0ra/1ILf895zgfL3L
         fL/HDkrqztRwZLcpKOsw9UtzNZ5yicrvX8YuQaII7rOWbSmulsE1ytJOSqERjDMpoWYI
         bb4ZzpYOauyL1AhPZxJM9glMA77e01DTreDi2Q6hLYkjWJ697/Fo+QHUuHC/z+OD//Pm
         wC6g==
X-Gm-Message-State: ACgBeo1wy24oeg/czup7jj5wzEJOVjEq5wU4y/TvUI2ztOuSsYWzP6tG
        j3no2vXtQv0emobhg/ee0DA=
X-Google-Smtp-Source: AA6agR7WxHsBEkY9ggr7HV3v3PgNqbnj1pgeHCEFCe3vAk2Y+trPkSeuv2ffrK/Dqa5M4s7R20DbjA==
X-Received: by 2002:a17:90a:318f:b0:1fa:a374:f565 with SMTP id j15-20020a17090a318f00b001faa374f565mr24718989pjb.146.1663001796887;
        Mon, 12 Sep 2022 09:56:36 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p3-20020a654903000000b004215af667cdsm5939632pgs.41.2022.09.12.09.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 09:56:36 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/4] list-objects-filter: handle null default filter spec
References: <Yx1qwlpNbxGEiUgc@coredump.intra.peff.net>
        <Yx1rfYtQAlZGfAak@coredump.intra.peff.net>
Date:   Mon, 12 Sep 2022 09:56:35 -0700
In-Reply-To: <Yx1rfYtQAlZGfAak@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 11 Sep 2022 01:00:45 -0400")
Message-ID: <xmqqo7vkfs58.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But it's probably worth avoiding this confused state. It's an accident
> waiting to happen, and it will be a problem if we replace the lazy
> initialization from 7e2619d8ff (list_objects_filter_options: plug leak
> of filter_spec strings, 2022-09-08) with a real initialization function.

True.  Thanks for a careful analysis.
