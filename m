Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0B4E6FE31
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 22:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjIYWmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 18:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYWmC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 18:42:02 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B184B124
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 15:41:55 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59f82ad1e09so30921107b3.0
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 15:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1695681715; x=1696286515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ful7z9tEolLtL50aIme6VKPeug9+N/OJUG5sV24Guzw=;
        b=BHmptKx7xcNHdtW+AojrpBwkaVL3GcNp5f2UQ87/1BsKSE31CuHJDaV3UKSHLk4rwO
         rttGyDcDQF76p+WIM9+9ayuKNBXIJUbsP4VDSowf4O93PJckDJeyE3iGSV168aqK3LZw
         duUuzxl+33HPd31m2aqYJ1s4zCPmfTzOVF4Zo68IQVDm20yOyxZrYLgid7M4V0b8BRCD
         PcWoazFdB2xOAQJggCZoL2OUYWQxHNpfyRNQ8rex2Ecbz+WYfCYxPguPFLRVBINX93qW
         /Jf/AvOXtcjw5sR99Ii4VUoFJboesozPcs4u6JEb2ZdBfocDzWaIpN6rFh4SGaVN2IU6
         M+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695681715; x=1696286515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ful7z9tEolLtL50aIme6VKPeug9+N/OJUG5sV24Guzw=;
        b=qXTj5GrLRmhQld2oXx8gaAwCbSQ/QNWg9e0LLtVJ1ICWKbAHR7HlE+CdeR6oSHmkvy
         LqQMyU9pBlUW0xNttpWQPjUOQQO5bxonFdPxWb7iNsrQPbWskI8wbHVOL5S77EEoFx46
         HTwQsNTAT82owCRxyURcvH4THdQNPlzqs/bDhR52aj2m0hJEBIWvkXRsyws2UYlkMojc
         N+Wp9M4geFX+NJydFvadePrbStY3+u7enHVVSsYLHqeTak6xY8YMWoYCjel2z8HqXrEZ
         9GqlCyEJEX6nlFyFX51YKj2tLFvFsqS2y/EkokgQIH30Rlw5skeZ1nyTtzGHE/RLIqh/
         Dx8g==
X-Gm-Message-State: AOJu0YzhF8zG54l+XPOKNeJI2RIIJGq+yVFZjfbqIqKmd8R9A0bkWzbQ
        Y5N931wOkMJaGoi8fLoSgy6YEw==
X-Google-Smtp-Source: AGHT+IFbHP8FbnN69iFbt+/Wj3HZfdfxIgwmXBOvXpp9cWQgf14Dm0L2vVH3VYLuCB8S+xSjX/eJdA==
X-Received: by 2002:a81:4f96:0:b0:59b:eedc:43ce with SMTP id d144-20020a814f96000000b0059beedc43cemr8578231ywb.4.1695681714830;
        Mon, 25 Sep 2023 15:41:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i6-20020a0dc606000000b0058427045833sm2649425ywd.133.2023.09.25.15.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 15:41:54 -0700 (PDT)
Date:   Mon, 25 Sep 2023 18:41:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v7 0/9] Repack objects into separate packfiles based on a
 filter
Message-ID: <ZRIMsdiXLqRQSJRh@nand.local>
References: <20230911150618.129737-1-christian.couder@gmail.com>
 <20230925152517.803579-1-christian.couder@gmail.com>
 <xmqqy1gurrpj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy1gurrpj.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2023 at 12:14:00PM -0700, Junio C Hamano wrote:
> Thanks, both, for working well together.

Christian made it easy to do so! ;-)

> Will replace and merge to 'seen'.  Let's see others supporting the
> change to chime in, and get it merged to 'next' soonish.  I gave a
> quick cursory look and changes to rebuild on the "existing packs
> cleanup" topic all looked sensible.

Sounds good. I took a look over the range-diff and the changes were as
expected. Having reviewed earlier rounds of this series in depth, I'm
comfortable merging this down whenever you are.

Thanks,
Taylor
