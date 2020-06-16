Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDB3C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 00:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52A4120776
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 00:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHQWLTWF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgFPAXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 20:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgFPAXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 20:23:16 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6F2C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 17:23:16 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h10so4657612pgq.10
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 17:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3CCmis0s3sGGPuzItCXldD2BacFZINroq+S+SKFVbKc=;
        b=tHQWLTWFikcwwsVi92j4zuRtnLgo7ZHBMjhsq6uDBZzbTlxUQTD1pbLujT/cTn4fbP
         RvnslyJwv6vEyZTyGDO4+ZJA9tD7k9D640TmbmEkLCbp5jGNw6rgxVMkhA/IQOr2yy1J
         04BRiQYa3KkQsp0Wf0HyKR3sn6+CRCBdQSc00ITxLp4VGqdUyMnCO7rUkyFx28qnIaVu
         GnJusq97XprDxzELuym8LWWvtdNidHAAW96GfWiqqsnbmhiWUh9yE2iOWzIGM7LPkr13
         5Sk0d5y/CDa0nBb4rJRaxDWcRVWJherPlsWDeXA+xIhnLOjDJ6g8t5XtVhBK8h/rqiXs
         7BUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3CCmis0s3sGGPuzItCXldD2BacFZINroq+S+SKFVbKc=;
        b=kPL3ZakR38+ufO0PI5S5wSdDs9V8KQR4Nmh9Q5gzutx/lxNEQOl+h26wqKj/i+EAqr
         X4rm0anvgysxzW8QHqDvuL7jjOX8KitOKqh0LuxBBrVrnIfGXIMQyZ+zb27sySVv5BVe
         UvnGf52Wzn8VSNxuL5UP7DuMbkU+1uA/KsozAr0r71byuZEXoiEMszin5Sa/zn4o7aKg
         2roZvcvZVE4LSjllBHJFg58NxZNFMcs3dXWfQamhHoeC0Ut7CmG+a1jH9pdSEe7EfZFN
         EnMLuHH27oQz60sFY/jSL6XP+gc83Rb/fn9zFUcCQ7CnaItXjuPZj+VS8Ki7XYDTZ4xX
         HVNQ==
X-Gm-Message-State: AOAM533kh2yEe0XB0VmgeqH30CNlQg/T7REhZVO3cp6ddjznqGh2ie5u
        QH3y56YG2xs92LIlO0DBFZ4=
X-Google-Smtp-Source: ABdhPJyYLAVkwZoWaveFpLMLqliGMYgdmDV1Bke3RJH1fFxUQRrdOMKtZSrV0LXaq5DGrEjvxUBmpA==
X-Received: by 2002:aa7:8506:: with SMTP id v6mr157988pfn.303.1592266996074;
        Mon, 15 Jun 2020 17:23:16 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id 71sm15458762pfb.20.2020.06.15.17.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 17:23:15 -0700 (PDT)
Date:   Mon, 15 Jun 2020 17:23:13 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Abram Wiebe <ethanpet113@gmail.com>
Cc:     simon@bocoup.com, git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200616002313.GC164606@google.com>
References: <F17A9CF6-E020-45BA-863B-D85F098691B1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F17A9CF6-E020-45BA-863B-D85F098691B1@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abram,

Abram Wiebe wrote:

> We run into this kind of issue in software all the time, which is
> why you see packages like PHP deprecate interfaces… but then still
> need to keep them around for decades, simply out of fear of how much
> would break if they actually took them out.

You might be comforted to find that the series at [1] allows
requesting the previous behavior by running

	git config --global core.mainBranch master

If that does not work in your setup, we want to know.  This same
setting also allows tooling authors to experiment with the new default
early.  Hopefully this can be useful.

Thanks and hope that helps,
Jonathan

[1] https://lore.kernel.org/git/pull.656.v2.git.1592225416.gitgitgadget@gmail.com/
