Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86667C2D0E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 16:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A3E207DE
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 16:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLhd70Zv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732077AbgIHQmX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731962AbgIHQmN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 12:42:13 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF01C0619E7
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 06:55:36 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u6so7236477iow.9
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 06:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=VCjyDtKrXax/wldNXxXoJBAVd7PxhxpdndyOU7C5FjY=;
        b=YLhd70Zv9K6/iZAHrLTI84hszQtQhK7amo4oJruZ9BpACy0Cl1BwvqDsAj4TPpgP6g
         55FetRZHK0SLnUJdOOYuW4HJhzLy3BP5Bc6+Y4GD/K4DKaRqQpzHrePw2aRwUm2vbFUJ
         uP4JDm3xl1F04OV0pMNX5PfKeuE1uz/n8UkdSZs++jCzawaVvLyz7QJ1uHrGOncHYZLh
         BmtVj+MpUnRvV6E0H05pO3bUUKoNCjBeCOlbkXBpFIJO5+Vv1Yg3Z/Mc/qzIhl4ZwSIc
         BZLF7Y9p71gkh4pmGp3UxqHTti08toVb6ZucfOAFhuYUadXxwn7KhSv/9mtxajFZ6Nuq
         qwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=VCjyDtKrXax/wldNXxXoJBAVd7PxhxpdndyOU7C5FjY=;
        b=EqE/pVmsqY4aa4F9aSWAcL20+/PVcq5SVA/qBKH05PWWQlRpeI9imxYaSdFzE0nRu/
         wdAWR8vueak7kKUuDmPN3TFWUrSZ1tNQ+4rRn2w3R9SqOmewWJvBXvp131TXz6X0r9SL
         /RI3apf97Nh80TX9uwQT/JlG1SROOpOlGj1DAlBFaaoxFgxJZht+X49ouIbbH0oSmbBs
         yORTHsc0tMKfXDwdCu2XbBy4Gk6O26/gkT4bYpF9OixFqlP5hmyePzCLHrM0YQmhLDVP
         uIRkFZLJqB0rTIjZPxIsGDC+4UFZP454lN81fElnyUg39IhUWLDCvC7W8gsRnMxQjZnP
         RLAA==
X-Gm-Message-State: AOAM530ht01BbLXmdQldfs2zIfkrUIzWGAB/Jna9RGkO4uI3CTFbjqTH
        hvqoL89XSUCDjgAbUADh9tTlV+7a1ysQec39Q0BMfnis7sY=
X-Google-Smtp-Source: ABdhPJxOk3cIysRucsrVvVCbTVUyrtOszWOwx4RcoCbkkjC+bNtrsqeKKE7KXblaOhrgJQk/NnPWzBzhCD1TOjoymGI=
X-Received: by 2002:a05:6638:2049:: with SMTP id t9mr1725401jaj.14.1599573335490;
 Tue, 08 Sep 2020 06:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200907171639.766547-1-eantoranz@gmail.com> <CAOc6etY1Wdfbg5D-CHSg3zOtGWko+de=HEAnRfgVO_QfK9w07Q@mail.gmail.com>
In-Reply-To: <CAOc6etY1Wdfbg5D-CHSg3zOtGWko+de=HEAnRfgVO_QfK9w07Q@mail.gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Tue, 8 Sep 2020 07:55:24 -0600
Message-ID: <CAOc6etZ=yurfKsX_Pnx4stnMnBfj=2CggT8hzCueO5yk6banbg@mail.gmail.com>
Subject: Re: [PATCH] blame.c: replace instance of !oidcmp for oideq
To:     Git List <git@vger.kernel.org>, dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 7, 2020 at 11:21 AM Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> Blamed the wrong branch. I should have looped Derrick instead of Jeff.
> Sorry about that.

I realized I didn't sign it off. Should I send it again? Or given that
it's an almost 1-liner, it's ok?
If I send it again, I will provide just a little more context about
having the !oidcmp calls replaced
for oideq in previous versions.
