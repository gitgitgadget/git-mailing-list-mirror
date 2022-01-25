Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20402C433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 19:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiAYTRP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 14:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiAYTRI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 14:17:08 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D50FC06173B
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 11:17:08 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g7-20020a25bdc7000000b00611c616bc76so43262495ybk.5
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 11:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kxtk2EkHAjuPMihP7K6SgDEdxffk6gc4ri22bfzCOQY=;
        b=r73P4EGAWPbNsP85OzjhTr+bGDc4BQEvF5GFj/dO95P1tjNKgAuoWcy79oO86sj3XA
         poyJVwVtgTB1awXWbYqu92kjbiQEB1ziAJKeSmLtLZPkVlbr2rNc6CfFvTPQe/h4pwnw
         8uIZajqXkDQ8QeRbdBMJQdF/lghq1TCQMg72t80sV/U91Nk9sANbuZ1ADLZ8SjrXMIbM
         lT5YW4R+4PIFWAtp2k5d7yjr6XyW4r8nglSGo+mUUwujabHfy22gQHFC1u2fsHDFrayG
         dBxlfdMFqTbmYHf8xvklRctJ1r2pPfO8YpoFelP3cOcJW4hL7nGJn6Vb3fHY0e3beWXC
         SpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kxtk2EkHAjuPMihP7K6SgDEdxffk6gc4ri22bfzCOQY=;
        b=3XBi5Q0e/LBAz/jrcnmNr9W87AZwZWhhaA0E7qKq52GPxsD1R7nmNy3Ute+DxFDHlQ
         CaZiIKfpv4ldIUtebQatHL0lo2eouAVdXopJSQRT5kgbz0Q3sEabdP3mmwITWrJipTgC
         tvjE45u3lZLFkQjuNu6pNJ0P00EIeelcUTXLAsbRQ7qkmcRdpnYdLX00MqRxjLTXPUb7
         zIR/ni43Zh2u/XSh63lP85//YWMVu3bluFbOu7eyXEi/Q+LcZ59m++RrxC/+Oj4AFZv9
         QNBZTdSLHhBVFSlKJFChdhjmd/+hBfX7M3x5RyJcurBV3MCO1EMKObCzq6bjnetRZZny
         W+3Q==
X-Gm-Message-State: AOAM530HC9IvnW9zE5ox7lUiTiR8X3Jks7uH/tDfJuj6KoxJv35+v++A
        KYdLwPq2+lTgbjxlNZatDX/C2YDmdep0X0MD4I5+
X-Google-Smtp-Source: ABdhPJylMywPk6CGfsQrlNDg6SzzNjmgdvChRfsrDF8lKoeLQqOcub8K2ajFysdG70P9rGB0i+HC8tCd0AnGVfNjxZS9
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:c0cf:: with SMTP id
 c198mr18763483ybf.375.1643138227589; Tue, 25 Jan 2022 11:17:07 -0800 (PST)
Date:   Tue, 25 Jan 2022 11:17:01 -0800
In-Reply-To: <E5AD42A3-AEAC-44F8-B223-90E2ACAEFCB0@gmail.com>
Message-Id: <20220125191701.2649292-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <E5AD42A3-AEAC-44F8-B223-90E2ACAEFCB0@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: Re: [PATCH] promisor-remote.c: use oidset for deduplication
From:   Jonathan Tan <jonathantanmy@google.com>
To:     johncai86@gmail.com
Cc:     avarab@gmail.com, gitgitgadget@gmail.com, git@vger.kernel.org,
        jonathantanmy@google.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Cai <johncai86@gmail.com> writes:
> Jonathan, how often do we expect diff to pass duplicate oids to
> promisor_remote_get_direct()?

I don't recall all the details, but not often, I believe. In a partial
clone, I envision that you would typically diff one tree that you have
all blobs for and one tree that you don't (or two trees that you have
all blobs for). If a user is in a sparse checkout and/or they're diffing
two trees that they have never checked out, I would recommend disabling
inexact copy detection to reduce the number of blobs that Git would need
to fetch. In these cases, I think that diff would only pass duplicate
OIDs if one of the trees references the same object more than once
(directly or indirectly).
