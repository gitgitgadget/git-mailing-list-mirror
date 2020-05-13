Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF71DC433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5806D20659
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FdZz5j+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390743AbgEMTqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 15:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390636AbgEMTqL (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 15:46:11 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B1EC061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:46:11 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q24so11440052pjd.1
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=hEGOL9wrALb1fjxDGbFkHzDytk7vvEoaOjX9ZiZl11U=;
        b=FdZz5j+Qfi3Dk15aKYIN6F7nvTo8H+FnICpJHGsNstoBaOtafYY0AH5FmI40gyTxeJ
         xIBs8q3TKZ4GMW+McI6fZI7+Rz2CKXc5w5ch7f98KxNCW/OyyOlFftoMZKEf2xc0VKZf
         L0TnBSYIIvKzRVVIhwjO/3hACWmSHEqqD36MR7a3mDYTKfHMT1K8gok2t6FUbOKoV+hX
         95LBwA1NcICE5e8wtIo5QnhezH6Xwfujxr5pdEXHvqAAaN/fizyQEqBRMsZ72UPyrAIR
         yMvo6xi8AJhWtVzV1XAQLZ6DRJn87gP2bK0hHQdJPxwRducjy+pc4pLduO8lCH/6kuw1
         4WgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=hEGOL9wrALb1fjxDGbFkHzDytk7vvEoaOjX9ZiZl11U=;
        b=pwV58QErO1lVwiuI8A7bo2x3bz49A/j6qPn61K5qn+Hax/UMhU0CsZxpzDY2clF/ZE
         lYBy7XCrDKl//lFga6lh4Gaqp/5T1dp9HVRLyJP8nGvfs9SExMxqAhaOMomKTifjt91h
         t5iRv6twGxxS5K0ZIPkHak6bWisP0kooxIkn5gTV6X6QgUmR2eVyMAHFDpkXQBdEPNBp
         xGMvqnPupA8Y4Oi//+Gt47gmYPjQkLUEd2/VcbToHZTK0kPI57hOJ6yORRbR/PCGgNhW
         20/x4wbTB0GwTvwELVHJrKp4yttkODlyVvWGAuqsH/+7n2+1IeK+DbsAbIsdg242HNog
         QgrA==
X-Gm-Message-State: AGi0PuZUDSmgydVADBqJe27wKgugSeji7m+KxdgTdm86UntVKnwwevAW
        BaezqCkCcHa7+YYiTrSYwwG0Uw==
X-Google-Smtp-Source: APiQypLZCV3vfZObD9Z4cK9x+fMR1uLpztBtwYqG4ZhCOwSP4mpIiYtKt+ywfEmE+1bMa4mFoaZPFA==
X-Received: by 2002:a17:90a:9311:: with SMTP id p17mr36506093pjo.145.1589399170668;
        Wed, 13 May 2020 12:46:10 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id z190sm306628pfz.84.2020.05.13.12.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 12:46:09 -0700 (PDT)
Date:   Wed, 13 May 2020 12:46:04 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] trace2: log progress time and throughput
Message-ID: <20200513194604.GA163566@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20200512214420.36329-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512214420.36329-1-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.05.12 14:44, Emily Shaffer wrote:
> Rather than teaching only one operation, like 'git fetch', how to write
> down throughput to traces, we can learn about a wide range of user
> operations that may seem slow by adding tooling to the progress library
> itself. Operations which display progress are likely to be slow-running
> and the kind of thing we want to monitor for performance anyways. By
> showing object counts and data transfer size, we should be able to
> make some derived measurements to ensure operations are scaling the way
> we expect.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> One note: by putting trace collection into the progress library, we end
> up with data events which have titles like "Receiving objects" - not
> very machine-parseable. An alternative might be to ask for a
> machine-readable title in the progress struct, but I didn't think it was
> worth the code churn. However, I don't have experience with processing
> the trace data after it's been collected, so if this is a bigger problem
> than I think, please say so and I'll figure something out.
> 
> CI run here, although it failed on the same error Junio noted today[1]:
> https://github.com/nasamuffin/git/runs/668457062
> 
>  - Emily
> 
> [1]: https://lore.kernel.org/git/xmqqtv0kc2q1.fsf@gitster.c.googlers.com


I like Junio's idea of adding an optional machine-readable field in the
progress struct, but I don't think it is necessarily a blocker for this
change. Everything looks good to me.

Reviewed-by: Josh Steadmon <steadmon@google.com>
