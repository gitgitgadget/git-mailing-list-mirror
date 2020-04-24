Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7DBC54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 23:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EFB420736
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 23:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcKwpvd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgDXXJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 19:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgDXXJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 19:09:57 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8213C09B049
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 16:09:57 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 145so5518570pfw.13
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 16:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZnZ+wSFCTf88fScaheF3ebtq3Ju/xOF/U6Wzpy3QfH0=;
        b=GcKwpvd1A2wwHmsL0eHN+LI5ccio7Dn55ZTo9ZBaIcCPegWYBbnPEcp6vynjGh+kfq
         Mmc4hi8QAt31P0ChmiAhUmCENER/545TAzJ3VpnFzZWpd34ihLHT7wbOewXZ4EcP/QOx
         +lSnqkoZVCmpiaDxmgwJTrVoyZhDo1hrMsb3WRBKm8/phIWIyf0Njdezh4sZ1rm1kK+I
         1dxp3FG6xUIUMygYdT4DR3ELB8t3ilgc9NCDtCN5Ybs+gFHwiPfeBfRDzHctNV6Zgsa5
         SMYSYwgsYmQ3Juir+BdEEEmLZ1GC58mMcODr3BRfHsNbIW4SHbj3PNJ3PDI64xfeVp3O
         qzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZnZ+wSFCTf88fScaheF3ebtq3Ju/xOF/U6Wzpy3QfH0=;
        b=SJ/DlnIIevgkkT/C3058cOQoa8knP4NQ+yTJtwnzLttfNXoEkvM6lUhfPgYFLriB62
         775DwV4aPTXRTT+nalWFWwUY7ZNoL8c9sleLvPDRycELeEP12K6OisePXDhPO3kHrFk/
         F2h9kTru+1evfOCJLQWGcm4eO80MmfC23h0511UsYsElLDnPXWMGCjYFH6Xua9wereSS
         2oyD3axiIxOZ8/WLUhQLzktcBpsehwCpCPm6Bm6GEUi5dwFcf4qkxBBybMcZnhLZHgzZ
         IXYh5769rT6RThMuDKgLSUn/2g2kHZ8/5ZlmneF1vZ3JVx7Ywykvz6CeTsgjut5MAmiu
         /pUA==
X-Gm-Message-State: AGi0PuZz/D68CyvJQrsZYxap7/GEhAQnNTmkW3Yi+Y+NuxflTQTd+YDE
        uGeZs3KGYDTQXPmSj/M9J+osrjzt
X-Google-Smtp-Source: APiQypKQSGkNjQPo5iTzWCxqhbLHLhUSMnrQZbcY8spX5i0whNteANhCf1/ZJhy2F6dZKrjWDC+ZkA==
X-Received: by 2002:a62:7b03:: with SMTP id w3mr11945950pfc.313.1587769797095;
        Fri, 24 Apr 2020 16:09:57 -0700 (PDT)
Received: from localhost ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id q97sm5872719pjb.7.2020.04.24.16.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 16:09:56 -0700 (PDT)
Date:   Sat, 25 Apr 2020 06:09:54 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 5/8] cmake: support for testing git when building out of
 the source tree
Message-ID: <20200424230954.GA4071@danh.dev>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <166b78f71755bb3f9967b32bfe282210c2bb240d.1587700897.git.gitgitgadget@gmail.com>
 <20200424173433.GL1949@danh.dev>
 <CAKiG+9V=bJNqrHRy8y8cbjkgzrmhOMMz47+8fgfQARAetx4MFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKiG+9V=bJNqrHRy8y8cbjkgzrmhOMMz47+8fgfQARAetx4MFQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-25 03:02:49+0530, Sibi Siddharthan <sibisiddharthan.github@gmail.com> wrote:
> > >  file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
> >
> > Remember cmake won't be re-run if nothing was changed in CMakeList.txt
> > If I only change some code, and I decided the change I make should be
> > tested by a-new-and-independent-test-script.
> > I need to re-run cmake manually! I don't like it, at all.
> >
> 
> No you don't have re-run CMake.

Yes, you have to re-run CMake.
https://cmake.org/cmake/help/v3.14/command/file.html#glob

> Note
>
> We do not recommend using GLOB to collect a list of source files
> from your source tree. If no CMakeLists.txt file changes when
> a source is added or removed then the generated build system cannot
> know when to ask CMake to regenerate. The CONFIGURE_DEPENDS flag may
> not work reliably on all generators, or if a new generator is added
> in the future that cannot support it, projects using it will be
> stuck. Even if CONFIGURE_DEPENDS works reliably, there is still
> a cost to perform the check on every rebuild. 

* Run CMake now.
* Don't touch anything
* Create new test-script, let's say t9904-just-for-cmake.sh

* Check if it's run or not, I bet the answer is not

Anyway, Junio said NO, I don't need to be a CMake hater here, anymore.

-- 
Danh
