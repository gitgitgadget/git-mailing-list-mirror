Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33794C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 01:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiLTBPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 20:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiLTBPV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 20:15:21 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEA217581
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 17:14:43 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso10600967pjh.1
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 17:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZyd6cNHHTLXhqSGlsy1eHm0XmU0YAMxvwrc70eLE90=;
        b=Pr5wnC2ezE+SL1R7l5Ehsednu1zuGTeSognzlzOgGsW0g/IcKs7vZayqLbfBXvSDoA
         xSX22eobZEwZkbpAzj3gvS25qHbFa/GqAUKnURYn7F8Yw9b491Kjz8+zdUQ7uNSUbQOO
         JFH5Dz3PACIeLNwVi6NjPaigQOf4s4OebfgMyvxjoeMREJgybQMUh/4DsQ3QyNrG4UCh
         9wFbE0pEqp0n1qISpbTQ0NW4W7GGHWtO8fDzf8H3Nts6weX3aBg4+phOanzw4JhLx/G0
         P0/W4CA81POFB3Lysj3jOphOTOfFJDi8rAgrU707mML2bvg0XOh42vsNFm29gk2dEnBD
         38Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dZyd6cNHHTLXhqSGlsy1eHm0XmU0YAMxvwrc70eLE90=;
        b=lJ7CJx/jE7DNU03KjPncmRIfzrv2BM4bhd5prlGweRBo9nelJ3EjSCSEI93QTd2RzN
         EC3DMpJh9TH9/taDMrTEYlASzlyKlWKWo3btMFvMOmLYKReIt+ht76f7yf9oD+uBZrJA
         uY2vVLP4SApbeaWgJ/TW494xjVisFfKZohfijrZllcXb8n48D230KVQMWyXWfnx4CvHD
         0ovq76bS5kSzZHrpHF8PtarrHp3WwTaRB+lFiq3RCaJ6cD5ofR1vjcfD9BsPqmJywz8G
         6QoqvCPl2SicajwbRFHOxVpDz7HSeKSc7n9MPZlwPz3TZfVwe7E6e3+cKSm/Zrjo23vv
         hGBQ==
X-Gm-Message-State: ANoB5pnAAxwf4baiqFysPML6aPqZKUGKeG8br0XWTcbkm1q9WEwF5HZG
        cXUF8RjXc/r/xbp1gHblS8M=
X-Google-Smtp-Source: AA0mqf4ZyUqB6s10UGwZ3q6YaApI4HXM5Qe1pr8mS9RrRkgr7K7wS3FdZk/Iyycul1khjSi3JyKGyA==
X-Received: by 2002:a17:903:3294:b0:189:69cf:9e9e with SMTP id jh20-20020a170903329400b0018969cf9e9emr42138578plb.41.1671498883176;
        Mon, 19 Dec 2022 17:14:43 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902db0900b00189fd83eb95sm7897307plx.69.2022.12.19.17.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 17:14:42 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/6] remove USE_THE_INDEX_COMPATIBILITY_MACROS
References: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com>
        <11545cde-9ce2-acf4-7c08-1b49d2dbefa2@dunelm.org.uk>
        <221219.86cz8fzara.gmgdl@evledraar.gmail.com>
        <a6efeaa9-0995-1d1e-a557-e320fbfe5d2b@dunelm.org.uk>
Date:   Tue, 20 Dec 2022 10:14:42 +0900
In-Reply-To: <a6efeaa9-0995-1d1e-a557-e320fbfe5d2b@dunelm.org.uk> (Phillip
        Wood's message of "Mon, 19 Dec 2022 20:42:07 +0000")
Message-ID: <xmqqili6zxj1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> That's correct, although even if that were the case that wouldn't
>> be an issue with this migration, as we'd have been using
>> "the_index" before, just indirectly through a macro.
>
> Indeed, I'm just not convinced that it is worth removing the macro in
> library code without changing to take a struct istate (I don't see the
> existence of the macro itself as a problem as I think it is just a
> symptom of the real problem) but I seem to be in the minority on that
> point.

True.

Many subcommands need to deal only with the_index and no other
index, so for the implementations of the top-level subcommands that
work only in a single repository, the macros are not by themselves
problems.  The deeper parts of the system that we want to reuse by
libifying of course eventually need to learn to take an arbitrary
"istate" and NO_THE_INDEX_COMPATIBILITY_MACROS mechanism (and its
successor USE_THE_INDEX_COMPATIBILITY_MACROS, probably) was a great
approach for that goal.
