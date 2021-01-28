Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CCFC433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 00:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C16BA61492
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 00:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhA1Ado (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 19:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhA1Adj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 19:33:39 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37698C061574
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 16:32:59 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id p8so2281601pjg.1
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 16:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=gSOVuWPvnthvxoz9l4A/DhjnqVWdSoUIxlDLRB6RPGg=;
        b=Jwnsib/KwstZkl3yFxAhyAhKjiwg+mBoevq1lSuMLteqxiy5b4hHEz9j9LqSkWh1Zu
         VFtzem7mTVDb1Zr/r90rQ+ldJxOtIGBoHNNOt1DLvH9pzW4TOazwalEM8IbCUiqO3KVQ
         yyEkRKo4F0+uCKTXFhLMD5DfNCBDBqX3pOQ7lx6GFg3MkPNTfXERIiKdeSUQLg2zgIJD
         mFYrBJpw2A3Me3y8nGBYfuygM2rhU8kSChRn1s3jDLq/J3QD8gggAObfy3RdMMyT3dYG
         iK79760TwpxKyM1FkiDmgNr7Gnh6RwgKuDlPBYwcUP1fL6x7VR9Lo+ajX/e5piWuKaxB
         FQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gSOVuWPvnthvxoz9l4A/DhjnqVWdSoUIxlDLRB6RPGg=;
        b=tlo5WelAvnHKY9BLmCHBU4zAHKLi0lk9sFzWRrD+yKgiIu5oDMH6TSH3fv4z+YwUYm
         vzGdeirQjHG+YVDzy8oJYt5y7hd8p9cki6bjtV2+mXJ7plaz28dSHaiEjNuBVpxE8glV
         pYAYZttw0hFzb2E83FyMpuER3+Fb6RgOzBpB/sojI0xCOSx46W3xcKg006c7kC52MJam
         myscvoJzxuOLNJ2T/hQC36lD5RO4+d/pnbdnIbXRE+x5WR4o7eGSS9kMygEOuTJKMpnw
         0TBicfn1Te0/LcfRhNrkGXdiRI4BSWcBtROS9auUo/jQ35/Zpbz5YCNj1FonrpOhjSDL
         /RKg==
X-Gm-Message-State: AOAM530jfQHoQ7X0UpI5w5ziZpQO7dPImtGD1580ZtdG04BBcBK7bGDY
        gmMTldflwQ46jZQWcb8+qPAf0rilChgFFq0SbFKC
X-Google-Smtp-Source: ABdhPJyrh6lPzA39A6UrDJYpbz9BXVxGj1a2Moqon5MFUsx5vKVcNioYH5/4QdKlShGv+p8dW2Xv6CS1ZHxk4T0+RYvN
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:9602:: with SMTP id
 v2mr8350067pjo.28.1611793978677; Wed, 27 Jan 2021 16:32:58 -0800 (PST)
Date:   Wed, 27 Jan 2021 16:32:54 -0800
In-Reply-To: <87im7m7drv.fsf@evledraar.gmail.com>
Message-Id: <20210128003255.3872508-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87im7m7drv.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: Re: [PATCH 2/4] http-fetch: allow custom index-pack args
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Sun, Jan 24 2021, Jonathan Tan wrote:
> 
> >  --packfile=<hash>::
> > -	Instead of a commit id on the command line (which is not expected in
> > +	For internal use only. Instead of a commit id on the command line (which is not expected in
> 
> Leaves the rest at ~79 and this long line at ~100. Perhaps a follow-up
> change to re-word-wrap would be in order?

Hmm...I'll split that onto two lines then. I don't think it's worth the
extra commit in history to have it exactly wrapped right, so I'll forgo
the follow-up change for now.
