Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7D6C433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 17:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72B5820706
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 17:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbhANRY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 12:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbhANRY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 12:24:26 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E64BC061574
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 09:23:46 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id h4so8991703qkk.4
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 09:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hdD7B+X63g+S4mNIDjfda/TDD0nyGYR/sk/MYUeuG+g=;
        b=jEA2MslWJi94ElNU0Zxwabglx0or/QDRU+d3Hy9C276OZC4kj5l616RU522jP0GG3P
         rarYvyR5t0XujpiKrkoHhsVPcQECBwl+wm1tH3nNpvSUtDL9g2TFOl3smwJ/GC/YZajG
         IOpgwjtVyCrdFH/Ed3adjV/tZAQ06WjhB6JFe+duAGySv3XhvcqJtOvNTCIFo0Ao83HY
         Tp14Xitn2ImW9kTv5LGFYASY/cpfJ95+mQQc2ze0peb/6VFc9EmpLtmAEwJ9RH1+7rWz
         3WWVo9Clh66ryxoFqZIOBHTPhYScK1bIvxLkpmOM8jf6BSxRDlGCPZKkcL8sP06l/YZ0
         d3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hdD7B+X63g+S4mNIDjfda/TDD0nyGYR/sk/MYUeuG+g=;
        b=fUB6NpY40dAce142uqiCFnvgWYt1NtHOv/5sZdflBwxJ0zgIbie9aJG73ROdIue9ye
         mx2AxnNorThYEfN6Y14miArj6TVBpgPe1IRR9ecANrmwWOe0PdOjGPdi0ZOoPZlqrEnq
         JdLTVfTdKVnnerIqNXhNvH+VMrxAP0grsheh9RrHCwnSiSXV97/mr4UqNMjIJESO+pFa
         YHG16KD7WFTp6FLKX8oAW2bpqChy45jo278N0bGuc6YWw8pDaW02NwiO9lPc3Tx3ye/p
         jbA3tHspI6uQtLPe1yb8/e2HJdEX51P0lrkUiTJD3BCgjNOpkM9h9DKWOBx26lUuSk5M
         Fl0A==
X-Gm-Message-State: AOAM531arxwxz3Wo2gcV5gQ/mfw2OFHpaIjHLLU+FrD4k6Vm2Ir1yCRz
        oF30YzbIXBpJXdrlny+cQ3aRxr5D+8MV9w==
X-Google-Smtp-Source: ABdhPJx3IUgXpoET6Wh0KIiRkAwGMv47BC5ihHFyUkBU4rP8yqJs7PxZ8owYZ6vVs4FFj6qAer/hnA==
X-Received: by 2002:a05:620a:22ab:: with SMTP id p11mr8245525qkh.237.1610645025345;
        Thu, 14 Jan 2021 09:23:45 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id 190sm3404548qkf.61.2021.01.14.09.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:23:44 -0800 (PST)
Date:   Thu, 14 Jan 2021 12:23:42 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 0/3] Refactor writing promisor file
Message-ID: <YAB+Hu5/5NHUb/vw@nand.local>
References: <20210114155016.3005932-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210114155016.3005932-1-chriscool@tuxfamily.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 14, 2021 at 04:50:13PM +0100, Christian Couder wrote:
> Compared to version 1 of this patch series, the only difference is
> that patch 3/3 has been added to die() in case of error, instead of
> ignoring it, when actually writing the content of the file or closing
> it. Thanks to Peff and Taylor for their suggestions.

Thanks, this version looks good to me.

Thanks,
Taylor
