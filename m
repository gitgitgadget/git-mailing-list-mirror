Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BADC43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 21:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5D42077B
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 21:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5eQ1DdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfLDVkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 16:40:21 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:39475 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbfLDVkU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 16:40:20 -0500
Received: by mail-pf1-f170.google.com with SMTP id 2so482178pfx.6
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 13:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ke/HObvDzOVmL9zMPqNzf9sBe3wrVphs58yHJg2vSkE=;
        b=A5eQ1DdCRCBw4ymCEx5huovLVaRw1TYt9O8ZqX+mmEB0SqTYrLiadHujn8fDtHT6kq
         arwI/uy75NvREkDPqlXnxP1lr9HPme1ohOAQGR3iZ2SdTSdO2cbHC/I3U7rbGxac18Py
         BL3v+7zVmWpRit3wT9RpK62my+8gJmGfYnYiKjSHNr971Lrb00Q0vZ1IXEmjn9yhq15Q
         ltKlG+Q7L2/IVaBfxbYIH1/eR8FXIj0zYeHK6SOR2mAV+vZJYXRsMShwc6meFf6rRmEE
         0Ap5JDNZAb19gRkFhqmmbbRKRtxTe9Feh050g5KcmN00+AIUEHaplMJ16ExalAXppyJV
         onHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ke/HObvDzOVmL9zMPqNzf9sBe3wrVphs58yHJg2vSkE=;
        b=MDyedy9oQpYmQDR8q+eJjIsee+0Ea3cC18u480yvUMdZYLh+RtrglVmC8lFT+9TOVD
         DDoWXjvgfkobWZQ5Co68xL1+GhCf+keeePVxJ3Jqx9kXg6DNa8XmjVKyeG3KoPmWHByD
         qqYBk68wx9Q3xzRv25Ov0IlUaOOgscVPyx0bAQ5WnBoN3pftDaU05uKhalA8bXXsAPLw
         8alG8hUtsF32p2urvSKikXAlLFFOSrQlrMX59Dp5H5/cMccQAfnDvX+MTAkybKafRiVz
         lhjw6qUVnaW/HHDbdrRImT1QL7Wwkq9XWIbNtu4HVu6eQ2KUAkjD9Hq+8LLutyTNs0sA
         tAQA==
X-Gm-Message-State: APjAAAWohYcYgmCOIrO3GbuufSQTJGR1Hboyws9XcNaqiQXR1T1hTNPV
        Skq969sEmMn51cqTPj7oPXr+Ls3D
X-Google-Smtp-Source: APXvYqwmamU/JKOiUSp4ALzC99nF/QylOP9rB76AcRC7+V7pd6RFb89eKGqlbUHTW4ApzhkdlVdENw==
X-Received: by 2002:a63:101:: with SMTP id 1mr5632063pgb.336.1575495619941;
        Wed, 04 Dec 2019 13:40:19 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id q6sm8880950pfh.127.2019.12.04.13.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 13:40:19 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:40:17 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Christoph Berg <myon@debian.org>
Cc:     git@vger.kernel.org
Subject: Re: git clone git clone some://url
Message-ID: <20191204214017.GA195537@google.com>
References: <20191119141537.GD18924@msg.df7cb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119141537.GD18924@msg.df7cb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Christoph Berg wrote:

> On some git hosting sites [*], if you copy the repository URL, you'll
> actually get "git clone some://url" in the cut buffer. When you then
> proceed to do "git clone <paste>" in the next terminal window, the
> command executed is actually this:
>
> $ git clone git clone some://url
> fatal: Too many arguments.

I feel your pain.  Is there an issue tracker post or support ticket
open for some of these hosting sites to make it do the intuitive thing
(just copy the URL) instead?

Thanks,
Jonathan

> [*] hello sourceforge! example:
>     https://sourceforge.net/p/wsjt/wsjtx/ci/master/tree/
