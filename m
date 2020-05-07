Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D1BC38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 21:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19ACE20731
	for <git@archiver.kernel.org>; Thu,  7 May 2020 21:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKM+USDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgEGVXz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 17:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgEGVXy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 17:23:54 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9F4C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 14:23:54 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 7so4280727pjo.0
        for <git@vger.kernel.org>; Thu, 07 May 2020 14:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UZbq2+RkFWdUoXakjCKlEJhG3UAJRjqH9be9Tu+/itc=;
        b=CKM+USDW+w/9CU32hyD7wqIFEMRcRTK7K+xKlRy0brOi8SF5v1jJweEwIOOibF1U4Z
         8c458x3yFy/AlVpnuhd78NSveR1yHkebv47HcDeUTEGSuVAmCRWnr9N1kGwI7FyLuzq1
         0nmbUaw0fjBXIWES2QsvG1+DzLG3oRgeEEQesRee058DPx5gDqbOLQynRrSqfy3apSFb
         Ig6w7LbbREqVkJSYnAYAZbm/XB24ox4+A2aa0NVb2XhHuvXOhNKVFQtNvar0CiX168V9
         Vrc3MFEC0SRWQ7e4n0cb1RLTCrUsccWFG1YWrmVLtcFEqEAvMYwFdnvy/uW7ILGrbqUz
         Nycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UZbq2+RkFWdUoXakjCKlEJhG3UAJRjqH9be9Tu+/itc=;
        b=OlAj0OzmPpQBOcGYjM+RzJKqbWJVpAfVOPdG88hXWlDh3sHVtrJlqqO2XitQM4yDqG
         rbjoBG9R9OmEBcUzcdJv/koDdFXyQjYPpFd8XdQRYfDWiTMmfpHpXsA7T0XMXcdNj+hH
         M9HN3R+whDgEBuzShiOf8UMRlojNG/LNthod+gDtpABpy0NzCNDuhl/vk6UE1KO1P+C1
         RFlvvSHQSU8Ulw51zkrU1zNsgFZsg2jzclf26AL0O+IJ2fapJyiQt+YLTonGQhyWsnI4
         mGIe4EZnQn+93TXw1pirYfIQ2YF5GZB1Rv4SB2rmLpPMsM3Uq3O2/PELqeheX0j3ocdl
         0PZQ==
X-Gm-Message-State: AGi0PuYRYvgGA+Zu+yB4phsdHctQB7XX68hq42zWdCOaeb+mlGo+X5NC
        ixO/Ejk5Cos20qaLdH8TtzM=
X-Google-Smtp-Source: APiQypJHp2rz5mJ5AkS229Y6reZS3h0iKyttz9EyCThK4a1JvUm29MfX3s8rS1Jgg4fZj2PQ32mQeA==
X-Received: by 2002:a17:902:694b:: with SMTP id k11mr9574087plt.77.1588886633476;
        Thu, 07 May 2020 14:23:53 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id a12sm4558484pgv.14.2020.05.07.14.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:23:52 -0700 (PDT)
Date:   Thu, 7 May 2020 14:23:48 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 0/4] credential: documentation updates for maint
Message-ID: <20200507212348.GA19917@Carlos-MBP>
References: <20200503063423.83152-1-carenas@gmail.com>
 <20200505013908.4596-1-carenas@gmail.com>
 <20200506162712.GB1275237@coredump.intra.peff.net>
 <20200506232848.GB75901@Carlos-MBP>
 <20200507205909.GA38308@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200507205909.GA38308@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 07, 2020 at 04:59:09PM -0400, Jeff King wrote:
> On Wed, May 06, 2020 at 04:28:48PM -0700, Carlo Marcelo Arenas Belón wrote:
> 
> > Subject: [RFC PATCH 5/4] credential: document encoding assumptions for values
> > 
> > Because of the similarity on the names of the keys with what is defined
> > in RFC3986 is easy to assume the same rules would apply here.
> > 
> > Make sure that the format and encoding is well defined to avoid helper
> > developers assuming incorrectly.
> 
> I'm not sure this really clarifies anything, because it just says "no
> assumptions can be made". Which I guess is a statement, but I'm not sure
> what I'd do with it as a helper developer.

not sure what part of the added lines you are referring to but I am happy
to provide some examples of what I would expect to clarify below from
what I'd seen from some helpers that I'd read the code from recently.

as an example, I would expect the helper developer to start checking for
the locale and calling iconv in cases where it is not using utf-8, before
sending it to a storage that requires that (ex: osxkeychain), or utf-16
(maybe in windows).

osxkeychain will probably also check for protocol in a case insensitive
way to make sure it is not ignoring credentials that are not all lowercase
as it does now.

Carlo
