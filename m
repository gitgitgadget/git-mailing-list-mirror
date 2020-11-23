Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC932C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 20:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D1120706
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 20:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNMoA7ea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgKWUu4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 15:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbgKWUu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 15:50:56 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF32DC0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 12:50:55 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d142so616327wmd.4
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 12:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=KpZsTPcQk2a/wUCKGV8WP89ckMbI6+UMBtHw6j0jbtQ=;
        b=DNMoA7ea1MTFwmkP11yzHGOWhwoYp7cx2RU+LZw75qYqFL1+i0JtHSf8gPrsl7rDPn
         oDdKWYBtP6ShzdvXnAIYrzzDder770/1Gs3Qxew0HHOeij0AUAvvW1oSaDr7DmnLAj97
         EbGRVO3rW7PyGpHzrE46uDZOE3ilHARVTvoNGABIoSK8UVmLbF8VdtYAsMC0E8at70Cu
         P/MCaJGewJUVy3pwJ4whII3XOYo60Ljtm0RPMznCIGWCJnYQ59d0npszoWF1KY0z/dBe
         YQyfrBQ8cJZGfMMlXH0M5rwEiKU6L7yxr7Vux+qJQHt3E5eCWlvowo3PdNhrpJDjNU8S
         2Dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=KpZsTPcQk2a/wUCKGV8WP89ckMbI6+UMBtHw6j0jbtQ=;
        b=KABxZOKpaLuK8khhKX1/4xTERNtpCMhTUTwxaZVu0uDEX2sdiSwxg/ZqICKMIyNWrm
         qUNQc4KGDTm3bT6gcX30OfswBtPTEKI/+sjPaYQcNTM+COSNDHdzlq+PwLxHpqfTXtVg
         Gti2HXhmtOBiiqRUu5fOkq0fzGFWF2Zm85YyJB35uqlUKUZ439uNOQ4xBqDKMuhOFU3P
         xtp9yXvI6Y7GivrgSX3O0R7n2PoIqgfSl3N9OjJcrBlk/LNkCXAfuQL5NlNM/UFstkHm
         lfIboUCI0LZQLt7P0Rr5om9lc+CEZEzdvDgg1VaNBVquxbhLaCAbO9W4NKjtxGqEpSoe
         pi7g==
X-Gm-Message-State: AOAM532iKUxKqHAsWOlngbkCwyUKqKJbLTbr9PO+LQh5ZTZ/J97gSq6a
        6GIrocX+g8UalDAASsMUmNMTsHolO0nonw==
X-Google-Smtp-Source: ABdhPJzC7QIoPrQhOCQsVTPZ9yd5V188xCeFFsKm+cZwyUceAkzu2WTncI+w9/NGAZ9CDVm4U0dYOA==
X-Received: by 2002:a1c:7f81:: with SMTP id a123mr805486wmd.6.1606164654413;
        Mon, 23 Nov 2020 12:50:54 -0800 (PST)
Received: from [192.168.1.66] ([46.98.122.136])
        by smtp.gmail.com with ESMTPSA id o10sm15681603wrx.2.2020.11.23.12.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 12:50:53 -0800 (PST)
Date:   Mon, 23 Nov 2020 22:50:47 +0200
From:   serg.partizan@gmail.com
Subject: Re: [PATCH] git-gui: Fix selected text colors
To:     Stefan Haller <stefan@haller-berlin.de>
Cc:     git@vger.kernel.org, me@yadavpratyush.com
Message-Id: <NKO9KQ.ECZZ8I6WPK063@gmail.com>
In-Reply-To: <b4571217-ea98-a282-48d3-e9679c600f4c@haller-berlin.de>
References: <7553c99f-1dea-0c1d-e5b0-2103333a76b7@haller-berlin.de>
        <20201122133233.7077-1-serg.partizan@gmail.com>
        <2436cd2e-26b9-a7cc-722a-7f27212f58f4@haller-berlin.de>
        <DZJ7KQ.UXACXR9SWDQI3@gmail.com>
        <b4571217-ea98-a282-48d3-e9679c600f4c@haller-berlin.de>
X-Mailer: geary/3.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Mon, Nov 23, 2020 at 20:03, Stefan Haller <stefan@haller-berlin.de> 
wrote:
> The problem is that it needs to be recalculated when the
> theme changes, and I have trouble testing that because the
> <<ThemeChanged>> event doesn't appear to be sent on Mac, as far as I 
> can
> see.

How are you testing this?

If I put `puts "InitTheme"` into InitTheme which is called on 
ThemeChanged, i can see it being called multiple times after git-gui 
starts, but when I change theme using "echo '*TkTheme: awdark' | xrdb 
-merge -", it is not called.

I suppose that signal is called only when theme is changed inside app. 
Yes, i just tested this, and that event is sent when you change theme 
from the app.

So you can safely put your code inside "color::sync_with_theme".

And We should move call to sync_with_theme from git-gui.sh into 
InitTheme. I don't know why I have not put it there before.


