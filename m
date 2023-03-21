Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64E7C6FD20
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 20:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjCUUrK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 16:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjCUUrH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 16:47:07 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75740567A6
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 13:46:48 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-544f7c176easo157603437b3.9
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 13:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679431607;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BOjr+A2sRSjJcC2qk0NPgdEEabkn+St763iEA3slXU8=;
        b=LBM02G2eYOdI+xLmxTmhQ4jQUAEdU2nwsJ6Mi43ZNHAzbpylaT4g3mzrNKMVtE4Sio
         TrVkiHhEUOrdxcbqGY4U9FiqHbHPM7JosxBnr80GBlKbpbfVlyzxRj5KhFSSM+S6e4c3
         s4Dvt1f7DOIkLkMfjm3QzgAhGNT7pfQX3syRtIOExAIJKAJQehrh+hsOPa03EI2AIdHv
         wm/DHQ5a90CHZjQR0D5xshuCWX5LE0uxCDaXGSZ3/9LxwkfL5ZPFLEF9zR+hDaqq1/64
         NVeoSTwK9r1S0R0iqHAoyXFHiA80PZCG4vm3PJ71/4SfEIRmdLqmwNGZ43gFXHx6gU2H
         uTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679431607;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BOjr+A2sRSjJcC2qk0NPgdEEabkn+St763iEA3slXU8=;
        b=isEym4hnsHwPTHbgCH8S80ED5pLHi/I99ubH77JdzIGnx+3yL5/Gnr8fPZTETxngYV
         gAvMPB8kzzn3RRx8lb1ODlLTpRhmH+bPmuGompSTKalbnX2BJRqJPdglNOQkA+TgqCyK
         nlbN0vgUr11KBkhM4U7++CrYAK9IPL/QAYvEFPBQqbg74PF+IDUmbN+sKcqp4xZk2Twd
         bIY/l744JYRE+B2b00GZRMds9pYxm1Dz8P817RwtytQ+Ssi5MJhVEoa1Rl2bS+aoQt7p
         ewVEwUcK5PBwx6iPpj6ep6irTC0KnhbDStfh23Z12A2VpenKcScXARgJqXm8SZ7w3ERy
         8RAQ==
X-Gm-Message-State: AAQBX9fn3RBKDCfArxfOyoUnWNX5L1y9/pmboOdTpLp+SeMwWJapwppt
        UTJ6aZ/kLAJq73jAaR7KzoqyfoFB3cdSRdBHnEShnbML8mI=
X-Google-Smtp-Source: AKy350bDp3j0egCTJSXUTgYwKllnliiOHzS5K1zMRaznLbAqWEhnK5KmOOH6kQjLhXUjRI1jOUqlrm9+WiPUvRBU48Q=
X-Received: by 2002:a81:a7c1:0:b0:545:5b2c:4bfb with SMTP id
 e184-20020a81a7c1000000b005455b2c4bfbmr1132801ywh.8.1679431607637; Tue, 21
 Mar 2023 13:46:47 -0700 (PDT)
MIME-Version: 1.0
From:   Ridil culous <reallyridilculous@gmail.com>
Date:   Tue, 21 Mar 2023 21:46:35 +0100
Message-ID: <CAEg4PiL+Y8yxCpWaQFUswTj1qegT084w9m0rc14Kf1dEWk5G-g@mail.gmail.com>
Subject: Feature Request: Allow to stash push and pop file modification times
 to avoid rebuilds
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

"git stash push"
later followed by
"git stash pop"
does restore files but doesn't restore file modification times.

It would be great if there would be an option to opt in for stashing
and restoring the file modification times because not restoring them
potentially triggers rebuilds for many IDEs (MSVC in my case) which
can be quite expensive for big projects.

Best regards
ridil
