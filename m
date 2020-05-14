Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0D7C433DF
	for <git@archiver.kernel.org>; Thu, 14 May 2020 15:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E053420657
	for <git@archiver.kernel.org>; Thu, 14 May 2020 15:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1+U/Z3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgENP0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 11:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgENP0C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 11:26:02 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923B9C061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 08:26:02 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t16so1282631plo.7
        for <git@vger.kernel.org>; Thu, 14 May 2020 08:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=37Th7weP9gpgbA4t/5BIip6ja3HbsQvmoy6yQjvok1Y=;
        b=P1+U/Z3xuLp56q8TJ6A+kUNsQ0D/0npbTsu5wYB1eHYF9QeOXDFFcA96NP7tG3F6nA
         Mi32sLeAzcnfldROWdG5KaZnrsB9nd6Z4nJRGUPkKvSpPcKG4yGUV2GWPo6vz/TCenVg
         bazHayEfev8I7puSQZKxEFmPCRYBQLNscL9mugCt7aTpNPDUr0qLUU0ITjZ1ky9H2nZ4
         IwL5pJkcJp4nl6Gg3oi/HzQ1Pt0DoYdE47mOoXuR7MtGJ8FEtqfF3A5upGQ5rRCbh73G
         YB6nNpbn/lx4meygwrdx2DpUo0Z+aKqPDdZPiEZ8bBmxN0VTVDlvHzOp58YIF3OfCOEt
         70Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=37Th7weP9gpgbA4t/5BIip6ja3HbsQvmoy6yQjvok1Y=;
        b=Gkwaqp2cfX9zNM5RGbDn6IGzJcyZL0Enu3MtUbXDrzmsNUmp/WD/kfHl6hAIDwL4jP
         x+56BcV7s1XuLwi3Bcg4qwzPMdr7v4hKCkFxYI757l9nMkQYfuo1km3SONeAqz04Ljrv
         LQk68O+z3lbTI5pLdbz+8lwzj5zk8AYpyE9Z5DlhzVEDB8THLVyOFK/Bkwmi4xzRNptV
         vncee/n9+d6uzXXLnUPERX4AMbpL/Ye9RBiDHm3UkvUhVMRtKLoQbPSMt3fmnaj83jKy
         KM9GfsYQRSu3llziuA2fwFGwFqXF37qbwpUsXXFTQdDy63QwxYQip8gWNpR81UFTKJbF
         Ll5w==
X-Gm-Message-State: AOAM530hVh1Rry1juIfOoEE/anUxbAT9u33Cl1j3eP0CLqQWMUAOoWXe
        g7R5fkZpBXQj9GZlXaUJvdYcXvZ5
X-Google-Smtp-Source: ABdhPJz9uLHd3pIyeSXPY2C1nSafCsj/r5m5G+ty3gsQDLksLC3KxXa8Ungqu2Pg2YLqNOQuQjnndw==
X-Received: by 2002:a17:902:59d0:: with SMTP id d16mr4378886plj.181.1589469962130;
        Thu, 14 May 2020 08:26:02 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id l10sm2658794pfd.70.2020.05.14.08.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 08:26:01 -0700 (PDT)
Date:   Thu, 14 May 2020 22:25:59 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH v2 06/11] cmake: support for building git on windows with
 mingw
Message-ID: <20200514152559.GA1939@danh.dev>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
 <00cae10bbb7870b27202642d6e1e284a97a3c5b7.1589302254.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00cae10bbb7870b27202642d6e1e284a97a3c5b7.1589302254.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sibi,

On 2020-05-12 16:50:49+0000, Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index 47d3f3c2866..9625e41886f 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -13,9 +13,12 @@ project(git
>  	VERSION ${git_version}
>  	LANGUAGES C)
>  
> +

This newline maybe left from debugging. (and other new newline below).

> +#Platform Specific
> +if(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")

Please drop ${} around CMAKE_SYSTEM_NAME, here (and other if)
Or user may accidental messed up.
------------8<----------------
$ cat CMakeLists.txt
project(test)
message("This is ${CMAKE_SYSTEM_NAME}")
if (${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
	message("Yes, STREQUAL Windows")
endif()
$ cmake . -DLinux=Windows
This is Linux
Yes, STREQUAL Windows
-- Configuring done
-- Generating done
-- Build files have been written to: /tmp
---------------->8--------------


-- 
Danh
