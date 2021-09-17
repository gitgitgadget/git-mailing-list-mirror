Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DC7C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 22:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66A9060F6B
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 22:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhIQWyC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 18:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbhIQWxu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 18:53:50 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37300C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 15:52:28 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id b14so10210149qtb.0
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 15:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+C/dzEjJuQnggIisW/xcj+qZ6HdLgs45Ut++V+AlVOE=;
        b=KspB5F+pK5jTPl5Soa7dtnXwzoWstKz4CkMaBZmm/l4wYc3qP7XXSsVC/jtSpx6+1Y
         NIZaOeOTL6+8YbV0D7K7yyjR3U+QwNjjB3aVtWZvY5A3x5VsnT0FJZnf3VdeeXCsufZQ
         ghYu24/hxZSw2QWjb7Ckdt1SzM9q9YBLUQdsC7RjqHvePyoT3IsgvVsdVp4YixS2/LZC
         9G4FRctY4Pl9GmiAICoTyy3lmg9LufE8w6VocNZGl58Naluyc+Q+N4bzA/i11RA+SmJz
         DUYopim+evPr5b60O1REjKgPXhPB8uX8y1ExW2kYgIH3tH/5NqRG1KNVS2l8HbVHFn4F
         wAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+C/dzEjJuQnggIisW/xcj+qZ6HdLgs45Ut++V+AlVOE=;
        b=lYdpZ+cTsZgQNzbmrfmzYNmB5vmtRiyKe/8IyudJ9KWcHVzF9z6B++mmZt41PmlVT5
         xkfD8lDsZAlQeDbm5xoHEWET9GEXsgQPxZxGAWWHcgNuQQ3Vdn8xpKqIosQ4mBnMezzw
         0u8iuAXZMtM00rsJ8CqQl5OoMKlS0dCkrNm6W6wefO667FbsG7pZ7ycrmt5NTxkzzoWL
         Um2SORqXd/fkGeZ15FcJmWuiRw0pGgXGmD/hd+QKoCqG0hhJH56PaBz0X8R04LWu35Cn
         i9w28dk1vuR0dD1Mfpu5f/nP3mQJjF4gDojCGC9KLzGl6REaSvvBxI+iIeCRuAfrRhrI
         PMNg==
X-Gm-Message-State: AOAM530oTPEXMJHto9Fq8UDtEbmImN2xg+elQOCkQFqysvTZtmSp+yMV
        /8sDyAg3wV/1WJOnE4LHFxY=
X-Google-Smtp-Source: ABdhPJyVluDn9ZBAvk94Dhqhq44Di5/oD72ZuKov8vcRjU1zQDPhh7ipfIXlBpGb9YqsEgEVq1FZAQ==
X-Received: by 2002:a05:622a:14d2:: with SMTP id u18mr10568325qtx.205.1631919147270;
        Fri, 17 Sep 2021 15:52:27 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id m21sm1865111qka.69.2021.09.17.15.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 15:52:26 -0700 (PDT)
Date:   Fri, 17 Sep 2021 15:52:23 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dev+git@drbeat.li
Subject: Re: [PATCH] unicode: update the width tables to Unicode 14
Message-ID: <YUUcJ2+S1V2iI4Xs@carlos-mbp.lan>
References: <20210917191920.55944-1-carenas@gmail.com>
 <xmqqee9ngda5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqee9ngda5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 17, 2021 at 01:25:38PM -0700, Junio C Hamano wrote:
> Carlo Marcelo Arenas Belón  <carenas@gmail.com> writes:
> 
> > Released[0] after a long beta period and including several additional
> > zero/double width characters.
> >
> > [0] https://home.unicode.org/announcing-the-unicode-standard-version-14-0/
> > ---
> 
> Thanks---missing sign-off is deliberate and waiting for something
> else to happen?

Apologies, I corrected it locally and then sent the wrong patch :(

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
