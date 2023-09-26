Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E28CE7E64E
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 16:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbjIZQjy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 12:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbjIZQjx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 12:39:53 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F597199
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 09:39:47 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c47309a8ccso75768875ad.1
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 09:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695746387; x=1696351187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JfZN6J5VCknNT+Q9zcGLlxsWDxVudiXzN2mRrKLLWfE=;
        b=Tdm+hH4AFglL2REInp6OG9Oc2EcqA58GGoKS95IyyiQKsctp7DR7LWXCKVN+IcHDPN
         Qr/KmyoH/3atxtu1cBOaQYy6Ixi7HET5X7pKxZYzmtbKSXhRhotr3rjH37FmX/at8WWS
         HDFyvRQO5DkB0Fu9rGI/GPPChUtT2ZsNkxDSLqFwAxYz5O7zDmJEOufjRuWaqWC6NC6y
         OfE+s/N3EWobPggtR1lfEYo3tBC4sfYPf7TKryrReNWFXTZ19GX+fo4E2sdkPf2CQ1Gd
         MxesX2i89QLf2zyve5H9v9RITniw2HLQkxmhVhgpsCojCd4YtxU4S6xzzWMI6wg7xqAz
         nkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695746387; x=1696351187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfZN6J5VCknNT+Q9zcGLlxsWDxVudiXzN2mRrKLLWfE=;
        b=lMUs+MDpITR6mMl5WmlnQkB8MYM+upG7OFi7T0jFofocJypybopX2+CXYbSS46B66x
         uDnEubapkKp6pzCyTa74rKQl2ITZMQJQXZnqaCjeDd323k53GqgbEUQ4J2fEeZM1W3Y/
         /uJVs4g1jkGWXCbesFPxuHd7acyyZ0tuOvEkX49by26v1Nspy2Wn9jGWD8/ZynM4CVWE
         B0/HxbVWF4C5Cn6BR5Uw5VxEMdBYdt0ik7ip/NwAaDZh6pXOI/ijy1YMu2PyRB2HPdoE
         ZWLHgh1z4b2DKfSil5gA+3+y1DgXOAQko7n+8U/vksLd0RhymNYt+AM95mb1RUW8JVbZ
         LJbw==
X-Gm-Message-State: AOJu0YzyMgbLR29wF6Ko8a8SOmxCEPrlIhvxOLnXRqlD92zqjCOBaFSL
        Q2Wq8sdppK9SCmlc42aU1A0=
X-Google-Smtp-Source: AGHT+IHQw/i5LQo6sUIFdJOXl0P1jg+NLcEyH50JSjlooP3H00KeMbl9XVEcVcuZTYbkc/jPl7Wfyg==
X-Received: by 2002:a17:90a:a514:b0:277:7810:ac74 with SMTP id a20-20020a17090aa51400b002777810ac74mr4927121pjq.10.1695746386580;
        Tue, 26 Sep 2023 09:39:46 -0700 (PDT)
Received: from five231003 ([49.37.158.138])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a031900b00274bbfc34c8sm13023881pje.16.2023.09.26.09.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 09:39:46 -0700 (PDT)
Date:   Tue, 26 Sep 2023 22:09:33 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Shuqi Liang <cheskaqiqi@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Subject: Re: Projects for the next Outreachy round
Message-ID: <ZRMJRVl16gBEElGZ@five231003>
References: <CAP8UFD1bsez-eMis5yH7Esds+LkhMnj0qTUMFPL1tRuDv2fiPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD1bsez-eMis5yH7Esds+LkhMnj0qTUMFPL1tRuDv2fiPw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Sep 26, 2023 at 04:48:12PM +0200, Christian Couder wrote:
> By the way, congrats to Shuqi and
> Kousik for successfully completing their projects!

Thanks.

> So Shuqi and Kousik, please tell us if you would like to continue
> working on your projects or if it's Ok if we propose them for
> Outreachy.

I would like to continue working on the project and hopefully complete
the duplication of the remaining pretty formats into ref-fitler.
