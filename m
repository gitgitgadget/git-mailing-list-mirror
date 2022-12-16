Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD6EC10F1E
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 01:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiLPBDc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 20:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLPBDa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 20:03:30 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BF818E16
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 17:03:29 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id t18so739713pfq.13
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 17:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=haZw52W/brY+nDqTBgvwLm0g0iFQuQBulqw6QEarjuc=;
        b=QYaTxIeGYUb5dJzXIuGflmzVpi0K3J9PnfI5fXKxEO2DpRjkj/cR5y2fAgBgKmCgJb
         EUaaA2NFyoZCMlwPFLfQd6MHj1ID2Y0az4+pW0ZxXbJb5tMryBL7sPtrMPDfj5bdHvxk
         sILYLWlOLrYdumijOspATihXTjLDjACWjXbqi2NshdT195Softg+ZFV8Ub5jZ0aHQHj/
         iqoJi6BUj8m3gnwrfqDZDfqq5awTtO6hsYPVbkK8gHHy+foTcESTGmP7hNpgtGOTE1eb
         Flo+uJV6PUiw8x3LyryPscDMoXYQ5OrqILGRM63Oh7VbO2YKjI0pxk2wdLR4gMcMqLdc
         i1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=haZw52W/brY+nDqTBgvwLm0g0iFQuQBulqw6QEarjuc=;
        b=P9KXh1C0bOdWYXu4JK13k1lt9nlyCaF+zFj3TmmHR0KkEEcMYeN/CuEvkzxgMV6T8o
         M8MX6TMVxy4+KX62lDtxFt2oGFq4Xx6wuR5K5M0qJI8YjUtipUtkRpPZX2XFyWy/nAvg
         UuTgndjcwVBlPB9e9Ssz5Gib28l0b3R4kgD7vovmbuZq58xl0OvnxubVOsNZqXUi/F4P
         ZHK+MvhoUyZDrNkP0rb1cwB68m6mU/7L8n2djsF7WIxHmQ4zQrJPL6dCA0AF+BZi0nPH
         DjjV/wcOFmFOMH2d1y3A+AsaMHv1vElUzy/2N8xaG8DX+0kqO69uPftM2mJWoYuxhIIV
         CihA==
X-Gm-Message-State: AFqh2kobG71o6znkjEYTQM/4P3+9oto0Qr1bRKsqZDk6NaPOhym6VPK1
        9d/zX8vIGk01uT031spWWjc=
X-Google-Smtp-Source: AMrXdXtmQ72TztvdOLqV97vmzL6ZKIu4oNkpf8IeWHBRb0p1AzDYoqgDuWXKIOSKTE0w8GBz8WE10A==
X-Received: by 2002:a05:6a00:1344:b0:57e:f1a2:1981 with SMTP id k4-20020a056a00134400b0057ef1a21981mr1033229pfu.8.1671152608952;
        Thu, 15 Dec 2022 17:03:28 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id i73-20020a62874c000000b0056bc5ad4862sm225882pfe.28.2022.12.15.17.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 17:03:28 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] bisect: remove check for fp and move the goto label
 after the fclose
References: <pull.1397.git.git.1671151402532.gitgitgadget@gmail.com>
Date:   Fri, 16 Dec 2022 10:03:27 +0900
In-Reply-To: <pull.1397.git.git.1671151402532.gitgitgadget@gmail.com> (Rose
        via GitGitGadget's message of "Fri, 16 Dec 2022 00:43:22 +0000")
Message-ID: <xmqqy1r8nork.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Rose via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Seija Kijin <doremylover123@gmail.com>
>
> The fp check in these function are only relevant if goto has been taken.
>
> Because of this, we should move the label so that fclose is not called.
>
> This is because the goto is taken when fp is 0 anyway.

It may happen to be so with today's code, but for the health of the
code in the longer term, I do not think this patch is a good idea.
We may add more "check error and jump to the label to clean it up"
exit paths to these functions, and change to add such exit paths
would essentially need to revert this change.

By the way, I do not know if this is something GGG end-users can
fix, or requires a fix in GGG itself, but somebody keeps adding an
e-mail address in the @users.noreply.github.com domain to the Cc:
field of these patches.  For folks whose work is GitHub only, it
might be fine to declare "this user only has e-mail-address-looking
string but does not receive e-mail at all", but as working with GGG
is all about following e-mail based workflow, such an address should
be added to patch e-mails sent to the list this say.

Thanks.
