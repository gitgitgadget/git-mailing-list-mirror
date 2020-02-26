Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919EEC4BA21
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 21:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632AD24679
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 21:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nCApCtdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgBZVsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:48:17 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:40516 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbgBZVsR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 16:48:17 -0500
Received: by mail-pj1-f74.google.com with SMTP id ev1so287855pjb.5
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 13:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xfLmSRt3DD3zN2OgPwRevR0oTV0yPOHxfSS4dNTixL0=;
        b=nCApCtdmTwuH6rGO7AJVN/FXBWpjimk36NExbiSd/1JMFtibJsozjfJ1ZUqYuW0VFi
         PRQVKYSo4R7zM+jY5g/6bK4TCGkuCRIVoqgCo+QqBT7wYq8KO0s4bzN5wotChHXt8PlT
         XN3eJLuBFtQ3HXm9IZrCD3JRBs7xnvsrIuyBfPjavLi7YpWryGjkJQCUujIV9dwoAeMr
         IUW+YuotBlB+SR5gCpvp9y6z7yYvyceocLigVdthooonR+8j15ItPptBGoy0BA7VA/vs
         cFkR6GRXpsEfh4MMmzMQJmlKOGQidepr03T7J6Bc9RandOL8QULzrVOJdvl3R0RQC4tl
         PPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xfLmSRt3DD3zN2OgPwRevR0oTV0yPOHxfSS4dNTixL0=;
        b=OCO21dcLtdFwFf7Xk338x41j7Yz280mvs2UhyWcFIEGWZ0gUWwqG+ZC8g/IJsJTR+o
         5yZQgKjCHy/vMZxHYshuS9vrblS5vvzXU8ESQVcuNi4Jm14KY2W98LX724hz3y9t7rmH
         LyIIsfYK+N2Hp9V9id042D8eWBorLRe5x7FOqOpVDqvZ8+XTIDrQP5JS+ztxsSyuNJrc
         nQ5pQhN5LUNJpD41FltYWqE7M1PfYPzxXrld/oanXVRkbzSv5ycoxATusTRxCglidlKq
         uHFVwbuCEZUoGhhgXD2zPzqWpvDaGFl/l7JMopYhtS4kA+thR/+PtPpnnUevqQv97bec
         6cHQ==
X-Gm-Message-State: APjAAAXv611JyfYbhmzfacSHIx2RJq9WM0MYYUHjbQiysPTjPTIyOz81
        /whfQmnTD4b8TRCecW6gxBP3R8CLlCP9prSSpwbD
X-Google-Smtp-Source: APXvYqwyeiafZAUkx1+LWvHicdo5Drl88NAG2upboR4xk3KRWAb/exkkHUPcxfif3Zjx+AT7DU91kABw9S30dAJ7+ofP
X-Received: by 2002:a63:e04a:: with SMTP id n10mr792825pgj.341.1582753696065;
 Wed, 26 Feb 2020 13:48:16 -0800 (PST)
Date:   Wed, 26 Feb 2020 13:48:11 -0800
In-Reply-To: <xmqq8skqkq35.fsf@gitster-ct.c.googlers.com>
Message-Id: <20200226214811.227720-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq8skqkq35.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: Re: [PATCH v5 2/3] advice: revamp advise API
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     heba.waly@gmail.com, gitgitgadget@gmail.com, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Heba Waly <heba.waly@gmail.com> writes:
> 
> > I'm not against this approach as well, but as I mentioned above, we
> > need a list of keys to be returned by list_config_advices(), that's
> > why defining the constant strings will not be sufficient in our case.
> 
> Sorry, but I do not get it.  
> 
> Either you use enum or a bunch of variables of type const char [],
> "list all of them" would need an array whose elements are all of
> them, so
> 
>         const char ADVICE_FOO[] = "advice.foo";
>         const char ADVICE_BAR[] = "advice.bar";
>         ...
> 
>         static const char *all_advice_type[] = {
>                 ADVICE_FOO, ADVICE_BAR, ...
>         };
> 
> 	void for_each_advice_type(int (*fn)(const char *name))
> 	{
> 		int i;
> 		for (i = 0; i < ARRAY_SIZE(all_advice_type); i++)
> 			fn(all_advice_type[i]);
> 	}
> 
> would be sufficient, and I do not think it takes any more effort to
> create and manage than using an array indexed with the enum, no?

With the enum:

(.h)
enum advice_type {
	ADVICE_FOO,
	ADVICE_BAR
};

(.c)
static const char *advice_config_keys[] = {
	[ADVICE_FOO] = "advice.foo",
	[ADVICE_BAR] = "advice.bar"
};
/* No need for all_advice_type because we can loop over advice_config_keys */

With the bunch of variables of type const char []:

(.h)
extern const char ADVICE_FOO[];
extern const char ADVICE_BAR[];

(.c)
const char ADVICE_FOO[] = "advice.foo";
const char ADVICE_BAR[] = "advice.bar";
static const char *all_advice_type[] = {
	ADVICE_FOO,
	ADVICE_BAR
};

Junio, is this what you meant? It seems to me that there is an extra array to
be managed in the latter case. Admittedly, this is a tradeoff against needing
to convert the enum to a string when checking config, as you describe [1].

[1] https://lore.kernel.org/git/xmqq7e09hydx.fsf@gitster-ct.c.googlers.com/
