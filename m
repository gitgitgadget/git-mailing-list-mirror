Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15030C433DF
	for <git@archiver.kernel.org>; Sat, 16 May 2020 11:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D105820671
	for <git@archiver.kernel.org>; Sat, 16 May 2020 11:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C055KYkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgEPLGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 07:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726170AbgEPLGI (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 07:06:08 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DC4C061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 04:06:08 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id r187so2424609qkf.6
        for <git@vger.kernel.org>; Sat, 16 May 2020 04:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=msOcnydX/7BX5qBjUjUjEqDgNndrFS/D9VtiKIcRuq8=;
        b=C055KYkWQqcPApFeUHgQgwAuVQIplJT14+ImxK6+5l9a40gaJYO3hxQJkcpXWL8Cld
         pCHWci5cmD+YzFf+u6WdNpjSUoWb0VSzKSQeCqItSCsIgHRdFlFFml6l5zIL4gsYZOMK
         KMhiWg9yacVS69h+toOGLP1TL2NdkfUHvS9UU86AlXxD2MXxBBujWjjNx/HGQdBxq2Gm
         nkfOe5zZor9j1X+BdcWOAjP+NRj/4Z8RV8Diel7jbMXswOvvCg36XYgU4+N7gzOM6uFN
         RFSQT0bIFpiLfJT72rozCBpRd+scwkU83m5N7NjKJNpST2gbQTfogFWFd6hTFl2vHH8A
         eS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=msOcnydX/7BX5qBjUjUjEqDgNndrFS/D9VtiKIcRuq8=;
        b=h3k9+0ifQqCxAKSn4MxY2dxTnO6TqNnIWpRI8aOzq+I8SjE/+FnRJD24SU2eAiasNi
         twPq/NoLhj6pLkcWM7nuDkAksI+Ma72hjRZADrR+O4fvhrcbC8uzWxoPZyhoSMh7eQK6
         a50+AHAVUdX/MdXqhM1a6vE9ekLMdriiJWMlOz6dEMh5TsheVgLTv/iML2r9CnnoUKRr
         TcIFhJYdw7X/P5JPLVpfh3hoj1T0EBj/1oWS8lb/RcAjKCysr5jNiquwnGnHO8igHAKJ
         vMLYnH+rXmzsen/BBCNYxV5ro2Bc6k6VWMluzNZAJrN6rsl3iZ/wuKmdl7Tiw/yGjH9m
         dkyA==
X-Gm-Message-State: AOAM531J6GuTKk0kevPUd6Y+IbJWRmxNY8M8P+NW7oD7lzhzZJRMacCU
        byVi5Kc0BMKhbi0AmlW13OM=
X-Google-Smtp-Source: ABdhPJwsmi5mZmZDkPqGuIwmkKpK2iblx3V93QB16jznAs+rAqMhoVWwMK8IwVOIb180SZrvPqth8Q==
X-Received: by 2002:a37:8287:: with SMTP id e129mr3303453qkd.204.1589627167349;
        Sat, 16 May 2020 04:06:07 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id i20sm993927qtv.90.2020.05.16.04.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 04:06:06 -0700 (PDT)
Date:   Sat, 16 May 2020 07:06:04 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, gitster@pobox.com
Subject: Re: [PATCH 2/2] submodule: Add 'quiet' option in subcommand
 'set-branch'
Message-ID: <20200516110604.GB22601@generichostname>
References: <20200513201737.55778-1-shouryashukla.oo@gmail.com>
 <20200513201737.55778-2-shouryashukla.oo@gmail.com>
 <20200514101534.GB28018@generichostname>
 <20200516055016.GB3296@konoha>
 <20200516085642.GA16726@generichostname>
 <20200516104015.GB25211@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516104015.GB25211@konoha>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 16, 2020 at 04:10:15PM +0530, Shourya Shukla wrote:
> On 16/05 04:56, Denton Liu wrote:
> > I would argue that it's unnecessary to print anything. If a user
> > provides an invalid option, then an error message will be printed. If no
> > error is provided, then a user would assume that the command succeeded.
> > Take, for example, `git submodule set-url` which behaves similarly. It's
> > silent on success. Printing on success would just be noise.
> 
> Okay, I have dropped the commit. When exactly is printing on success not
> deemed as noise?

There's not really a hard rule on this. As a rule of thumb, though, if
it's between a success and a failure, the failure should print and the
success should be silent. If the user is requesting some information,
then it should always print the information. There are probably some
commands that are exceptions to these rules, though.
