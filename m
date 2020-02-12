Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03D8C35242
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 01:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14A720724
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 01:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISKCt3fT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgBLBfl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 20:35:41 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:46297 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbgBLBfl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 20:35:41 -0500
Received: by mail-pg1-f170.google.com with SMTP id b35so185247pgm.13
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 17:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+9nqptLpZrECQnmjBfLnVIBOvBVwolqv9w93hsEc4WI=;
        b=ISKCt3fTItUIn/Y8vDYgSPpBHn4RdkrlZnzPRIDdzLnCrV1btoWzuR7m/R5GLSYYJ9
         k/x1D8XWRMdwMzVgSykrahAF+b3NW5dt1PLRG/l0QpdiahRdzC5nc3FFqorPQsv6Po/6
         yWaeG13GZb48E6oHRDzsWpG2utlSBRIjGpcaVNMzblc95SazmPyKKJiXNarmRu02lGGC
         uc1F5B+nNyJx+4mnwB2P4MXc2lbm63SBdiao7jVIpSOrBPyCfsryeBxJ+ioO1akoQXaj
         75hB/VY57ocFW6flvpQ/3JtqjZi7NOIyOgUF0X2TBsey45/wgmJ0/I6nReRrn9HBgySP
         C6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+9nqptLpZrECQnmjBfLnVIBOvBVwolqv9w93hsEc4WI=;
        b=sNarP3RD0pxTHvNt+dJvfGB8vVF9Vwr//aOvvVkLno0ptMwngD6Hx+cKH4RrFJmZnl
         oV6WH8gI1byBXl38CNtvda5iQLAxuHq7DH9wjbwJbAtr08N/vVkYxbkgfnFAH37+j2Q3
         xE89o8ztM7YNj7Br4OeYFZXMzh6dw4BO8Zep/tqzmOqAiH3qG/6nO2hI9syoGOACWf8N
         EDtoYVGawuUbFqgfzRNVGiNVa0JLoYH4V8UDIBlsLe1ctthgVWoMNiEoLEYJ9dSM08ga
         pAXxeVUEwduD6jf+1Q7fz77FlNJYwvfKDlgRVOx1gTHoX1eoDqaSOE+JZV7HfqO3sxUX
         LCNg==
X-Gm-Message-State: APjAAAXGIaKcW8SIoWOfE+9oOcbmP4+fhL3uM0jtcGJdyb/XqhD4a4Je
        7dWVB6drbRL3hwm8pWi+DE8=
X-Google-Smtp-Source: APXvYqxtrK0T8XYVZgDk6eg4mNjxMOH5ESD+SZZTZ361aEwaXKZO0mK3fTyg6cyqsFdAAM3krvRZxA==
X-Received: by 2002:aa7:9633:: with SMTP id r19mr6229177pfg.90.1581471339445;
        Tue, 11 Feb 2020 17:35:39 -0800 (PST)
Received: from google.com (240.242.82.34.bc.googleusercontent.com. [34.82.242.240])
        by smtp.gmail.com with ESMTPSA id k9sm4300367pjo.19.2020.02.11.17.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 17:35:38 -0800 (PST)
Date:   Wed, 12 Feb 2020 01:35:37 +0000
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Toon Claes <toon@iotcl.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: URL rewrites for submodules
Message-ID: <20200212013537.GA18770@google.com>
References: <87wo8ucgar.fsf@iotcl.com>
 <xmqqv9oexfnr.fsf@gitster-ct.c.googlers.com>
 <87sgjgdeh5.fsf@iotcl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgjgdeh5.fsf@iotcl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Toon Claes wrote:
> Junio C Hamano <gitster@pobox.com> writes:

>> If you define them instead in $HOME/.gitconfig, that would apply
>> equally to all repositories you would access.
>
> Yes, that makes sense to me too. But in my testing adding URL rewrites
> did not apply to submodules anyway.

Hm, that doesn't match my experience --- I've been able to use URL
rewrite rules reliably.

Do you have a sequence of commands I can run to reproduce the issue
you're running into?

Thanks and hope that helps,
Jonathan
