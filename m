Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53FF720281
	for <e@80x24.org>; Tue, 19 Sep 2017 02:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbdISCgH (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 22:36:07 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:52895 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbdISCgG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 22:36:06 -0400
Received: by mail-pf0-f169.google.com with SMTP id p87so1242096pfj.9
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 19:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=34BR5Ibn1kGeiMkoZxk0Oz1wzknB9FN+qBlFvzwad+E=;
        b=rwm7ELMOyp8yEB8JbDYpNgWZUhe7AzNwsRWBbA4dtizIioyMm148em/sz/033Fsvlj
         AIx7+/faM+cTyuHVscBuX80nm4dYnkGBKa76+HxxkoHjwdxZcfbbo1o7lwt5a5uGrEbu
         BQtqx8qJRwC4gJWg01ZaoFjWY4McFt+m6J0RikP5duwZzzL/gdOXPZajF2FvvX0gT2jF
         m1+ctp77o/D4w4j9fjsy3mNiwdPnrow792JDBYqsMDevj6VT8jhFrhk4Oy3TIp//6g0Q
         YErUrSu7y7W/dKARKvFf/6F2nJGed2zCZwEWdbf09gxSyx6pYkPfUemQa9bw1Nm6fT4E
         jihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=34BR5Ibn1kGeiMkoZxk0Oz1wzknB9FN+qBlFvzwad+E=;
        b=BwLtSCKoN4gh1sGfu3yfWjrvnDuk6TlL7xNAPs970tbJAV+FvtPbb21e+Pn8OATSRi
         2JBSgqvDXLPiab4R3Mfy3pfwxwyeUlYdD9GDjbngErM/GpDLEO5/p1fv1UcVLx4JRWeL
         KseSa3EBZKVZKWnyqMWfmkNmKzu5v7aBhOo32ohr8IQD2pWzZXzDNh0xEdHpICtZSgg0
         H2jxJX72OiSGIqL+5lASyMrvHXERhsxBpgD6m/aemoTVYndTxvs8NvqVYGuNfybcpfnQ
         Ivm2qHBCgjisE2ibfHh0PFzvEKjUQP/TdBz/xE4WosiLxsdlBnwJuQk+O8Gvbu0T4+uQ
         unxA==
X-Gm-Message-State: AHPjjUj31qZQekZ1QbjfeyW+XXjGaeg4QTYxSXJsupcFYOD15IlJK1G0
        C7AgbiK8QE3hSw==
X-Google-Smtp-Source: AOwi7QDw5cATHKLCUEtWBVOGkNl5+ah2WXD4MPZma88BQ9XmztAYU46PGsL/o4BkE+0iXfXb/0HUxQ==
X-Received: by 10.99.3.216 with SMTP id 207mr579359pgd.15.1505788565725;
        Mon, 18 Sep 2017 19:36:05 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:288c:7217:eb8c:bacc])
        by smtp.gmail.com with ESMTPSA id e185sm959270pfg.142.2017.09.18.19.36.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Sep 2017 19:36:05 -0700 (PDT)
Date:   Mon, 18 Sep 2017 19:36:03 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/2] fix read past end of array in alternates files
Message-ID: <20170919023603.GB175206@aiede.mtv.corp.google.com>
References: <20170918155059.54f7z6cnrl47f5el@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170918155059.54f7z6cnrl47f5el@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> This series fixes a regression in v2.11.1 where we might read past the
> end of an mmap'd buffer. It was introduced in cf3c635210,

The above information is super helpful.  Can it go in one of the commit
messages?

>                                                           but I didn't
> base the patch on there, for a few reasons:
>
>   1. There's a trivial conflict when merging up (because of
>      git_open_noatime() becoming just git_open() in the inerim).
>
>   2. The reproduction advice relies on our SANITIZE Makefile knob, which
>      didn't exist back then.
>
>   3. The second patch does not apply there because we don't have
>      warn_on_fopen_errors(). Though admittedly it could be applied
>      separately after merging up; it's just a clean-up on top.

Even this part could go in a commit message, but it's fine for it not
to.

Thanks,
Jonathan
