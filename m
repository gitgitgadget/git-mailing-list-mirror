Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939E0C433E0
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 20:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62E9A2074B
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 20:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KbDDoyHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgFAU5e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgFAU5e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 16:57:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7157C061A0E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 13:57:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z7so14006134ybn.21
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 13:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=npE6E5oKodAVi1LGwZTZkSBy3c0rrDzTiK3O43RE0z0=;
        b=KbDDoyHvupcwSOvM1SqEYp1k+CYsKPEf8o0ggM+sHXz1yzF6yL374M1K4sHJ3wcYM0
         uKwDJz1RTnl7IGhF5XyJh43Dwmqz58Z9jvZtVC6WvtmiKU5m8GSsI7+H2oKy0kTkaK+x
         iByao5wKz1+S79+J49/g+5e5nT+Xj7xJKHKFABUc71uOndsajHIwxLxb80xNzrlMH4us
         +1JSRU172VvOzLCapjjagMqVT8P9a+jjMsX4i3VHHWrjcFh5eKj4L89EfgNtPM8QNF8V
         icn3LVQZkPsq1JwNu+p4rsDk6jCjj7ywbwiyzjk7jM8AGrgPmOY5OLxG0BTwrcdah/aD
         rXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=npE6E5oKodAVi1LGwZTZkSBy3c0rrDzTiK3O43RE0z0=;
        b=er3KQubRIuhmDqNcqLqj/Fysp3FUtseImGTXhMnbkgky6QM1hHOn1zqnivvNIlQ3yE
         GRDusxv0QI4vJ9+yV+teCfD2HMyH8v5EG2/HEGPLqaawbx98GULSbLhe5PeRWfJs2QhN
         JZ2QEr56gxj+TCR3fR7v1TD4zo7Jp0QRvleG14k/OsGZjWWs/84FGZMuCtE2urK51h2w
         94mKZkZYoJgk0Wt59ORQxvYsKwBdBeXb1ppxZyD2JaOKHALdi71DfPAqlqJTB5PWyjST
         ppYhsvVJoJBAlGXuDIsTLYn69OGrNBCtsDHfGNp7Gpedu+lGvI91ok+FZdKRmJU+R6Ca
         qOcg==
X-Gm-Message-State: AOAM530yAThXnNGm8XbclMIHMFM1uDHsK1GukwBH/bDXDaDNMQD6ZjMR
        je2wB7pmGDk8NXPgN5u3VP+mW+McQ/LvEzRqcHXk
X-Google-Smtp-Source: ABdhPJx188dpoybKR1UryisQKjfrmeHYyEchZdfIxl7Zmk0pkJk9M0duqb5a5XBIWxFGv1z2BGpD1oOFYg7aVvTj7Zgm
X-Received: by 2002:a25:81c9:: with SMTP id n9mr38356447ybm.385.1591045052172;
 Mon, 01 Jun 2020 13:57:32 -0700 (PDT)
Date:   Mon,  1 Jun 2020 13:57:30 -0700
In-Reply-To: <xmqqa71qxqoy.fsf@gitster.c.googlers.com>
Message-Id: <20200601205730.230613-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqa71qxqoy.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: Re: [PATCH 4/8] Documentation: order protocol v2 sections
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > The current C Git implementation expects Git servers to follow a
> > specific order of sections when transmitting protocol v2 responses, but
> > this is not explicit in the documentation. Make the order explicit.
> 
> Thanks.  Are we breaking other people's implementation, or is this
> the order all reimplementations of Git currently follow, so this is
> purely an preemptive safety measure?

I only know of the JGit implementation, and it currently follows the
specific order of sections (if not it wouldn't be able to interoperate
with the C client). So it's a preemptive safety measure. (If this series
doesn't go in for whatever reason, it might be worth just merging this
patch on its own.)
