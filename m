Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B583C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 05:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17F9020870
	for <git@archiver.kernel.org>; Fri,  8 May 2020 05:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1LWxDRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgEHFrg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 01:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgEHFrf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 01:47:35 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49F6C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 22:47:35 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id b8so357782pgi.11
        for <git@vger.kernel.org>; Thu, 07 May 2020 22:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oHgNCGZVOf77I3czFSSGL4ViB7u1R10YuLnk50NpgcY=;
        b=X1LWxDRxdoxRBa7tKpJYU7rSeLFuuArojoT3GmRVdiNbE2gcNNHQHQfqXO1gcRyOtB
         fyA4G2vXnjAqdq8CfrdhA7Ms9zvSvG5ud1/NQw842yEVw0bqM7gOhHanv94rWEqIDKR3
         Ia0rejeLkFjRddQtUhF4F34ubJ/NPgVd6ZmZhaJxHTxZAHGCyKEhvF0odPZ8g8R6ahrj
         rq16GdelaOfHAYY8N/PqWUa6xxUhAsCNcRcA81FbsXivYje1FpjWMO01U+frqeWRwyAe
         HnsbjgM6ASKGAC4RY4kyQkuSKQWGWVDNyjm81cNNo7FSWZfUW9r7KMG1BKdnhNz9ru6r
         fwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oHgNCGZVOf77I3czFSSGL4ViB7u1R10YuLnk50NpgcY=;
        b=eSb9O+jGrXN2sjeuQPlbPfXzEoMzFshqzW3p1KkH0GUR03RG3VX2ZXkAZIDBWoLurZ
         l7uxo9wNpzdXbAu5wxEsZasOeiRVUXGuNKM8Hb4OsQAWcjpYGcMnxV37depy5336NcCN
         D8EZ6NiVpdOZIdn/7CcQSRFHUwaA0nzTKOM65f2fGHQ7eItrLu0CdXvLKH2gOAj5APf1
         1b9MI8AwpcuFw2JJ4ZU2Vx8vSnDlh72G60tjbXbi4Q6U1yKVREvpBEZw2zVymyzIvkvk
         ARG5PdO4l25HQlQc47CZ5uw79AKb3H30QjLky63nAF9o6fiyZtiPDck++UQQkl2LjhD8
         C9/Q==
X-Gm-Message-State: AGi0PubhxUGFsHhFjCOfeKNRMGtHxcoglhupQtvMi5H8guSDxwdewmgl
        8GmNReHL3SaCa9G3fjLVvvuJuh/je365zg==
X-Google-Smtp-Source: APiQypJmqIICHRAhvSeiCfr7RicLwrYTkd2rZ1I5zBG6ABqgLArscpbxZAHG0u2q+9s4RS1022T6Qg==
X-Received: by 2002:a63:82c1:: with SMTP id w184mr815053pgd.268.1588916855301;
        Thu, 07 May 2020 22:47:35 -0700 (PDT)
Received: from konoha ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id b1sm563854pfi.140.2020.05.07.22.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 22:47:34 -0700 (PDT)
Date:   Fri, 8 May 2020 11:17:28 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     chrisitan.couder@gmail.com, liu.denton@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH v4] submodule: port subcommand 'set-url' from shell to C
Message-ID: <20200508054728.GA8615@konoha>
References: <20200506073717.9789-1-shouryashukla.oo@gmail.com>
 <xmqqtv0t6l84.fsf@gitster.c.googlers.com>
 <20200506181239.GA5683@konoha>
 <xmqqwo5o6hzp.fsf@gitster.c.googlers.com>
 <20200507044028.GA5168@konoha>
 <xmqqv9l849i4.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv9l849i4.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/05 10:08, Junio C Hamano wrote:
> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
> 
> > No worries. BTW, should I include the `path == NULL` check in the
> > if-statement?
> 
> If I were writing this code, I would probably write it like so:
> 
> 	if (!path || !newurl)
> 		oops;
> 
> Specifically, I would write "!path", not "path == NULL".  I thought
> a rule for that is in the CodingGuidelines (I didn't double check,
> though).

I could not find a rule like that in the CodingGuidelines.
Should I add it?
https://github.com/git/git/blob/master/Documentation/CodingGuidelines

> The comparison on argc is to see if we are even allowed to access
> argv[0] and/or argv[1].  In practice, if what main() got from the
> outside world in argv[] is passed directly to you, argv[n] would
> never be NULL as long as n < argc, but there are a few levels of
> callchain between main() and you (i.e. module_set_url()), so not
> counting on that would be sensible.

Understood. I will add the NULL check as well.
