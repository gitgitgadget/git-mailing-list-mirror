Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0879C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 02:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbiKKClI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 21:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbiKKCkw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 21:40:52 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0B511460
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 18:36:57 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id d3so1993779ils.1
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 18:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dn06dXyR8C1koQvxTYYIWU3YBqQy3HgRtXlTZc88ePU=;
        b=djvwS2uTCTBjuBhd84AS/bk5bDhHNyRyvCLmyG2qDFjyGj9JtM1dwDbCyazZOWbehD
         k0Ow5FInHubXu1Y0VG5QWIn2FC6f6Tgb38melX652C1Nod9zJvftcqUkcZQIMGJiMwDY
         DZGCp2PR6IH2mX9qbXuXq+KlFyaOuB6bYJMJifF+8JqTBAc5Rjjf3mynwYRmP4EtDOdm
         HcpWUuPMAh22e2h3nMdRXyZD8l/9KytMbk7RDkuHgGwUclIhFQXPjcgEZgnRQZwxRNb0
         K29oV5bWOT9X+yFyYYmskaT4fwl03yc+ASoDM4X19J4aAMsHjxmtv1ZHI0LeiuGSPxSD
         iU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dn06dXyR8C1koQvxTYYIWU3YBqQy3HgRtXlTZc88ePU=;
        b=kE0J9AIabJG53CwDEWtAa8XbsJN2w+Vwo+P//CdBOtat0Q1u211u91WOTcCnxUYCD8
         3vGV1hGbHstV5XLwZJeenuLopZduJrtS+eC+G5Vp36nEOxnATJvp7FY3i+a2YiypGTQ3
         THMtCTPg1yMa+bLVChV49aKid2QXqO9Meq9Zo3bZwdxDlBA1bnWdQP77FTp2ai4wYG62
         9n6bnJdco/Q8C6U0wsMzbWwJHr5Wi3k1EAwcADQ0xqp5rAa/+FNitFt2E75u2E/DbwBv
         eByeKb7DnkQkOhT6EYahdhFmPjYZ2PZCn6e8erJ3GXJFk2TUT0eUYj5w/yGShNvwolMK
         I00Q==
X-Gm-Message-State: ANoB5plYb9cr2jIa9yi3qj+Ug4ypeowqgGE9k1XR4ERmf/aWrdqFs2Zz
        5m1ST1h06C6L4wWr95L8IS+vmg==
X-Google-Smtp-Source: AA0mqf6UYvtrgKM2kWlYurvh1u7Hyvk4UkCvvMjkkYGUohUSnGr+BuUWkyR1NtXadxFEdvcrt0KB8Q==
X-Received: by 2002:a92:d1c8:0:b0:2fc:5d2f:2de3 with SMTP id u8-20020a92d1c8000000b002fc5d2f2de3mr74385ilg.318.1668134214068;
        Thu, 10 Nov 2022 18:36:54 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h14-20020a056602154e00b006bbfb3856d6sm353898iow.5.2022.11.10.18.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 18:36:53 -0800 (PST)
Date:   Thu, 10 Nov 2022 21:36:52 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2] http: redact curl h2h3 headers in info
Message-ID: <Y221RAgmLOQp3MDs@nand.local>
References: <pull.1377.git.git.1667955151994.gitgitgadget@gmail.com>
 <pull.1377.v2.git.git.1668121055059.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1377.v2.git.git.1668121055059.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 10:57:34PM +0000, Glen Choo via GitGitGadget wrote:
>     Thanks for the feedback, all :) For this patch, it sounds like it would
>     be too onerous to do the kinds of testing I initially envisioned, so I
>     think v2 is ready as-is.

Yeah, I'm fine to start merging this one down as-is, especially with
some verification from others that this does in fact fix what you say it
does.

I would be happy to see more tests here in the future, but I agree that
they can be done on top.

Thanks,
Taylor
