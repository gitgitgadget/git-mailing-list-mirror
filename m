Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6530CEB64D9
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 01:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjF1BhE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 21:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjF1BhB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 21:37:01 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F6BE4C
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 18:37:01 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b80dc56953so13190435ad.2
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 18:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687916220; x=1690508220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ipFETN0h0Yo0s5jtMcXNw+jWZoNbH5qTlRY4d1PIdbo=;
        b=3xa2tPMCxtTjchEHr/zPdflZ+5e1bl5XQjwh2rmEx4mX48UnQpgInUoWiyGkV8jlPB
         k+i7iegIwS+j4xfmDWoAu07rU97zdgL2qUkwFlH4w2E7cYdLOv7WPdnbot4NERoS8Pgp
         kH0MIq1bKxAarRpNYhRpsTPb70SKuhUz5/77j5ohLL06aSaUjmPNzXJxl1IQ5nfwYgO+
         KojGyy4/QYYyVAK2CGgsGlwt3v1dwkoYSoXER1RXpJcDoxofEfbrvzZqetnowLAMm7aO
         TkQwNMKGq7glzAWE9cB8nE7SQP8ChdGGb92WzOssoDzDVvU6ht4WmADs7E5G14YB5w4s
         YC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687916220; x=1690508220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ipFETN0h0Yo0s5jtMcXNw+jWZoNbH5qTlRY4d1PIdbo=;
        b=GFMCzDyJBcen3/WiFxeiGGYGg31nAXgSaJoV0P54lWK4zBIS/oO97mB7JwnIBarxaE
         CzC/CmKEwtcdXC7O5l1xY83BCri6rZi9b1YQ0Go+AT//PitJd80VW7N/Fb+nubNx23Sp
         X62aVQbdMOdL0O4VLMNxubuk723k97pmuW/31nY2fwklvHai8yRDZgaItNXBYX7QvRkO
         LLMfUBq1xPa7mbhxg8vLMNi6og+ZOdnX6HeddG/uG3DM0LnrbuNkF1km3rLapv4dy/0j
         sR3Q81TGKJI2ZQPR/mJmlQHvUnrZ9KMUCnRKKSVplVft0ENlFxx+DHThE58XwgBYYYmD
         dQRg==
X-Gm-Message-State: AC+VfDwIZ06hg+FhUGS0LSbtAMKo48vxR2cXHqFRNDDJd59DZ4orXqUB
        sDpOY3iTbu2uiLc8jjLYJO75g6k1ekfOmw==
X-Google-Smtp-Source: ACHHUZ4aHdZRTIV2A7q6o+KGKo9QKFM9nMTbwiKAAaEPnfeNMHbHH9IZoFjyOg5ssqq5mpNTaymH/hlrvuzgSA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:f984:b0:1b8:8c7:31e6 with SMTP id
 ky4-20020a170902f98400b001b808c731e6mr535609plb.1.1687916220494; Tue, 27 Jun
 2023 18:37:00 -0700 (PDT)
Date:   Tue, 27 Jun 2023 18:36:58 -0700
In-Reply-To: <xmqqo7l0e5x3.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1538.git.git.1687910254473.gitgitgadget@gmail.com> <xmqqo7l0e5x3.fsf@gitster.g>
Message-ID: <kl6lsfacqsed.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH] submodule: show inconsistent .gitmodules precedence
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The last-one-wins sounds like a natural outcome for reusing the
> config reading machinery, and the first-one-wins sounds like a total
> confusion, but we probably should fail any operation before the user
> fixes the .gitmodules by removing all but one path for each
> submodule.

An informal poll amongst Googlers suggests that my team mostly agrees:
last-one-wins makes more sense than first-one-wins, but erroring out is
the most sensible thing to do.

I'm not sure how reasonable it is to just fail. It makes sense if we
were only reading .gitmodules from the working tree (the user can fix
that), but we also read .gitmodules from commits, and I don't see (yet)
how a user could reasonably recover from that.
