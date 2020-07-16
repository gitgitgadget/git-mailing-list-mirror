Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C715FC433DF
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 22:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9417320656
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 22:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594937431;
	bh=NHdi25TYm5KISOSA7BY3rb11/5s/eM8CJyhNA0gj9dw=;
	h=Date:From:To:Subject:List-ID:From;
	b=D+AfgJV39fpgdmdb6wctiS+qlhackFB1AGLdbTVit1zMqsdIF+OT8iLhZmG7TaUoG
	 vg+TrvFgE0NjAV4pIRK1ac4xgJty0XOSxEA1wZXETmEp78diZpHdkO0qG/HTO/FYQB
	 Rx4LPuye82GwTT2GwkqUmDagglpfje1ZinqDVXJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgGPWKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 18:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgGPWKa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 18:10:30 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09039C061755
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 15:10:30 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id c139so7067121qkg.12
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 15:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=uYyht/dGVQm+a4QlSzHxKVo7ZK+/8dTcEwb63PUCviM=;
        b=cImRp+mOzZKLMqBo6CkYc0xqtC36FMmmFAzYUiPuknyDDt179ZAxHMPGj7oq07DeQQ
         etvFLoBHTG4hq49UBHgumQ4cvzty0+dVlGsUhfLx52cl73XoDw85bD1MnT8M55ylLVP1
         um1cWK0oIrSRzxW2KfHeYxWr6bEU7GsGcVXtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition;
        bh=uYyht/dGVQm+a4QlSzHxKVo7ZK+/8dTcEwb63PUCviM=;
        b=E566TnkPbiA4NXjOaMCqFp4ZU52SFCMlQJtYt5Og8W9CbVUQhZgK4es6ZX5B1TOkSU
         YfkEEpLumltbLDxRe45daXud0/HbE80Q0E0rOO6HF04c1suOdmFAy4iqEyQLLPZv7hXL
         hThxFEG7AI/sVjZbhXfGAy4eV9i1O8CeOvV20XlOTSRjd+EFxdk/Fs7s/Nb5dHk3G8vg
         y0lH1C2C5sCNm02R6sR2FFLerTtW54S8NuSFqblOpAljSkNBaGjBtrDpUbtU5m1xG16g
         lb9MVfkfk72i4sHhXCytMx52y/d5XCWjrVbfOjCuWroLcHF3Ls/8DFbnPJSze8csl8oP
         akaQ==
X-Gm-Message-State: AOAM533Rf0z61X0Rae7sHT1ls9tJysN8l+2scklHAk654dotj6uz9m+O
        R1JIKtfEPWPjjshKsH+ajYmhIYQxXeLhlQ==
X-Google-Smtp-Source: ABdhPJyS+OAzkLpQVcEo36g/SuBNF13uuphwG1+DCNzOxanmrEm3Bfwep3cWRGpbLjHddm27zS6Ozw==
X-Received: by 2002:a37:9f82:: with SMTP id i124mr6150710qke.129.1594937428853;
        Thu, 16 Jul 2020 15:10:28 -0700 (PDT)
Received: from chatter.i7.local ([87.101.92.156])
        by smtp.gmail.com with ESMTPSA id o20sm9769484qtk.56.2020.07.16.15.10.28
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 15:10:28 -0700 (PDT)
Date:   Thu, 16 Jul 2020 18:10:26 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Subject: Compressing packed-refs
Message-ID: <20200716221026.dgduvxful32gkhwy@chatter.i7.local>
Mail-Followup-To: git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, all:

I know repos with too many refs is a corner-case for most people, but 
it's looming large in my world, so I'm wondering if it makes sense to 
compress the packed-refs file when "git pack-refs" is performed?

What would the implications be, other than minor performance degradation 
when reading it?

-K
