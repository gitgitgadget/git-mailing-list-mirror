Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAEFC77B76
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 22:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjDNWGT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 18:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjDNWGR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 18:06:17 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B183C3D
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 15:06:15 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pm7-20020a17090b3c4700b00246f00dace2so12335456pjb.2
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 15:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681509974; x=1684101974;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LM0rRicvLLqt6Aj1EdHn6K8Ic3R2K+dYTi8l5DTeswo=;
        b=GCN0inTMWcr6YKbW+b0pbPLNG9jDfJflVq+mVUUmUkxSImE8B5G3js1ZqTIbLpi+3B
         qD6FIMCFTFWw6FSyIgNC8fFPabFuPtJcG5fihmU0WHfnV+lXDiW0mJdTzv42x23i4Iie
         f6cf9+0Yy9xpsMXzYxBJCaaPy8uWFMs8+sms6KROSficD0IAPEtBWe9Rw1hvgJ7rZG9k
         8scl8kJrB5dBoO18Rj/Fhi1UiFmHFGdjlkuSyByIs0AbZLmrZbxsR39lUA9ScjLYY5Ka
         7aJLJw2vUF9D3H+pPynnZK6zYi00CSfNnsihBwwqhQCeUVCRbK7sZCkaVkXdCe0fX4Qw
         v+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681509974; x=1684101974;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LM0rRicvLLqt6Aj1EdHn6K8Ic3R2K+dYTi8l5DTeswo=;
        b=DxH8jYxaH/0JaQaPf7SS9HRksBaAQPKiP0/R7uxQZiVfTD0Pj9tekKVwyZ2W80FcFa
         tzGyzrb80lza4noVlWtvYvgFp2dhQOGavYenTC2kDdGPK+mIaon7GMd6V/oJlWPV14im
         zWHf4/tLXQ/uKFRVLq3eMEHVFzc1rFF5cBk4EMLVuoPcinpc0lk+6o2Pf52Z+c3Wk/3v
         3muI3r4EWSIkXMqwA/jqf0Qeu7q3CpUZ9XSk0UWNFB74BHADjLHWZsx+Wbu8AgShuoIa
         YO1IFifR61jGO2ZQ10DSQcFYHM2wMAPFbFhfogPFw7RCmkZWZ+fLxtwR4GWepDyVDk1w
         SGEg==
X-Gm-Message-State: AAQBX9cQSi8SJ5LgBcwB+txVVyfj/5YdItX3EmyBuStcMlPHRLSAyAhd
        ynRCWhKQD2GoKZtdP3A9yvI=
X-Google-Smtp-Source: AKy350YLwtimRAF/LYG3kVNfLZ7IcT2HZRAlpkwaAb1kDUKts6OMM/AVTYrAU533jp4DaWYPGUOIiA==
X-Received: by 2002:a05:6a20:914a:b0:e4:83b4:bb9d with SMTP id x10-20020a056a20914a00b000e483b4bb9dmr13023973pzc.29.1681509974473;
        Fri, 14 Apr 2023 15:06:14 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id 9-20020a630309000000b0051b460fd90fsm3280357pgd.8.2023.04.14.15.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 15:06:13 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: set actual revdate for manpages
References: <20230413074722.71260-1-felipe.contreras@gmail.com>
        <20230414070449.GA540206@coredump.intra.peff.net>
        <643949a57396c_5b7e62948d@chronos.notmuch>
        <xmqqildys97o.fsf@gitster.g>
        <20230414214508.GB640081@coredump.intra.peff.net>
Date:   Fri, 14 Apr 2023 15:06:13 -0700
In-Reply-To: <20230414214508.GB640081@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 14 Apr 2023 17:45:08 -0400")
Message-ID: <xmqqmt3ap19m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So doing it all in one patch, though this conversation may indicate that
> the commit message could do a better job of explaining the goal and
> implications.

I can read both formats, and if we are moving in the direction to be
consistent between AsciiDoc and asciidoctor, that is good.  As long
as the design decision is documented well in the proposed commit log
message, I would not complain ;-).

Thanks.
