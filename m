Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDFDC2BA2B
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 02:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6101421841
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 02:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8Z4629R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgDQCLL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 22:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728969AbgDQCLL (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 22:11:11 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB53C061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 19:11:11 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x3so314488pfp.7
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 19:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vIb1BkIiqQewTG9bpLs4yhzdUOau4N1XtWIvfbWYM+E=;
        b=s8Z4629R/hrvEt9BXiKQVvAYLkKy2LJeKftQGXOPd0i5YUwu22JBbd0LqLknD1cdF2
         /rzAs8FH+cfb1g+fbOuWLtkutmpfNQvLIUDEH9SxJ8uN44QJHougwp7DsBRz/KvWvvne
         JrIGOwW0fvLcCM5veePt6iR8DmxBsDte4UTz2Ef3Qx5TIOMm5pXE/6SMBvG3XqMHgnV5
         PmuPz/lO1nS0Qn/6H5diIVY2oHwrCvapptRN0eOTtVDl/P4o/mbZnYq5O0fYYnL3TCZ4
         gRu9Xrrq1cQIIh4VglZdvbZQRR2M91fGLRxH/Ktjy75CtEcOb05+OBlYy2IlUr4DYY21
         kX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vIb1BkIiqQewTG9bpLs4yhzdUOau4N1XtWIvfbWYM+E=;
        b=dvumkAlJxMnY+fhyZiyKhB64j5EasTWbskqPBT3MO9mLln+Kq0fHrzJR8JNum41x24
         go5MdJqHXa9AVqoXqSS+/2NQmfwdZfxMDOliu3549CpM3j6WNeVWEw0shMZO2KQ6YWLv
         vIQXnmDhS/QiRwu0OxFSlcfviDw4CbVhApZ187aaf9N9N/o88Kyj9mHdiVlACvn6+Rw3
         RgZY+1ZStbdm4uiOPycYZ/JQ0u1nGBb3OjEodmuoumUNvwh8TgvWEHmpr3mRKRiKrLau
         9gr7PeRRfyFo+EnqlxYY8/qS65GMuGzzTUep9lL2pYMYgV5pckKjyhMJvcAjP8fgqkvV
         zE6g==
X-Gm-Message-State: AGi0PuaKD2yXs6zeHkN4eTWBDdSNA1cmiNyUvOAI/Adaqrd8V+ZE/P5t
        ERkhoLqkO6Tpmjd/3MBCRPo=
X-Google-Smtp-Source: APiQypJTWFRV6hdczSbiOkkjk58KI6U9FFNXsdURBy2Ts2vzuNkMbGgKBPHjwU67PxWGThuRgeujIQ==
X-Received: by 2002:aa7:9e4d:: with SMTP id z13mr879270pfq.6.1587089470570;
        Thu, 16 Apr 2020 19:11:10 -0700 (PDT)
Received: from localhost ([2402:800:6374:5380:b9e1:93e1:68db:b9f6])
        by smtp.gmail.com with ESMTPSA id a9sm16699155pgv.18.2020.04.16.19.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 19:11:09 -0700 (PDT)
Date:   Fri, 17 Apr 2020 09:11:08 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 1/5] help: move list_config_help to builtin/help
Message-ID: <20200417021108.GA22340@danh.dev>
References: <20200416211807.60811-1-emilyshaffer@google.com>
 <20200416211807.60811-2-emilyshaffer@google.com>
 <20200417020426.GD2285@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417020426.GD2285@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-17 09:04:26+0700, Danh Doan <congdanhqx@gmail.com> wrote:
> On 2020-04-16 14:18:03-0700, Emily Shaffer <emilyshaffer@google.com> wrote:
> > diff --git a/config.mak.uname b/config.mak.uname
> > index 0ab8e00938..f880cc2792 100644
> > --- a/config.mak.uname
> > +++ b/config.mak.uname
> > @@ -721,9 +721,9 @@ vcxproj:
> >  	 echo '</Project>') >git-remote-http/LinkOrCopyRemoteHttp.targets
> >  	git add -f git/LinkOrCopyBuiltins.targets git-remote-http/LinkOrCopyRemoteHttp.targets
> >  
> > -	# Add command-list.h
> > -	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 command-list.h
> > -	git add -f command-list.h
> > +	# Add command-list.h and config-list.h
> > +	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 config-list.h command-list.h
> 
> In <nycvar.QRO.7.76.6.2004161406480.46@tvgsbejvaqbjf.bet>,
> Dscho suggested to squash his patch instead:
> 
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2002261649550.46@tvgsbejvaqbjf.bet/

Sorry, I'm an idiot, please ignore my reply.
His patch is used for old series.


-- 
Danh
