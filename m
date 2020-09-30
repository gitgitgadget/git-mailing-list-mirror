Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEFDC4727E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 14:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12BEE20789
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 14:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R15M5IfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbgI3O1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 10:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgI3O13 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 10:27:29 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29F0C061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 07:27:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id v14so1049587pjd.4
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 07:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ljs+ZF+g16jZe3c6eZ2j2+p8ioYd1/q5aRMO14hOXYM=;
        b=R15M5IfTpkxh9j6QJTEYvVkKMPgtYhdGTSEsSyhZ2hz+ZcWH8sZS97AzS7EvdEssCm
         ArcsCTDhq9T9aa5KybPEqOwYBITPJpiZc6wlo3Jqca0SO1BC8ByNUmU1EwpGkOE6cECT
         zTRhS+ZRpqDSm5IQSbCL+cZoRreGbFN+SAPtttLl53LqcorD2Y3vNfslxyrLpa6jraHu
         U1cQmq/TXKAPtmlxapKTwNpNgRWQ42qVUPZDVaQrcsDfkqo2Ch8IUUrNuToI7eGMHKQ6
         Ypg6jBecrPy+RfrCIn0tk4z4nSPG9U4ClNyjs0OauGd9+5aFFtkLw1WhPbCX+B9Ff8Vo
         94+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ljs+ZF+g16jZe3c6eZ2j2+p8ioYd1/q5aRMO14hOXYM=;
        b=gzPanzNaEFHb8tZIfQc5+EppL6mK46LYGzcNVFrlZwgiOUUneVGEk7NL7+T1fC7fN4
         jDQdkQomvceGxpjJGhO6Kruby9Gdmw1SfJ4JtuOfnhOuCX2iXS3ZBDGlwRjm2QGiVzdT
         5ZoZsqLH4lTRtMAaprwjQAfRbvEViGLP0z0XCWKkcwp6b29ohx0RwuEsotHlI+nFQ8V9
         Vktptrx45T/JeAEM/CKb1bNvwAzxvkB3grEQ6C+W45wm73J1+cRkDfAMG4y00GXsScBk
         v4HAHVdU+jiMhErySyWt2yK1TbyzzN7Plg2vv2uE+Cas+z6cYl7CUfUCug1OheAVCqJJ
         +ybQ==
X-Gm-Message-State: AOAM531udtsbtb3NtnYtT7bsU1sl4eDdjqwzRGs/CruyTXH8/+qsHuB/
        4NaJVKje1qyU+qStBD1ohrgdVhrx75wL4g==
X-Google-Smtp-Source: ABdhPJxae3M16wn4iYAkDw3e2RCoXZo0C9eQITtHchEo8OjzVybufawYud1f7v4LiQUJf2gGl3lgAg==
X-Received: by 2002:a17:90a:a88:: with SMTP id 8mr2800113pjw.105.1601476049312;
        Wed, 30 Sep 2020 07:27:29 -0700 (PDT)
Received: from mail.clickyotomy.dev ([124.123.104.31])
        by smtp.gmail.com with ESMTPSA id s16sm2444272pgl.78.2020.09.30.07.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 07:27:28 -0700 (PDT)
Date:   Wed, 30 Sep 2020 19:57:24 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 3/3] t, doc: update tests, reference for
 "--force-if-includes"
Message-ID: <20200930142724.GA24694@mail.clickyotomy.dev>
References: <20200926114626.28823-1-shrinidhi.kaushik@gmail.com>
 <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
 <20200927141747.78047-4-shrinidhi.kaushik@gmail.com>
 <1377ee27-3f71-a12f-41f6-613e5a00695a@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1377ee27-3f71-a12f-41f6-613e5a00695a@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On 09/30/2020 13:54, Philip Oakley wrote:
> Hi, spelling nit.
> 
> > On 27/09/2020 15:17, Srinidhi Kaushik wrote:
> > [...]
> > +Alternatively, specifying `--force-if-includes` an an ancillary option
> 
> s/ an an / as an /

Thanks! I will fix this in the next set.
-- 
Srinidhi Kaushik
