Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E19C636CC
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 17:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjBERcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 12:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBERcm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 12:32:42 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72B81CF5B
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 09:32:41 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id jh15so9956271plb.8
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 09:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrG21/bPfs6ffdbFSwOy4luxkUE4oJWFoY46VamfKsY=;
        b=OOTn5keCeXunW1OjluDU94UIkjjJD9dzZ8NuOGgGfk0kMfVBQ7+6ueriT1VtbxalJT
         Z+dpeiEM3MPEawx3u80d8CjLkw71FHn0vUL9ifPjxJ6pWpyckU6sjNubF5S6gjeIwLEX
         ri5FzXq4C3esP3pPFF0pEbrzFIt/nJKE2m8giBU825TNX64OxFyv1MsGNUufUBx1D0iS
         kkgwxLJ8TRKZQbiG/U9A/WscK0sRlR2j+GR1AwhoQtx0YbTNI9bb0pOIEn3hU4nzD535
         IS36TC69SZCehUMI3uhwNhfsdYl2RiAMsjJM+1cbUy36nVucJF2X8mwmd2cnWSWOeQtK
         usiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrG21/bPfs6ffdbFSwOy4luxkUE4oJWFoY46VamfKsY=;
        b=hfG7rRgh01hwBivSK5uEPM35Nd2Wv5AM4cjAKSyVADJSYZzOgYvoIZPpdfpCSmhSed
         Rr1ZYweHM8SeAgeYUG18n1wwH6lc0vnNmnDUDiAZHMQ/k30OZ850XHNu0sRBWsfgT5WQ
         ANCuy/pxEuahjMvuvenZwICGu6EvleHXhZkopdqf32820SWmRk3PotEGJ4rX12f4k+tw
         jAAJVZz0hHKFaNh/+K1WMhY1io/8eAmfF4PEdgSjIwgYGF8L8uaD9QFQHUE6q9ghMG8f
         7bsMZdgDb9F1xm6wUMOK2+WBea8sewIH1gOdqlh1ZcDmOVgoG5qXMzK6I/ez9oizr/AS
         JCkw==
X-Gm-Message-State: AO0yUKXCyVXFcTdzJrNAsmjQ9dI64Nw2JHYFW1/VEz2mHMh83DgWqVFa
        auTZBYUXaRHTIZfm7BXERLIfM0ZpjIGvdubx
X-Google-Smtp-Source: AK7set9suQq+T7H/RYgJMKcbFX4g+4LJWfrcTTg+aV6F/4LeJOCJ18d0V0WRKIOhcYqt/cFWpyiz2g==
X-Received: by 2002:a17:902:cecb:b0:195:f3d5:bead with SMTP id d11-20020a170902cecb00b00195f3d5beadmr20387471plg.36.1675618361090;
        Sun, 05 Feb 2023 09:32:41 -0800 (PST)
Received: from fivlite-virtual-machine.localdomain ([49.37.146.128])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902728300b001930b189b32sm5145204pll.189.2023.02.05.09.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 09:32:40 -0800 (PST)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     newren@gmail.com
Cc:     five231003@gmail.com, git@vger.kernel.org
Subject: Re: [GSoC][PATCH] merge: use reverse_commit_list() for list reversal
Date:   Sun,  5 Feb 2023 23:02:37 +0530
Message-Id: <20230205173237.159371-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CABPp-BHnXy+Hpv4y83znMxDGOTCZQfYhnDon=ehBDGOxAnW1vQ@mail.gmail.com>
References: <CABPp-BHnXy+Hpv4y83znMxDGOTCZQfYhnDon=ehBDGOxAnW1vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 3 Feb 2023 at 23:32, Elijah Newren <newren@gmail.com> wrote:

> Anyway, the point of the GSoC microprojects are to make sure you are
> familiar with how to format and submit patches to the mailing list and
> respond; having the code you contribute in a microproject be accepted
> is not required, just a bonus.  And you clearly managed to send the
> patch to the list, had a correctly formatted commit message (short
> summary with area and correct lack of capitalization, good
> descriptions, signed-off-by), got the additional notes for reviewers
> (very helpful!) in the correct spot, etc., so I still see this as a
> successful microproject for you.

I still need to get used to the codebase a bit, but the process
itself is fun. I also realized how helpful these notes and discussions
are. Thanks.
