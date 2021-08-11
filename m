Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF5FC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 21:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3437C61019
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 21:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhHKVmy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 17:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhHKVmx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 17:42:53 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F2DC061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 14:42:29 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id oa17so5780762pjb.1
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 14:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QZBME0flWuQMvvvtrJhVokxKX79YQJZfk2so9LhAwL0=;
        b=BrTjN/en8JS/wK2SeXodylgO1Au7zqKR3PY6KuVaUlSV38gw4Wx4CBFc01QA3rHkB2
         aIBIBFeOKm9GbrF5DmaVNzQ+Vo7KjEdq5CFNeiUat4t7WwFkD1jC7BrA5Wc9kNTlHKBS
         lnB+/7RwurOdJ5y8kXC2eDgfSCWZg7aTRGxUS7Z9q9kaqMTF46K/kWmWbm2FwwDPAtYf
         08oOM7evRC7h2FaBwzGM+3uaks2CmECpV10EV/lq9PesUVK4UjXDA/BLnNgrDgtUpJ9Y
         5fDmlOS9EblmfOnuPlXhz8A2fSaw7v1RlfcTLRlwHBaHCWhEJRVBrT7KLE93L+ZXGKUf
         F6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QZBME0flWuQMvvvtrJhVokxKX79YQJZfk2so9LhAwL0=;
        b=MAX449NMT8X+ecxX5CZxt5+fasm0BT+VsgBObL0KZiN2V/HPt1RBAONvW0AlFHaVbn
         Tu7OqiKB4KZR9tzfSzuz2vvxxxIvBWx+Vyf2sPqpw1pfmEJlBHQCg406gHwDIgAbb6A0
         d1nlP1RcnfdOTBLUQCr9LPDMzy6+DNtuHuxwyLztI4cbBA1ntBPqLGmo2onu9PCuFhki
         Y7G/bEvdjZGxCsK5Lm687E96C+Dro2az7Oit0HycS+zMEoOU4ZH8JocUTRLCD+b87sfe
         mjcXWSkaXDOjiRkK5bOwSA0OohUwAmmaQxtMNDgJ1pyJbp1b6/62pgr6AMlMToyQgRf8
         CTHQ==
X-Gm-Message-State: AOAM531q3Zx3Tn15IEZMhmLvJzvybnWaEIz6KXzTa1jAMcScIyQpTU/1
        V1NSrAVTyZYJtTL75h/1/fExwdHfUxdbWw==
X-Google-Smtp-Source: ABdhPJxeOOCpCV1tAVM3rH2C5H0vMN/8/yLrrcf60oqRAtXgRhEi1wgaEJpxFWfLsZFz5ipkpzgCRg==
X-Received: by 2002:a17:902:7282:b029:12c:75a0:faa5 with SMTP id d2-20020a1709027282b029012c75a0faa5mr851846pll.35.1628718148377;
        Wed, 11 Aug 2021 14:42:28 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:1377:1116:63ab:bf4b])
        by smtp.gmail.com with ESMTPSA id b204sm529718pfb.81.2021.08.11.14.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 14:42:27 -0700 (PDT)
Date:   Wed, 11 Aug 2021 14:42:20 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/7] grep: typesafe versions of grep_source_init
Message-ID: <YRREPNA8GPyKdWBr@google.com>
References: <cover.1628618950.git.jonathantanmy@google.com>
 <e5e6a0dc1ef59b2ab419816e463814d93115e7f6.1628618950.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5e6a0dc1ef59b2ab419816e463814d93115e7f6.1628618950.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 10, 2021 at 11:28:41AM -0700, Jonathan Tan wrote:
> 
> grep_source_init() can create "struct grep_source" objects and,
> depending on the value of the type passed, some void-pointer parameters have
> different meanings. Because one of these types (GREP_SOURCE_OID) will
> require an additional parameter in a subsequent patch, take the
> opportunity to increase clarity and type safety by replacing this
> function with individual functions for each type.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Like Junio said, it is very neat.

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
