Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5963C433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 01:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 741F222248
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 01:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/LQ+Aat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbgJIBzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 21:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730755AbgJIBzI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 21:55:08 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5157C0613D2
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 18:55:08 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b26so5523328pff.3
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 18:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uwi0gQ5TU3luA2jQU9LlSYaGiK0PMCSGsGvGJ7lTkfA=;
        b=c/LQ+AatB/004lHiugTj8hQ366R6jeUMloAMTy40OX0gLmshlJHA4/3qTAG1SF853f
         II2pSTND4JS/G7Wi2X09eRyV9aLyMABM+listj2FCBWvVajFsfTT3XHNH/GctqfGPBXA
         hZovJrT5FXslxVdjW1bWdEvwZx6lkpHyWXHdgHjHPVaiHbEjwzNSwhjQ1rFDXTWNouh0
         JHIaDsxXHizs2ZoRQGI+xAo6naaUNZkiABvT7X0gJbHVqv35Hpo5u31Xdab7RMM4ZzO6
         u3E1S5rikXTMFv+VVf21Fl76qMfx0f8ric4i7gvw1Dj7pqvsWucm9gCKMXZDfq5MKAal
         /kVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uwi0gQ5TU3luA2jQU9LlSYaGiK0PMCSGsGvGJ7lTkfA=;
        b=F2U1sHXDFSz1FrNXomr3MMYv+xkuX4cQE+9yGu3/YcUQWPAjGK+OiD5dgRQFfr0/xA
         j4x6MtrwJie4Vk5FWROHVDPiDN0L6g+XJ0JsDlVTUPA4IQ5bR6NBpI8l5yYestMGextK
         ePYWX+OxqqtvcUOcmaSZInj3b/VBnJ6Zr3+774z5XylDUaGowdv5WjbyUxPm1fQD8AHS
         Pe2g3DR6QIJY3C1QrdHV/V87tUJDnbTVuoWAzBAPmG1sDBj0jpyIEQgUwOV0z+NdhJAb
         PeqdzyGcg7rnifRSR6gyptzNhTH0u88RMKlGwPNESDqarCLfHXJtElsRTpkzvUtWmGiE
         swbQ==
X-Gm-Message-State: AOAM533/FHTGHbD9BOrwzGzZV3NDvIntaS5NouiRhtyGlvRMLxRjPu+X
        UkLPzZuPSJ2HpGykp9okkOA=
X-Google-Smtp-Source: ABdhPJwrXwtF9/8lxXMHD7pEdgrJaz037jyUt/NXdTzty+fPbQmKXhQR9S3D46vbRk7nxiYCW46/DQ==
X-Received: by 2002:a17:90a:ad98:: with SMTP id s24mr1868462pjq.199.1602208507947;
        Thu, 08 Oct 2020 18:55:07 -0700 (PDT)
Received: from generichostname (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id b185sm8841911pgc.68.2020.10.08.18.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 18:55:07 -0700 (PDT)
Date:   Thu, 8 Oct 2020 18:55:05 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clean up extern decl of functions
Message-ID: <20201009015505.GB1314@generichostname>
References: <xmqq8scgzqis.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8scgzqis.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Oct 08, 2020 at 08:27:55AM -0700, Junio C Hamano wrote:
> Among external function declarations, somehow only these two
> functions that return pointer-to-function were declared with
> "extern" in front.
> 
> Ideally, we should standardise to _have_ explicit "extern" in front
> for all function (and data) decls, but let's make things uniform
> first.  Bulk re-addition of extern can be done without any extra
> difficulty with or without this change.

Why are we re-introducing an explicit "extern"? Since function decls are
extern by default, what do we gain by doing this?

You mentioned in the past[0]

	I think there is a push to drop the "extern " from decls of
	functions in *.h header files.

so are we reversing that push now?

> Signed-off-by: Junio C Hamano <gitster@pobox.com>

The code part looks good to me. Good catch.

Thanks,
Denton

[0]: https://public-inbox.org/git/xmqqef67zz7u.fsf@gitster-ct.c.googlers.com/
