Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28245C2D0E4
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 17:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE56C23B54
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 17:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgLRRP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 12:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgLRRP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 12:15:56 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7393BC0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 09:15:16 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id d8so2566754otq.6
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 09:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=e5DYpNabzOQLbylbhq4S1XmXuSJjed+fGLDKuUlAs88=;
        b=sZZ+ysoCnWo8n9oga7U/VWkI3Hc2nzQ9CLixtKF5F3bvjj4OT4QcHb8V/aYQaK//tc
         fhpznuvrHVQEsQzjk6MbHSMQ1g+ncxoIl1rNpx02Gzg1qqK4bLrSXWw3z2MUBIkMYhBL
         OPKNaJIO05uTE5b28PkjfGOSMVJBKyaZOpSXFVrT8EwWF2LA2OXQyWez+rU6jNkSTN1o
         xBetETgLlUe4+Ke/lrpDMiwlHGwdjkkBi9sirZm3wu604bibsNiDBn/mJ/MucWbRMvtR
         zE5gerH3BY1HotOxSWR4ikyVJvyBEQ/VMstZ3MeDZvHB7EDXVXAiu/Mn/BEYfxBgWmwW
         dolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=e5DYpNabzOQLbylbhq4S1XmXuSJjed+fGLDKuUlAs88=;
        b=NxsXfjkj1a/7VMWQ3IvWWNfZCMtVoSD7qrJamep+F7QZTlTlTjfea654bq+znYz4G+
         g5jkyWy9IjW+RNWYLLJbpoPmYXjJHd4jqB4nz6qB7REV5zYgh4S8LlDkqVbwNgL9kRFR
         vgeFHtEchKWBIP6O6agGEg75S9wfRmxpd+Dkh/6Glqtb06kLG9MvwZDqpGUaF50w4m1G
         UTiqoA8v49TO4HbpmoVRKh/R9BTe4DsYrhHzmLwSUwvpf4uQvvsBZtBjV3BG/vLhX0UT
         iMe+himfcFQz/qsTgg6JjMxcxAxh2A1vqC81EJNihU5EPQvzeq1vkAJwnKePxEuKCE0i
         VyCg==
X-Gm-Message-State: AOAM530HtpMSLS2u3LARaL2dKHdAgxwpiKFyndcbBAOMHI7D0bKmxNoi
        s5hE3xC8zXFQKuNaPoVQrEM=
X-Google-Smtp-Source: ABdhPJwjmasezh45x8ywu2eQvRnofCJWxF1pSMwyLs4hrZGwRLCSHTzxcLzzMoyXJE39aQZVNRPTWw==
X-Received: by 2002:a05:6830:1398:: with SMTP id d24mr3677909otq.199.1608311715835;
        Fri, 18 Dec 2020 09:15:15 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id j126sm1886299oib.13.2020.12.18.09.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 09:15:14 -0800 (PST)
Date:   Fri, 18 Dec 2020 11:15:12 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Ed Avis <ed.avis@qmaw.com>, git <git@vger.kernel.org>
Message-ID: <5fdce3a04a8b6_12eac7208b@natae.notmuch>
In-Reply-To: <CAP8UFD1XMA7y6qXXS8h2HZXTuC8nGVkxTiMG3ZA54XJJg=gAsQ@mail.gmail.com>
References: <PH0PR11MB48875130A7DF30A7394DD3619DC30@PH0PR11MB4887.namprd11.prod.outlook.com>
 <5fdccc25255b7_1273af2086c@natae.notmuch>
 <CAP8UFD1XMA7y6qXXS8h2HZXTuC8nGVkxTiMG3ZA54XJJg=gAsQ@mail.gmail.com>
Subject: Re: Feature request: 'git bisect run' option to redundantly check
 start and end commits
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder wrote:
> On Fri, Dec 18, 2020 at 4:39 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > Here's a quick patch to implement such feature (it doesn't apply
> > directly, it's mostly for human eyes).
> 
> There has been a lot of work over the years to port code from shell in
> git-bisect.sh to C in builtin/bisect--helper.c. So it would be nice,
> if you plan to implement this feature, if you could do it directly in
> builtin/bisect--helper.c.

Yeah, I'm aware and I might be willing to do that--which probably would
require moving the whole of "bisect run" to C--if there was an
indication that such a patch would actually be merged.

Cheers.

-- 
Felipe Contreras
