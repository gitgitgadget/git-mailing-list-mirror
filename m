Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326F4C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 15:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiKGPLq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 10:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiKGPLm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 10:11:42 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072321DF3E
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 07:11:41 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id a5so18024081edb.11
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 07:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EO8X5sId2be0DmQ8ha2SVCkN3F3+2z9KbkTtoaI5JxM=;
        b=f+QbOvOaXQfFChtg+CRNLibng2zosZkrl7OXBEMvu64s0bVGjwy74mIIii6ekk4iT4
         NL8YwgQGNQWgZSqhkUaf16m9m7WVR43LWkC+/fvbuzyQOmz80D+UtmtyfuyHwl/cFRMw
         XDaKXxdxz/g4nZ0TrKEolY+NO3J1249UNtM/P4PlLkcHlFdv5XWD7eV/pgZQz/hKTYp8
         ZygjKzivrT8NcRxHqTJ/hnfNmpOsk/pVvI/zmE+fETs68UfQ/6g/zNDdRSB1LN71lSCk
         uwJNhDJUlZHpdeucA10ndmJ4GODV6NpnGRLp7ed+InoXaH3bHeD7oeoyZ6vdkCat6e3m
         QneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EO8X5sId2be0DmQ8ha2SVCkN3F3+2z9KbkTtoaI5JxM=;
        b=fTDvKnQbrRioaEs4kXqHvVJYKSE1YmjBj4wL5q8zS/3m1E/oL61Yn9GSjmf97Ew6ZW
         6AsDA87ZyeSEWJdH1TUbCPBbeXaTgQMZeezAFFdrkp5ZfVeboBEAWevcrFBLQZyiBU7B
         l6OMDWg75lAFtyFHEPcxeTyVdvYiKIGCLMRMNfANDIdBLQTB/kgGZ8ixg7WuxwLYSnZJ
         FVPlfknA+PEhFmkFi9HmdVyGpBKZ6p4S8SwUHBx+xfKWR1QQWasfiKPzDT0Kvmht4Ayb
         crDkC2vrxmBO2Bd3wZNNeXwRexzgpvPXDb3NVqbL7lhkJ/gsQ1/T645mpIw9tf3ZFNZ8
         Jb7A==
X-Gm-Message-State: ACrzQf3tSpmjX/Qzi9XPOjaH3NGsFnBHleEiZe61kff5ZzTuHBAZe6fG
        PBbFglSmpM43UGpBYNsYWN8w9ZI7y+g=
X-Google-Smtp-Source: AMsMyM44vCMsMTWhrp+Ogk6YATUY0zSi/jRIppVwwS7Zf5OG+3MzSxSKfNFuYy8n5MevKtLaESRi/g==
X-Received: by 2002:a50:a449:0:b0:464:718c:a507 with SMTP id v9-20020a50a449000000b00464718ca507mr18071571edb.401.1667833899379;
        Mon, 07 Nov 2022 07:11:39 -0800 (PST)
Received: from localhost (84-236-78-97.pool.digikabel.hu. [84.236.78.97])
        by smtp.gmail.com with ESMTPSA id w23-20020aa7dcd7000000b00443d657d8a4sm4302354edu.61.2022.11.07.07.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 07:11:38 -0800 (PST)
Date:   Mon, 7 Nov 2022 16:11:15 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, man dog <dogman888888@gmail.com>
Subject: Re: [PATCH 1/3] line-log: free diff queue when processing non-merge
 commits
Message-ID: <20221107151115.GA1951@szeder.dev>
References: <Y2BElOFGJ8JinYxC@nand.local>
 <20221102220142.574890-1-szeder.dev@gmail.com>
 <20221102220142.574890-2-szeder.dev@gmail.com>
 <Y2MJRRfwG7rSp6Ra@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2MJRRfwG7rSp6Ra@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2022 at 08:20:21PM -0400, Taylor Blau wrote:
> > +void diff_free_queue(struct diff_queue_struct *q)
> > +{
> > +	for (int i = 0; i < q->nr; i++)
> > +		diff_free_filepair(q->queue[i]);
> > +	free(q->queue);
> > +}
> 
> Though I wonder, should diff_free_queue() be a noop when q is NULL? The
> caller in process_ranges_ordinary_commit() doesn't care, of course,
> since q is always non-NULL there.
> 
> But if we're making it part of the diff API, we should probably err on
> the side of flexibility.

On one hand, strbuf_reset(), string_list_clear(), or strvec_clear()
would all segfault on a NULL strbuf, string_list, or strvec pointer.

On the other hand, given the usage patterns of the diff API, and that
it mostly only works on the dreaded global 'diff_queued_diff'
instance, I don't think there is any flexibility to be gained with
this; indeed it is already more flexible than many diff API functions
as it works on the diff queue given as parameter instead of that
global instance.

