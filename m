Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4C5C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 14:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00441207D3
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 14:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoT1kTIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbgFOOFB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgFOOE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 10:04:56 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E690EC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 07:04:55 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d7so9600895lfi.12
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 07:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AoaLYB1IDQG1leN+J1i2klqNOpXNQfDSFDZrhJvoR/k=;
        b=OoT1kTIB9zwbjhzL1mi2B+r5UUz+/M/lgWhNaB2jWMa5tMZenvvyxkhFY4udUtO9NM
         lTdezSiLgwawWaH8Xbsqq+nKEwVJij7ShVeYzczqYGJinNOfa+nEX6ImLuldNers5kGk
         JQRLNRFvAvP2hDiC2hXkKSsLb59vJJTL8kBJPgKEa8Acwe06bkU8uo+I5ggKLmNbKKZF
         blLF4F7A29Sh9KKgN1lWyb0/+7bUFZtFQmVv5QRTVKRAr9ImBRrTJ5K7hzKBh78xJmsM
         /VqrKctROI+waMcNTvGaHebsj7lTxb2fwYKrzZYvxP3M76mAs4EsCVVZ+6/OxwUtDhNQ
         meAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AoaLYB1IDQG1leN+J1i2klqNOpXNQfDSFDZrhJvoR/k=;
        b=OUwZ8ogV7Lw1b3/1sVr45e6FWmwsl16s3qNoSGASCCCLQwZIt2Sgpo2dA3fJENLpmx
         Nl52LxOZu06hfpjN0jqPizqhl579FU1PkblkIiJdErHI1YFvnA/vE51DtBrJ+dfPKqtb
         9L7Ww9zCL2KTucL0C1TZMjQ3fFawVq3nC0Mb28kGquvvXnVyvpb115Tfu3sHbkcczyFG
         3ZZFyssbZfLj8d/ljVKR9PEwis7WAwUwIlTir5Wi2XSO0zJFkeI5XiSenLDcFEho5ars
         ugwNoClM0VQtHH3slx3B4bN3GCrCbC/ZjV21EB28r17twKFIf77G+r7/4dquA61adSHP
         QHuQ==
X-Gm-Message-State: AOAM530lPzSVEmpSujfaOYmio1bDRcoWN1tjBGDbTVugumkQS1E84a6t
        Irl8K/rAD4ks3WVAovdq8D0VZIdff0M=
X-Google-Smtp-Source: ABdhPJwEj15E6v9e5n8IurQv82KZ8ALiel0IJK+/j5RUI6Iqq+WF5l7mtjCQOt0ZjSzN8kSgsdzpHw==
X-Received: by 2002:a05:6512:3089:: with SMTP id z9mr3397348lfd.83.1592229894459;
        Mon, 15 Jun 2020 07:04:54 -0700 (PDT)
Received: from no92wrk-walle.osl.infront.as ([195.204.99.197])
        by smtp.gmail.com with ESMTPSA id j18sm3003854lfj.68.2020.06.15.07.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 07:04:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sibisiddharthan.github@gmail.com,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: Re: [PATCH v4 7/8] cmake: support for building git on windows with msvc and clang
Date:   Mon, 15 Jun 2020 16:04:42 +0200
Message-Id: <20200615140442.1847-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.25.0.windows.1
In-Reply-To: <f85ea0ac0ca5160a23a0a4ea26b7090638bcaf11.1591986566.git.gitgitgadget@gmail.com>
References: <f85ea0ac0ca5160a23a0a4ea26b7090638bcaf11.1591986566.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +#Force all visual studio outputs to CMAKE_BINARY_DIR

What is the reasoning for this? AFAIK this makes it impossible to customize it
from the outside by doing `cmake -DFOO=bar ...`.  

>  if(WIN32)
> -	add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.res
> -			COMMAND ${WINDRES_EXE} -O coff -DMAJOR=${PROJECT_VERSION_MAJOR} -DMINOR=${PROJECT_VERSION_MINOR}
> -				-DMICRO=${PROJECT_VERSION_PATCH} -DPATCHLEVEL=0 -DGIT_VERSION="\\\"${PROJECT_VERSION}.GIT\\\""
> -				-i ${CMAKE_SOURCE_DIR}/git.rc -o ${CMAKE_BINARY_DIR}/git.res
> -			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
> -			VERBATIM)
> +	if(NOT MSVC)#use windres when compiling with gcc and clang
> +		add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.res
> +				COMMAND ${WINDRES_EXE} -O coff -DMAJOR=${PROJECT_VERSION_MAJOR} -DMINOR=${PROJECT_VERSION_MINOR}
> +					-DMICRO=${PROJECT_VERSION_PATCH} -DPATCHLEVEL=0 -DGIT_VERSION="\\\"${PROJECT_VERSION}.GIT\\\""
> +					-i ${CMAKE_SOURCE_DIR}/git.rc -o ${CMAKE_BINARY_DIR}/git.res
> +				WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
> +				VERBATIM)
> +	else()#MSVC use rc
> +		add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.res
> +				COMMAND ${CMAKE_RC_COMPILER} /d MAJOR=${PROJECT_VERSION_MAJOR} /d MINOR=${PROJECT_VERSION_MINOR}
> +					/d MICRO=${PROJECT_VERSION_PATCH} /d PATCHLEVEL=0 /d GIT_VERSION="${PROJECT_VERSION}.GIT"
> +					/fo ${CMAKE_BINARY_DIR}/git.res ${CMAKE_SOURCE_DIR}/git.rc
> +				WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
> +				VERBATIM)
> +	endif()
>  	add_custom_target(git-rc DEPENDS ${CMAKE_BINARY_DIR}/git.res)
>  endif()

If you list a .rc in the call to add_executable() then CMake knows how to
handle it and will invoke the resource compiler on it. I am not 100% sure how
to provide additional arguments right now, but I believe it will lead to
simpler code than using add_custom_command() and add_custom_target().

Øsse

