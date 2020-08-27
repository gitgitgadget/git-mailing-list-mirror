Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7EEC433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F3DA22B4D
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDZZ6/Sv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgH0TWF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgH0TWE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 15:22:04 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B281C061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 12:22:04 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id o13so4076156pgf.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 12:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/htDlKYD/U1bkKEGh+3tVAj6J1B3FmT5GqIPALGB5Wk=;
        b=kDZZ6/SvicHc+zwtGCvrpJ50kt6+P8w4X0ycKbwdza8sfc0YiEK8euCwSVo1rdkX7n
         eRC7CTpn6kedJ7t0v551uvT41Dk/xjJY1hYqep/QmnxGLlKdheY/TF+8hi81hI678pTe
         c5aqZBnGrc7BnPOqo7tVLbRQ7z6DMhIQrHlM122/v2vsqvwU0/MZxVKwAs6pK76iLgYE
         q4d4x9KrapDWi4g43VhB5l1U8gYxBV12z76tIH4G7JqwqRXivI5JACCmfBsslc3htCzr
         +hXkLeWRwvGPA0KsMOX1fXUMVQzsec4S4hT2HMkbt5fpT1M+/mb+n9uQLTg8+A3frITB
         sYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/htDlKYD/U1bkKEGh+3tVAj6J1B3FmT5GqIPALGB5Wk=;
        b=PQVI4nsX7YlOz4QPG+tAgWEJSv/2Isj2clswCULctwoShGBUOQDdKvpFaY3S3b4uV+
         yKpRHKu4mf6PIw8mS7yVjvnBzo7P6CntPyjk1BlX/Ky8uBQjcacynqTfnHYR3djC6FNg
         yV5085pzLwhl7JFwERfR4zMCNYUdPqrGdNfWL9vvYVMmNRZDL1ea5WxxvS0/RszPPaRj
         2jrgqFRDfv+Hn1yefHr9qjVY7OwAG76+Lg0pd5rIfpK01E8oDdihECnImm4l9ED8SWyK
         bZ9291PBym3jspNxbyCZ96ZnF2T17DfrfuDGDztoTVfbY48N1ihp9DbfMiz4bQcX3Ldv
         FfHg==
X-Gm-Message-State: AOAM532PNc4N12b2UsuYPOkfEIevojMCdV7PVUpm43k2DmpCm5hNAKuQ
        D6hqsh68SC1PIdrzg8NLykhITLxrxL1cTw==
X-Google-Smtp-Source: ABdhPJzK1TIzwz8d/GhpulXknubF/CZZJL2vXvwnKvFqmXTRQSQLORPPm0YCsx+Htr/QsmPLj7p44A==
X-Received: by 2002:a63:5f03:: with SMTP id t3mr15552520pgb.258.1598556122922;
        Thu, 27 Aug 2020 12:22:02 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id a5sm3141655pgb.23.2020.08.27.12.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 12:22:02 -0700 (PDT)
Date:   Thu, 27 Aug 2020 12:20:29 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
Message-ID: <20200827192029.GA63138@Carlos-MBP>
References: <xmqq3647rjnt.fsf@gitster.c.googlers.com>
 <C580P9BS4VYA.15I6SHXQQ35HF@homura>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C580P9BS4VYA.15I6SHXQQ35HF@homura>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 27, 2020 at 03:14:57PM -0400, Drew DeVault wrote:
> Do you have sendemail.to set in your local git config?

I do and can't reproduce either; which version of git do you have this
problem with?

Carlo
