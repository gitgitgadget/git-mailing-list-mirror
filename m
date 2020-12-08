Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D562EC4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E40422288
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgLHWMq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729925AbgLHWMq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:12:46 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCD2C0613D6
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 14:12:00 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id q22so15256330pfk.12
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 14:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=z8VLLDbQToPMfqAYu8nwC+7t47CcrHrmIMcaLCo4hP0=;
        b=gJCQ42r+I27/rL4EM5XebPkpdANMvJu2owCSxQeqnImNG7F9KkGXDDvv/Ee8EcLs8j
         V6xy9SdecbOMamE1Yh9MdAQSB38XuOTbYSeDQKbDknHsKByHpoci40l1+nVYpJN93ZcK
         PQHTGLfHwtfxxDqDEOzq4oBZXSLuxg0dc1rjw9tkC9LDNMXbCKcRwEsEK6MhI8YxBUik
         zZtUgWp+8l+ibFynqi8Wfj6ZvDvmJNMp+ZCxvvu7H18IpT6j3sOmi8KyDO+jQ7Y2IIzC
         QdPMmdsD2EMOd76HoW9a964EeA2Wb+Tn0+zIXUGWeKisZVHErw9c8F4I789PRP478/J8
         VqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=z8VLLDbQToPMfqAYu8nwC+7t47CcrHrmIMcaLCo4hP0=;
        b=AOamDRn+XLYllHARGPz9olzDDLlgj5jXlGYw5Am/Sl8VPFWd/IoHqBBRwV8taEVwRs
         o7NyZb/JSczK8TbpW9usRwpaRFA5c/W0cV4W3SAjz9dq+/umH4Hmna9acr4YxRKr4SOK
         EUF0Ofv1EFrcGviy6PPsHzFjUYxAQSHTua2m0KpXqS71LiZzxtduVxFXm9CvZkCrBxnc
         oVUXgYZPqfMR6erhsBxpAYA6hvVCGLxngzpGGmfq6znRAzzZDOHv2Bf+RAszLBiq6krL
         Cc8oT64l+UbAw8Z2bbrxGcGSoDrxrmonXVSVnXkmbdTv1k8u4HlmgAeM4Uzxn3BNrIxh
         TKdw==
X-Gm-Message-State: AOAM5313sZZZUeGpiTw/iWs6rZ4vbWZp9BHaIZS+bWal2W400YWfxuUh
        C2+rFqcEILDr5omPdKvAg0Onqg==
X-Google-Smtp-Source: ABdhPJwmChhCE8UDSUDelmoqOBST3zhe7cjVrBsevkB9J00HUtBP5hFb3WW3L5wXo1rHr/glSIgmdA==
X-Received: by 2002:a63:1047:: with SMTP id 7mr151909pgq.3.1607465520021;
        Tue, 08 Dec 2020 14:12:00 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id c24sm2007607pgi.71.2020.12.08.14.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:11:59 -0800 (PST)
Date:   Tue, 8 Dec 2020 14:11:55 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 15/17] hook: provide stdin by string_list or callback
Message-ID: <20201208221155.GC3783238@google.com>
References: <20201205014607.1464119-1-emilyshaffer@google.com>
 <20201205014607.1464119-16-emilyshaffer@google.com>
 <20201208210925.GI8396@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201208210925.GI8396@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 08, 2020 at 10:09:25PM +0100, SZEDER Gábor wrote:
> 
> On Fri, Dec 04, 2020 at 05:46:05PM -0800, Emily Shaffer wrote:
> > diff --git a/hook.c b/hook.c
> > index f0c052d847..fbb49f241d 100644
> > --- a/hook.c
> > +++ b/hook.c
> > @@ -9,6 +9,8 @@ void free_hook(struct hook *ptr)
> >  {
> >  	if (ptr) {
> >  		strbuf_release(&ptr->command);
> > +		if (ptr->feed_pipe_cb_data)
> 
> Coccinelle suggests to drop this condition, because free() can handle
> a NULL pointer just fine.

Done (locally). Thanks (and thanks for checking the coccinelle output
too).

> 
> > +			free(ptr->feed_pipe_cb_data);
> >  		free(ptr);
> >  	}
> >  }
