Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4557FC433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 23:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C58320722
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 23:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI8nK/QO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgF3XBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 19:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgF3XBt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 19:01:49 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EC9C061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 16:01:49 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f9so10095934pfn.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 16:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ys+ft0nMrmLI/NdA6ASnAn4012QxFdP40NfpNRWbgV0=;
        b=lI8nK/QOJ14ITAm39jKM1J/MgkGWK5CauNfuABSql+wiwDcVJpatEZRtxcEyRvftQQ
         5xzQSovKZuOGXQnfvPDn+n4OZwgBmfXLJFAoppHhKRxR6gt+VVMp4WYHkXFrvr3cBvkK
         vdpm33TmOZX+GacwWupZfobBwJUR6Nc1w6xLBEtAcWkWqjcEQgHDMhr4LGDgekJofE77
         iSxyDCjGTMT2RWRv/pJtyDHxlyAxtCnPKpyMduALNehPAA79Gx/hZW9LM8b9WHP7bHiL
         FLr8V+opU5GZgboEKzamORseGptiruaNU0pIj63OTG0RpyfI3kX1+463QCqUdU11gC2I
         3xsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ys+ft0nMrmLI/NdA6ASnAn4012QxFdP40NfpNRWbgV0=;
        b=uAWyg6wufH4AmLg/WbhnNL1NskK8/vWqn/W4YU4yOKwZtNCNtsSZEenbs+A75S3qYa
         +tPPfHkHVC/3h+XiCwgkbZKi3Uq3d+IJwXNRMZj8Kb0oQfyTty/EMNKV6uXIxwXbl/6d
         sOybghUpm/yYWjlQnd/7eJdA2OtwqXO+kcXrqPgcXQ5ApEGztHRZ9d8Q0hmf/9LZxYQ+
         K3rvhc2WLD6z3l/3g82uDfb3ZdNQF3Yw0SZtwoNRq9FOFsh8Jm1PKXMsZN4Bu5NBx5mv
         zC3yenDEyMpIBRQHp7++0gcH3ruVqNDwuL+7FK9kChv2OzI+Pa7BQJJnyjDvkJdQKBbM
         ZntQ==
X-Gm-Message-State: AOAM533uT/bZNlHZRqB8fYR9lEjMyt6N322m8x3KQnoTX6oqz986PRem
        eJNnTn0Jsn9/cLfcR0Bz5gw=
X-Google-Smtp-Source: ABdhPJw0YD4BzhmldoOPIR5C8I4eK4M7wdJ1s6mBiGglK3e59Qa0EBM7E9TTWediceNEkwhAuyo4gA==
X-Received: by 2002:a65:6846:: with SMTP id q6mr15910830pgt.397.1593558109069;
        Tue, 30 Jun 2020 16:01:49 -0700 (PDT)
Received: from localhost ([2402:800:6375:9968:2644:616c:71ad:c7e6])
        by smtp.gmail.com with ESMTPSA id y10sm3599741pfn.121.2020.06.30.16.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 16:01:48 -0700 (PDT)
Date:   Wed, 1 Jul 2020 06:01:45 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     sunlin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunlin <sunlin7@yahoo.com>,
        "lin.sun" <lin.sun@zoom.us>
Subject: Re: [PATCH v4] Enable auto-merge for meld to follow the vim-diff
 beharior
Message-ID: <20200630230145.GB15821@danh.dev>
References: <pull.781.v3.git.git.1593414441313.gitgitgadget@gmail.com>
 <pull.781.v4.git.git.1593516397380.gitgitgadget@gmail.com>
 <20200630162333.GA15821@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200630162333.GA15821@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-06-30 23:23:33+0700, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> > +			then
> > +				: old ones mention --output and new ones just say OPTION...
> > +				meld_has_output_option=true
> > +			else
> > +				meld_has_output_option=false
> > +			fi
> > +		fi
> > +	fi
> > +	# Check whether we should use 'meld --auto-merge ...'
> > +	if test -z "${meld_has_auto_merge_option:+set}"
> >  	then
> > -		: old ones mention --output and new ones just say OPTION...
> > -		meld_has_output_option=true
> 
> I think something was forgotten here?

Please read this line as:
Is this a copy-paste and forget to edit-afterward.
Somehow that line was lost.


Sorry for the extra noise

Thanks,
Danh
