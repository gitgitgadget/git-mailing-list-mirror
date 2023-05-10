Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA90C77B7D
	for <git@archiver.kernel.org>; Wed, 10 May 2023 18:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbjEJSFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 14:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjEJSFW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 14:05:22 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CCB1BB
        for <git@vger.kernel.org>; Wed, 10 May 2023 11:05:20 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6435bbedb4fso8166524b3a.3
        for <git@vger.kernel.org>; Wed, 10 May 2023 11:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683741920; x=1686333920;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w1rPJ4eAecvynzNsrGRkimaOhdjCnoqLAJWn9ZdRraY=;
        b=B3848anKLxsmU8dXIWXFHnYs5uDpFLem51beBVYRN4oLUeIc7sbB2Utq4B4w34Kl5H
         QuqDaB1v9cgR+n/FwyRb/LTQS2ygSt52g1TdvqUjUKwTOMXzMXB1S6yIyuj8av7eeqKx
         SdU9NrGA8ejcmxo6GhrhUWDGkKhKAb7pVMd9289ZmDx7/FtGyteoFQ/iGCyNQMiuKWHr
         F/WOhAlvwk3ujUfv7lfKLOJK7iIVJfaQw8t+qNFudQQEHyphK8sBIAtCN8FZAg6k4zgs
         oYU9ADgKHrEwLGzJdiyde5C8VP2XCRtOwCoVzSNSd5bzYHWZunbO3F8QfngdIDfLfv4f
         oiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683741920; x=1686333920;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w1rPJ4eAecvynzNsrGRkimaOhdjCnoqLAJWn9ZdRraY=;
        b=YKelcHYAdr9z2fGcsyuxlEtDPFZN7jucoR3hlJ7X62S9v6vEWIyTV6JxhmEODgi/2W
         fjV0Pt3us/vxYfhxFsCFjsP6YBiYQzto+82SoKZfT4uva3uiJaB6d9jtfVi4IhZHpOnn
         +xSmmA5unFy7X5gu1xSNWp+qieQPJcCdBQShoo/wWfOU6do8vwI/9pQJNeQTZnZRZmE0
         4+xfJb7B6Jihe5lgccJvNy+R1z7Yww60aGQDauSlzgRwctx0Wf/zDV9kurRlXUnsXMWg
         9hO4RANXteW3dxQqVZy0OVIltc7BQ2DaarfjMO40XB+oxRNDb3BCddcpeiOtOcA8uDJ5
         Jmhw==
X-Gm-Message-State: AC+VfDxNFIX5mv8Cz2X7648uEOJYrsLBrKHv1fJhhxwM67v+R2RNqT/p
        n7qNkXbxxrSJ0pPGqMMF4SQ=
X-Google-Smtp-Source: ACHHUZ7FMsrYgIn7aSnKDqEsbtv3NxTa8tlL9COgDx/c3/bkApnHAO8/zRrDzY0f4IrQROOdOCQNNg==
X-Received: by 2002:a05:6a00:1a09:b0:63b:7119:64a9 with SMTP id g9-20020a056a001a0900b0063b711964a9mr23913925pfv.16.1683741920017;
        Wed, 10 May 2023 11:05:20 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id t23-20020a62ea17000000b0062cf75a9e6bsm3809459pfh.131.2023.05.10.11.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 11:05:19 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v5 0/9] fetch: introduce machine-parseable output
References: <cover.1681906948.git.ps@pks.im> <cover.1683721293.git.ps@pks.im>
Date:   Wed, 10 May 2023 11:05:19 -0700
In-Reply-To: <cover.1683721293.git.ps@pks.im> (Patrick Steinhardt's message of
        "Wed, 10 May 2023 14:33:58 +0200")
Message-ID: <xmqqwn1g3vvk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>     - Patch 3/9: Added a test to verify that `git fetch -c fetch.output`
>       without a value set fails as expected. Also dropped the tests that
>       checked whether stdout was empty.

Thank you for the attention to this small detail of valueless
configuration variable definition.

>     - Patch 4/9: Reformulated the commit message to treat the missing
>       left-hand side of displayed references as an inconsistency instead
>       of a bug. I've also added a testcase to verify that direct OID
>       fetches continue to work as expected.

Again, the direct OID fetch is a good thing to test here.  I noticed
that the test added here insists that the standard output stream is
empty when the command errors out, which is not consistent with [3/9]
above.

>     - Patch 5/9: New patch that makes calculation of the table width for
>       displayed reference updates self-contained in `refcol_width()`.
>       This is a preparatory refactoring that should make patch 6/9
>       easier to review.

It is an excellent idea to avoid calls to refcol_width() for each
ref that gets shown and make the helper responsible for computing
the required maxwidth.  The result indeed has become easier to
follow as you mentioned in your response to my review on the
previous round.

>     - Patch 7/9: Refactored the code to parse the "fetch.output" config
>       variable inside of `git_fetch_config()` before we parse command
>       line options. Also fixed that the commit message was still
>       referring to `--output-format=porcelain` instead of the new
>       `--porcelain` switch.

As a standalone step, it leaves an impression that the step makes
the way we handle the output-format configuration variable
inconsistent with the way we handle the other configuration
variables, but I think it is a good place to stop for the purpose of
this topic.  It lays a good foundation for future clean-up after the
dust settles from this topic---we may want to move global variables
assigned in the git_fetch_config() into the fetch_config structure.

>     - Patch 9/9: The `--porcelain` option is now a simple `OPT_BOOL()`
>       that can be negated. Added a test that `--no-porcelain` works as
>       expected.

OK, this time the familiar "prepare a variable to its default, let
config callback to overwrite it by reading configuration variables,
and then let the command line option override it" is used and the
result easy to follow.  I do not think .display_format is never
assigned DISPLAY_FORMAT_UNKNOWN with this change, so [6/9] could
lose the value from the enum, I think.  The defensive switch
statement that has BUG() to notice an erroneous caller that pass
values other than DISPLAY_FORMAT_{FULL,COMPACT} is still a good
idea.

Looking good.

Thanks.
