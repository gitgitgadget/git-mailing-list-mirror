Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABC1C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 05:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A023E610A1
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 05:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhJHFgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 01:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbhJHFgt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 01:36:49 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14977C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 22:34:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r18so25974665wrg.6
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 22:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MOiDxLrg55yGrX/ba6bUtOAeBC/Xtw9JCEahgmG5W4Q=;
        b=RseqgEBeBEfQaPJx0/AIwpm5gJ2hmgG4BJdH9rr9SOxiWCS2IAR2y/1a/rN4HL4E40
         v3xNQGJdNqABedmRhdgtcVOxDudakKXFa55xAb/ozF93PFC5oswyMl5AFQ0N5EvvrvRc
         12/jkyhXc4Tuo3J3IP3UIbMHOGWZ2IEBpEiSOA14Bk3h+nzDf2uw96ugWmBKNjo0BCSm
         +JBwYhOuidz58r3a2HYP9MuSYa/yyGznhistqy7mW4cvIIQW30EeEvs4Ah3fQgI3u7Xv
         tkUbN4i1UuWhNwcqJ5u/d3byfd2CKfKdIsArGZUKhpqwaPQpQut9K3EKdoUg45FJUCKn
         07pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MOiDxLrg55yGrX/ba6bUtOAeBC/Xtw9JCEahgmG5W4Q=;
        b=Unx5aoQHO7YdlydlJX/h1aWG9DegjuLeicLfpIiUCZr88OYZ7WZyLjG+M/ckqHMhXH
         2YfMNUOpnZ3uJRavoyjtWOOecJjP5FqJ1B/+V4c+cp3ebzu7P4LrkezgblcWVsxThf0s
         9iQkgLCVWjNlXJeRCd+tOjqMombso75TFAzHQA5d+hkm13VChsE7WBURBekoXeeiZ/mP
         X690w1UC432x4iE5dppE7GaEm87fZa8ZKDUYpeEk4CDJ7onOO4J3RXbEA6lMJxgvS2L5
         OgdF6DIyNC+PEgT8kboRnyj4vKAJowsWvRnTEvZxefKYn4Ay+xilXPULNwqHrOaxkUqc
         ZU9g==
X-Gm-Message-State: AOAM531TkmCfDlkiQnS6VZL650+/A8Jq8BXjIpbZwaR+UVmOIgQT8UyW
        UWzSuudCtg5kQvB8fIeByTE=
X-Google-Smtp-Source: ABdhPJynL+/N77a/Xdp1WbT0dqeYm3qsm1PSC8ePPgYOjuLN1sq0JB5Sc4YfTP5n6haDQIkgxD58wg==
X-Received: by 2002:adf:a10f:: with SMTP id o15mr1510100wro.286.1633671293674;
        Thu, 07 Oct 2021 22:34:53 -0700 (PDT)
Received: from gmail.com (77.119.218.218.wireless.dyn.drei.com. [77.119.218.218])
        by smtp.gmail.com with ESMTPSA id b19sm8842897wmb.1.2021.10.07.22.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 22:34:53 -0700 (PDT)
Date:   Fri, 8 Oct 2021 07:34:50 +0200
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de
Subject: Re: [PATCH] t/perf: do not run tests in user's $SHELL
Message-ID: <20211008053450.wjttkhsbbsnuwwpt@gmail.com>
References: <20211002112640.hrn2ojndhoa2dd4c@gmail.com>
 <20211007184716.1187677-1-aclopte@gmail.com>
 <YV+1/0b5bN3o6qRG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV+1/0b5bN3o6qRG@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 07, 2021 at 11:07:43PM -0400, Jeff King wrote:

> I wondered if we would always have TEST_SHELL_PATH set, but we should:
> it is put unconditionally into GIT-BUILD-OPTIONS, and we will always
> load that via test-lib.sh, even if the test is run outside of "make".

Yeah I was gonna add this to the commit message but didn't because it's fairly
easy to check. Probably still better to include it. I can resend if that helps.
