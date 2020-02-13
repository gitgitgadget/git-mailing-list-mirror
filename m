Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA8DC3B189
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 16:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73B924650
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 16:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6SPYyh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgBMQi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:38:27 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37317 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgBMQi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 11:38:26 -0500
Received: by mail-pj1-f67.google.com with SMTP id m13so2650822pjb.2
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 08:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6I06vU+2kw8fhjypwqyqBpdHpDfy+SSwNMkSz5o44FE=;
        b=c6SPYyh7OjQ4BKIXyGOLyCfL1MLEcz+8f+VYGdV/a3SyZFNZuE/7tbfGBHEOHZ53VR
         g3FvvJ/AgfctXMJtODJ/UGwWzd/nuEQsOzb3dKMOd7QXWybFeLI2pLrmTm95cKSDPkcj
         wQeg0a0gbue+UtyQbyThEolve+BXoT1LdXY03LDqPsEAY6FW4R5oq/LX/B42BYGSXM0P
         qpGH2gZOpEn1Bt7bMjbWmXCP/OqCfzn90py9Eltln+sIT4YdS9hYjDROqz5H0BpZHezM
         36gaQeN8Vt+E31BQNffYS0o3KcMzVT6tNQsZ9e/riAdh6VMKJnp6rBuVwDokFcg6rZYA
         k1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6I06vU+2kw8fhjypwqyqBpdHpDfy+SSwNMkSz5o44FE=;
        b=E1B4EtfsrzRKrzVGVCrCdoQHO1itLtdoeP4eBzDsisEvTZVHKAg6TR2/+5RD8izWx7
         lzzY4RwW3//3Qi+5SeYBbiNp5NGjcGq4MiJInvYRcFsLETWzmklNcYFGE/SWHgyUVGJJ
         D9CUyvlfxsARHp4qQRFv8m2Oqm79GWtBfcDgyb8i7A5lBxqQwMmPx8DuORW/64hkfJzk
         Q7Qb9uthAYvHu9u7ViCShAuFCama8gTxn0lNoRyQNiOc0fIQ8QRwwqAi/Vbe6ilUqTHg
         +rZR4A6fj1ZXGw0p9FC1iN1ipkz5QbLsPAV3aAmMpo3lo14EveTdCu+dl/yL655RaLJx
         VFWg==
X-Gm-Message-State: APjAAAX2mR39OPJjzE+5GHVDv2Yaij1HhfnzI6pTZeQvA0HDHHJ2dOys
        BXNJsLF9Zv+nMk/2oHG3QdsIELRL0Fcn1g==
X-Google-Smtp-Source: APXvYqxlN9wXkjxSJI5sy/a5/ZWzknyXaH0SyPDWKHPR+vPSzpjLdc8bB1zUb6WomHfQQunysN3rVA==
X-Received: by 2002:a17:90a:c301:: with SMTP id g1mr6034168pjt.88.1581611904662;
        Thu, 13 Feb 2020 08:38:24 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.172])
        by smtp.gmail.com with ESMTPSA id d14sm3396734pjz.12.2020.02.13.08.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 08:38:23 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     johannes.schindelin@gmx.de
Cc:     chriscool@tuxfamily.org, git@vger.kernel.org, gitster@pobox.com,
        peff@peff.net
Subject: Re: [PATCH 1/1][RFC][GSoC] submodule: using 'is_writing_gitmodules_ok()' for a stricter check
Date:   Thu, 13 Feb 2020 22:08:19 +0530
Message-Id: <20200213163819.6495-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <nycvar.QRO.7.76.6.2002131435301.46@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2002131435301.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

I understand your point of view here. What I am trying to say is that we must update
our .gitmodules if atleast the function 'is_writing_gitmodules_ok()' passes.

Before, we used to pass the if condition if our .gitmomdules existed and it did not matter
if there were any traces of it in the index.

> But we're in the function called `update_path_in_gitmodules()` which
> suggests that we're working on an existing, valid `.gitmodules`.

But we still originally(before my patch) checked for the existence of .gitmodules right?
The functions exits with error in case of absence of the file(which should happen).

> So I do not think that we can proceed if `.gitmodules` is absent from
> disk, even if in case that it is _also_ absent from the index and from the
> current branch.

Yes that is one case, but the other case is that _if_ the file exists, it **should** not
exist in the index or our current branch(which must be necessary to ensure before making
any updates to the file right?). This is the case which was not covered before but I have
tried to cover it in my patch.

Is this explanation correct?

Regards,
Shourya Shukla
