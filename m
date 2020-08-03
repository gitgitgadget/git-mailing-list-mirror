Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B25C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 22:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E6C42068F
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 22:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tEq6Frk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgHCWjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHCWjv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 18:39:51 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DED8C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 15:39:51 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s15so9451229pgc.8
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 15:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fg4/EwdhlzD8fvWE2pHGl6IxouJDjLYK7mR6azwgtjc=;
        b=tEq6Frk+HyWDutyKcmjToeRXmawCFmHm3QiVHVDmiyW1XbHxjyojIhLZ8CLHENAP3C
         LKUB1QjClm0xGhSHcmcf3guYSeOZop6BaEcrmwzXaq3MQJwBMpKqwRErx3CtRGfY03Yu
         jCkzRPmBqwMBy3yQELHFUZg26aDpKrL3NLQ4u7h9u/ROLopwNYUxhyAVe7pch09nj3il
         4sp6/3TQx9Ln4759oiawmsOoveqhUCtZ6VzPcB0F2wxXJIurT8i/7GrMByJX80K5PXQJ
         dBf9rcLKk4xCjnhP0WDW/bgYt2ZdC4V9TMXzUCXuteyy8ABv3Hf0hDoeVotYf5KWaCvb
         fGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fg4/EwdhlzD8fvWE2pHGl6IxouJDjLYK7mR6azwgtjc=;
        b=GSX1g3kwR6WMP+NjX0S1Pug1pydyyof2PW0WwSdDpawVeOilFD+mzzH4D+e5H7IkL+
         mr2CFPTHmSpodCQOzEuarFJUwGff1UQgxyBtru1TNWtGOroL42i97UvF3gn5rjOozoUv
         VL64UZhP5AYWkkUt+qWoaWPQkwIRyFXcaXuEgNGoJNXUfMuhngLPBuvqZSuoMwvvp+HI
         C7VqpaaYk+qHHQrsBN1CmWqAbNYXmMyNoEzZSWZpQeGL8scVXsmKRp8ntQXwy7Odot8/
         LhclbWL+2MU0QZG1od3fFAgEba/s091wUCfBzan4RZO88WINROc/79zYVNH4B1yxwuQR
         eM0Q==
X-Gm-Message-State: AOAM533sRqQccgm3MAxrXbKYS34vnus/0s+6zeBjyQiIdLolz9S1tulI
        re/6zZUoIltIQptAtuXmT7Fyjw==
X-Google-Smtp-Source: ABdhPJwiadGv+6UhFqzX4ZVOf/UBqyuX9zTWnuYAEs0drQAG675/fv4eycS+tFI67pd/pYWSbyl52A==
X-Received: by 2002:a62:77d2:: with SMTP id s201mr17396027pfc.213.1596494390578;
        Mon, 03 Aug 2020 15:39:50 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id w82sm20221736pff.7.2020.08.03.15.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 15:39:50 -0700 (PDT)
Date:   Mon, 3 Aug 2020 15:39:45 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] Revert "contrib: subtree: adjust test to change in
 fmt-merge-msg"
Message-ID: <20200803223945.GF2965447@google.com>
References: <20200803185749.1441344-1-emilyshaffer@google.com>
 <xmqqlfivv7ky.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlfivv7ky.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 03, 2020 at 12:43:25PM -0700, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> I wonder if it makes more sense to move this (or other tests in
> contrib/ if any) in the normal test suite so that we'd notice its
> breakage, though.

I'd welcome that change. We have some scripted step during our release
process to run those specially, and it'd be nice not to have to.

 - Emily
