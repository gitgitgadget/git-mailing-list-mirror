Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85791C433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4598961164
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbhD0Kif (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbhD0Kib (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 06:38:31 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A96C061756
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:37:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m5so4754641wmf.1
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mavit.org.uk; s=google;
        h=sender:from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=9lDTLiTgMIc6czya+jhDEZZvBTn04zfMEiBNHhTwU14=;
        b=dWFyzedp1YNEz2bOqWAm3oPxnpRVRzOXVdl4T5qBRB6Z+TSk+6qVOl5AADGAyVLc9/
         aFyufZITKqo5FBW9ZiQyPtGl9bJwYT6ySbq3wxf1XIGpFTnUOSPvo+mIo4qnXBeBpK5S
         Jgayn1RhT2i07fcvU/XvuUoMzeYPvuMTWSIK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=9lDTLiTgMIc6czya+jhDEZZvBTn04zfMEiBNHhTwU14=;
        b=Wc15s2WKLQn+MqVXvT50mKlaAIJqqBopUO5puyTBNfqkO/OGRlMKbxYQS/iI8kLxBX
         VMCsbuqnDBpQmIof/dcyNHtYPnUkXvrSG37RB1rIjc3tEb/JJ/AJ1WmJ+YwZQj64FsfK
         elLevwbLbNp+ULJeH18y0nk4Nfz+05nunSXcIwZ4f4EdVc9ezd6LCEKRYf5/DcuGrLPW
         A4iALwD6l/TpgayCKxkXwGzFmaBitTyrD0FTa87HKNaSZE6qqfNHYiUzsTI7frITRdbY
         9/9IhZSUlMJRHZeuDSqwI8FYEdB/KrqVfsDw7nwGbQgUh0cgVPWfbwSRKvIML9n31iLu
         4czA==
X-Gm-Message-State: AOAM532llp7GxzerBSrrNFXVgUUzl9ARXd3y0a7iZUYLUgjDs3FnwfS4
        4U++Fhq05GL8aoh+y+HL+Qmf9Q/eFDsEsg==
X-Google-Smtp-Source: ABdhPJy3NKhnN+cAfhGRjIJDP7Ng99EiDwKI+0Tf2PEtWdgnDsn8W6cfyIr0aWbSnNauXA0Ux8U6wg==
X-Received: by 2002:a1c:7c08:: with SMTP id x8mr3579699wmc.130.1619519865964;
        Tue, 27 Apr 2021 03:37:45 -0700 (PDT)
Received: from froglet.home.mavit.org.uk (cpc118948-dudl14-2-0-cust32.16-1.cable.virginm.net. [82.37.201.33])
        by smtp.gmail.com with ESMTPSA id m14sm11050035wmi.39.2021.04.27.03.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:37:45 -0700 (PDT)
Sender: Peter Oliver <mavit@mavit.org.uk>
From:   Peter Oliver <p.d.oliver@mavit.org.uk>
X-Google-Original-From: Peter Oliver <git@mavit.org.uk>
Received: from froglet.home.mavit.org.uk (localhost [127.0.0.1])
        by froglet.home.mavit.org.uk (8.15.2/8.15.2) with ESMTPS id 13RAbie6008724
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 11:37:44 +0100
Received: from localhost (mavit@localhost)
        by froglet.home.mavit.org.uk (8.15.2/8.15.2/Submit) with ESMTP id 13RAbitK008719;
        Tue, 27 Apr 2021 11:37:44 +0100
X-Authentication-Warning: froglet.home.mavit.org.uk: mavit owned process doing -bs
Date:   Tue, 27 Apr 2021 11:37:44 +0100 (BST)
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: point to diff attribute in patch format docs
In-Reply-To: <xmqqh7jsdvlb.fsf@gitster.g>
Message-ID: <aa421f19-2ac5-570-61a0-100fa526423@froglet.home.mavit.org.uk>
References: <pull.940.git.1619463549689.gitgitgadget@gmail.com> <xmqqh7jsdvlb.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 27 Apr 2021, Junio C Hamano wrote:

> "Peter Oliver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +5.  Hunk headers mention the name of the function to which the hunk
>> +    applies.  See linkgit:gitattributes[5] for details of how to tailor
>> +    to this to specific languages.
>
> Shouldn't this part be as helpful as the change you made to the
> earlier part by mentioning that the user wants to look at a specific
> part of the document, instead of reading the entire gitattributes(5)
> manpage?  Perhaps "Defining a custom hunk header" section is what
> they want to refer to.

Thanks, good suggestion.

-- 
Peter Oliver
