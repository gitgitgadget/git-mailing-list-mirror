Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D033C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 15:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiCBPxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 10:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242906AbiCBPwz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 10:52:55 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D48A4EF5F
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 07:52:09 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id y5so1682078ill.13
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 07:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lP3TF/nfnGAGLm2MBXReawJMfG7aMi2b3p6qVnCZrfQ=;
        b=kefih78AmV3XGQXwgFdlPqglr5PTkAS5dDB73hYgvABkcnO65oBqNu7Tt7KQf3omUd
         iqLY0oLwK3Q7YQYjhCK7Sv8BWBl4slOctEuoa731w6D1oDddecalXpDKuOeHKwNykx+B
         Ol1f/UBTzFtZA+Eql2w50jnk5Hg1aHROUobLVld17Pnq1nQ+2VEAKdGwEpWFUEI5iCY8
         azdcMN9ejKs8t3poOPO08csaiCdNmERL5PHeK0sn5PQNjMLRG+4ceBMtB502S+5A4ww9
         F9Ez8lHPjLcuoVg8lsIKy3eCrMvLGjz+e2OQB/U/r8nzE4IWOPGKM1mikGJDvwfqsZH6
         cdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lP3TF/nfnGAGLm2MBXReawJMfG7aMi2b3p6qVnCZrfQ=;
        b=7X3PfYdus0WtzHCqbqRsrO2VjBxCLyhX60FdcfJ5LS7y06BgKxG6iALY9I5omZlbiF
         ObGj7c88OOIn4urKVCRgMcnyUtKkf57aqBAHhIWDWbvXlq2MU9enThR73y+PjP+clNnz
         Ep9wCSha3ALo435+AE22P1tnI/AGTKo1qLV7sqifQr2tqa30YdiB3hh+ozMSWWIOI+Ex
         kCGzbN4V4GnLCAU87eyOr9y2IsSO7lfVM0ApqHFvy9MzUeDM2rAEhFYiLl/YlH6Aup5t
         87gzY5BbwvGicHZLJ3xibDfh1f/g8JvSbwh0/TyFQq1RJNExyQ6RSdtVrsz1PBMkxSXh
         ZwVw==
X-Gm-Message-State: AOAM532o/dYEEyVohNFLueRwSxQfT1HZJaUFLwn3cW2Ceu3WtcjmTB2k
        NavTfNt/hhhrwQ3VVYduw7lQyv34qvU/i1mg
X-Google-Smtp-Source: ABdhPJxlhpURFBu5AYUMPcet7QKpJ20FSzQ0lgdZGPSGB2adYvcDfWxNuhJuMW+Pq/nrzLXJ/ahcBQ==
X-Received: by 2002:a92:d2c5:0:b0:2c5:fd4e:fc01 with SMTP id w5-20020a92d2c5000000b002c5fd4efc01mr184461ilg.81.1646236328668;
        Wed, 02 Mar 2022 07:52:08 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k11-20020a926f0b000000b002c2756f7e90sm9327403ilc.17.2022.03.02.07.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 07:52:08 -0800 (PST)
Date:   Wed, 2 Mar 2022 10:52:07 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net, gitster@pobox.com
Subject: Re: [PATCH] builtin/remote.c: show progress when renaming remote
 references
Message-ID: <Yh+Sp5BxqxYhBv0M@nand.local>
References: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
 <06ef2e2c-7048-1101-870a-4774a2dcd988@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <06ef2e2c-7048-1101-870a-4774a2dcd988@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 02, 2022 at 09:32:48AM -0500, Derrick Stolee wrote:
> > Instead of a more complex modification to the ref transaction code,
> > display a progress meter when running verbosely in order to convince the
> > user that Git is doing work while renaming a remote.
>
> Thanks for this patch. It improves the user experience through
> useful feedback.

Admittedly, it feels like a little bit of a shortcut to avoid modifying
the ref transaction code, but I think it's an OK short-term solution.
Thanks for reviewing.

> > @@ -682,7 +686,8 @@ static int mv(int argc, const char **argv)
> >  		old_remote_context = STRBUF_INIT;
> >  	struct string_list remote_branches = STRING_LIST_INIT_DUP;
> >  	struct rename_info rename;
> > -	int i, refspec_updated = 0;
> > +	int i, j = 0, refspec_updated = 0;
>
> My only complaint is that 'j' is not informative enough here.
>
> 'j' as a loop iterator is good, but we aren't looping "on" j,
> but instead tracking a progress_count across multiple loops.

How about s/j/refs_renamed_nr ?

Thanks,
Taylor
