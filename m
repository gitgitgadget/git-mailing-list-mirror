Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8C7C5519F
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 12:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 591CF2078D
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 12:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIKMOvBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgKVMay (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 07:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbgKVMax (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 07:30:53 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E90C0613CF
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 04:30:51 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c198so13374388wmd.0
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 04:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=PROycb6fFl18IM+Wg4O2RAz7Yks4Ov7MfVZJ9uJ1S3M=;
        b=qIKMOvBa3T9xFgcvGcZVCo+qxTV3O+XL0xG9kRCH2PnlHCKaIisV7K6EF2aAs+f+5q
         Zf/vObrNLBQoe7eVhGjcl1eE9325UCrkYNzj1rD42IS7MuE906h9XdJvP8LOXncUEPWR
         N9TxeKr6B5y+/mi5igzx2lAyBJrBbuw7UWTHcZFuQ9rnKRzOqgMKJmChzD3PgAqWEumT
         Sl6Ykyt5nwhiHFs1urHUUYDyMRc/DwSXccln+hjNHaB2+jucMFaXRUxyIu2qLt3+ccqX
         iHwe7qf7MpnwAukEDXVDFDCmKMEfC3kthBSkob/Uqoe+oqc9ykTjWwqK/18gu0MhjUZW
         O0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=PROycb6fFl18IM+Wg4O2RAz7Yks4Ov7MfVZJ9uJ1S3M=;
        b=ZuNLoE//OelLGtNNod06WlnNYJ7wEUjtw5uKLdjWELJEh16W656vf3vMAf/3cGaNp7
         mblzdQAzxd12kiYjiDHqbQwyiwfpg4D+/WKPwiC/4funolrGxnk+eqZt3HSv5knknkUT
         wNVedeIyVibh/QQ4I3vZGwKfDaifo3cJEs4u581BCs+6KGV5Xo71+ZuEpceAYotQTOpG
         Nf7kxYgGtOUXUvFnVRYxRZT6ORVt23Tindz4hnZlm5kxJuDEer68Dq1QJE7o1gt49Mqs
         sqQ/BqAnxBxXcLhZLZ6Tc6CFPZSDNIiR+IvJMfJgvHDJ8PFbC+oMYsfX/BEz2UJNMBZK
         0uzg==
X-Gm-Message-State: AOAM530QRGdDEdMR/xbo6+Mol9U0a9HzhMHkXTAV9JXmvjPcLFYC81I4
        MdT3Smy6kl/gyQVR1pv8cOpLxmsNEMVnrw==
X-Google-Smtp-Source: ABdhPJwx9Opvlge+AczuzVsJls+BPT7/nNe/BMzimZOu3m6ZTNQiIc6vHZXlmeOVM7bXwXA/qTsEUA==
X-Received: by 2002:a05:600c:2048:: with SMTP id p8mr19551743wmg.165.1606048250500;
        Sun, 22 Nov 2020 04:30:50 -0800 (PST)
Received: from [192.168.1.66] ([46.98.123.94])
        by smtp.gmail.com with ESMTPSA id i5sm13290955wrw.45.2020.11.22.04.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 04:30:49 -0800 (PST)
Date:   Sun, 22 Nov 2020 14:30:42 +0200
From:   serg.partizan@gmail.com
Subject: Re: [PATCH v2] git-gui: Basic dark mode support
To:     Stefan Haller <stefan@haller-berlin.de>
Cc:     Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org
Message-Id: <6R67KQ.86UAEA0ZJLWH2@gmail.com>
In-Reply-To: <7553c99f-1dea-0c1d-e5b0-2103333a76b7@haller-berlin.de>
References: <20200922110419.ymqj4ol76kg6qshf@yadavpratyush.com>
        <20200926145443.15423-1-serg.partizan@gmail.com>
        <20201008130741.mz7k3uy65xdbdkeh@yadavpratyush.com>
        <7553c99f-1dea-0c1d-e5b0-2103333a76b7@haller-berlin.de>
X-Mailer: geary/3.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Sat, Nov 21, 2020 at 18:47, Stefan Haller <stefan@haller-berlin.de> 
wrote:
> This caused a regression: when selecting text in the diff pane or in 
> the
> commit message window, the selected text now has a black background 
> (on
> Mac and on Windows, I don't have a Linux system to test this). This
> looks quite ugly; it used to be light blue on both of these systems.
> 
> When setting gui.usettk to 0, it is light blue as before (as 
> expected).
> 
> I'm sorry that I can't give any suggestions how to fix this, because I
> have trouble understanding the code related to themes, even after
> staring at it for quite a while this afternoon.
> 
> Best,
> Stefan

Looks like it uses inversed text colors for select colors. It works the 
same way on linux too.

I'll try to figure out why and how it can be fixed.



