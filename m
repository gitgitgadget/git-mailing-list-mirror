Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2F4FA3740
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 18:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbiJ0SJ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 14:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236067AbiJ0SJy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 14:09:54 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373BFD2CA
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 11:09:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-367f94b9b16so20423587b3.11
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 11:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8cHAtG+6xWjZZdjOBw7b8+fWqtYpfaKmefCVMlxh6Wc=;
        b=I+aw46QDw9LbFzuGd0FcJOwnobat5nuKkahsr+nUzEau7qdRPUCzTPt7kXT9xL0hVk
         MJRjrF0EMiCr3i0YODeY1R8F8f1CRhYtLdLrv2XzSIXL6Ijvq9Jec+QUik7FPt6tFw/e
         dx4YCsRwWn8TfdCYrOLLjizvx5ZWheBuox0xbx8hewG1iH0UGMUDwC/ctv1nPf1Y/0eK
         IUa+Fw568qtXz970KCQObvkRo1aQhlG87i8JcZMZa20xdc2tceO4wspYBmL07a3RQ+92
         DBh7KCMdaTjMqPEQwAkpX72eHTw+6GZ9pmyeEi12kmARnlpeP5EV8VVzwLYM0XoFM+9L
         Pzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cHAtG+6xWjZZdjOBw7b8+fWqtYpfaKmefCVMlxh6Wc=;
        b=GmPLylkQ98LjUa27nKY/17PZDgAbD0aAkf1GhfDq15VwgjOkJL79oZMbD4/LE25D7e
         6YmypdaNFBLwBeNrx2bfxOqJc8R0mWNb3Iz0YFo9z+1hG+u7yFMcr+nMLSr0ZgXeQHor
         L7afdOBUjqm7erQopuHz6zH1qz3eeU/pwlmch1bwplSmiICrpw3fNMtw0UFe+eSqJFeh
         9kiur3THnc0uhqjHQQouylRj2KPSyOWkUyZpOjyMBBv8sA7SuUXtRaAPJBAPzlOjqJQq
         U1Sfmt6Tb8866WlwsP878AbyjuRkvkQqOtgPJInKxvB56qsKZjkK39eeFuEZtkqhEMDn
         82VA==
X-Gm-Message-State: ACrzQf0xVJUDuWJmDnJtEkzc+ThnEvUOTvPUNgGMlZs7K6PYT962bRnJ
        aye2J06mDM1Xp4q2VH2Plc8DSaMHQnYpjoU2JL9n
X-Google-Smtp-Source: AMsMyM7Gn1k8LcKWzy+JcVP/XHkuDSzAjEafCP7Scb153RzftZUAsPEVwnYu494q8ZD4QCTopZjwZ/p2JP0mMoEMYnAX
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:ca95:0:b0:6cb:ece2:6f5f with
 SMTP id a143-20020a25ca95000000b006cbece26f5fmr1841214ybg.230.1666894192403;
 Thu, 27 Oct 2022 11:09:52 -0700 (PDT)
Date:   Thu, 27 Oct 2022 11:09:49 -0700
In-Reply-To: <79959a54eb4c1a0812b1f4643530069a63e549f4.1665973401.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221027180949.1837457-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 1/9] tree: do not use the_repository for tree traversal methods.
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Alphadelta14 via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First of all, let me echo what Glen said [1], that this series is  
overall well laid out and makes sense. 

Other reviewers have commented on style issues, but I'll hold off on 
making my comments on those and also possible improvements on commit 
messages until I can say "besides style and commit messages, I think 
that this series is good to merge in". 

[1] https://lore.kernel.org/git/kl6lr0yuqlk0.fsf@chooglen-macbookpro.roam.corp.google.com/

"Alphadelta14 via GitGitGadget" <gitgitgadget@gmail.com> writes:
> +			// This current codepath isn't executed by any existing callbacks
> +			// so it wouldn't show up as an issue at this time.

I was a bit confused by this comment, so I looked at the surrounding  
code. I think it could be better rephrased as: 

  All existing callbacks at the time of writing cause this part of the  
  code to be skipped when S_ISGITLINK(entry.mode) is true, so this 
  wrong behavior does not call any issues. 
 
