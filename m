Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C474CC2D0A3
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 11:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6023B20782
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 11:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lImo81lM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgJ2Lxj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 07:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgJ2Lxj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 07:53:39 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B91C0613CF
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 04:53:39 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id 7so3461534ejm.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 04:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yFzW2LhiXmt0kE6M3I46raNMM3Hja8FKay91EL0Gxkk=;
        b=lImo81lMRGVbg9Om+PWdjqXB8aCnwyk71I0zDCXX8g3TPpilAE42kDy85LhNsJjbs5
         +DLOfNgh4PMMD1YXed5sjPSbinLDDCctCzJtQGAh0ttFRdgfzMHrltBdq0LLYLfWGIsz
         g8+HP3zD6cGdF/ZtHXGgpX/G3gp8RV+Mu/7vIvnjo3/UIm4Pm9v7LqRvF25/pKMXJE9h
         JdOqPbgYFxyV9LOdIUg3VaxeX8iOw/wJ1u0ZM8xBgJyxArLazfcHEBSLmMzWNtPkW/YB
         AhCTC8IvRM+EQoqZX10rJwTvm/lwsUC9NTAfpDwukkCplS9VBQifRULjPnoNDpuztSqD
         0Jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yFzW2LhiXmt0kE6M3I46raNMM3Hja8FKay91EL0Gxkk=;
        b=M82Bc0qzC24U3yPDjOYAtHkdc0s2D7Fyxanxx5gl+cRVAsm6XaQtrjvWzikKgIavaN
         /SKw9Japy3ycP774xUzvGNyY3vZIBgQ4qgZr/VLVw/PsID7nYV0WEqa+7SFfXOI5xpQX
         NYa8GjESGokNA+4BuyQs9cmWWDVl57KKi6T1Va1dTvU5X+Z0kTuPx7SwmgEvVZT3JcPF
         wGZ5OifXVp/sVwY5mbEQpupaxTuOOQNoLQIhuEmAu1y2sGaj29sUOX1BPOEu962hg6gd
         Pu4ONYnHBi2puAECH9/n6OkTLu1PIVB1HT+L2Pjw2OISFdhxuy/QBnFXsLWGDGVAQVKh
         ocSQ==
X-Gm-Message-State: AOAM530FX3W4owC86Bgco7QXB+QnL9+N2IHYMxrxn8X8fOHBHoaBzNBC
        SsdV/HCyHAHhcrjRHIgidT0=
X-Google-Smtp-Source: ABdhPJxn98i1+XIfxB5EokUEk9TdYR93qYaCjjbdIMNyUgUvI8wfZfGsfEKb/f4bnY7wZ2KlINsfQA==
X-Received: by 2002:a17:906:19c8:: with SMTP id h8mr3833463ejd.318.1603972417751;
        Thu, 29 Oct 2020 04:53:37 -0700 (PDT)
Received: from partizan.lan ([46.98.122.18])
        by smtp.gmail.com with ESMTPSA id p20sm1337493ejd.78.2020.10.29.04.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 04:53:37 -0700 (PDT)
From:   Serg Tereshchenko <serg.partizan@gmail.com>
To:     serg.partizan@gmail.com
Cc:     git@vger.kernel.org, marcnarc@xiplink.com
Subject: RE: git-gui: Why are the main panels no longer white?
Date:   Thu, 29 Oct 2020 13:53:34 +0200
Message-Id: <20201029115334.41295-1-serg.partizan@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201029114400.38284-1-serg.partizan@gmail.com>
References: <20201029114400.38284-1-serg.partizan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To get current theme, run `wish`

ttk::style theme use

--
Regards,
Serg Tereshchenko
