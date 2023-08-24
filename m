Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EC2C27C40
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 20:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243430AbjHXUME (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 16:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243432AbjHXULz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 16:11:55 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB6BE7F
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 13:11:52 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68a3f1d8be2so211334b3a.3
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 13:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692907912; x=1693512712;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0/tWvsDfAcnXBsJKGF4BsnNuetByelwM1nsoXz4nkE=;
        b=EuJitlS3+7qRLYnq+ISBvdDXW6+fEMDNS5SHQaWNUcVzDKThcvE6+F6rmtew+r7txJ
         kdcx3aGWl+hPeGNaTBg56+I/+GWwjGj9oE/lHh0/kyxNxFn5lDcP8ZbSZFuxbKcLnh6d
         gJ9amoE01r401xXhlqH1wLW2BHAMa/VYeHMqAH+2jVh+5l1sx3WbpCemJXpDukUKB0Fx
         Q7GHCOBXVw4DxDLk9SmFtK/4kf5v2NioHGbNGFb3rtqHYpwcywBCRs3FgmsH+bnTZcaZ
         lGdiVKeImL7PqaFPrVVK3e6yqnbhT8aN4auG9jv8riVXx3DA/I1WuLcRv5IsVgjjisrk
         GVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692907912; x=1693512712;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0/tWvsDfAcnXBsJKGF4BsnNuetByelwM1nsoXz4nkE=;
        b=PRq1cOR4ug3+F8J6R3MA/akSpA/TumqE7wpVimYY/jfFN6vn8dzLLVeWGe+xj9yceG
         5kE8aRoEyhEfIGJNMB6JR2CSDq2JR0mqtGYmvkk054joDPJBu6Olk7D46KtYnhymNIhh
         GpDCtNaXoSPL8/As4yFco55N6tnwbRY8LdyHxoZc7xOqfFeN3GQSO8KLrdSfn0mBDyxk
         kwG57tThKQabwS/o2vmAgbICnNkQaBBM8UjGvXc2iR80/WVcFuVWiC88dpr1k9SWFlAW
         Mm47eL7CbxZh8yoUvO9yq4P5XFq2zSkaYm0T1+TjHU6v7+Em78CHFh0QUgD4BnEXZ4Zt
         af/g==
X-Gm-Message-State: AOJu0YwchkCIf2zz15PzizGuNtXU7n1cQFicIdUD5tpIC4sXSjpoyDvD
        HD7PZjRANtZbRXOdN1wzQkTAQddmCGpsFyJo2eJ8+Q==
X-Google-Smtp-Source: AGHT+IEPap8d5lVOKoNVOPJEpn0s8ygGPerhlLSCp+bE/Qo9P6yPzHhqx0dGq4fCPsxhMQxyYDFnVA==
X-Received: by 2002:a05:6a21:498e:b0:13f:5234:24ce with SMTP id ax14-20020a056a21498e00b0013f523424cemr19083077pzc.28.1692907911990;
        Thu, 24 Aug 2023 13:11:51 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:699c:c07:e0db:43a0])
        by smtp.gmail.com with ESMTPSA id a16-20020aa780d0000000b0068bc44dc40dsm132266pfn.34.2023.08.24.13.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 13:11:51 -0700 (PDT)
Date:   Thu, 24 Aug 2023 13:11:46 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     linusa@google.com, calvinwan@google.com, phillip.wood123@gmail.com,
        gitster@pobox.com, rsbecker@nexbridge.com
Subject: Re: [PATCH v7 0/3] Add unit test framework and project plan
Message-ID: <ZOe5gtYeQaKqOJVm@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        linusa@google.com, calvinwan@google.com, phillip.wood123@gmail.com,
        gitster@pobox.com, rsbecker@nexbridge.com
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1692297001.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692297001.git.steadmon@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

BTW, I'm going to be AFK for a couple weeks, so it will be a while
before I'm able to address feedback on this series. Thanks in advance.
