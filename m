Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B78C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 17:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C2B06127B
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 17:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbhIVRm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 13:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236815AbhIVRm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 13:42:28 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D1EC061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 10:40:58 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id d18so4383607iof.13
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 10:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mb1PqJQXrb/aYQNrTJa/YUnNxvtRhk/yBcSpQyEVGHc=;
        b=FoC3ihqjb0ancDEoql6wKGvhAjmZKdsKbFS/a49oXZ5fIkkIizPPfqjFWiS3Gz3Y0Q
         +h07dvUW8Amdm0sLcWaMsAvkTG8D/GEIuzUyh572dUZegZ+saAsoA+n/0z9vgFsKPRSb
         CISdlFLTXMAfKPO/Y5JNU7RU3xOIX2oA704ni/9tWK0jF6Xl4ZhrU+QZ6/YBeUbU/ya1
         7sBi8JEBJKaWV0rWnpspaKZbZSx1lPFYnsROQZ+ZENKX4QJrbRexO1Q+YH8KHQoOJUZj
         zP3BREnP0pSKwKie+O4oTdfVrbiVgdRxGEIFyBuFWB7WdaxSauHNdfCvSOU49kQByQu5
         GMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mb1PqJQXrb/aYQNrTJa/YUnNxvtRhk/yBcSpQyEVGHc=;
        b=7iFopVXCI2v8Vl8CYiyZqPdVNNK+B7v4KaWHyBJOnAPpRHC0SKKBIt0OAq/EMRJxou
         Lf4zl2Ly9H94IxkNMFxVTBdQa2DKGqYlXZMYvr6tG/9JVgYARbWb8zLZnI5bprBn+gF0
         O1Xd3/Nx81ozV6W2PCJRTkUi/4AlwVUgD3NtopLN1beOQ5oD6iXQnpeSObgIxVGopjj3
         P4XAm/up2VTvqVJno24g6md6sCPvoUm5PJ8WKq07dSoLX6SZPHzzn3dAc2vgi6vW+6iB
         B5F0MsvRJHVUUsBn+mNt8Zt7naLAj9N33mbBMrIm6yVFHdCAoE6/lV5Zo02c42kEPM1I
         kADg==
X-Gm-Message-State: AOAM531OhhIybwyCVRY3LzcWcn+SXNzJhqpjPhHdpgBINyRa0nXZ33A/
        AFrG/gWj3iqANdS+1fuoFXU2bCt9PbpcXA==
X-Google-Smtp-Source: ABdhPJy9fRYjK48Ni5wA3Itp4r517zseUqjePwVxtM5s8UBcfszlHG0VC3T+mSxHV/f8sQuQ9ZQCSg==
X-Received: by 2002:a6b:be02:: with SMTP id o2mr163095iof.103.1632332457460;
        Wed, 22 Sep 2021 10:40:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x5sm1244979ioa.35.2021.09.22.10.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 10:40:56 -0700 (PDT)
Date:   Wed, 22 Sep 2021 13:40:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, wolf@oriole.systems
Subject: Re: [PATCH] rev-parse: fix mismatch quoting of separator in the
 message
Message-ID: <YUtqp+1Mwl2v0kuh@nand.local>
References: <20210922111744.675326-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210922111744.675326-1-bagasdotme@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 06:17:45PM +0700, Bagas Sanjaya wrote:
> There is a quoting mismatch quoting `--` separator in "no usage string
> given...." message (`' instead of ``). Fix it.

For what it's worth, I think that the `' style is typographic, since the
pair look like English "smart quotes" (as opposed to straight quotes). I
have no opinion about which is better, but I don't think the pre-image
was necessarily a mistake.

Thanks,
Taylor
