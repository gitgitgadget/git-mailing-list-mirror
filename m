Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E98C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 04:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D60D23BEC
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 04:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgLSEvl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 23:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgLSEvl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 23:51:41 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13757C0617B0
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 20:51:01 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id w5so5096875wrm.11
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 20:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oO/DvXgKxis2f0QVdoQnC9ryPYgQtxl3Dnlf2gCW6k4=;
        b=rRLGURyP3M900ua/NLQkUOUjdCvHiSe2w//nb9KePAEKztARChGGDxK2inl/fCMSfh
         UQLMIu2emlawWX5NQVTS/rPhrO9LM7Vsli9Na2tWP+OYQrSpYwzupL46sLXEYSy6UeIe
         UcWhCDYHy3IowrCMZkh4PXmpsY7MMo12UdVo+EqF7JOa41/V469k4eaidC6pu3pyecwl
         oh1tmKYXRntgx0N3/4PYDqa0TnImh1VP195f9LkRAqCGhDtpAhaXsjlTcZUZD8LqNak2
         W/AClrDWDi5LOS/mU8A3aFBst1PQY4qMoqznBK3QcBRq2j16VHQwLapFltG4+mdNk3k0
         20pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oO/DvXgKxis2f0QVdoQnC9ryPYgQtxl3Dnlf2gCW6k4=;
        b=VUUZoPOrENnehzoeKftTTGguBfK/eZj78fY2Ebyjr19wcylMl7MPos7YFjZ4sLSnN3
         0gqD8p3AfUT/fn/CvQQJ3LPrX8oUDrNlaOwuyYCTBMY734g3Z8OFk/lrr51E4UvyfhZE
         kMNUVPLMutc0oh5/KfijEygLfKBw8reLqgqdEsZKMEdD7JXYbUWB7RaNJOIcJa5jqvFm
         Gkhxs7sPl7n5xX0z7F2lvShfVONC4775Vavj8iRaUcfEYQ4St2Yp/0WnhbVTZOP4/Acf
         s0BfJNW5ubTF2tFekco+6cXNc29qvwbw4lh6qKhEKLhGDT9aSA28K8WwdxmxJKu3hBfY
         5v2g==
X-Gm-Message-State: AOAM533wy2aiVWXLYdPEDB3I0g668Lre9q6HNFaJKoZ+LLgcOXq1G6/z
        54EeRzyDqXpd2fZPmaXBw2aqvOOSnTvkt344Iw8=
X-Google-Smtp-Source: ABdhPJy4C1QoUOL6tOjIk3nnRK4gZemGTla6aukiH5P9ZZu7KzFf/LVpf0GyVUccnEICKaT/gYYvrdJES+tzPLpsVnA=
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr7755285wru.84.1608353459901;
 Fri, 18 Dec 2020 20:50:59 -0800 (PST)
MIME-Version: 1.0
References: <CADtb9DyozjgAsdFYL8fFBEWmq7iz4=prZYVUdH9W-J5CKVS4OA@mail.gmail.com>
In-Reply-To: <CADtb9DyozjgAsdFYL8fFBEWmq7iz4=prZYVUdH9W-J5CKVS4OA@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 18 Dec 2020 22:50:48 -0600
Message-ID: <CAMP44s15CJVGRg5Qxcgqq8xVkDhpVyxND67-iQZF9uZ_PRstEQ@mail.gmail.com>
Subject: Re: [BUG] Regression in 'git mergetool --tool-help'
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git List <git@vger.kernel.org>, pudinha <rogi@skylittlesystem.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 18, 2020 at 10:27 PM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:

> It seems that 83bbf9b92e (mergetool--lib: improve support for
> vimdiff-style tool variants,
> 2020-07-29) introduced a regression in the output shown by 'git
> mergetool --tool-help'.
> Even if I have 'meld', 'kdiff3' and 'xxdiff' installed and in PATH,
> they are not shown at all when
> the above command is invoked. Only vimdiff, gvimdiff and their *2 and
> *3 variants are listed.

How about this?

--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -46,7 +46,7 @@ show_tool_names () {
                while read scriptname
                do
                        setup_tool "$scriptname" 2>/dev/null
-                       variants="$variants$(list_tool_variants)\n"
+                       variants="$variants$(list_tool_variants)"$'\n'
                done
                variants="$(echo "$variants" | sort | uniq)"


-- 
Felipe Contreras
