Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C966C433E6
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 19:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28D0B2076A
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 19:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DX1U7D+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgGJTY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgGJTY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 15:24:56 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1AEC08C5DC
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 12:24:56 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id t11so2940507pfq.11
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 12:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BNbquenD19vd4ntp2Q3iuqlQnadSwQaZRLtK9mjdpec=;
        b=DX1U7D+Xc1VSB2+HNu252EzMhdkJtgPQO9HrR5rWH9e9fk/Gb/NdidudYfhnMo/NQk
         8IBefViaq8xtKI9j/PqWDExLBhf8eJepJbG2+JbsuM2v5WeMI7xBA2/mfI7aaOHeyOUR
         Wv8oXGkuTw+XOSMB+j/PWNdQanpV+OCgKfwhhw2NMpChdSFAwT2k+Rf7lAiXMhwYEHVk
         rERxlvojxZ9xSdg9bXXm1GeXFRK/OcyXSJ5B/xfOLtzKDsLPm4nMRPuJDgdHEf5akhi5
         BhouLb7BpyDhAwEfFgpkAQDhXHlwkVmZmRc6hdvFqCVmDkqds2IsfleQinovfRm+BDMg
         04pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BNbquenD19vd4ntp2Q3iuqlQnadSwQaZRLtK9mjdpec=;
        b=ClKSrUFt8S6VtxTMHZ4zsUKsddUZ+3poV8m9ulzMVDpMr7cwEzeOH95aJCrULQAUB2
         nGivD7z1XU0kUYFnZsyL/BWp2Oc2xvIwk0HtlWPAUFkbHqN/qu5YELUuBCvId6CrpuMw
         zKqKO49akDJlkS7IUX2dNbtBgy0RLuIxcoqDgEg+ftebBYaLKMYXBmjz9X9EGDCasdcg
         Lyv4XlG31TH6fU8YlsFXV4j6KATieT2lqEzldTyHLGxEilIvvnXy2fg4YascXziVfXZE
         h9EFGx26yFTnJW5xJrgLtIcJqats35+YlRdG9VjzwtVsexxdedwZmuImykVHE0ua1t7p
         d+OQ==
X-Gm-Message-State: AOAM532VOwDPeYSaWDvUoDoaaG+fux3P2JV1vHMTwR9LELxtE5u6OIIz
        gWoQWE/m3yR2jBN0npPVv/Fqg5MTP0Y=
X-Google-Smtp-Source: ABdhPJwUwy2IfepsSLjXQYh1bgRL7wA0m92jf9CFnP4ypUw9/MGCZS0eTNoCM/AmOCo+KnO0K9xJdg==
X-Received: by 2002:a62:347:: with SMTP id 68mr12138406pfd.185.1594409095980;
        Fri, 10 Jul 2020 12:24:55 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id k189sm7044770pfd.175.2020.07.10.12.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 12:24:55 -0700 (PDT)
Date:   Fri, 10 Jul 2020 12:24:51 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] progress: create progress struct in 'verbose' mode
Message-ID: <20200710192451.GD3189386@google.com>
References: <20200710014242.1088216-1-emilyshaffer@google.com>
 <20200710014242.1088216-2-emilyshaffer@google.com>
 <20200710021451.GI9782@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710021451.GI9782@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 10, 2020 at 02:14:51AM +0000, brian m. carlson wrote:
> 
> On 2020-07-10 at 01:42:41, Emily Shaffer wrote:
> > Before now, the progress API is used by conditionally calling
> > start_progress() or a similar call, and then unconditionally calling
> > display_progress() and stop_progress(), both of which are tolerant of
> > NULL or uninitialized inputs. However, in
> > 98a136474082cdc7228d7e0e45672c5274fab701 (trace: log progress time and
> > throughput), the progress library learned to log traces during expensive
> > operations. In cases where progress should not be displayed to the user
> > - such as when Git is called by a script - no traces will be logged,
> > because the progress object is never created.
> > 
> > Instead, to allow us to collect traces from scripted Git commands, teach
> > a progress->verbose flag, which is specified via a new argument to
> > start_progress() and friends. display_progress() also learns to filter
> > for that flag. With these changes, start_progress() can be called
> > unconditionally but with a conditional as an argument to determine
> > whether to report progress to the user.
> 
> So to make sure I understand this right, we'll collect traces regardless
> if it's enabled, but we'll still honor the --quiet flag if the user
> doesn't want to see them?

Yes, precisely. display_progress() used to check whether to display or
not based on whether the 'struct progress' was valid; now it also checks
whether 'progress->verbose' is set. display() (where the real logic
lives for printing to the user) still never gets called with this
change.

>
> If so, I'm definitely in favor of this
> change.  I was worried when I read the cover letter that we'd display
> them to the user regardless, but from reading the patch and the commit
> message, it seems I misunderstood.
> 
> I think the making the verbose flag a parameter simplifies the code
> nicely and puts the rendering decision in the right place.

Thanks!

 - Emily
