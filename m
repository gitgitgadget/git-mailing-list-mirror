Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A04CC433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB29A20738
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7rNy7L8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgHURS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbgHURRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 13:17:16 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E621C061573
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 10:17:16 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id n3so1017624pjq.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 10:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=1LNnOj25kClvYCtR/heJRxpj4R1LclfVgP1cPbNfCK8=;
        b=K7rNy7L8FEoP14MUfh2H6F43J3CXKbTv/Joqtr302ecVYOnYqVEBbCCffshCeHgfBq
         b1jrUHWMCqCbuu494UnzMvx5WXRnw4SdImKJnk8A4Y44xyCGpvorVfHH2IA+WirpIxp0
         m18wi8/488+TS3k6GLa4hCfPaChYwDB9mKO2QJ/bRFmxtRik8DMZ5/OzeFFOJ8QGEa58
         mZWWFOPoyOpDDJyxJbaqKLfs/CbtB8KHM6cp9Pi6TX+wIyta5gS7lVPTFjFPiKsF05/C
         O36Y8nlOPlE79pWKuEsX+VulEPXUD4ZVibkl3Ljkc52KQX/xSRi4EYbsHTdTt8cIYBhD
         Z20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=1LNnOj25kClvYCtR/heJRxpj4R1LclfVgP1cPbNfCK8=;
        b=LnGeha2QvpWrpJeBf0AEh1y399QkCml5SKm6D1OvNV8t42/lFGwBYjo6Oqpen/w6wB
         vthR5RGrOhyLLWTn4iL0fuA/UvhDme0H5oJCWnUgxlsxltS/ohC7v4GxKE5ND6gq/l0r
         oGVPdBHdoaBx8ma+sVwQK75/d7LRA/kosi5bx3MqhIxXIoxE3TYNDyWlXgJHEC0erznE
         J7vub3vcvWtpGLbx2O8WnoFNWkWICKAz4eaZZd1QyTj3D9n2rSD2E6UnT6pBXFi/7uLU
         05lqRKvq/wxTTV7+OMdRcDE1s75i9UAwjiu4blhzAgFLMo6cD+YOs2zDrmYXSy9TVz5x
         eUTA==
X-Gm-Message-State: AOAM533JCJPJMaPTzhTP8kLGfKiK8nKMGnvT100mqoNWC+x43bCb/kHu
        XiOkIb87M+sK8AqiIV9vqbw/Y9YmSrpXNg==
X-Google-Smtp-Source: ABdhPJxGmiXS3LDQv0/bBpOvKtW8jQbiZPxDeQaVqYJq4cKB5tPOcmjoZ3bbbNeEeBl9GfEZgE16bw==
X-Received: by 2002:a17:902:44c:: with SMTP id 70mr2990421ple.293.1598030232985;
        Fri, 21 Aug 2020 10:17:12 -0700 (PDT)
Received: from konoha ([125.99.204.38])
        by smtp.gmail.com with ESMTPSA id x18sm3235983pfq.124.2020.08.21.10.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 10:17:12 -0700 (PDT)
Date:   Fri, 21 Aug 2020 22:47:05 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, chriscool@tuxfamily.org,
        christian.couder@gmail.com, git@vger.kernel.org,
        kaartic.sivaraam@gmail.com, liu.denton@gmail.com,
        pc44800@gmail.com, shouryashukla.oo@gmail.com,
        stefanbeller@gmail.com
Subject: Re: [PATCH v3 4/4] submodule: port submodule subcommand 'summary'
 from shell to C
Message-ID: <20200821171705.GA16484@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqimdc9cuc.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think a test that relies on platform-specific error string is a
> bug.  It's like expecting an exact string out of strerror(), which
> we had to fix a few times.

> So I am not sure we would want to butcher compat/mingw.c only to
> match such an expectation by a (buggy) test.

Alright. That is understandable. What alternative do you suggest? Should
we change the check in the test?

