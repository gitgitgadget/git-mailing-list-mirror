Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC20BC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 02:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFCEB611AF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 02:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbhIICvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 22:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbhIICvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 22:51:09 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FCCC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 19:50:00 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id v16so428410ilo.10
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 19:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Pkpk1jncG2PFhWHhgztteDz/AMgPCUoQQN6XSAfohmA=;
        b=05F2tyyEJPOogGMyPSmGpq+5e3tj6+Ul1hC1WgH/+Qd8ODM9iIsZJ+bGDnB1x83PNx
         otsMUrT/wR8E4xQEpi8RuUWY317eABcQnP5l3s67yMvhnWpsRv0+RFuAdgB2YFCk6P85
         954h5uxSPBveNiU6OqWmSqUPx6Riep9vglKv4RE8aytgHT39id0sOmPR4pSle7Q8wlF4
         nUUofjMTqYtalItqxQDIpHo2IzVjeI/AyongA2Dv3qqreYy5lO6X8AaJsOl0xrYxkB6R
         GKoyKvYSnRh9VaM+zbtvHwVZkSQwZG2J8xsUs+11HL1OJpXuEDw8ZRqoMuWiD9aP6qR5
         ZzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Pkpk1jncG2PFhWHhgztteDz/AMgPCUoQQN6XSAfohmA=;
        b=fAqwcNNjllBUxBjtOmgIhF1fGi9vvp8KR5v//1Nm0q9ea8QLmMDHOqDUmNJAyneopt
         i/ZlggdPvYpllQOCWU2cCuS4dGQjk/Hhv2sNhuuiX0qapC7bvwYpvdYwKnQXLnw6TUtP
         JCR1NnMLhxjpFKE5624vG7ldQBle0Wz//aFHwffV5NjxvrrrIXrCNGVU8TGmrwbX74EE
         BEneWL8zNJSIEcJ7UCF02iyC6waelTkJSks4mlac2b06/71aUVAS4xEasEiwAPMaXrKe
         CdU61ZKGyzYY1REmtj+qAnr0JSKJjxgi0LdKHHlOEw1rHOQEIHY68OMj44vzjWz1fjE6
         echw==
X-Gm-Message-State: AOAM533Vvj1U/4Ofdnbx0AZj0ktgvHo1dYLG1jf/MQYB9r2vEH85cHWd
        xBZ6F/UNijvpuyKH55snBBC/IQ==
X-Google-Smtp-Source: ABdhPJwa+CwS8ryEq7FLzStmuXCd4TWY/wkYtaIaFBwArb+RRetK6jdYLBRh0Wjb02LWvm24gL8SIA==
X-Received: by 2002:a05:6e02:1aa5:: with SMTP id l5mr536615ilv.271.1631155799903;
        Wed, 08 Sep 2021 19:49:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z18sm261666ilo.60.2021.09.08.19.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 19:49:59 -0700 (PDT)
Date:   Wed, 8 Sep 2021 22:49:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        gitster@pobox.com
Subject: Re: [PATCH v2 0/3] prevent opening packs too early
Message-ID: <YTl2Vn6eB2MyXehM@nand.local>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631139433.git.me@ttaylorr.com>
 <877dfqhb8n.fsf@evledraar.gmail.com>
 <8735qeh8h5.fsf@evledraar.gmail.com>
 <YTlfp/tRmNy0kt+b@nand.local>
 <87y286fs3v.fsf@evledraar.gmail.com>
 <87pmtifp2e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pmtifp2e.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 09, 2021 at 04:36:17AM +0200, Ævar Arnfjörð Bjarmason wrote:
> Also: That avar-tb/idx-rename-race-3 has a bug where I didn't update the
> bulk-checkin.c code accordingly, missed it because I was running a glob
> of tests that included "*pack*,*rev*", but missed "*large*". I've got a
> avar-tb/idx-rename-race-4 which fixes it. Sorry about that.
>
> https://github.com/git/git/compare/master...avar:avar-tb/idx-rename-race-4

Yep, I noticed the same thing while running make test on the series
before sending it out. Your fix matches mine (which is to move the
change from 7/8 to 2/8).

While I was fixing the second patch, I inserted a new one just before it
to store the hash in a `unsigned char hash[GIT_MAX_RAWSZ]` instead of a
`struct object_id`.

Thanks,
Taylor
