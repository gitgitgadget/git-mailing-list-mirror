Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511A4EB64DA
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 07:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241378AbjFNHGz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 03:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbjFNHGx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 03:06:53 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399E619B1
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 00:06:52 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b2b7ca1c5eso4510319a34.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 00:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686726411; x=1689318411;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=XCMvbZ+nygxaPCkCynzOrILzubNqTH2Nhnpk32aPby4=;
        b=YYM9zqa3E6kJoXV8IEBTyz/jPvNsPdvy81MA2+H0ll57EP5DBpYe+c3fNWRTI52LyQ
         DvgBJyh/yRH6pCdn8qa3D5jvKYJXBSTeM/IyuKz8KVCREs55mpPEd5YC2dSi4xERZ0K2
         KC7L4UhR94SqBI3bHGPEwq3qTithYyHJkH7PfYt5Bl0E98CKooye2mko17qncKwTbByX
         WNfx6k/EScxCsRFNn2NsKOtN9AsalbL8lPPVBoHVV5JE67n/bNfBie4c5+BKGV7o+OQE
         fK4fU3l9oINJZxiS7VLF70IpIxP2Wtqakb49adiSfmfGg+C3WUx8OvAPw5wVDCMmFHeh
         tZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686726411; x=1689318411;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCMvbZ+nygxaPCkCynzOrILzubNqTH2Nhnpk32aPby4=;
        b=P8MEn7JXREinN3HTEfAZKg0ou1E6aNxGXhSBLxwApRot21jEKZDiZG0+PEX76OPX0W
         WmSNIlTLdI0oclcjVbpgBeAct31jBvcyrf0yEC0G1BVTCsHlTC1tQmDTCIfCSQJW2fmJ
         9RmxqpI1JpRYo1XqCRBHRAYp+LpX4ObNV1wKxLlmhBU6UorHl0s5jwx2AVS3k0NYriQJ
         QnXb2E8jYqytZYg/WomO6Nk8o6d5cau1Y1KLaLiVP+PtTBZK86KdA5pLwNIjOw2URr5I
         /tR3nJ1vCEZ+A+DJn6EhBu7ilW1osht4FYVjQW1w5w1mDHZpXJmL/b6EGKjmTWJkCNA9
         vIPw==
X-Gm-Message-State: AC+VfDwwDVGxGAW74h5a9WQiS1TDIzv0nwhNaWnNYkF97/lONRW9ohfq
        Cb/mCep2zXRx7a1pHcJQ/d4=
X-Google-Smtp-Source: ACHHUZ4ADyxBYeAXt5hdexzpNKi8ykPu3BFhse7cr0tQUVx+afMfBuhff76/Klwde+Tz/jky/95vMg==
X-Received: by 2002:a9d:7b56:0:b0:6b2:425:fa14 with SMTP id f22-20020a9d7b56000000b006b20425fa14mr10331269oto.9.1686726411323;
        Wed, 14 Jun 2023 00:06:51 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id z11-20020a6552cb000000b0053051d50a48sm9644120pgp.79.2023.06.14.00.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 00:06:50 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Josip Sokcevic <sokcevic@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff-lib: honor override_submodule_config flag bit
References: <20230614041626.2979067-2-sokcevic@google.com>
Date:   Wed, 14 Jun 2023 00:06:50 -0700
Message-ID: <xmqqedmezfn9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josip Sokcevic <sokcevic@google.com> writes:

> When `diff.ignoreSubmodules = all` is set and a submodule commit is
> manually staged, `git-commit` should accept it.

What does "it" refer to in this sentence?  Does "accept"ing mean
"Even if the configuration tells us to ignore all submodules, the
command should record the commit with updated submodule"?  Or does
it mean "as the configuration tells us to ignore all submodules, the
command should honor that wish and the command should record the
commit with the same commit at the submodule path as the parent
commit, ignoring the manual addition"?  The sentence needs to be
rewritten to clarify so that readers won't have to ask the above
question.

Everything else I wrote in my draft review I notice was adequately
covered by Eric's review, so I've removed them from this message.

Thanks.
