Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4F0C433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 09:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0891206A4
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 09:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="cYSx4iiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgFHJdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 05:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729163AbgFHJde (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 05:33:34 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBB8C08C5C3
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 02:33:33 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a127so8275190pfa.12
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 02:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=prR0xTSBQYTIQ/IoDMUwH1geAfgxVbEgNY/YLlCgSFM=;
        b=cYSx4iiVQMFn5cG8yu5FieAWd+gsEWKRmDn3ePg8HU7NWFD5c/IvmR3dlrz9wMvHL5
         DA74gt9NGuc7dHMLg+PndmDH+HqPynxuQWhfolB8QehCs/mnKS8oaysskakFEwJ1or1o
         419chWrawPeT1y4da6rLlJ1/lNweASDPYLOLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=prR0xTSBQYTIQ/IoDMUwH1geAfgxVbEgNY/YLlCgSFM=;
        b=owictJPJqtlyvdnz7d0Q0sFd8Hdi9LI5o8ssi3OkFt1xKkqK5NaSiCZ1OKxihx9nLb
         arruxG5KIiG/8d7uA3yBubmmvs8B8FxhgPV8vWNSgJ7/ewewROfg5r04XBfwRmFoFL3f
         x3g5iInHEjFm8NH7iVmE0k2EphEQLd+ch/35v7od0TVpuFrHFUruVy15Z4IMzPogR5kv
         rHc832QhgdgYeDL6/EX7TyXD+AvUB+O05KN70OUkCVCR+afNUA+JBkdL56rWohNgubkK
         hlxhyk5VXq4YJIVNf4IgpOI1SVIJRy7UGBjQiL2epB58LHo9H7wXmhq8urrj1PA3QbYc
         dQOQ==
X-Gm-Message-State: AOAM531K2q5s+dF3+OLh1jvodARJ6RK8EJDRXqRVJxK2Wvfq2+pg/ujQ
        SxQrkAXLP/dyWngQiZhSr7A2UhMNDXLzFwM01Uk9R4zTAL1u/ls/CIwL5rUMkOjBvMhmdapFxk7
        jKsmvj2/ANRLHrJj+69zrfAe0SCZ04MkJDzUZJUoff9rWN54zKGnm5z9d03EH
X-Google-Smtp-Source: ABdhPJzLzRltWJvsg9zGVWGuZzGKwDuJO2mMbzBdayiXzB5Urcj6g1qA9XgnYqR+/Iz4BkvP79QAEQ==
X-Received: by 2002:a62:1c42:: with SMTP id c63mr20294833pfc.293.1591608812803;
        Mon, 08 Jun 2020 02:33:32 -0700 (PDT)
Received: from DESKTOPLINSUN ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id d4sm15076479pjm.55.2020.06.08.02.33.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 02:33:32 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     <gitgitgadget@gmail.com>, <gitster@pobox.com>,
        <pull.781.git.git.1588901124066.gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>, <sunlin7@yahoo.com>
References: <05c001d63d77$8f6a76d0$ae3f6470$@zoom.us>
In-Reply-To: <05c001d63d77$8f6a76d0$ae3f6470$@zoom.us>
Subject: RE: [PATCH] Enable auto-merge for meld to follow the vim-diff beharior
Date:   Mon, 8 Jun 2020 17:33:27 +0800
Message-ID: <05c201d63d77$df7ea5b0$9e7bf110$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGgEXnIspvwM1+JRKv+oNgSDonxlak6zJ/A
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

https://lore.kernel.org/git/pull.781.git.git.1588901124066.gitgitgadget@g=
mail.com/

