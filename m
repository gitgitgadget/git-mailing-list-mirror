Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5167AC4363D
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 00:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BBB3206F0
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 00:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmxAMpS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgJGAPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 20:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgJGAPz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 20:15:55 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075ADC061755
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 17:15:55 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 144so307326pfb.4
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 17:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hmlRhbdbFO+LthcMtyrC7zNiuTYN3e5jxvMFxBbcEKM=;
        b=RmxAMpS3sjPW84eoRB2hFQkN6+oUKbHCVHfSrA8so5FIaYFEEAbqWfVWEhYWa5OfWW
         ROyYXM5CzdXQeiKJCEBIgHpdPtg7vuAUyexmpyaZxyHe2etjDjErRotnUOKvjOVw/P60
         Cf/JCc2rpOipv4CaUBBkRpL/+eraM5U+xolB/Op/YKdvvSeYqKC0nGClfgEr5n8akiun
         fXM80Z6TBTRFjUb2+gfV63oYe7rTojg8V3G7fulL1LB9NHFDAf60Et7KfUAryGKjot+X
         ClXw3CkgnAHiBrJb+Lr8uv8IO942MIDOmVdH6tVbQRBQDVf/lPpyi4GDiVU5MdQldbSZ
         3+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hmlRhbdbFO+LthcMtyrC7zNiuTYN3e5jxvMFxBbcEKM=;
        b=mwC1eobDwVTrbe6NhiFaA06ucTZwCqIZ5jWaPpZa2M22NQeXBVQZ23sVUJSzhWA6Es
         bagtJKIC1OFP+EHFofWB4EUbY/UnMMHitJBXkV/i1pywbIN0hqSDvtNItmoHY2ku6ieR
         IOsF3L40MR+zyIqGEV/BjQfsNKT3xW5FgQofbj42QZes8J0k6lo6zyAHjK6yAvsCAGK9
         ECDiw/iu5Td8bWcEQWYDczSzfDSI+agyQnhS/BKjQZ6VeCBSJDG+L8prdxbKvdBsnbmH
         clveWxmKL9BknHyG7iwiwy8V/oO0zA8N5NcF4mEt16pPvfQK8rePNrKRGFGa2zD7sf4J
         WeYA==
X-Gm-Message-State: AOAM531E97Ob/5OPQLMf30Raj3TJKmcQefcAFS5CWXaZxzWp69qddPPu
        mCXbmwB76A8ArJ3W/+006O0=
X-Google-Smtp-Source: ABdhPJyhDzLZHXBHbCNQvBub4QM3GVdewv+5+TUJMNnS5UNy6tAR24kdJcyI3ehlTcYXGx3oh4zwAw==
X-Received: by 2002:a63:fd08:: with SMTP id d8mr639249pgh.223.1602029754587;
        Tue, 06 Oct 2020 17:15:54 -0700 (PDT)
Received: from localhost ([2402:800:63a8:e735:e424:e5d:450a:d98e])
        by smtp.gmail.com with ESMTPSA id x66sm349372pgb.48.2020.10.06.17.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 17:15:53 -0700 (PDT)
Date:   Wed, 7 Oct 2020 07:15:51 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t5534: split stdout and stderr redirection
Message-ID: <20201007001551.GA10178@danh.dev>
References: <20201006150818.15698-1-congdanhqx@gmail.com>
 <xmqqft6r5fwb.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqft6r5fwb.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-10-06 12:11:00-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> 
> >  Arguably, I would say it's OK to change the:
> >  	
> >  	test_i18ngrep ! "gpg failed to sign"
> >
> >  to:
> >
> >  	! grep "gpg failed to sign"
> >
> >  since the latter will be correct even if GIT_TEST_GETTEXT_POISON=true
> 
> Is it because we haven't managed to translate this particular
> message, or is it because we should never ever translate it perhaps
> because the message is meant for machine consumption?

We translated that message.

> If the latter, yes, I agree with the reasoning,
> but I do not see a reason why this message should never be translated.

I was wrong, I thought test_i18ngrep will blindly "return 0", it does
call grep on "test_i18ngrep !"

Please ignore my non-sense in the foot-note.
I guess the main part is still good, though.

Thanks,

-- 
Danh
