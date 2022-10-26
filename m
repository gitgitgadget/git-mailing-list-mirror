Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD0AC433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 06:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiJZGqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 02:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbiJZGqK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 02:46:10 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1957F8322B
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 23:46:09 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id e4so10462459pfl.2
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 23:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JF+i5jF3JV2lK6LpEHw6Y42leqgPzxCgmR/CPCy/5/0=;
        b=hmnh1fTdjVwUZB0YWSjO2sUF+i2XM2Hj+PdEuyh21j/T7tTPs++g2i24LQ90as17+/
         6Hair2sKHH/vTYxP/6JGo9fHJOKLiJvykCR6corbk+2An5hg9KiahDUdpfQaNjphxNrn
         dWd70dMjyAjKALdf+ltCY1/JPIP3cWg9EyQwQP7obSuiEE/cjYen7daLcmMjRjIh9bLM
         CQN5pX/5mCdx2u/5Hs4iLnWeAGBjTZFD/XSAuDRCjKj2R9x1RkrbJZGmKXdB/gBJYSL/
         IrJjR9ZHCJW990RCiapQSeRkAJuy4+UMGUdlOx8GUqp4ghslGIp5KrQXt/s6PCiXuVKl
         fDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JF+i5jF3JV2lK6LpEHw6Y42leqgPzxCgmR/CPCy/5/0=;
        b=gv61mBiUp6yuFV2k2aOE/5qzTTfnSHXl/fryF/V4Vtc6NsoChPnV4Pt/MA4Oud98NY
         2bW4X1umNpaLlFWakHFg8jh8CYkbeoBf/rykBFG3DLBlKuWKKFpjd72y2DebTAU0befc
         ZhzTNcXpEObLyYeb1fPGRgj+X4h88XfHKlRLTVhGt3Ye1oYFS56pNladbItZrwkVDERI
         69oviOlbzRntbDr7HKNj2S/IMGyR028kEDK9WCVzAhcBv5/AEjqyVmSwhUa/4daPPF6x
         axqxahNlzRhbNNrEMJbr72HY5Tx47kZiStnbKNSv9YCjjmwYyUk0eHQPTAT0DrQny/4C
         JQTQ==
X-Gm-Message-State: ACrzQf0efV5U2GwKzwCFl1xYXqAc/dmte3DQ18qSnxTNgYDb97aq43a6
        8pZcyRH9jwOqXdDTpW+fllpN1d3CMn8=
X-Google-Smtp-Source: AMsMyM5NfV+OtOF0tAplCYeB5E1/myhvwn1sDgGn4ST0Gj+KoDWaJNh/Cxa2wL4yjgN506IyMacRbQ==
X-Received: by 2002:a05:6a00:1ac8:b0:56c:361c:8698 with SMTP id f8-20020a056a001ac800b0056c361c8698mr5105140pfv.76.1666766768368;
        Tue, 25 Oct 2022 23:46:08 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id cp2-20020a170902e78200b00186dcc37e17sm606899plb.210.2022.10.25.23.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 23:46:07 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 4/4] Documentation: add lint-fsck-msgids
References: <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
        <20221025224224.2352979-1-gitster@pobox.com>
        <20221025224224.2352979-5-gitster@pobox.com>
        <221026.867d0ncncu.gmgdl@evledraar.gmail.com>
        <Y1jG8p1aARb9+CV+@coredump.intra.peff.net>
Date:   Tue, 25 Oct 2022 23:46:07 -0700
Message-ID: <xmqqk04nkrps.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Another alternative is to generate the doc from the code, rather than
> the other way around.

Yup, that indeed was what I envisioned in the "Possible future
directions" comment in the cover letter.  It might not even be bad
to do

    #define FOREACH_FSCK_MSG_ID(FUNC) \
	/* fatal errors */ \
	FUNC(NUL_IN_HEADER, FATAL, N_("NUL byte exists in the object header.")) \
	FUNC(UNTERMINATED_HEADER, FATAL, N_("Missing end-of-line in the object header.")) \
	/* errors */ \
	FUNC(BAD_DATE, ERROR, N_("Invalid date format in an author/committer line.")) \
	...

as some of the users of the macro may have use of the translatable
messages themselves.
