Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE4AC433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 03:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A133B20EDD
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 03:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JO/2jM3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgIID2s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 23:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgIID2l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 23:28:41 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFFEC061573
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 20:28:41 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m5so1024544pgj.9
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 20:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9cgVwRhCm9Sw/AlQ9/iL4hs/rJ+PWzSjc2zcLrffHA4=;
        b=JO/2jM3OQeR6L7Z8oBWQ5c0XW86GoroPYFitzgJfphBQXZm1pfhHieHSuFczVkpEyD
         0cN2kiK9E5m0xycmivBpXTVQRqxHo2JME25KAOhnahBAChljcaW9CHweQkg5vIHtd32q
         LYp9OmQhxMvtrKy7citY3bJdDqvLzw1/1DLQ7yaTu/01AodSsrjPYqeRN5DNxldX7eMM
         9eHJ6w27//M5pTxvRHHtdqy9eeT+lrnh/TixJrDXcYsN9+x2qmUVrC33b5j92Kf263+c
         ALIycX+iOQaxbnYWhu3c4OKsXKYrlP5cPYWqRA4h7eOh/zE9fFnelzvFH63LH8cSLbGA
         vcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9cgVwRhCm9Sw/AlQ9/iL4hs/rJ+PWzSjc2zcLrffHA4=;
        b=blnD8HX5MBpI96ZxCdh5ojWzwQL4NjvZ7SM6xZEtiwhF8VLI7w7oXzlbmoDC7CTOqz
         vhHJbZao0DeaqY6Oja2qaTTVaRgGA0osVSvooDAFIokc7iSiWe7whvJ3AWnrf8ad+NGO
         hdSSKyK8sGvBcCnV92q4RrYZdzqA7yfGa3VqbPtWWzETEhxy+57kJ6Z3xNX4it+T30tM
         P0p/rssD4xmQkEG17J820WyTIaxL9EW2cwwxJwV9JjjlhLGr8xUas+hAd+zGzo3gSpdo
         4vJByiZPmD1lvtDufO/lJT6mJ7OR+W1gB/PRdjcJVo4IpMKmPPQxzlvuKn8IvMgrzyXR
         v45w==
X-Gm-Message-State: AOAM530aQacOtu5WqvmWq34QJ8e+sCe9pzv9x8AT2UcJl+IGrdyqsBZS
        +W9YO30EYKm8XT7k4IbCdZ8aBAmlvtPrxw==
X-Google-Smtp-Source: ABdhPJxv4THU5nctH5Z/vFTD3iAV4VuMYCBIQ8u7LUmzSgwfY8LHxUfQwCTsXzTHszFnrBlXQWnAkQ==
X-Received: by 2002:a63:c66:: with SMTP id 38mr1356175pgm.379.1599622120823;
        Tue, 08 Sep 2020 20:28:40 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id w203sm793472pfc.97.2020.09.08.20.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 20:28:40 -0700 (PDT)
Date:   Tue, 8 Sep 2020 20:28:38 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Daniel Villeneuve <dvilleneuve.4142@gmail.com>, git@vger.kernel.org
Subject: Re: permissions of main folder for git-manpages.tar.gz
Message-ID: <20200909032838.GA59978@Carlos-MBP>
References: <cc8487b0-c23f-46c3-b8c3-e3188b7c0d0e@gmail.com>
 <xmqq7dt3x134.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq7dt3x134.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 08, 2020 at 05:09:35PM -0700, Junio C Hamano wrote:
> 
> I'm contemplating to apply something like the following patch to the
> build procedure so that I can externally control the mode bits
> recorded in the tarball by setting TAR_C_EXTRA_OPTS to options that
> overrides mode bits and stuff (it takes GNU tar unfortunately, but
> I suspect I am the only person that runs dist-doc target anyway)

also useful (albeit not for the same reason) with BSD tar for adding
things like "--check-links", either way don't forget the signed-off
while adding:

  Tested-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>

Carlo
