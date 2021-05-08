Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,SUBJ_BUY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F3AC433ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 22:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F66B613C5
	for <git@archiver.kernel.org>; Sat,  8 May 2021 22:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhEHWnr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 18:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhEHWnp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 18:43:45 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0B2C061574
        for <git@vger.kernel.org>; Sat,  8 May 2021 15:42:42 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 76so12127772qkn.13
        for <git@vger.kernel.org>; Sat, 08 May 2021 15:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ampliffy-com.20150623.gappssmtp.com; s=20150623;
        h=date:to:from:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=jykGrU5P8idetVgKdzwIrjt7HfIbGzNbdFxsgbxNnx8=;
        b=FJok9idwYVREX6oOt4ObVQ8mXNi1x8uF8ze0HjExG6GE4T4938NZcAoYGWa9sr5lOg
         XdB3myqld2sBUg3m6PVB92UG8SngaJieG0SSOBNS8tNYnT+Py3tjPMeveRF4g2gadC9U
         8oTBZ4hW2QOnJ+3djJsRuMKY5KU7lQ5IdqD4SNSuBy2vY7ikKVFTqR4DbP2OhUdh83/B
         lPD0spXjLlQvmGhZ1XU9PmTJQOxy8Psj2aYKohzZXT8nb7OBSH/loK/uiRZqGX0OzLIk
         j9ZlpVubBx9zOaaCuCFrGzYrnlIaHt+vz971bvQu/i4bBt5gWly4D99EpqHJNy/gHKMn
         3qKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:to:from:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=jykGrU5P8idetVgKdzwIrjt7HfIbGzNbdFxsgbxNnx8=;
        b=p0aCwtO98OJXX8F8LQ4vJbt1Mqu89Ilt/zVw7s9PNWt4l5fE/pCHdX/h9Z3elwV5xl
         eYBC6lAjyFyqznCESxUf8V4zRASo676gLy/Hdk9njOadeF5u7MIbRxLsbcUVIyY3auem
         JpzVYpVQwrMjqif9/K8NF64BJv3MySlcjAid+xvqASu/xTEn+CxoOMwrHz+7TTMbggg8
         H5tIVHYD6zuwO4R8CADXgLLGhrfZ1cBaoeBhll5izueWRevfAmJfCQI1iPV6WnXKumvD
         hJP1OJI/mYZXJqvlLR83Rkzf1ezO+Dpn9ulph6klDAU6pZEgUwcELLltLgCXn7WWMTzS
         FVfA==
X-Gm-Message-State: AOAM532UETI66PgQD2B+P9O7anZVtiOaCxfYjfj5cIJLooshbdkBasHd
        Pw/TZSz+oMPflvmdROCTkSPMKTs3I1+BCA==
X-Google-Smtp-Source: ABdhPJyfIkpagPdB3Ou1EjwG6gdXny6FnLh42rNbjkksJuKXVAy0DZU0azTrMrmSY6u+OcJOasexzw==
X-Received: by 2002:a37:a8d4:: with SMTP id r203mr2424177qke.260.1620513761380;
        Sat, 08 May 2021 15:42:41 -0700 (PDT)
Received: from intranet.smilethink.com (ec2-18-207-127-202.compute-1.amazonaws.com. [18.207.127.202])
        by smtp.gmail.com with ESMTPSA id a19sm8503784qtn.97.2021.05.08.15.42.40
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 15:42:40 -0700 (PDT)
Date:   Sun, 9 May 2021 00:42:36 +0200
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Diana_Gonz=C3=A1lez_-_Ampliffy=2Ecom?= 
        <diana@ampliffy.com>
Subject: Buy In-Stream preroll video
Message-ID: <7130cbdf841bb5aacb54454239ac4a33@intranet.smilethink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello ,

How are you? I hope that very good!

I would be interested in buying preroll video advertising on your site.

Who should I talk to to explain how we work and explore a possible agreement?

Thank you very much for your help,

Diana González
Media Buyer
----------------------------------
Ampliffy
Access to a Young Audience
Barcelona - Madrid - San Francisco
----------------------------------
Email: diana@ampliffy.com
Mobile: +34.611.693.613
Skype: Dianagon90
Site: http://www.ampliffy.com
-----------------------------------

