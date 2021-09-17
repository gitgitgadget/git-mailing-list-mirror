Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8DDC433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 02:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59B2961108
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 02:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243029AbhIQCjH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 22:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243205AbhIQCis (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 22:38:48 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB04FC0613AD
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 19:35:18 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id a15so10367808iot.2
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 19:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iJ2Hjcy4Bt0b+e3ATMw3Oh7lKTMrAx1ZmQKkxB06bUQ=;
        b=bcu2JqKoB768cd3xQ572yjvRroL4Qf9qy9Hvl5EcGM0Wa7Bne/PS1aeNR3VG4NfHak
         A0bgzxiTxJMrvdf/vZzd/XP7fZnBlRXJ9n+NB+Fvlu2OLg+bMvZUeGOyvqWr8OuaJshk
         ZmHhkr/zylGawutIEK8W2OyNItQ+WZMBEZ9fVgub3ZXarNmUEjfGfMlMaOQ2cZ5FSiF4
         Uep2KY7EpL41TNmQCFHfWEQSRntxIXlsQ5oJ8bYrTB2R5ypdan2rJbBoIvrpsRp093+N
         7cPMqLAjcHhmQWrg/rF7xFNJofNZBVX5YloOdDa/TJikT6fbnglO1dqrZy5dig2nXo43
         bQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iJ2Hjcy4Bt0b+e3ATMw3Oh7lKTMrAx1ZmQKkxB06bUQ=;
        b=5gvyL2bDDsE4WuEhL1nc3Whpx5Q+ZGQ0GOdxcPh5vB8SG1XustJAqovbT/oQO8ztMz
         ELvdYw699bu/as25M3eZhrxlXgIFQE1I037iiDCgNH8efC2DNUcrU9lqq5ccdLjMlMZO
         J/21yrpM6eHWG92aPv6Fl2bb7kDbhKvW4JxPTV7NAp7K+z4NueBv28aMfhy8/rnT8HSw
         ZUucYcMOykYr64x59oX6Ac3jIoirC2ErCai3iCiQIwSn8aJd0HNJ9n6QF4GntdiQWf+C
         8i7OzcQL2PFaydSrEjBeZdZFrmU2gdHJLlawEvLP+A6mXXuvVXNtoKWjPKUmFyjuRMMN
         GE2w==
X-Gm-Message-State: AOAM530BW9TNybWgJ194TOi3/TmDYPIXmVY6PVBSOfu7AtMK0MhOkIRH
        e5QkpouoNxCMV8sd0vfZg6kf5w==
X-Google-Smtp-Source: ABdhPJzy238xz+t+oOpUKd6GC+23XYnI6N1QF4xQp1Kwky51Vy+I0FD+pt8UHmCQH2QWWXWPRW17Ww==
X-Received: by 2002:a5d:9355:: with SMTP id i21mr6957033ioo.12.1631846118218;
        Thu, 16 Sep 2021 19:35:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p11sm2801171ilh.38.2021.09.16.19.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 19:35:18 -0700 (PDT)
Date:   Thu, 16 Sep 2021 22:35:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v6 15/22] object-file.c: guard against future bugs in
 loose_object_info()
Message-ID: <YUP+5W9rAWwNQ23t@nand.local>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
 <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
 <patch-v6-15.22-3fb660ff944-20210907T104559Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v6-15.22-3fb660ff944-20210907T104559Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 12:58:10PM +0200, Ævar Arnfjörð Bjarmason wrote:
> An earlier version of the preceding commit had a subtle bug where our
> "type_scratch" (later assigned to "oi->typep") would be uninitialized
> and used in the "!allow_unknown" case, at which point it would contain
> a nonsensical value if we'd failed to call parse_loose_header().
>
> The preceding commit introduced "parsed_header" variable to check for
> this case, but I think we can do better, let's carry a "oi_header"
> variable initially set to NULL, and only set it to "oi" once we're
> past parse_loose_header().

Everything in this patch seems OK to me.

For what it's worth, I think that this could likely have been folded
into the previous commit. I was just a little surprised to see
parsed_header go away after I had just a minute or two again spent time
thinking about what it was for.

Thanks,
Taylor
