Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEA7C05027
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 19:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjBCTHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 14:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjBCTH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 14:07:28 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F111BAD4
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 11:07:26 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id n13so6201422plf.11
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 11:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pr7SpDAPZBMoFVC7i2p0r5dXQvjGr0pBZAkru43GBjw=;
        b=qWZSZRHYmzJ/FpPSoVIUUBfWi0FLbHaZp5L/f/uleHNQW7hZ6wZ2GTA0FgdaXEb27o
         iTPiyEwAbqStoSmB9KkmtzuLdNBWp5TGjyXwPsPCcWsfnfytx01P9TCEf0emR0JCNXQ4
         iTL5TPdHSMV25eDzxzbIh2DPr/XLetdXX+WRCGHZ4oBzhWll1CiV4x3ZRuwAoBuwYAsp
         m6+fbITnd8kZ6EXBUIBTi1BO3N6NcGkEQLWQ+v2hHcdn299ki2nGBogpZDQIvCxWd2MF
         WiDxBKdakLMAqh9po+0+sULGpeP9Pnf31/kOUXDUswjMaaDdJc4hTlgo/Zao7Pa2G+ZM
         pJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pr7SpDAPZBMoFVC7i2p0r5dXQvjGr0pBZAkru43GBjw=;
        b=OfmA5BlOs9bUGLFKeka+6A/haLpcxdpXq5a2FhQkCo9/LNR2rWdOYd03kUskt7K/9h
         rd+8N0gBsI8BtU4hXX0fVoR+7fyu7xzntcQjJ81Y1/FIk0jGAm4WXytmLwdM6Ro70dGZ
         URQubweKa5IDbOrj7826GfzOrpBkiw48HqKnIacWA+WkhTWrcnNVoQaBOlW9WsrpAsbO
         KcD4pcQ/V7h3D78VJxo2hcJwWF08tKr7GVUJ1vBduTWV1jBbOJAiyyWQ0YIzmtrz9nB4
         5smiJ8qYqzO6F6w3aEB1MeklsoDKpHC01fLyPdOway11YP4XfKO2HtI4j4H6tYP2t2ke
         BpVw==
X-Gm-Message-State: AO0yUKWEjewGPNjWglRyBuJbAko+QeMoNd/Cg3MFUZx2PYF4TnWDsJKT
        pgFjliJYvMGIoVRplIf594/Yq+1ZwhI=
X-Google-Smtp-Source: AK7set/8QpCDorTVEVjJD5+NzJweAPlMc4O7Rbosk1HL7u1dZvO6Joks2Af3vdX8ldT8KKGw+W9YJQ==
X-Received: by 2002:a17:902:c406:b0:196:2ab7:c44 with SMTP id k6-20020a170902c40600b001962ab70c44mr14642034plk.14.1675451246073;
        Fri, 03 Feb 2023 11:07:26 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id jb10-20020a170903258a00b00194afb5a405sm1940073plb.118.2023.02.03.11.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 11:07:25 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Subject: Re: [GSoC][PATCH] merge: use reverse_commit_list() for list reversal
References: <CABPp-BHE=zGT_vPW8+TZn-wqmufhVdGQT-=LXoLQkto6TMrnrA@mail.gmail.com>
        <20230203174910.123441-1-five231003@gmail.com>
        <CABPp-BHnXy+Hpv4y83znMxDGOTCZQfYhnDon=ehBDGOxAnW1vQ@mail.gmail.com>
Date:   Fri, 03 Feb 2023 11:07:25 -0800
In-Reply-To: <CABPp-BHnXy+Hpv4y83znMxDGOTCZQfYhnDon=ehBDGOxAnW1vQ@mail.gmail.com>
        (Elijah Newren's message of "Fri, 3 Feb 2023 10:02:36 -0800")
Message-ID: <xmqqmt5uo9ea.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Also, gitgitgadget #1156 was opened because of my suggestion to do
> this as a "leftoverbit", i.e. I was suggesting it as a micro-project
> to new people.  I should have checked at the time that it was a valid
> micro-project, but neglected to do so.  You merely came along and
> started implementing what was suggested.
>
> Anyway, the point of the GSoC microprojects are to make sure you are
> familiar with how to format and submit patches to the mailing list and
> respond; having the code you contribute in a microproject be accepted
> is not required, just a bonus.  And you clearly managed to send the
> patch to the list, had a correctly formatted commit message (short
> summary with area and correct lack of capitalization, good
> descriptions, signed-off-by), got the additional notes for reviewers
> (very helpful!) in the correct spot, etc., so I still see this as a
> successful microproject for you.  I apologize for not doing my due
> diligence when I suggested it, and for us not catching that it should
> have been closed when someone implemented the valid half of the
> suggestion last year.

One possible action item for us may be to rename or give comment to
highlight the in-place destructive nature of the function to make it
easier for developers to use (or avoid misusing) it.
