Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351AFC7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 21:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239938AbjDZVS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 17:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjDZVS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 17:18:28 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ED0AB
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 14:18:27 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b5ce4f069so9307303b3a.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 14:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682543907; x=1685135907;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMkkm02ze8DtPl+KzGk9UMBiXEKCaD4mmecQIvrt68Q=;
        b=De4qhbNNCFT103912xellCdckCEYQuSBTRXC9SSvtYW8FIAfJiXZ1heOsfNFSIMrTK
         Tw+AHkeFnfa4A502xu/tpcl2PckAcxbdKCR4rby24kEw4Epb8SzzVBNmHkesdZ0dXEef
         BFncAoct6qy7FZ1uWbStBOXmhXZzgOyCZpxQ7z2CZu8jHa8S+rubdbnP8bo2x5Kf3yIv
         pEPujzC71zZfkeMftvZsIZuy5IM5xriQyifmRjP9GLzHMbWEwh7uU6hVzyb9SMwdFR6w
         3x2Wi71qe7sdTDX4IV6k92Qp/fmeVbaejEV0c5Yzch9425jkQiCCqvtCfkszDhl7lbiY
         zLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682543907; x=1685135907;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fMkkm02ze8DtPl+KzGk9UMBiXEKCaD4mmecQIvrt68Q=;
        b=HGGfY3TLO+5XuJD1u5wMyeV6TmOJZvnq9a1vzTyeN/9Zar6ogfOZ9TAZU+ZLaSxU/a
         oz7xzLhdzvnMyNbfTE4f7/mDGmnoe/PSzpnt2BWrHue2wgak3D0RHGWfCfBdS8TQ8N2v
         hjcX8BijQKKNUH67sMeJUWDbEDvoV5QTtQYO8WJ9/TI2NJSam336lsjbO/ahvXamo7VI
         GO9a8pBiHBoqR2Oy5F+hrz5nZGpmeVFtRA7aZrWeuu05F2RWQp+mk4zzrUomH3smnkce
         XqXHmuD5FmQbOarcyGZARxarPRuM+i7UYLRHBrqRaIED8/f8hKZ5F7EMD7jDwNct4eP4
         WhpA==
X-Gm-Message-State: AC+VfDwHPQgscrjWZwQENKTVw2fFn/MDbWD9tH7qdYCUimfosL2xLm0T
        p5t+CkO5N+EynCu+VanKD2Q=
X-Google-Smtp-Source: ACHHUZ5xT6HboKoVjYjtwHB7ScymQVcnIEUYkftPAaliv0wXzU7QOxazUyN3mgONAiL0MML8kfsV/Q==
X-Received: by 2002:a05:6a20:8e11:b0:f7:fbd8:5951 with SMTP id y17-20020a056a208e1100b000f7fbd85951mr3792585pzj.49.1682543906967;
        Wed, 26 Apr 2023 14:18:26 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id d16-20020a630e10000000b005186e562db0sm10168155pgl.82.2023.04.26.14.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 14:18:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Adam Majer <adamm@zombino.com>
Subject: Re: [PATCH 2/2] Honor GIT_DEFAULT_HASH for empty clones without
 remote algo
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
        <20230426205324.326501-1-sandals@crustytoothpaste.net>
        <20230426205324.326501-3-sandals@crustytoothpaste.net>
Date:   Wed, 26 Apr 2023 14:18:26 -0700
In-Reply-To: <20230426205324.326501-3-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 26 Apr 2023 20:53:24 +0000")
Message-ID: <xmqqjzxyqr4t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> However, up until 8b214c2e9d ("clone: propagate object-format when
> cloning from void", 2023-04-05), we honored GIT_DEFAULT_HASH in this
> case, so let's continue to do that.

Let's not.  Once we identified the bug of mistakenly honoring a
wrong variable, let's fix it and keep it fixed.

The local optimization, if necessary, can be taught to peek the
source repository and propagating the object format selection to the
destination repository.
