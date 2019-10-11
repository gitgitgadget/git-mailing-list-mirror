Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 120211F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 15:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfJKPmz (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 11:42:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33009 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfJKPmy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 11:42:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id i76so6026805pgc.0
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 08:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=GWo5znymiuvhKGEcGKLJxI7j3UYUt7DRjHbgKc18pNw=;
        b=Vw1XSlokNnftIDcttgcMIBRX76VyYVWKXVWJFFcuJY8qJI73cqwiaJOPyZNQQklP9P
         tThAHFcMaFmXVuEfWdzJ3K+q2giqlOI4jI5eLfVZ5k8MyOzjv7P7MOHXuNTidDFN8URC
         /E9VexmyoatOKDY2+XOimdab88Wz/E56iAcUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=GWo5znymiuvhKGEcGKLJxI7j3UYUt7DRjHbgKc18pNw=;
        b=T44/DXd41OkgwaCuQF9Aj62xTQvaJTOZl95MWWuFfxu1qAOsJ3FUXAnmSqlXOLYQ2b
         y9J4GrZ8a4bjJfCL32cN9irwJ9AP7vgnGaeskgkohHEUukDmqs9i/exGNWSsGZBJgG6W
         M5bBSm5rX7n2jXreCcj8VcXprH3lTjA6b51mLcOfq+JkSjgssLZieEJ6l1AAsrbStdcG
         l68OxZYNdgOpHI6A6tOjba7yN2sHoqPT09HppJxx54OIlmX1rXwB6n60OWQPqe76GoG+
         zK1bYtG4XqRzxMSR9fj5SUqD9upm8UQEBNyiJxBcw3No7OwqDTk7Q8gQf1Kp0o+FA/5a
         7IpA==
X-Gm-Message-State: APjAAAUF8gk9ERW7u6LGy5yDvsL5vWgPN9kQQY8JXby4eWa3z++QNNy+
        P+fUETlocbZFXRn8pBZVFpPB/A==
X-Google-Smtp-Source: APXvYqxas8A75OaCBaYXf+UJtfoQrfK2MtAc8bqrjvIKAQeXe/1GNrjK8X5DJ/uBdzw0SLTMbyLTqQ==
X-Received: by 2002:a17:90a:ba8d:: with SMTP id t13mr18335063pjr.129.1570808573729;
        Fri, 11 Oct 2019 08:42:53 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id j24sm9646974pff.71.2019.10.11.08.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 08:42:52 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Andrew Donnellan <ajd@linux.ibm.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Christian Schoenebeck <qemu_oss@crudebyte.com>,
        patchwork@lists.ozlabs.org, Eric Blake <eblake@redhat.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] parser: Unmangle From: headers that have been mangled for DMARC purposes
In-Reply-To: <06541640-7eca-bc40-5c4b-9aa682d774a8@linux.ibm.com>
References: <20191010062047.21549-1-ajd@linux.ibm.com> <20191010194132.GA191800@google.com> <20191010225405.GA19475@sigill.intra.peff.net> <06541640-7eca-bc40-5c4b-9aa682d774a8@linux.ibm.com>
Date:   Sat, 12 Oct 2019 02:42:49 +1100
Message-ID: <87pnj3thja.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

>> Neat. There was discussion on a similar issue recently in:
>> 
>>    https://public-inbox.org/git/305577c2-709a-b632-4056-6582771176ac@redhat.com/
>> 
>> where a possible solution was to get senders to use in-body From
>> headers even when sending their own patches.
>
> I think that's a good idea.
>
>> 
>> This might provide an alternate solution (or vice versa). I kind of like
>> this one better in that it doesn't require the sender to do anything
>> differently (but it may be less robust, as it assumes the receiver
>> reliably de-mangling).
>
> Yep, it's less robust - but OTOH there's always a long tail of users 
> stuck on old versions of git for whatever reason and having some logic 
> to detect DMARC munging may thus still be useful.

I'm not sure this solution is correct.

If I take a patch from Andrew, backport it, and send to the list, Andrew
will be listed in the in-body From. However, he shouldn't be the sender
from the Patchwork point of view: he shouldn't get the patch status
notification emails - I should. We don't want to spam an original author
if their patch is backported to several different releases, or picked up
and resent in someone else's series, etc etc. So unless I've
misunderstood something, we can't rely on the in-body from matching
Patchwork's understanding of the sender.

Regards,
Daniel

>
> -- 
> Andrew Donnellan              OzLabs, ADL Canberra
> ajd@linux.ibm.com             IBM Australia Limited
>
> _______________________________________________
> Patchwork mailing list
> Patchwork@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/patchwork
