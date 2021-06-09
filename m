Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17CBC47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 04:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D56F861289
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 04:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbhFIEev (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 00:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhFIEeu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 00:34:50 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C029C061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 21:32:41 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id i16-20020a0cf4900000b029022023514900so12774726qvm.11
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 21:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i9IRpsh/D4RM17qVVU5lfQx5gPps0jts74Lg5um8smQ=;
        b=H1kgfdUfBG9eQqjpLm1HaUkg7Z7a1aDv7w22kli8bEe9URdcd0UxCzlGL8mo2xJJDw
         MoT8/BeQCTqB3FpqYMMj4z5h0ifnsVLHxzMpKhYdoP4GKlKdZg+XMyhpmNPEaO+BxWd6
         0ZClfejYCqg7hcKPrW1Ap7xbh6yIPoWuFmmEFyd1oqHZ0sr9UhBzr/dWBNfW9Jm5bn+R
         6iB2Ej3z+l8WgfuWaZd0jeHB60gbWtrjseQ4Cj3fTd0yhiLKbUQUsCBl9tuntreJK57s
         23/cTF9/LZDDcb7U83leZpZsmR5ACqdXrA9xEqxeIrrqyIMAhzz9yghG+R9/sYEoHCx5
         15zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i9IRpsh/D4RM17qVVU5lfQx5gPps0jts74Lg5um8smQ=;
        b=PUr3VuHSa16p7tQ9EYWWdnijfKKsvcTTOd0g4lOMPMIleag5gLlvPmrQbgouomkPkQ
         fBw5nq7Yl1g10P9MJDa2he/oR7YuGmAuSAsb/CrbR7nEkchjeW5XRjZYsBCPKii12UQI
         PIAwqYZiYbmbhXFSrM9pDOHA9648V/oI+TGoJtqAtuE5V0rNYju9myGrE5jg8/lmBC9J
         AmiVspDYPVGSQaYXyniOdBd1mfwtW+LR2vj8aUV2MQBfNasJdApNpZA3QkufZbJ9dz2w
         KzsWVzaokOblREuoZMM/KYhdRunW9RzNMHUA2pc3aAgGpUel18k/IZu1s+e/qdKycGba
         S3AA==
X-Gm-Message-State: AOAM533UQfsDad0htuiRojKDyuGF2Uhli/LlFYtlO92BjzTWinC+B06y
        O4oe2lIR1+K1Dh5rJmfl9JqgfkT/RCNpbh5E/lgT
X-Google-Smtp-Source: ABdhPJy6hBLnEnJuB9+LIid0RfoNrVZG8ajEANcP8rRQeX9vm9U89aX7eQhXS6NxvKW4AJPXxtqwsFqc1CxoDRvTVoKA
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:2aa3:: with SMTP id
 js3mr3632381qvb.56.1623213160407; Tue, 08 Jun 2021 21:32:40 -0700 (PDT)
Date:   Tue,  8 Jun 2021 21:32:38 -0700
In-Reply-To: <xmqqo8chq9g8.fsf@gitster.g>
Message-Id: <20210609043238.2324303-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqo8chq9g8.fsf@gitster.g>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: Re: [PATCH v2 3/4] run-command: move envvar-resetting function
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, me@ttaylorr.com,
        newren@gmail.com, emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It does make sense to move this to run-command.c from submodule.c
> and the function name is already suitable for being global.  I
> however cannot help wondering if we should also pay attention to the
> GIT_CONFIG_KEY_$n and GIT_CONFIG_VALUE_$n pairs (which is not a new
> problem in this patch).

Note that I changed the function name (the previous one was too
submodule-specific). As for the config pairs, they are currently being
passed through - do you have a situation in mind in which they should
not be passed through?

> This helper may sit better next to prep_childenv(), instead of just
> saying "the location does not matter, just append randomly at the
> end", though.
> 
> Otherwise looking good.
> 
> Thanks.

Thanks - I'll move it.
