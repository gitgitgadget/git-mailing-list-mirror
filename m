Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FD3C433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 09:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E3AA206A4
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 09:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="de3xeEoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgFHJbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 05:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbgFHJbU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 05:31:20 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616F7C08C5C3
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 02:31:19 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n23so8462896pgb.12
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 02:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=269sxgTVepJukICOfxVD1o7lUZkVwBgkckCP3REGkps=;
        b=de3xeEoiAR26KPLiiwCVl9JlLcigHPGus+RMWKvolFxFUaDiAVxGdy2jTJexGcY0H/
         It2Vfr1YvicXcLyefccq0L/xmJ5xUqmlAyLBdS5CNoa1UGGhT980Xj/KSbl4zS/FSpeW
         Ft+MPb1HbLzbJv5sB762PD9jih0Y+/g6oOPW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=269sxgTVepJukICOfxVD1o7lUZkVwBgkckCP3REGkps=;
        b=EIG8xfa0ZEo9pkZYHUlpyy9rq7KmyUGeMldeats1sg1pYfaqUw11gDwKS9ebDcN5Qu
         TWVfP42RuZoW0QjbXezxMzLgzb/yrKkxClywFq0VV4tOEdRmQNiMTDtfjX1517Oc5J2A
         UYKwzAj6MA/WleMIT0UBB119qpMGQp9jUcg9WZOxJVC7KScxCVYzeiTyjflLj0rIHzpw
         ncqySHyRD1S80xwsSQ9RF4wPjf2AKuyeQzCF//RxFuAlwZ3VNfpLPml8ak5rlj0+013D
         JNG2bZmPev3ROzEDuEc/HgenuU4lNHBX6wrEhCYWBYtL3ofdYi347881TMuICg58QHS6
         UWPA==
X-Gm-Message-State: AOAM533M7j7X5UakeIQgY6SgJrsiDWhKO0thDXMNdRvpWpwL3PpC1Zp6
        IJgZYjBBMPPa4DBnRtZ5PyWgDJeL5CYVX4Mlqv220bw6QfQnaoHUXyV/TYPgw6GNHc3zIEQifKI
        LAydw2u1AjBP5krLlJKU/+ArbMnFQ/gzRZwxUiRwgoD0d+I8w48w7LEi7p/t/
X-Google-Smtp-Source: ABdhPJzRNI6sWMnlw6DkuAuvhBoZplDKtniW7xMnakw8iPLZWqzMaI5sbtm4pqupQKZwVKGE5WlYew==
X-Received: by 2002:a63:1165:: with SMTP id 37mr20353025pgr.424.1591608678558;
        Mon, 08 Jun 2020 02:31:18 -0700 (PDT)
Received: from DESKTOPLINSUN ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id 145sm6796938pfa.53.2020.06.08.02.31.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 02:31:17 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     <gitgitgadget@gmail.com>, <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, <lin.sun@zoom.us>, <sunlin7@yahoo.com>
Subject: Re: [PATCH] Enable auto-merge for meld to follow the vim-diff beharior
Date:   Mon, 8 Jun 2020 17:31:13 +0800
Message-ID: <05c001d63d77$8f6a76d0$ae3f6470$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdY9ddi5ON/g4NsfT8m/Prgp85qQqQ==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Can anyone help to merge this patch please? Appreciate.

