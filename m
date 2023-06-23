Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA38EB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 15:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjFWPaM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 11:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjFWP34 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 11:29:56 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C043919B
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 08:29:55 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f8666b9e81so176267e87.0
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 08:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687534193; x=1690126193;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vnsrFCDf8AnIvC2LlrYcfA5SP3pIp6QurFq7+nyy92o=;
        b=AMtpZLhWfFDRZFCXWglLLcg7sQJFE2/YDJ02bD5HkixMw95c1iSI2H6pQbr5dU5SDi
         xmSvCdDNCPnJB+ZJl0Qsax9qmsLD6JoMOXGB1mRkA8P+vemOS+rIK+AIxItClKU+Gm92
         P0ExcRqu4EtHaMqSaMfg0gPLBAqVHj4SDJr9KjDtQGNb2uMUWAvZDmmgcSaL1Ew5XMvP
         rzG7ubdO0a9mJh5P6NuuU3Fqp2eQvXnbSsGPK149N8xicDk8ElrK+KHL+sWW+2J1lYpU
         spsxfZHCyfZY+AKNqo24ldWN53QKPfBW/7MkDVIXJRWAdU1q5dfNGVXBpB+jkjqiC2PR
         9FNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687534193; x=1690126193;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnsrFCDf8AnIvC2LlrYcfA5SP3pIp6QurFq7+nyy92o=;
        b=NI8R/qjTZmGFuzMY9KpWaH58KONyxeC3Jymlf3KKski2p8GKVgDDtIG+lNkvAFmIUz
         iT0EBBiT7dcQhZe+IcPeEzNyOWNPyejg7A2FjcNoG3plSbzeBoKANNAzIFbzISbA/paS
         PGTtCZFLZShEpUkZfYmYNZbwxfccD4xL2Vu4Pd4wmKQ6IKf//fWtJme4Xyk6lu3QZgW4
         /Hogj2oFdRrrDW0yBx/Y3TXGNmKG+2X58XFWyrSvJjJSpH3iMUmxWzWSXRCa+JuX07lI
         +m5SSFtgy8LkAm1tVvKA5uF20pcivOzQZDyKs1ro9yq+iTaDE3aAgH3lN/XrKIRF6uuC
         pwqQ==
X-Gm-Message-State: AC+VfDzYdb4SsudlErTZgMhwR44c6cgZ0wci/eC6RExnACVClk2cyaJJ
        0EicnnGq3W/EilR2CqkV2HfN3bG2ICoMh3xvERou7U8B62w=
X-Google-Smtp-Source: ACHHUZ6klJB8gRjpzuKfU9d0AJEnYsaXbZlrvux0Hd/NfwbEoSlwfWPME09sayWkV/AYbMMn3LIivo7rMYc86tOzNs4=
X-Received: by 2002:ac2:47e5:0:b0:4f9:6e0e:625d with SMTP id
 b5-20020ac247e5000000b004f96e0e625dmr1398286lfp.3.1687534193473; Fri, 23 Jun
 2023 08:29:53 -0700 (PDT)
MIME-Version: 1.0
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Fri, 23 Jun 2023 17:29:42 +0200
Message-ID: <CAHGBnuOR+MU50jhNBHw8buWS_Yr9D92mErvgoi=cK16a=4_YUA@mail.gmail.com>
Subject: Clean up stale .gitignore and .gitattribute patterns
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

is there a command to easily check patterns in .gitignore and
.gitattributes to still match something? I'd like to remove / correct
patterns that don't match anything anymore due to (re)moved files.

-- 
Sebastian Schuberth
