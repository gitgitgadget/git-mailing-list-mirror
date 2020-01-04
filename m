Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8006DC00523
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 01:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A63217F4
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 01:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAhcn7K6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgADB5x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jan 2020 20:57:53 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44242 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbgADB5x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jan 2020 20:57:53 -0500
Received: by mail-pf1-f195.google.com with SMTP id 195so23404903pfw.11
        for <git@vger.kernel.org>; Fri, 03 Jan 2020 17:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KkEJ+8qQazbFMKw7cWIXlMNhR7YOBhQOqOGuyRMK4qY=;
        b=bAhcn7K6smJsOZiEQwYbmDrNSBYIiAICXQozn+hEFZJUIDaBckPate9/onc7QkArCj
         B9J4CtkAaUGETmuUY7jW/lVaFtm29J08bvqAhzfgQJEBRcTaTtsQ34DJxEnJXUHcZyk/
         oKjqQkgXNOdVpHJm7DNirxZP0vT4a26bSfd9XlmoxAMJoKgbKcyi2hHYRAFhZpr33F4K
         dr1DpR5sf9NFPHe5U8VG0QS8H9DtjX7RJ2NJrzcRRyTf2LsDE7ZmwVdmViWLLXv/shZK
         JL/v7NN+qxFjvpUaQnQhTDj419rD/A3ddtQ4PBnO9DSibq1n6e3yhRZmdmqFmrAj1fmj
         y57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KkEJ+8qQazbFMKw7cWIXlMNhR7YOBhQOqOGuyRMK4qY=;
        b=RppJpqp+bViP8HiTjEr859XAlSH1IXpw+FItqWeUg2KwZ1JzVbnHWhWvKLUxPCCd46
         6y8yXD+9qQ8fgEv+BOPqj/acjTejuwETgeoutt2dfxB/okXaVJu39phTe5LqXyDPeOf+
         OuXvhAuoGiHWEZNmqIeOInMzfYFQ2kcE9vnR7xYLGeEJiaAyH8LG1UEHQoy/YkiWycBf
         qxDtnduwFQqLsHzgWRMb6uYfUWpZSox39L4I/Yr7TzOWERYvp7DEE6iKvfB6uGlaoLfJ
         v5BDmZdMY6FBOPR4XzSMaXPrTBW5gZttMBW7Z4jGrRrpSLmG14rM9pRPNGtfn9+JIhWs
         RRdA==
X-Gm-Message-State: APjAAAU74I3GNTIktIUqgKhPqAfwRKx0t+zp9Ux0FecTCXdN9NYngPAJ
        tbLvVdbQr/a3NjbPxe9hWiYV0xil
X-Google-Smtp-Source: APXvYqzGxpdmVj2d7FysiWL++w4jfbI99iEExgBdPIhLFY5LjyuoFv01932u3GMrvo+XUXCIlYhDiA==
X-Received: by 2002:a63:6b07:: with SMTP id g7mr82383098pgc.243.1578103072477;
        Fri, 03 Jan 2020 17:57:52 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id 13sm67664014pfi.78.2020.01.03.17.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 17:57:51 -0800 (PST)
Date:   Fri, 3 Jan 2020 17:57:49 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] mingw: only test index entries for backslashes, not
 tree entries
Message-ID: <20200104015749.GE130883@google.com>
References: <pull.682.git.git.1577382151.gitgitgadget@gmail.com>
 <4a120fd0b32d2d6492eac6b0494ad6b1bc2ba500.1577382151.git.gitgitgadget@gmail.com>
 <20191226200316.GD170890@google.com>
 <nycvar.QRO.7.76.6.1912262221000.46@tvgsbejvaqbjf.bet>
 <20191226214245.GA186931@google.com>
 <nycvar.QRO.7.76.6.2001022053530.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2001022053530.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:

> As mentioned above, the idea is to prevent Git from attempting to create
> files with illegal file name characters.
[...]
> On Thu, 26 Dec 2019, Jonathan Nieder wrote:

>> Is there anything we can or should do to prevent people checking in
>> new examples of paths with backslash in them (on all platforms)?
>
> As mentioned in my reply to Junio, I don't think that it would be wise to
> even try to warn about backslashes in the file names. There are _so_ many
> Git users out there, I am convinced that at least some of them have valid
> use cases for file names with backslashes in them.

Thanks for the quick answers.  It helps.

I think allowing people to clone
https://github.com/zephyrproject-rtos/civetweb but not to check out
the problematic historic revision is a reasonable choice, especially
since it's still possible to get the data from there using

	git checkout <rev> -- . ':!bad-paths'

[...]
> Or maybe you know of a code path in the `unpack_trees()` machinery that
> does _not_ go through `add_index_entry()`? I would be very interested to
> learn about such code paths.

Every once in a while someone (e.g., in #git) has wanted "git checkout
--skip-index <rev> -- <paths>", and that would be the natural way to
implement such a thing.  But no one has done it yet. :)

We'll just have to keep a watchful eye as people make new
contributions.

Sincerely,
Jonathan
