Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE578C433F5
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 00:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD40E61247
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 00:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344887AbhJRA5T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Oct 2021 20:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344885AbhJRA5S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Oct 2021 20:57:18 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F143C06161C
        for <git@vger.kernel.org>; Sun, 17 Oct 2021 17:55:08 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q5so14306234pgr.7
        for <git@vger.kernel.org>; Sun, 17 Oct 2021 17:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xiWnAD80anBAjKjk9hUkXoIMiPD+YI+P5dBpz2bFegY=;
        b=nTioPKGpb06uYs/mqeDjTQHsZpb1BMWCeAv0TE+RxkYuAZ+epW4hKn5UNFl2aTYrMq
         SSDk9rX6Punf6xIEUVbFPehGNfpREW+qVK6qALR5HNh3KttaZ5xWm3QqR8wQ1sqPM89N
         /6EVBqfL7PwehAZWyJ+dr5p6IzY5tQrMTCIK45jZ6RhQbDrZo3ENSpUMkseCCXGfCHxB
         9A4FRDLZHMAXLYZfLmeojEtSYOvXMpWae8a8ksHlh+e/rT0QnWtd0gRKIpoJWM9j+QnL
         bHjXi8Jw1/lGHEKCNt9g+0qmL3PvZzfR3gNj3saXUJfQUVo2gvduGgHmaBwd2HJUKpNa
         C/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xiWnAD80anBAjKjk9hUkXoIMiPD+YI+P5dBpz2bFegY=;
        b=rPmNLBIALYiboAgPSAih7kfpPKB8Uvqxlq6QCUP0gGksXaaRWIMitajWVaVX4rc9a7
         F4rJL12IUZzxXXITHmM2zubATYbWjWpK9WPWyDph1jiW0rqN2guUyXq6lkXvqJi5qZ4e
         VLZogwwD5ZGzpUGFpym+1g8fxHIhng/cg+2qggKI+uuFdOsGO9lfxzM1G5FN6++hIbYt
         qLEWHsfTzaDJDHZRg3PINClODDdhIiVMeFiZVmp5efxgoSxq8GmIiuUr7O8QzttGpovX
         HGq5yEgFLyhZmNBG0FCsJhRw7WI2fs9HCLIvdIEBERJApaUGD2Ixcql4E2Ys2DPdMQRj
         KA2w==
X-Gm-Message-State: AOAM530wLbXrKSxQOqqnEd+JVMLGMLPWwQ5UrtWE2RmVZobh//FQ3G+Z
        SaJFXk655eNdDQbFhPNqUEs=
X-Google-Smtp-Source: ABdhPJxgBI7tGHDMlllzKX81gmxsNEV0U0OBmq9yLCjcHrbn5lGWWJAVHPYCdV6fEtGfAb08l1iHWw==
X-Received: by 2002:a63:36ca:: with SMTP id d193mr20494722pga.73.1634518507975;
        Sun, 17 Oct 2021 17:55:07 -0700 (PDT)
Received: from gmail.com (93.77.230.35.bc.googleusercontent.com. [35.230.77.93])
        by smtp.gmail.com with ESMTPSA id o127sm11131730pfb.216.2021.10.17.17.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 17:55:07 -0700 (PDT)
Date:   Sun, 17 Oct 2021 17:55:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Joey Hess <joeyh@joeyh.name>,
        git@vger.kernel.org
Subject: Re: [PATCH] avoid insecure use of mail in man page example
Message-ID: <YWzF6deqfffBM7ub@gmail.com>
References: <20210928121648.1390915-1-joeyh@joeyh.name>
 <YVNi91WYyj3Le6UF@coredump.intra.peff.net>
 <xmqqtui4gt5f.fsf@gitster.g>
 <YVOy0HLvManYQdGo@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVOy0HLvManYQdGo@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Tue, Sep 28, 2021 at 04:46:52PM -0700, Junio C Hamano wrote:
>>> On Tue, Sep 28, 2021 at 08:16:48AM -0400, Joey Hess wrote:

>>>> As recently seen in fail2ban's security hole (CVE-2021-32749),
>>>> piping user controlled input to mail is exploitable,
>>>> since a line starting with "~! foo" in the input will run command foo.
[...]
>> It is not the primary focus for this documentation page to teach how
>> to send e-mails in the first place.  Instead of risking confused
>> users rightly complain with "my 'mail' does not understand the -E
>> option---what does this do?", I wonder if it is better to just change it to
>> 
>> 	git rev-list --pretty ...
>> -   fi |
>> -   mail -s ...    
>> +   fi >>/var/log/update.log
>> 
>> so that it illustrates what's available *out* *of* *us* to the
>> authors of the script, without having to teach them "mail" and other
>> things we are responsible for.
>
> Yeah, I'd agree that side-stepping the issue entirely is a good
> direction. Doing it right is probably best left to tools like
> git-multimail.

This makes sense to me.  Joey, are you planning to send an updated
version of the patch, or would you like us to take care of it?

Thanks,
Jonathan
