Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD80C54E4A
	for <git@archiver.kernel.org>; Tue, 12 May 2020 11:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2798206F5
	for <git@archiver.kernel.org>; Tue, 12 May 2020 11:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjghBpVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgELLWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 07:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgELLWE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 07:22:04 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC21C061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 04:22:04 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q24so9224943pjd.1
        for <git@vger.kernel.org>; Tue, 12 May 2020 04:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yao4VkzVGX/qRpbK9zCJ8Ds7QH9wA0UWpTcYWH8cQJQ=;
        b=NjghBpVk6KhslCJSd9N3nUX2AGIiGkVKkuLvIQ7L88U40e1HER58fcC85vcsJ0Th+F
         qss0KrqvH7iSsk3ulWWSKdfnhYcLvCf2lG8Uis5bKlrbff/Yg2mjBZg0qwAh+G1rCCEi
         z59jTBKcZWuEswEZQ1by/KU/CW575mr0EUjM7VgEG4WC7qwpQc3eNqOFfmrqxR/oIcuF
         h4njlnMsPAAgnZ0ThJ5n5hrXyYIsYnEGQWO2fexK1y7quE3sF6mV3fSGwrlztOFbNPDS
         fs7aDis74xGm4cb6P+zdFjyPKjQKJU5Xc+5sM+i9O5xWhjmNCwMDLs6gayh8s33eXb8J
         LYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yao4VkzVGX/qRpbK9zCJ8Ds7QH9wA0UWpTcYWH8cQJQ=;
        b=Sdl59LVHkz0ONrj4UJji7nra7fC2J7YBJg5kOaQvceyA1SKqE4xffwyiGnqdMkkROh
         tBAkPTOKk7vo7SG7p5lVdbjNV2CTQ26CPhFFZkPS3mKQe1EXnYlrrh5E8cltHmmppt8N
         79JzYSMoNaNHQBVpsyX0d6hr3+/ObpH+TQogxBf+5SiXUFUtGs2ZvqPJUq+HejyD8GY2
         NLtaOXjiGCIWEV+VnHB2dc6VmLli/UqvnzrU58Lb1RrMv3fnRLfoiAONzOzxE0WeeC1v
         V2QQ9mknLrx/h7t1b/16g173eP65B0tHijh4UQtbXv6MSXxu7A6at6Ez3LAKphXHyJgH
         QVBA==
X-Gm-Message-State: AGi0PuYH1iy0odGfYSUOpye3unIEcP5bpNT/0tpltgTldB90IZ/14EOe
        M9TRaJTOoMk56iZIpy48Jco=
X-Google-Smtp-Source: APiQypIodD016XEyT0JXwmoDNrF1eZbA0ckSRjs+SpF9xm26Fr68vKv8dA3IPz649AKETbCUVOBZEw==
X-Received: by 2002:a17:902:c282:: with SMTP id i2mr19450506pld.20.1589282523858;
        Tue, 12 May 2020 04:22:03 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id a33sm7352228pgl.92.2020.05.12.04.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 04:22:03 -0700 (PDT)
Date:   Tue, 12 May 2020 04:22:01 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     David Moseler <davidmoseler@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git-credential-store does not work with a file
Message-ID: <20200512112201.GA10049@Carlos-MBP>
References: <Wc7NKqbl9k45DWha23OG_TvVA4Ftq3sOCiHScVXhmAbCPOaz8pkEqQrPXw_JBC8G7g9CrIKxwfE8pv8Nr9Dcw5J0zA7fNCAi9Mq1OnxhpMg=@protonmail.com>
 <56HlWgfQEg1t99VKZaFZqhdcjAs279HXXP1gQ9YzZGOGcR9jEzSVYgl3flvbTiqSet2HB0gc6jotcDmYbtDipE7k0-QbdrzjgxiKZBnIK_4=@protonmail.com>
 <uBc-Htk5XJFPF28aiZsQUIowfd66Ay2NiCyVbxkWpD77ugn3k4LBLse-jm0Jf4HpAKMWt4chuRAbxskeczZpj_pEnUaX_XOrmhfYksCeVLw=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uBc-Htk5XJFPF28aiZsQUIowfd66Ay2NiCyVbxkWpD77ugn3k4LBLse-jm0Jf4HpAKMWt4chuRAbxskeczZpj_pEnUaX_XOrmhfYksCeVLw=@protonmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 12, 2020 at 12:40:10AM +0000, David Moseler wrote:
> Hi,
> 
> I'm using git version 2.17.1. Providing a file to git-credential-store, such as in
> 
> git config credential.helper store --file='./git-credentials'

your quoting is off, so you are passing to config only the value 'store' while
the rest is ignored.

what you really meant to use is probably :

  git config credential.helper "store --file=$PWD/git-credentials"

note that using a relative path might not be what you really want, as the
context for when that is run will not be what you expected most likely (ex:
the root of your repository)

> is not working. When using this command, git writes to ~/.git-credentials in the home folder anyway.

note that credential.helper is a multi value setting, so you probably also want
to clear the list first, if your intention was to only use that file and not the
one in ~/.git-credentials.

see `git help gitcredentials` for details

Carlo
