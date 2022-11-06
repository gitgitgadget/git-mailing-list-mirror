Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C809C43217
	for <git@archiver.kernel.org>; Sun,  6 Nov 2022 00:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiKFAaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 20:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKFAaR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 20:30:17 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35DF60EF
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 17:30:15 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e19so4323632ili.4
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 17:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7zrt58ECWgHfYr9Oq3+LHDet34lXNNK9le37eYuZPYw=;
        b=fzDpNHTZQONjr9dVsncFhvfM+MvFKtKozmvWxL0mPlMl/n4d+piIJIkyp8EQjnLyIH
         j2gZayBXwmj7VrrxLxHVNM7EXUXXDwts7M1xIh6GNosRhSJCm1fJ+mPIGWfbrCcTqR1f
         GpBwTxa7/hR6x7J26hMq2l30wCS65wjn5dulZpQKFrN6hRfz0NxWzN36UuQDb7qqJcfq
         INg4Ak2OWPXr3/WPnNG4XU9Ko8yuw/GCxyw89KZKBSfXHM9L2kDuRoDwn88cRpgYCldr
         OgyaSqCtbQaoyHAmw9h8LZ2E7PPgxkdHbMDyb8Od+CFMxoAo+DE08gDMHEVFkAOYOlEg
         MfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zrt58ECWgHfYr9Oq3+LHDet34lXNNK9le37eYuZPYw=;
        b=EnMU1Go92wM6G6WAY5JXZRzIgCMlhuOLjTtegPR31BMbOQIFdQ+L1q5s/RfkIacwx7
         ot5RJrKACDbYKgoLaqRQgvAiGBPfnuBS3N0XQxhHZsxGXle64W51vhEuTg9dYxbwcYiC
         gXqb4s5F+j9iHagqIG6ETjp66I78sl6GdC6kC+hiH8sEIPRaj4j33SmdFfr8c1FqFyXv
         BGtIFfY0SJcwcycAjL5nDrcpCf1jne6/MPL8zC7Y65c8VShwOHN/pCjc+Rwi7rZhrfaU
         y4voMuXickHj3lTGdiXm/0bTbtKbSq9SqOrwzCrzT/LSbqUXRKFEBVEjsKCazjmwte87
         o7bA==
X-Gm-Message-State: ACrzQf1jAJxliqDY+xtV6OcKhwbYI0XjN7EFBz+c/SYybh0KPPHTQZl9
        J+H1I+SnafeegOrRdMk01zTlCw==
X-Google-Smtp-Source: AMsMyM45Uti9wC5wezC8rdGgqKJjdQAyL2ux1AeNxnt4+uChWgjzM4i71qm25YcMDAfn3YhjA1/Q3Q==
X-Received: by 2002:a92:d308:0:b0:300:d8be:85e2 with SMTP id x8-20020a92d308000000b00300d8be85e2mr8621923ila.86.1667694615341;
        Sat, 05 Nov 2022 17:30:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b10-20020a92dcca000000b003001f822301sm1320931ilr.81.2022.11.05.17.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 17:30:14 -0700 (PDT)
Date:   Sat, 5 Nov 2022 20:30:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Ronan Pigott <ronan@rjp.ie>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Andrzej Hunt <ajrhunt@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt <andrzej@ahunt.org>
Subject: Re: [PATCH 1/2] for-each-repo: interpolate repo path arguments
Message-ID: <Y2cAFSR83bjFFcq/@nand.local>
References: <20221105184532.457043-1-ronan@rjp.ie>
 <20221105184532.457043-2-ronan@rjp.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221105184532.457043-2-ronan@rjp.ie>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 05, 2022 at 11:45:31AM -0700, Ronan Pigott wrote:
> This is a quality of life change for git-maintenance, so repos can be
> recorded with the tilde syntax. The register subcommand will not record
> repos in this format by default.
>
> Signed-off-by: Ronan Pigott <ronan@rjp.ie>
> ---
>  builtin/for-each-repo.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Seems reasonable. So the 'register' subcommand will never write a record
that isn't an absolute path, but a user may manually munge the
maintenance configuration and we want to err on the side of flexibility.

OK, sounds good. Missing test, though?

Thanks,
Taylor
