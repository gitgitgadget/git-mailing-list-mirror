Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D76D1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 06:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeGQHXD (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 03:23:03 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41845 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbeGQHXD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 03:23:03 -0400
Received: by mail-pf0-f195.google.com with SMTP id c21-v6so19222pfn.8
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 23:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sFBMf/5oTTBUihGZnwJhUO2DlHasceD3ocDgxRSHbVA=;
        b=ikPQD0ZQl5huMvYjvrWzWlhwmcGkenRnfoCrRgrexBicgM2sliFku14l1+BqyC3n96
         eOo79ugt+lLxXR2QU2QJs0DTLTDeLZDylYidfF3iu3zt/xIgQPSqgD1UzaiTmVmcgKaK
         4snjGZUGWdsQVt6QbpVnhJPRj3mamnXh+3ncOLqpv1u/mJ1o5cY7/FJCkdM/gjMR9Bvl
         XDusqd1HjEeEX/7kZjd68muL6E9bYibzb0f9d9rdNPIlh8XU4INrSrM/QkG91QCHd5+w
         TQDEln+Ifox/Tjt6sfLPBTFL1XahrI72tvHOKwyvuB8N772Ki4mqss5DTr783W0uYd+q
         bivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sFBMf/5oTTBUihGZnwJhUO2DlHasceD3ocDgxRSHbVA=;
        b=deuDqMrp9BhoF/JV+liVnxQhRQG/jsT0huwZ2wFVvKmLXiB8KbLT5lFPUqjF7W/WP2
         d2CJeCJOdDSvWQIUNCErGsshiFNPHH/UTd9IFhlNM9m6TNNcbrsjkkCs/dRVA4Ib530X
         iV7Z879wvC8m72A8gmrs5RP44kLP+qdPhbDYgOurhmFyRuIYFsCdDwvsFYcyY50bbeu1
         2qpnb92DF5Fce95Njw8Z202GBX1wDOymglwKSNeYVrmK28/e47rznewMzCSUwFwuFz/E
         8W9+aWiUDO3lDuH2higASns3bpw7nQmjo4X0stmGBAdQNYU4IGf99HKjAlziLVYfLVFh
         TIVw==
X-Gm-Message-State: AOUpUlEDLF9D5GkWe6mX7/2aHBE67c7b54/Z+1ypikSKPVpnjxay1clz
        N9IDVcn4xTgvTccNQgdpd9U=
X-Google-Smtp-Source: AAOMgpcjQChsUVYDBCk4GG9ezHhmxOSZxURnlQNa7/QZsRbfNPyucsphRE/pDYBzedWVgixd+XoAcw==
X-Received: by 2002:a62:9b57:: with SMTP id r84-v6mr443865pfd.6.1531810319224;
        Mon, 16 Jul 2018 23:51:59 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id c19-v6sm429915pfn.182.2018.07.16.23.51.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 23:51:58 -0700 (PDT)
Date:   Mon, 16 Jul 2018 23:51:51 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH v2 0/3] gc --auto: do not return error for prior errors in
 daemonized mode
Message-ID: <20180717065151.GA177907@aiede.svl.corp.google.com>
References: <20180716172717.237373-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716172717.237373-1-jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> In a087cc9819 ("git-gc --auto: protect ourselves from accumulated
> cruft", 2007-09-17), the user was warned if there were too many
> unreachable loose objects. This made sense at the time, because gc
> couldn't prune them safely. But subsequently, git prune learned the
> ability to not prune recently created loose objects, making pruning able
> to be done more safely, and gc was made to automatically prune old
> unreachable loose objects in 25ee9731c1 ("gc: call "prune --expire
> 2.weeks.ago" by default", 2008-03-12).
>
> This makes the warning unactionable by the user, as any loose objects
> left are not deleted yet because of safety, and "git prune" is not a
> command that the user is recommended to run directly anyway.

I agree that given the better alternatives we have now, "git prune" is
not such a great option these days.  E.g. should it say

	struct strbuf now = STRBUF_INIT;
	date_stamp(&now);
	...

	"run 'git gc --prune=%s' to remove them", now.buf);

?

> This was noticed when a daemonized gc run wrote this warning to the log
> file, and returned 0; but a subsequent run merely read the log file, saw
> that it is non-empty and returned -1 (which is inconsistent in that such
> a run should return 0, as it did the first time).

Here's a series to address that motivating case.  Thanks for the
careful analysis and to Peff for the patient explanations.

Sincerely,
Jonathan Nieder (3):
  gc: improve handling of errors reading gc.log
  gc: exit with status 128 on failure
  gc: do not return error for prior errors in daemonized mode

 Documentation/config.txt |  3 ++-
 builtin/gc.c             | 53 ++++++++++++++++++++++++++--------------
 t/t6500-gc.sh            |  6 ++---
 3 files changed, 40 insertions(+), 22 deletions(-)
