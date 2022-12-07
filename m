Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A56C63703
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 23:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiLGXEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 18:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiLGXEs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 18:04:48 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A592417894
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 15:04:47 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id p24so18497016plw.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 15:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BbXO71NA+CoXy9I9QnZsOkZIf9LjB0VWxERoII1qOU=;
        b=OehyLIRx+QJ+xxZ2mBMe9PWMs9UmaWFwVNxSk2Vb2LZwwjx1dJZubdLJNJOoyO3gnZ
         C8Ig0G4K3pKOjo2B1pmScY5uw05O2a5akuv4IEpN14rXbr/9CVJCeSuN8u2oj/O5weNG
         OFKpvSGhM41p8WnI23BhIlekl057GFrnQpA1rYkZkownhrvLYFH0jP5aPDGhMlsGG0Rp
         oLoEN/bxz8p4w/JyMMa9WNao8hdSIFDXf5+La4x/UJwtU0mNtqNziE/ey4gJrPlOkQSJ
         Ydgj+SfzrgOz/8gl/bbB8nxhhs84rUiAoBT76qbAzLNq4dAs0J5Jr+1TQuYGSqvWaJRw
         fEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8BbXO71NA+CoXy9I9QnZsOkZIf9LjB0VWxERoII1qOU=;
        b=XJOvu+EEYm7p8MtHLzYLLs+GjXQyzS4L/lQ4VD6GWgTCV6sj4V/mEsqZXZAcBPH3RH
         iv478VeZWl30p4i5WDcA+JYC/ULYqsWuNu62bZw/mTQnFPWvNz6bM90Y5RiPAn5SAwmY
         ogOrDaevX4uf1wcHqu9UFCCbJ0VEjLxhfXSdIVafoNMvzNPxRORW64PFgBpkJRBz5fii
         QQ4ZXZDsvESxrxDxkp4J9KJjM0xWtz9gE1x3D/JU0MG6hU0dFh/KIWNtiRREfxWSRo2c
         RWTmwhKW/9qvC1bULLNlN7DiuCh6fyxxRjZhDn49cXfkifPMlYZyIdF3hueeRPBtrLZ3
         b3lA==
X-Gm-Message-State: ANoB5pkdw0CQ3YxHUhWOkUxhnHdoNkOJIltuyAXuPWr2jYrcTZ3uKV0y
        0jVayWPAM0GRIWL/kasHXG0=
X-Google-Smtp-Source: AA0mqf6xARXG04rVFxDMctpswRv4C9HEIH44eMkowuAZwyg05+fpRWZ98iQBMso5qck5qZ0n2WAm5g==
X-Received: by 2002:a17:902:a617:b0:185:441e:223a with SMTP id u23-20020a170902a61700b00185441e223amr881062plq.53.1670454286961;
        Wed, 07 Dec 2022 15:04:46 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902f38d00b001868bf6a7b8sm15065644ple.146.2022.12.07.15.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 15:04:46 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     David Caro <dcaro@wikimedia.org>, git@vger.kernel.org
Subject: Re: Skipping adding Signed-off-by even if it's not the last on git
 commit
References: <20221206170646.6lnpr6h7oprziy5b@vulcanus>
        <Y4/xSObs9QXvE+xR@nand.local> <xmqqlenj7t0b.fsf@gitster.g>
        <20221207084027.7dhyaatkzaawrg4g@vulcanus>
        <Y5EQCD4XCsN10HO+@nand.local>
Date:   Thu, 08 Dec 2022 08:04:46 +0900
In-Reply-To: <Y5EQCD4XCsN10HO+@nand.local> (Taylor Blau's message of "Wed, 7
        Dec 2022 17:13:28 -0500")
Message-ID: <xmqqtu266cj5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> > >     $ git commit --signoff[=[no-]dedup]
> ...
> Thanks, I look forward to seeing your work. It would be nice to
> standardize on this `--signoff[=[no-]dedup]` thing throughout all of the
> different commands that support it.

Also, if I am not mistaken, each of trailers can be configured to
have its own semantics (e.g. .where and .ifExists).

 * Should we have similar override to these trailer tokens, not just
   sign-off?

 * Should we offer not just [no-]dedup (which is equivalent to
   switching from addIfDifferentNeighbor to addIfDifferent) but
   other customization?  This affects what --signoff should be
   allowed to take for consistency across trailers.


