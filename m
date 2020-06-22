Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCD2C433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 09:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C95A320739
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 09:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujGlQWGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgFVJmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgFVJmW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 05:42:22 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADCAC061794
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 02:42:22 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id j4so7352525plk.3
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 02:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition;
        bh=p0E+FQSTJyHxKMSVliMk0YdopwFOAQ71UAJEfvyuK6I=;
        b=ujGlQWGlB10sIcPUDpSA+KQixXHLWKTGcRT4vaRg7IXhOPsG43qDxnjq6byM6YGCgg
         CzVHJzsMGgVn8ei81TkcTE7j0HOAFYsUkY10vxjoeR9Zl0RHapcKCny9XXISXXHHrjsI
         7qmJ6ivjkYie473NodpKDo4xQz+MrgNSnatBtME/UfA7mjbiP99tq23DOKTZiAXP/3+E
         /6//x783UBLsfS6sza+WcR7wCm3MlcneW5PXMbv6q16JvC1wuKHcsM0vBuL0+Y3Xcbur
         csYGU1TISIqBloemJaFirPGTldNqcY79y3Z8Ks/RRmOr8oNcd2giAnX5Er1j/xWN24oX
         VvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mime-version:content-disposition;
        bh=p0E+FQSTJyHxKMSVliMk0YdopwFOAQ71UAJEfvyuK6I=;
        b=pj3hyxaRTyB0ERdtHX9XRtoo883uqazu0r6mMo/fao65bjOYNUt3XCHjpYMJzn/dmQ
         HYjjiaeML+obRFpqY0gFwCniXdHy40HG3Lw9Fdeb4lZ39X+bO6qBN7gIfiRa/mp+7XGz
         WG8HPEJiiosrgr/dYt5qxS0TmM0zwATVyQ5EeHWHaCaOZzSTgAlqwuQrxOMFDKStz3//
         WWlJa1ja+MlwUcCHZJ77JKBUn0YXSAowlJK3IxyKNLUKOutSwItmP+1IdocO212sX3vE
         muhKkSTHgF4s244EDSsAk3QmZq4Ixymx3X9Tuyb8PBL6rjJXXFWRpaQBw6N714E8G+7S
         1gzQ==
X-Gm-Message-State: AOAM532qZaKl9z668sCOyz8VI25opnYMFgpihkTaWe9KWn+L66R7pq34
        /oV9HWWW9/CxJv6YE02eQwD/4Z7m
X-Google-Smtp-Source: ABdhPJx5nfyJcfnC00a0S/pDr3udnx/HZRo9qFSP13jsGOvN51Ywt4Z4sOywjvl7Ksft86l/5XXd8g==
X-Received: by 2002:a17:90a:8089:: with SMTP id c9mr18217683pjn.126.1592818941251;
        Mon, 22 Jun 2020 02:42:21 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:2000:fc5a:4d80:dab6:77a0:3c64])
        by smtp.gmail.com with ESMTPSA id 12sm13613451pfb.3.2020.06.22.02.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 02:42:20 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:10:39 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jnareb@gmail.com
Subject: [GSOC] Blog about week 3
Message-ID: <20200622094039.GB1719@Abhishek-Arch>
Reply-To: 20200617093328.GA1327@abhishek-arch
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone!

Here's an post detailing the third of my work:

I talk about a bit about why we cannot increment graph version in the
commit graph header, the alternative solutions suggested - their
advantages, disadvantages. Then I talk about the performance numbers I
got through a rough working prototype.

https://abhishekkumar2718.github.io/programming/2020/06/21/gsoc-week-3.html

All feedbacks and suggestions are welcome!

Thanks
Abhishek
