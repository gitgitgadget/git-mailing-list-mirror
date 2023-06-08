Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83A9C7EE29
	for <git@archiver.kernel.org>; Thu,  8 Jun 2023 16:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjFHQZd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jun 2023 12:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjFHQZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2023 12:25:28 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B262D75
        for <git@vger.kernel.org>; Thu,  8 Jun 2023 09:25:19 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-561b7729a12so28333897b3.1
        for <git@vger.kernel.org>; Thu, 08 Jun 2023 09:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686241519; x=1688833519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uvbmveP+fQe9ugGoK/QmI/fz3wbNC7UZfpyYR+sfK9o=;
        b=RFgjD2iHsuzmQA/Bkvy+svsvXaDLRjp3agFjW5Iz75IMNNZre9qsb7gbhjhf/tQe5h
         iMCdEGqO3YZTco6DWFTDE/yb0rmxEppvn2a1OYlTGZLE2Ca1Hr0SibRP6k7CxheSEsbC
         j+G8S8pKBDoYlcmHpIRFo3NqlIz564AC1iJCQsgcrzkdYt6+BQuuG9HOYa74O0x1s9cO
         zi7wagGY9g3goPq5YFnUCzZjyTzb15TIeOOKmi8CyAidqf2eW3VtQPb36EUCoF4RAc7n
         CkZw4kE3LHlW0GPdW8XbO5BmTV4m+itbonozs2dWOAfGB5k6yEaW2b+A23W+34cP+3hZ
         vtzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686241519; x=1688833519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvbmveP+fQe9ugGoK/QmI/fz3wbNC7UZfpyYR+sfK9o=;
        b=mFBrm8bZN1Dz8JeyaWBMk8s3Za57/BfmpsfRVm6CSEqKWEHQsVYYR3giCjPFhscBpP
         075MH/lHCApVReG/H8/QcABJRekFK8sXkmPJxdhTddKoIdAVc175u33vHCEZiS7IFxLA
         EpZRFoG/TC2fRll10KjnJ4qL/4gLcsdZKVTUqN6d1pLjkxozFQhscClEgc9mNaDQZtHe
         4mHcRss/+KXvVdj1SQLfKPylK3tmKK4AVcKwSz86SiGgcn3JJx0Q0hcLmSxWVtQPI1gf
         oPvyA3pIKtl5onzn+kAB9S8Z7rhoPFLjwVM8kVEXQSS+Y+PqtqEfQy5vIjNFHQwurg/K
         IlQA==
X-Gm-Message-State: AC+VfDx+nDJL2h6suUOKm1UyGiROdgEhk7usRXCX4tYwcDMpMREn1+QO
        rkh5plVPI9ZhbjPgL+0xEYDmAPe0I1bESIGUyKPJTieh
X-Google-Smtp-Source: ACHHUZ6RwT94hK+8VWWmzfQOagWXFvP5dABG8tm9ZN90zKYcngyPgDui+cfHXgyoPYZ7L378ddDvHw==
X-Received: by 2002:a81:a08c:0:b0:569:ef9b:eda with SMTP id x134-20020a81a08c000000b00569ef9b0edamr247265ywg.10.1686241518902;
        Thu, 08 Jun 2023 09:25:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p68-20020a0dcd47000000b0055a382ae26fsm18680ywd.49.2023.06.08.09.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:25:18 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:25:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 0/3] pack-bitmap: boundary-based bitmap traversal
Message-ID: <cover.1686231639.git.me@ttaylorr.com>
References: <cover.1682380788.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1682380788.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is another copy of the reroll I sent a few weeks ago[1] of the
boundary-based bitmap traversal topic.

It is identical to the previous version, except rebased onto the current
tip of 'master', which thankfully produced no conflicts.

My plan remains to drop the conditional after a version or two, and
hopefully having this be in 'master'/'next' sooner rather than later
will help us build additional confidence with folks who use those
branches as the base for their daily driver.

Thanks in advance for your review.

[1]: https://lore.kernel.org/git/cover.1683567065.git.me@ttaylorr.com/

Taylor Blau (3):
  object: add object_array initializer helper function
  pack-bitmap.c: extract `fill_in_bitmap()`
  pack-bitmap.c: use commit boundary during bitmap traversal

 Documentation/config/feature.txt |   3 +
 Documentation/config/pack.txt    |  17 +++
 ci/run-build-and-tests.sh        |   1 +
 object.c                         |   6 +
 object.h                         |   2 +
 pack-bitmap.c                    | 241 ++++++++++++++++++++++++++-----
 pack-bitmap.h                    |   4 +
 repo-settings.c                  |   7 +-
 repository.h                     |   1 +
 t/README                         |   4 +
 t/t5310-pack-bitmaps.sh          |  38 +++++
 11 files changed, 284 insertions(+), 40 deletions(-)

Range-diff against v3:
1:  c31508ac4a = 1:  1fff820874 object: add object_array initializer helper function
2:  e7b30490da = 2:  fa67382e21 pack-bitmap.c: extract `fill_in_bitmap()`
3:  8a8f41e0c4 = 3:  b80d17c938 pack-bitmap.c: use commit boundary during bitmap traversal
-- 
2.41.0.3.gb80d17c938
