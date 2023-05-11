Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE14C77B7F
	for <git@archiver.kernel.org>; Thu, 11 May 2023 17:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbjEKRYn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 13:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238787AbjEKRYl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 13:24:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD6F19B4
        for <git@vger.kernel.org>; Thu, 11 May 2023 10:24:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba2d0b391d3so11446696276.2
        for <git@vger.kernel.org>; Thu, 11 May 2023 10:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683825879; x=1686417879;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KbUqAM59s6Pn6E/ujkOLdpcHsIZPpOqV4ZU/11u6UVI=;
        b=Kqp7ZgFF11JpWEjQpbcUgrDW3+GLV8xpmbJDhjNI6pdIUtLRrHh6szHhmH6/rMVTts
         I8oW8juGhwHMAsrGe1vubUKdzBoxGfd365+CTlbnQcmGWgeoHO9su1FmgP6LNYxGDRrK
         qvjG+Id3s2VewFiq6KlcSHGAeRRuRRxcZoMRBLnbfAbMFT+Bs9uCyjDQ4805p9hAHd7H
         JUEOeV6aNfnk0OQwEqQnfHKU9EgM7dS078X0Im4VcTZwIYgPu8ZHWi7Pvu9z/7dvOtX8
         0832RX8f/BSe8CukF58fvyyL/t/wuW36Yg050ExUfXOKgYcp66QTXb2v48F9wRr69Shc
         5b/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683825879; x=1686417879;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbUqAM59s6Pn6E/ujkOLdpcHsIZPpOqV4ZU/11u6UVI=;
        b=PppXCYgDx2chgMkRRY2o60n2Q4oLi3fuU+7l/FjEAeeYHL/HlRzdzPJhFyc0TIBFKS
         nXrlrCaYY1OUZKvmvDCbte+yFuOGII7jcsGDfM9beTrOC3tQ6YBCRdubdrQNOmpaSz2X
         1YhFaGzsNx1wQ70NIgoMRoVGZ27DTGNi65wXyPhEY+CeycxWOE+OHg0IFBCQSiNt+KDt
         UsaLPrpAnbnDrme7s34YVcMj+2eCcem5J3QvPvoeaI/j2z71HvtrXTJKYUi7t31CfIij
         14Zh3WUFE+e5JfnGvtpa4YRkTlmN830bsrXAGoh2zsgYqO/oJG0qdqKWSjJhF+maT8tS
         zcrg==
X-Gm-Message-State: AC+VfDxJ8PZwDNloMxRadkoXMh8UrGpAGTXaUQ8f4gk6UhxrBYySu2Nj
        hWRozLe1Dbd0+UkEWIP0pcFsp2cDfdYzb/4=
X-Google-Smtp-Source: ACHHUZ5TgJdAzAQyVTgYJ4JJv4zOuedyXwz45vo42qBIlYHoAYSJB8osnyP+pqpnNYrxUsKt5piudN+F7q45gGc=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a25:6b11:0:b0:b9d:a7a1:cab8 with SMTP id
 g17-20020a256b11000000b00b9da7a1cab8mr13343560ybc.7.1683825879459; Thu, 11
 May 2023 10:24:39 -0700 (PDT)
Date:   Thu, 11 May 2023 17:24:36 +0000
In-Reply-To: <12a251f77f679123d01892109694f8ee19b96252.1683431151.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230511172436.935061-1-calvinwan@google.com>
Subject: Re: [PATCH 01/24] init-db: remove unnecessary global variable &
 document existing bug
From:   Calvin Wan <calvinwan@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Splitting this patch into two would make it easier to review and follow.
Regardless I think both changes make sense and thanks for documenting a
preexisting bug.
