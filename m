Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EE2C433DF
	for <git@archiver.kernel.org>; Sat, 30 May 2020 13:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A162074A
	for <git@archiver.kernel.org>; Sat, 30 May 2020 13:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjmbBrOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgE3NRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 May 2020 09:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgE3NRd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 May 2020 09:17:33 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C89C03E969
        for <git@vger.kernel.org>; Sat, 30 May 2020 06:17:33 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d66so1211419pfd.6
        for <git@vger.kernel.org>; Sat, 30 May 2020 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1gUllgODFJdvcFgfM51xWn3fSwi+PUvhbixPTDPnL5E=;
        b=MjmbBrObifueK4Su7ibngDo3Vf3fuocwk+9r4qDP0ndzI2QEcrP2+f9gteJVh262ml
         R5H+7SkCtq66E5vP/WSV2FgsygmWbT1Z82PY8mVH9Ya1/ne6Vgj13+agzRP6xFAC/cTk
         kTiYCiyyCMDwXZCjUCZC4SRWVwMi0PpQxpOkAjfQUcGtxJcGzAH+isqmCxcfSvUdDKIh
         hezihfEMirwKu3H1+cIITVXEaHtoAV58nRIeGPEQZIvL9HvlQo+ih8Gub+fD1TffsfLZ
         kvpSRs8Wf78Jaq+KkXD0+Q9o4nYeQwTikYPyHc45UwFboxJr9FZUDMU+X2yse5SY+Tc4
         Dcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1gUllgODFJdvcFgfM51xWn3fSwi+PUvhbixPTDPnL5E=;
        b=SHCu+9GrH1zmbIUi+GSyikhmoM3VD6XORAmIu8avJgQSyz2ngiliQiPHjQ1d7WdMhz
         Fhr6aJHECGPjH8HTiqp0tK+69SYHEZmqLuzlq9QPk/9sMqyUq7bczajjd8V49Q4fIJ63
         3wmLulgwrwuccZ0DaTPzafJicU7Vnao3vTtESwx16k+LJGYdYjmTUCfIajWmXADafI1Y
         uxiGG7BEkG1pbDs3Tz9NqIB5ThfZdTg7Pt+aBYAK16jz7QzQ/aOkWq5J54nnZ5FnXAeS
         IX9RrfODMyMJvJIlzFsQgo6gV9ownlywVXze2t5KYIhyRhwY1hQH8RnAyOa5M6oULVoi
         qP1g==
X-Gm-Message-State: AOAM5335H2REfIE92/UE2Gh3KxkAyyilyC32aQDGI3N4f1/x94g5y6v8
        b+KkWorBeruoD7Oz8j7KWXk=
X-Google-Smtp-Source: ABdhPJxvX19XWCX84qkGBF3ZW9nzCW6VQtzxcopKgxk5dTgrEDVKQwKM3VMZJKYaliFsFuE++1CcXw==
X-Received: by 2002:a63:5225:: with SMTP id g37mr12113209pgb.230.1590844652946;
        Sat, 30 May 2020 06:17:32 -0700 (PDT)
Received: from localhost ([2402:800:6374:cd6f:3908:64aa:a24d:1be1])
        by smtp.gmail.com with ESMTPSA id f7sm2229353pjp.24.2020.05.30.06.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 06:17:32 -0700 (PDT)
Date:   Sat, 30 May 2020 20:17:30 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH v3 1/8] Introduce CMake support for configuring Git
Message-ID: <20200530131730.GA2151@danh.dev>
References: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
 <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
 <09c972de52b35b14a4c6f44b10c3dfc1732b2c7a.1590759624.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09c972de52b35b14a4c6f44b10c3dfc1732b2c7a.1590759624.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sibi,

On 2020-05-29 13:40:17+0000, Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com> wrote:
> +file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE git_version REGEX "GIT_VERSION = (.*)")
> +string(REPLACE "GIT_VERSION = " "" git_version ${git_version})
> +string(FIND ${git_version} "GIT" location)
> +if(location EQUAL -1)
> +	string(REGEX MATCH "[0-9]*\\.[0-9]*\\.[0-9]*" git_version ${git_version})

This will strip everything begins with first non-number.

With the same Git repo,
The git binary generated via Makefile reports version:

	git version 2.27.0.rc2.274.g860c8aebb9.dirty

The git binary generated via CMake reports:

	git version 2.27.0.GIT

Anyway, I pretty much defer this step to build step. Since this will
report the version when *cmake* is run. And *cmake* will be unlikely
run again if nothing related to CMake is being changed.

-- 
Danh
