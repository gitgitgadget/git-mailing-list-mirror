Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436D4ECAAD8
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 03:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiITD1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 23:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiITD1p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 23:27:45 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E40F18E0D
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 20:27:44 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id q11so793807qkc.12
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 20:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=q0/7AAiPr7v4p0HDUMWIZRbRNO+Y7E/lXoGTFH03NdY=;
        b=EeV8ZtV0wincq0arM5EX4HykBbZvQKsN+8MYA1DgbE03e2BdD8Ldu7ytebqZSiqUH2
         wFIo2822b28Y82xTfwdQ/n4VH1/TTgJmnMDlpjSP3SVuDaCE+9Tdye+dG0fQw1wrj6H9
         ldb+Fl2SGb/32fXyxtBaMdc3V3Uo+1+MHCBxfWg5CB/gMKtZv3ZeDuAojJuP10dZLhUj
         IrPiwj1ysctJomZNkwVE6FBeDbKrWD4IPiCiPiPNvMMq05SK38pC+9tqX94lMQu1hrq3
         gOCKyTmBI4JxuMItzAbObpaFRYGR/XnjlwGQj4TNOJGjkJtfJCp/CsHWuqN+SALscFs/
         nU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=q0/7AAiPr7v4p0HDUMWIZRbRNO+Y7E/lXoGTFH03NdY=;
        b=GftyowIi3iNJg8a4OrLAk1DEOs04mkrbHljzBLKRTVyO595KbaVRrE9KakIRLbhEZU
         0FzEXWZK4RJjIMx+pdnpPjeSjVPO0WZyoPtZ5XcymiPx+jnD0axzvUlULqAI62zinlqc
         q1TZXlATrO8xeWHz7eycyWaEpmmTFvg3gsykgXQczU62nK8rhFga2XJv1lEoh7F4vUFv
         r/TjQYA2JM03bjbzrhpD1jBAHqilqa09FapidY7fSnjvaxHjSkkpPwrYtgh4d4SNe5cA
         w4rApMfPAvfU7GswF9allbeG9ytT6AHtW5rXA1nz4o3d61qXHrrSq4eKFHrbqmtTE0R4
         ULbg==
X-Gm-Message-State: ACrzQf2uUWEOZot6oo0Ydkrv7MMORzMpWJGAa43kY+ZESiwXJxlj1vt9
        Pd+EsMIft3o2UlSvcaDJ+fZAnldJ+Gc=
X-Google-Smtp-Source: AMsMyM6hGVFZ7t3SNCFAL7Muaf8dCCfWWTcCBvibyX4FaLBCCJb1WjLflhge+VOOk1eYkjxUh4aGlw==
X-Received: by 2002:a05:620a:4091:b0:6ce:4982:1aae with SMTP id f17-20020a05620a409100b006ce49821aaemr15063553qko.636.1663644463623;
        Mon, 19 Sep 2022 20:27:43 -0700 (PDT)
Received: from gmail.com (207-237-203-247.s3058.c3-0.arm-cbr1.chi-arm.il.cable.rcncustomer.com. [207.237.203.247])
        by smtp.gmail.com with ESMTPSA id c29-20020ac86e9d000000b00342f8984348sm101213qtv.87.2022.09.19.20.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 20:27:43 -0700 (PDT)
Date:   Mon, 19 Sep 2022 22:27:21 -0500
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Erik Cervin Edin <erik@cervined.in>, git@vger.kernel.org
Subject: Re: [PATCH] sequencer: avoid dropping fixup commit that targets self
 via commit-ish
Message-ID: <YykzGTMuKUGM793U@gmail.com>
References: <YyZWDkZWAkS7q+Wf@gmail.com>
 <20220918121053.880225-1-aclopte@gmail.com>
 <xmqqmtav7ygq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmtav7ygq.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2022 at 04:09:57PM -0700, Junio C Hamano wrote:
> Johannes Altmanninger <aclopte@gmail.com> writes:
> 
> > +test_expect_success 'auto squash of fixup commit that matches branch name which points back to fixup commit' '
> > ...
> > +	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p}" tmp >actual &&

FWIW I copied and adapted this one from the remerge-diff tests.  Not sure
what other tests use. Maybe the HASH replacement is worth a test helper even
though it is a heuristic that can go wrong.
