Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E775C6FD1C
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 22:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjCTW5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 18:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjCTW5I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 18:57:08 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFAC2E81A
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 15:57:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54463468d06so136220967b3.7
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 15:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679353025;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QBRkEiSR9tcfhCOGkqRsAaw3tSepdN47KkEY0AN8v2E=;
        b=k41pOaD3yCsJCP80d4IR+Uj8GnCbal4fGIDNXXE2srawmOUxigs1NMxiiczb92f+Te
         i54kHU9xZttOy0teQwYTt4CLVbq9KFD9/dBJV10exbvWBpcz45qOzbFLIedZ58y75E85
         9FJV6JA5CAKuw15EZ5/6rCQb/rH4tGMkCNFRPLmfPTnrvAfOrAxzHJfkhEODYKyZUmta
         isJcSJrXKi51vWo1FBmwzckinbmPJABEDynpleRsF5DXBTLrdRjE7Q5syyTEvXttsA/f
         eLZqmPLPQUirQ+Ior/ax2T3nuvNxfyP8LID7y7HLPM5NJzVw2KECdQ8294itxaa0Muj3
         UMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679353025;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBRkEiSR9tcfhCOGkqRsAaw3tSepdN47KkEY0AN8v2E=;
        b=aBL6FPZLZQHonq6PTML8g3Ob2F4ukVrf0InAiVa1QQyhUfeuCP6MOefCMVp83Bjg6z
         Ju7zl4J8wj8jgr6F/FEk7HPdSMK3F4YNcBbTvP41+pMZ+LUQHuCa2STS7TVnjytLdSwf
         vt+SIUXeiBLouAlcaNyTqyIeBnooqlV/tXuK9BUqM4TmALhhkhIw+qyIyWV/geWfL7az
         dQ8AUsJAIC6BqdRpcKw6qJRXMdTWqWLpur7alx2BIgpeTJUnuSBBHvAd4Guf6BcdasW4
         ZPuLSWalLhrlTssx8G2n7ih4SfWa23Q3ipZ9y1Jz9wsJoXZmmrgCZVJC+FZhLr4o9OBy
         xAJA==
X-Gm-Message-State: AO0yUKU1GukhbLip93rMdLknQhYE4JDjRv1o4HRRZ8Ll+7PpuskA47pv
        wGjdwRhv3yHiCZwLqnv2bJrRwrmeX6mqfyKdUZWz
X-Google-Smtp-Source: AK7set+41HalivELGe0odK7znlKvHBtVMGFI8X1IfgmAQ04Ccs5XAnkUy+h/BetMDVZZEYLabVtZCk5wiqMarxOLXHJN
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:5b27:b61c:65e2:5f93])
 (user=jonathantanmy job=sendgmr) by 2002:a81:cf04:0:b0:544:d154:fd3c with
 SMTP id u4-20020a81cf04000000b00544d154fd3cmr6741990ywi.1.1679353025128; Mon,
 20 Mar 2023 15:57:05 -0700 (PDT)
Date:   Mon, 20 Mar 2023 15:57:02 -0700
In-Reply-To: <fe7e2e85eb37cd4068b5160721663c21a16a8138.1679315383.git.ps@pks.im>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230320225702.1471172-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 6/6] fetch: centralize printing of reference updates
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:
> In order to print updated references during a fetch, the two different
> call sites that do this will first call `format_display()` followed by a
> call to `fputs()`. This is needlessly roundabout now that we have the
> `display_state` structure that encapsulates all of the printing logic
> for references.
> 
> Move displaying the reference updates into `format_display()` and rename
> it to `display_ref_update()` to better match its new purpose, which
> finalizes the conversion to make both the formatting and printing logic
> of reference updates self-contained. This will make it easier to add new
> output formats and printing to a different file descriptor than stderr.

Thanks. Patches 1-5 look good to me. As for this patch, I'm still not
convinced (I thought that the new mode would still print to stderr), but
if other reviewers are OK with it then that's fine. Alternatively, patch
6 could go with the next set of patches that implement the new mode of
printing ref updates.
 
