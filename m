Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A44C4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 12:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbiKWMRL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 07:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbiKWMRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 07:17:09 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38E2167C8
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 04:17:07 -0800 (PST)
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DA14A3F339
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 12:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669205823;
        bh=WDWEvq/rxvhEHc8F71FcauyDUOpuJ14c+h+960csrsE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=pXeWyL9Stasa3RSFGMJg+1box5T9ugI5gxBsDq8eBzSSBFdUdYjbY0CUyVg52/szk
         GFZWUYwhKvrm3jD4favXe+tot2G2Ylw+jyxTG4un8e3sBjYPHcyrSNAYU8Uad8DLLG
         B2rg+Zv+ndOhKCDfEohjIy/YqBdmR1p+zCeFuHXcJ1CLImhfULAPampqT9BVJCQ5SC
         CvnCmJIR+2zxlcqp3OD8sPoyrRAETN8ecEzo7P04bt7WZ3wv29+8FKGxp1D4H/NPD8
         sEcyGLkGuPoxTG1DxpiQ7QEoCltytsm3kal+zsF0SFAd6TnjdNYzPgl6JjRTtXU9Uk
         eyULamkD2GdvA==
Received: by mail-lf1-f70.google.com with SMTP id bp18-20020a056512159200b004a2c88a4e1eso6401009lfb.3
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 04:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDWEvq/rxvhEHc8F71FcauyDUOpuJ14c+h+960csrsE=;
        b=J8V/MESRviQQtl5GRLgO0Me02NNkR628Ua68ERCPzH3FA62MUb6XXVf1e1BzewvEhP
         YAAXQQcgxzNvh4feIemdoYaphzA6vn1QjYuhVimQNg4c5koHx5cJMYX2VDgBulKQ3s54
         byYEf5BuDl3Rvu+A1il5RcRgDQ+tI+HHakBkfikPQJQcoUGzFRT5Ip/FuwOsDGToCJRw
         15cD8pt8NDYRD/zLtVi9zYvB+XK7UlXYftSGE0ebjN/saKl/U+tPH9wo4h16rjMsOzRj
         Z0J3oQm/QK+KSKgq/0G2sJI0838zBa39d7E9cYepXxJRy+RN86bPbhJg0LsRDsSPDG+J
         1VMA==
X-Gm-Message-State: ANoB5pkaqJU2+RsS3NRnJuy8Wzu73tMFT/xXAbBH2n2JQQvJhPCdehbN
        M/Vd4lcn8CEDyinA6cfxWpdosrsiXGo8BhF/GBeymPQn6TgyS6Cq5G2mfKtFfsyBrJcNBdM1TsC
        4hGgg0Iz0ztbfTh73cyssjw7xqTds5WP2h57pOCKUegsZIw==
X-Received: by 2002:ac2:4e07:0:b0:4a2:2a60:ecf5 with SMTP id e7-20020ac24e07000000b004a22a60ecf5mr9942872lfr.57.1669205823242;
        Wed, 23 Nov 2022 04:17:03 -0800 (PST)
X-Google-Smtp-Source: AA0mqf608loagsdtij2iDyuIopeojtI8n+e2PXIVe6L+WlWIDAa+Rzz22mqMXE7/Atl1s/JAhwLsn/5uWv9qPYhif4I=
X-Received: by 2002:ac2:4e07:0:b0:4a2:2a60:ecf5 with SMTP id
 e7-20020ac24e07000000b004a22a60ecf5mr9942860lfr.57.1669205822990; Wed, 23 Nov
 2022 04:17:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.1385.git.git.1669148861635.gitgitgadget@gmail.com>
 <CAPig+cQ6_7wf6C280Rqi7mcTCiQp-n5GiLWTPazfcUcGFeZi0g@mail.gmail.com> <xmqqsfiao47q.fsf@gitster.g>
In-Reply-To: <xmqqsfiao47q.fsf@gitster.g>
From:   Andreas Hasenack <andreas@canonical.com>
Date:   Wed, 23 Nov 2022 09:16:51 -0300
Message-ID: <CANYNYEETCaaQGOXVLrRCC8wdS-uD66BHqr98Eetb+1GVk5WkTg@mail.gmail.com>
Subject: Re: [PATCH] chainlint.pl: fix /proc/cpuinfo regexp
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Andreas Hasenack via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Should I still change the commit message regarding where I mention the
commit that introduced this, as explained by Eric? From the activity I
saw overnight it looks like things were already picked up and it
doesn't matter anymore.

On Tue, Nov 22, 2022 at 10:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> > Makes sense. Well explained.
> >
> > A separate problem is that chainlint.pl doesn't fall back to a
> > sensible non-zero value if ncores() returns 0 (or some other nonsense
> > value). That is, of course, outside the scope of the well-focused
> > problem fix which this standalone patch addresses. I may end up
> > submitting a fix separately to make it fall back sensibly.
> > ...
> > As mentioned elsewhere[1], this code may eventually be dropped
> > altogether, but this fix is good to have in the meantime. Thanks.
>
> Thanks, both.  Will apply.
