Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC87AC4727C
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 19:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 782D420709
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 19:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aO0/TW5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgI3Toi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 15:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgI3Toi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 15:44:38 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8AAC061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 12:44:36 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id c13so3016124oiy.6
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 12:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1/xwR+EpuJU/3VyVfU9LkS5V49aaqEnrNTY5oDmmxHE=;
        b=aO0/TW5Agy7BjTKtHkYnQfVDQR73i+yDGXOv5kpdPQdV1obNHWA/T1eMwY6FvdnXp7
         Ax1aNIg8KGAWh9RJt3P3daeREZBooggFmav30/6t7nWqDHCDIUEzBd//0AJQzYEdc4H8
         NudDWSrVv2HNFlpW6B2YJPyEnfX9lTdvfSJ53TcmtZ61LkCbAAJPOoN4tIMd+thDXURt
         EshEbH4styHHo+rJxyxgvk9fYScPKg00+lry7IUfVpqhf1OgR8huCf8fAxYD/TkQeIFl
         KYbQQRmCseqpBHer0gxRDtxw+f6DtJ14M38RdUpXS/IUCfOi53KVCOXWi2kYgHCJbtpe
         2k7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1/xwR+EpuJU/3VyVfU9LkS5V49aaqEnrNTY5oDmmxHE=;
        b=IOUs22r0VS22ZZUBcyr87pqnCKHhhhg3pfCmvGzNB4M/mYfqwdGvrHgJ/51LhRhxnm
         Eba/Bg+ztwufSAwoCqQxvEhC09q8udmLpuc8lzTIw+y9mLLkP58abH9pOAq+VfQZuIAQ
         ql8s4bojTPzw3o6+YUZuCD/U+gKrEwuF5MZPlR5W6Liu8bVZfM/74R+puLVZfom+2nqe
         2c10X6GT+xlj8M7tBSdw03hUkfF5Ckyp6dPUF7Ej0Z+AeVsCPGKPNQgehDWB7duuu1tl
         GvqPlwZeLHagdg9VYVLH30J+m1DQszS4oJVXL2tK15FyeDY1w0tNVaROw2Lpu7NyqmEo
         eFpQ==
X-Gm-Message-State: AOAM530QJEMu7uo7TQF41Aq5hikW9eDPqE79rcOQeJJ/A0UVP+mN5yCm
        vREJzoCSBWYIjp7vGrAKSSvGuA==
X-Google-Smtp-Source: ABdhPJxGeTB/N9MeT0SgaNbjzU9nCJ5WMnZQyyil0OZdVoRtTRSmAXujiAh3riagqcb62ALOngnmvA==
X-Received: by 2002:a54:4806:: with SMTP id j6mr2214552oij.10.1601495075878;
        Wed, 30 Sep 2020 12:44:35 -0700 (PDT)
Received: from tbodt.attlocal.net ([2600:1700:7265:260:81ca:f55b:69b7:6648])
        by smtp.gmail.com with ESMTPSA id c14sm698892ooi.9.2020.09.30.12.44.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Sep 2020 12:44:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Propagate --quiet on submodule update to merge/rebase
From:   Theodore Dubois <tbodt@google.com>
In-Reply-To: <xmqqft6zgjaj.fsf@gitster.c.googlers.com>
Date:   Wed, 30 Sep 2020 12:44:34 -0700
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F2F35572-E88F-4D6F-844B-6E17FCFD2175@google.com>
References: <20200930074729.99629-1-tbodt@google.com>
 <xmqqft6zgjaj.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This is not the problem this patch introduces, but the way GIT_QUIET
> variable is set up does not allow us to do the above so nicely, I
> suspect.  Wouldn't the above change make "git submodule update -v"
> invoke the underlying commands with "--quiet" option?

Interesting. I didn't check every setting of GIT_QUIET, just looked at =
the first few and assumed the rest would be the same. The "git =
submodule--helper update-clone" invocation also has this problem. I'll =
resend with "unset GIT_QUIET".=
