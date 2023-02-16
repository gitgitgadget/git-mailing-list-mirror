Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD92C61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 17:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBPRgY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 12:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBPRgX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 12:36:23 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4844FA85
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 09:36:22 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id v23so2806179plo.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 09:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IBq5v7MqqdGsop26bpPr30u5ivd7XmtZY9IqIciG3rg=;
        b=BFd5FQm8qBmAut9HgB+NE9v+b0g+7kuRqoyGSwcudOoDIuNo4Ou/CLApFEEwo3cEFR
         b9eVQYsheUUWgYxkMtLJIZUsE8bVTjl8jqD0sT57bvRXLRR/YDrTiFS0D6c2E5vy0dhk
         DPeKmfe1fSCsd++Q0VeToZznjA+o1Z3OUVzeJ+drGBuFYge5E3Jxdwkb959syH06T1hQ
         REiENTx9B+xxwVV0pGMkgqVxhXjhSmkqEdzyvsEW/+sidrDkTO82C5dqHtVYbtWbZP/e
         x8+mM5LycPaN0oEQG1oTNyF+jI9sLJJ0TdKLACHYO8uVm8f+5eR5NILuCK9Jo3ZJ+YjP
         Z13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IBq5v7MqqdGsop26bpPr30u5ivd7XmtZY9IqIciG3rg=;
        b=DvWsV8PQJDsUH694owVTpXJuArMzJ4A+achS0XZcEezmcbgDo02h/n/vQLVAJGvyO9
         oWzvjSzrYdwXbM5f1H74FL2Wd3kEGgXz3679/DZ4T/QFaupOKq349o5k7LBDBzJhnVNn
         FXzAtd/Bmt4dD77Z9Le8Uw2Cy3i+lOncGW1I2PqN6YHBlml1oKW082bqawsBOKDjEwBx
         kQNv2aCElNa38u9lJIe3uGjbW5025+lEuV8YkTEHax4TGkRYnTmUJhAEzg13+x2ef/rC
         WuBxnKr58YMPxXXnP2pIDVG75+QNcrYWVp5fIoGv3eikMFMzod4N7BtazMYSbdLRB3xX
         922Q==
X-Gm-Message-State: AO0yUKVqJzupKc6DKnWxDDIDStZ2Y1CRg2GfjVw439jyYxriMT+ei1VI
        fq/yrZRSmXQFKnQ3goH4mFY=
X-Google-Smtp-Source: AK7set/LwDfoOEVBKmIZWrgLZulhMI03XUOhLFyJle4LbBaasgOyZpv8qnIWLi95ISpruBU7s1zWuQ==
X-Received: by 2002:a17:902:cf51:b0:19a:80c2:4396 with SMTP id e17-20020a170902cf5100b0019a80c24396mr5938264plg.68.1676568981461;
        Thu, 16 Feb 2023 09:36:21 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id u15-20020a63b54f000000b004fbc4d51d19sm1439729pgo.83.2023.02.16.09.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 09:36:21 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] delta-islands: fix segfault when freeing island marks
References: <61e490595b80b34c55fd640e093e021ff6fa9591.1676542973.git.ps@pks.im>
Date:   Thu, 16 Feb 2023 09:36:20 -0800
In-Reply-To: <61e490595b80b34c55fd640e093e021ff6fa9591.1676542973.git.ps@pks.im>
        (Patrick Steinhardt's message of "Thu, 16 Feb 2023 11:29:48 +0100")
Message-ID: <xmqqfsb5qzqj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> In 647982bb71 (delta-islands: free island_marks and bitmaps, 2023-02-03)
> we have introduced logic to free `island_marks` in order to reduce heap
> memory usage in git-pack-objects(1). This commit is causing segfaults in
> the case where this Git command does not load delta islands at all, e.g.
> when reading object IDs from standard input. One such crash can be hit
> when using repacking multi-pack-indices with delta islands enabled.
>
> The root cause of this bug is that we unconditionally dereference the
> `island_marks` variable even in the case where it is a `NULL` pointer,
> which is fixed by making it conditional. Note that we still leave the
> logic in place to set the pointer to `-1` to detect use-after-free bugs
> even when there are no loaded island marks at all.
> ---

Missing sign-off?
