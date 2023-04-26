Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F29C7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 21:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239904AbjDZVOg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 17:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjDZVOe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 17:14:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185D3E5A
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 14:14:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5529a6f9f28so115308867b3.2
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 14:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682543671; x=1685135671;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCvp8pUVI07oEaXJ+FzXpKAvYhAmenzEnZhYmuK4QQg=;
        b=jO3e8LTixPcgBRq6OVthyHXBVYvdDZ8onYYOnKR8SFiZgYHIe72OF5IGJgKiqf212R
         6IRC8yFdllSV8ZQW/pWlhGipLG06EJ9W8qdzATHiBRImpmfDDA9JzedkjJiMeMdfn5Pl
         TaGypfiEHIDTfgU5Zjt3Wkk6VzyxMPuRF8Ywz4gYAETIYFTPh6J/MD5/8jDgEWOr2myR
         Daxuw9Wzhx55EW+ePw5JoP+a8DTiMGvQG4X9Sc77FxlrtkEsTCv17tsaDSX0Z01QcsCL
         +pwj7GEZ8q1SFr69pq61xX4P8IKWGI23KA/5Mzj2xY0nfTtYjOBL+C0vVQjFiIdtVrZL
         o0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682543671; x=1685135671;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCvp8pUVI07oEaXJ+FzXpKAvYhAmenzEnZhYmuK4QQg=;
        b=bFLjzn5r9ewBN1MDuikMuOVmNu3w3DFPgz5VE4lbPpDoG7K3jCdjjHtXPABFJQ0QaN
         39HIQr+uM95GDNdFESLAfd8m1r6NXhqFeo1CZCjXa2ux9ByMld4X18GAJcHOv87sWdGo
         rplu2GYQOFVChdlu+zBenZo7pPxFWLsVhqzRzB33tJmRNcCDJzNzngjZ9Qs/dGpoJC1B
         f5z1PUoilqRgzFO5QNMjALPq0N/NV5ZNyEHpFwHLq7c6bRH4ixN3U7JZ1Y3wigTQ93Ms
         VsqWrX2ck60SsthUPgHaeayWiMPLsIiyHAQizkMAHxxKvYlLF0UP5cAa+aZB/gEEQqyx
         URqQ==
X-Gm-Message-State: AAQBX9fJgvzLvHmu5QSV/PukX0FvGI669SDnJoNSeRl/ddNNP3LzOpqI
        fauI4K4rZ0aBGXGxhLh1nFn+pLXJ/ZmRHw==
X-Google-Smtp-Source: AKy350ZsiA6xrk+oQINJuLItxD3X0vZuEx3CdqNWPKDjPhWqox/AHBh9KIhPBDP8Q6FXlrLuzD/GEaJXc3dVNw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a81:aa4b:0:b0:54f:b95f:8999 with SMTP id
 z11-20020a81aa4b000000b0054fb95f8999mr10401695ywk.6.1682543671365; Wed, 26
 Apr 2023 14:14:31 -0700 (PDT)
Date:   Wed, 26 Apr 2023 14:14:20 -0700
In-Reply-To: <kl6l8reeo4no.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover.1681906948.git.ps@pks.im> <kl6l8reeo4no.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <kl6lttx2mjmb.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 0/8] fetch: introduce machine-parseable output
From:   Glen Choo <chooglen@google.com>
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Hi Patrick!
>
> Thanks for the pleasant read! I thought this was a great topic for
> Review Club. It's too bad that we missed you, but we post all relevant
> feedback here anyway.
>
> Nevertheless, if you'd like to see the meeting notes, you can find them
> at:
>
> https://docs.google.com/document/d/14L8BAumGTpsXpjDY8VzZ4rRtpAjuGrFSRqn3stCuS_w/edit

It seems like Jacob Keller and I have mostly the same comments (since we
did both go to the same Review Club, after all :)), so feel free to
respond to only Jacob's messages and ignore mine (where the messages
overlap) - I'll catch up on those conversations.
