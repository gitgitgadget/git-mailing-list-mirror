Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61463C55186
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 06:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CA2C20748
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 06:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEcEYAq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgDYGwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 02:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDYGwy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 02:52:54 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA57C09B049
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 23:52:54 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id j7so5730629pgj.13
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 23:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0yl+tIFbGwFUobaHahPLEUVdWjMchuxHX6t3eUaZhB4=;
        b=GEcEYAq2i7rlnpYwzT/tvzR/Vlb+nNA6B0mQXAQTDyh5eyHhmsArHbH3O+vjh8LwWN
         eSmefjN43Pjc3zRI3pitmqkjoX+wg7uf+oHXDXUBMFx6KgtUjUNaCTTFKE4INf/naevp
         nBidX1/Pru5okv6aTIzqPxkihfMr+Qm0OZOT1BkfPZN/metMcTPhEIbnOpRDSWcyxPwl
         nq812cjXgtd8NwiNBCx56cD8VaODxkLi9ldJOw8y1LoRkhjyYwQn93A4fI9JmUXaxCyy
         zTE95T4gCToFQXc7bGBfJ9Sju+Uu30fi8b/sYeWscOvybBa9WYhWADA+aXH6Cx+cqt+K
         qq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0yl+tIFbGwFUobaHahPLEUVdWjMchuxHX6t3eUaZhB4=;
        b=lSv5Nssp21YtiHzEvvVXoLusCVLBgVq6EBLv2T9vR2OAO1zuccxIBaLCgobq3GrDi3
         X2sb2kdj1uH6MJezT+HBY/fHK6WPlLR3/fccvPE8BGEtETjogBWtRRIisBaIZ15GdnMY
         scAsdaebc5E67LOOoOfD1Z31iNcDBFBQHvrQb9nVhHH7Vh4TzteZeHE471/h1DRRbBii
         RENh0Kbd49lmGyCQ/o4ZMKMAOwQOJln8iWmOClJs3kWDE1spiyBXdQz1GhNnRNao1YkS
         1OXHmRhBwtfTo7QNnUCtU8t71Km+p2eH/RiQ7kOdJZlY7SYfmdHIm8XQCOfnwzd8jazy
         15QQ==
X-Gm-Message-State: AGi0PuZD7c3pX+0EnCTKc45YZI466btCxjjnLX9E0G994oAYycJcWqLF
        G7hpaR4js/G6IjE/8WnvHM0+1sTi
X-Google-Smtp-Source: APiQypKnWKbI3SIWNWJCFODXPLASW3vMaqJwajVlfrDVuDHLw4aSH3J3e0MvzDoeEoy6LC9P9rT31w==
X-Received: by 2002:a63:dd55:: with SMTP id g21mr13064058pgj.354.1587797572878;
        Fri, 24 Apr 2020 23:52:52 -0700 (PDT)
Received: from localhost ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id w11sm6479327pgj.4.2020.04.24.23.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 23:52:52 -0700 (PDT)
Date:   Sat, 25 Apr 2020 13:52:50 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     lars.fricke@googlemail.com
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org
Subject: Re: p4merge no longer working after upgrade to 2.26.0
Message-ID: <20200425065250.GB5065@danh.dev>
References: <CANYt6aFi+6vKRD71digEh-D0RKkLPBRtek5t8zA-8_cPzwexkQ@mail.gmail.com>
 <20200424064805.GB44448@Carlos-MBP>
 <CANYt6aFjp4wVzYk85Ag9mH3AWp4qUS3+4xsGioyQknKz9tmRUA@mail.gmail.com>
 <20200424072049.GC44448@Carlos-MBP>
 <CANYt6aF1o9fmK2rwAA-LPSbd3TeW+x+6LdUj99sg_ANy3Q0kJg@mail.gmail.com>
 <CANYt6aFN0eAKEhRvNhoiOTu7jO54Kau_ayQMhrdy+7_GPAOCyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANYt6aFN0eAKEhRvNhoiOTu7jO54Kau_ayQMhrdy+7_GPAOCyw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-24 11:28:13+0200, Lars Fricke <lars.fricke@gmail.com> wrote:
> Just to help anyone who runs into the same problem.
> 
> For whatever reason (maybe broken package on SLES) the wrapper p4merge
> was missing from $(git --exec_path)/mergetools.

In openSUSE, p4merge is splited into git-p4 subpackage.
Which make sense to me.

Can you check that?


-- 
Danh
