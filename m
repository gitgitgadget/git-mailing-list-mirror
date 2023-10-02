Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E92E784BC
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 15:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238014AbjJBPSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 11:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbjJBPSx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 11:18:53 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D871D9
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 08:18:49 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77412b91c41so954139485a.1
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 08:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696259928; x=1696864728; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s10GRTed29bKKTFfORZ+bFNlJ/4owO6bFrxbpmxIgLc=;
        b=LPmb3www1sHl1YaSV6zzHaDnHDNHBP0GfB28fxj2JpxoYsWhyaeIXPY7qPDfOm16tV
         BKP8Xytb750YFUtY3Anhra6oEERcsIjhCxwMjh4nV2ATXDnsZTCXE08ufEh6rZctuyzc
         MhU0CoeKTwMaTswrlf1Aa0yN1cDrSscAGJhdGSBysYFQyEiJL6EsujOJ0Vcw5++xR1pR
         y6HqjTc5conK6gKd+DFrOn8B7vGLyNtWl+TustuWoQn3GfB9nvGy3Oz1DyRNwPP0lUmJ
         8b3h9mScFu+LXvx5O+9/lYLyqEbBpyNgw58wnbYi+EAxuL4sYYixKq+E9xQH7ctc0lwh
         JQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696259928; x=1696864728;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s10GRTed29bKKTFfORZ+bFNlJ/4owO6bFrxbpmxIgLc=;
        b=bEkAEPFvhZes4hD2yA8affnMSL6yRN3+rAHC9bGupshc1XXslgktT9KhyghvaNYujR
         Papnp3VLpXxoKcaVrCDLeLnTLQTXntxUPJ1Y0E3cgRW4NxrTlscly8OSrnM7WfmjW4aD
         TKCUaTv0YLCsItAsbKHef7RpNXFyudjLgtvzuCAgbPA+GKJyBkigNHnA2tJM/sY1AFQm
         3hNsbDGKcDB+K+RGvLOlj5dBl/ORLHuGkj/XM8Z7wInCAtCSlPfGQR7kP2bdXCPD/tcc
         Cw37XlL7V8x/A1Ij0nRS5UkVXhznc5YdkPfaWmZ6wDguO/Q13iT6A3iCjRLiAZY43FY8
         aj9Q==
X-Gm-Message-State: AOJu0YwPp+Lm6zRhHhWuNFYAuk1ZcvIkCCjS6LAe1glEpBKRXouoPO0f
        gDXjcgZSD5Tat3IHuuc0JrAUI7Hod5o5HA8Q15z7Vw==
X-Google-Smtp-Source: AGHT+IGTY5fg0WGucnyh8DxN53ozg+0AbfHrWZo1u4pcq/4OjgZVVxdRku3m9Rd1SclsD7uQeehHhQ==
X-Received: by 2002:a05:620a:3951:b0:775:6650:bc54 with SMTP id qs17-20020a05620a395100b007756650bc54mr12173011qkn.28.1696259927984;
        Mon, 02 Oct 2023 08:18:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c4-20020a05620a134400b00773f008da40sm5051775qkl.125.2023.10.02.08.18.47
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:18:47 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:18:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [TOPIC 3/12] Designing a Makefile for multiple libraries
Message-ID: <ZRrfVtIbYrPiY3qy@nand.local>
References: <ZRregi3JJXFs4Msb@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZRregi3JJXFs4Msb@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Presenter: Calvin Wan, Notetaker: Keanen Wold)

* Looking for help with makefile use and how he's making libraries
* Wants to have rules to leverage makefiles repeatable for future libraries
* Wants a fail fast for breaking libraries
* Current approach that isn't working so well
   * Each library to have its own section - using directives to section off the
     libraries
* Request
   * Are there makefile experts who can help?
* (Jonathan) do you have an example?
   * (Calvin) using ‘ifdef GIT_STD_LIBRARY' to tweak what goes in LIB_OBJS. This
     approach doesn't scale.
* (Peff) for every C file you have two copies?
   * No, for every reference they are using the same file
* (Junio) libgit.a will we need something different, if so, why?
   * Stubs, how do they come into play?
   * If we had a makefile for a library, we're trying to understand how we have a subset
* (Jonathan) Do I end up with two different .o files?
   * Yes, there is a subset of shared and not shared files
   * Some of the objects are the same, the stubs are different.
   * The problems are the stubs which are shared
* (Calvin?) ideally we want the .o files to be the same
   * Yes
* (Peff) if you are worried about writing the same rules again and again, there
  should be a solution
   * Yes, it will likely have to be a custom pattern
   * Does anyone have a solution that has worked before? A simple solution? OR
     our own custom templating
* (Phillip) can we build the file in standard git so we're not creating the file
  for two different libraries?
* (Emily) if we are changing the behavior using standard git builds and library
  builds...
* (Jonathan) in the past other projects used recursive "make" to reflect module
  structure in the build structure, which has lots of downsides (Peter Miller,
  Recursive make considered harmful).
   * We can define our own structure of what we want the Makefile to look like.
     Linux kernel files are perhaps a good example. There's not necessarily one
     standard everyone follows, it tends to be very codebase specific
   * For better or worse, "make" is a "build your own" kind of build system
* (Emily) why are we not using a different build system? Such as CMake
   * What are the technical reasons for make?
* (Junio) How do the libraries and make relate to each other? Avoiding
  compile-time conditional behavior seems desirable anyway - git as a consumer
  of the library can also benefit from cleaner error handling.
   * (Emily) cleanup related to the library might mean moving exit()/die()
     closer to the built-in. Do we consider that potentially valuable instead of
     useless churn?
      * (Junio) yes
* (Jakub) It's easier to die when something is wrong at the top level
   * (Peff) It depends on what level of error handling we want to get to. The
     reality of C is every single malloc can fail. Do we need to check every
     error?
   * (brian) standard error handling mechanism would be helpful.
* (Emily) for libgit2 does the caller handle the memory?
   * (brian) a dummy value (git_buf_oom) where you can check if it's out of
     memory
