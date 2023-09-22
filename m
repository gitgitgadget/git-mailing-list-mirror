Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1411ACD4851
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 19:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbjIVTFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 15:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjIVTFn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 15:05:43 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0215DAF
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 12:05:34 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-412989e3b7bso15699861cf.1
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 12:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kitware.com; s=google; t=1695409533; x=1696014333; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TF1/eQRnwm7Vfke809GZ4n6Q8Fqxh9mF5Se+hAA02Tc=;
        b=T5jZZhCsfvxLLdrXmeg/E55VqniQEcMus1soyBvtsmgBfvmQeiz5dLoFXqNjB8bKyb
         rQzEfwA++T8r8FpyosMUz3waC8sGfq+qFnHtGGWJv2QUdDSxjpbrpE2T/ARvrWubQ0RK
         /s0MJNpJbRxgceIVw0MCmR5YHbasgk8rlxtHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695409533; x=1696014333;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TF1/eQRnwm7Vfke809GZ4n6Q8Fqxh9mF5Se+hAA02Tc=;
        b=ngYq/ryMVrpQNsQJBIpAXEZBPt4nJTpczyFNLPJ3y9RJOzxTqwc1iCMwHJ55f6hkzc
         3SdWTkUcLKTy0GlwrUnNZBlD8ShjDGsNJDX+KzhOB61H7bQ1s0g2aTybeuWZce54NMiq
         gMXpILXWn3zuJqxpm5qHlMS5FYw7dlO276l+qfOsi1xwWH2ZnLcAlGJYF+NFav5pAin2
         hEPn5PD87KenCNy2Os16LiDpDKl4bCWeLfFVoAOeDKDf5EmpUUnoL1+pf0AgOhcfq5V3
         9K9t/sFRLCed/q8LwFi1dLjlZbgMTYUYIs6WZ6HgO4rKteXR6G1+PRx9r4lOiSKpqIPP
         ghMw==
X-Gm-Message-State: AOJu0YxOB6EGOEbjX5OJySGT9KCldXiVcMlGuLxQsF3xH+QRpcD37jpp
        g2nOjP2hhQ86/6a6acmXyVt1O+5KfByeBSVSsQjiHQ==
X-Google-Smtp-Source: AGHT+IHuBhV5YGi6ybtAnrUtqly5aIcXZb2ko/XRRvTCxEJbg/x0axAmjBfB6JVJ/+x9k7QBEebVXQ==
X-Received: by 2002:a05:6214:5085:b0:630:7d0:56f4 with SMTP id kk5-20020a056214508500b0063007d056f4mr221357qvb.49.1695409533135;
        Fri, 22 Sep 2023 12:05:33 -0700 (PDT)
Received: from localhost (cpe-142-105-146-128.nycap.res.rr.com. [142.105.146.128])
        by smtp.gmail.com with ESMTPSA id c4-20020a0cca04000000b0064f66ae4be3sm1661516qvk.88.2023.09.22.12.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 12:05:32 -0700 (PDT)
Date:   Fri, 22 Sep 2023 15:05:30 -0400
From:   'Ben Boeckel' <ben.boeckel@kitware.com>
To:     rsbecker@nexbridge.com
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [BUG] `git describe` doesn't traverse the graph in topological
 order
Message-ID: <ZQ3leoLhljc+P5wP@farprobe>
References: <ZNffWAgldUZdpQcr@farprobe>
 <ZQ21NsLmp+xQU5g+@farprobe>
 <02d701d9ed6f$abcb4b00$0361e100$@nexbridge.com>
 <ZQ3GAJ/AHsM9e9a6@farprobe>
 <02e701d9ed78$436b3c60$ca41b520$@nexbridge.com>
 <xmqqediq2j0g.fsf@gitster.g>
 <032d01d9ed80$5e569670$1b03c350$@nexbridge.com>
 <ZQ3ggxA7KOysXrba@farprobe>
 <033201d9ed85$991c6af0$cb5540d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <033201d9ed85$991c6af0$cb5540d0$@nexbridge.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2023 at 14:49:58 -0400, rsbecker@nexbridge.com wrote:
> On Friday, September 22, 2023 2:44 PM, Ben Boeckel wrote:
> >Yes. It is explained that the commit date stored is only to 1 second granularity. Since
> >the commits are stored in commit-date, an equal commit date ends up "twisting" the
> >history and traversing some ancestors of commits before the commits themsevles.
> >This loses the "seen" bit tracking that is done and ends up labeling way more
> >commits as "not part of" ancestors. By sleeping for a second, the commit dates can
> >be totally ordered reliably.
> 
> This is going to be awkward to resolve as time_t only resolves
> (portably) to 1 second intervals. I still would prefer the resolution
> to be path-based rather than time-based.

I certainly agree, but I'm not sure of the best way of doing that. Do we
create/load a commit graph and use that for resolving insertion order
into the commit heap?

--Ben
