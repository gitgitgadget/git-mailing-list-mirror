Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A150C2D0C0
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 21:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348D9207FF
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 21:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbfBisbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfLWVl3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 16:41:29 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44135 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfLWVl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 16:41:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id 195so8897705pfw.11
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 13:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OysBAeE2XhO+fAmu3UoO7uDDuhfeORzgHDXy1nUN2sg=;
        b=fbfBisbpTasSqLjwDfXHiVnAMbkWTv6K2xBc0G3vHf4C3UeYo+2XOUU2LdrjNlRUxs
         8hoImHdydrB9h+GhXB3BQd8vKM4H3Q/BmPfETcriQ0PMFDNKTFc/E/a9sf+2obf1Plzk
         PIFFEOGaeD3BWz4sNUXGANYWYNkwj716FPFVoIWdtJdFeyBGHShXecf0hLUmANvX+2fU
         ykdAxChHatTYgvf7XDVm0iXPUedU2QCt0bsrRydK9Ghy53PLXfwOrIi4dtT8iGTXfmzY
         momS6H07zxX2oSfCxgbFRqJDwXaYazMahlA4OgdTiXnDdfKT5qh/bdwsXHRH15RcKYNa
         UMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OysBAeE2XhO+fAmu3UoO7uDDuhfeORzgHDXy1nUN2sg=;
        b=VXIIfE99oWwSf30yRKINAADMj5h3Na+uFMeVS9gxxnOzZpIePO1xoDJFwk1SLFW2lc
         XB8eMI9ncnX+NuZhECaknr9DNac6SThp0JOiUkSeblTMHa8ah7L08ugLv29hia62SZcl
         DyRJnEmzrd0uWQhcbGSUki2fr8gCfRCeqACvsIeHYPbYKQwRdLxBZxNr9NsoXHgzqgBQ
         xezxZdq+odLuyCk+elQ5J12B6X6grHQbyIOtq44WS//sOIkelrcGf+Xrfe8eD27chGBY
         I4H9pfCY4k6REN8z3X4ftH/X89+95JBhRPFBZl1pVvppVlcrEgwjfpo6QiIGfgHSusRV
         JZoQ==
X-Gm-Message-State: APjAAAVJTH5C993xOMPgGAM4xbumlEQdsEyXjbnOyOibtfso55oP0RaP
        Gs6xaap2RvtRNN+ISkd0tWc=
X-Google-Smtp-Source: APXvYqyoa7PMJiMjy6gprOqM8N1LpgsPd6bW0c+XbD8RJvKNWGIl51fwwnaRV5oOuTr+mtz8wRfnoQ==
X-Received: by 2002:a63:9548:: with SMTP id t8mr32410299pgn.205.1577137288095;
        Mon, 23 Dec 2019 13:41:28 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id p17sm24974600pfn.31.2019.12.23.13.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 13:41:27 -0800 (PST)
Date:   Mon, 23 Dec 2019 13:41:25 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Arnaud Bertrand <xda@abalgo.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Possible improvement in DB structure
Message-ID: <20191223214125.GA38316@google.com>
References: <CAEW0o+gwbNyDqmiouFzO16LsRUfcAnSwj9K77oGe5hi=EVMB=w@mail.gmail.com>
 <20191223190950.GA6240@camp.crustytoothpaste.net>
 <CAEW0o+jRW8LJqfjsDVtUiSNxwM9yBkj0c=Ddy3kEGUdsYM8myQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEW0o+jRW8LJqfjsDVtUiSNxwM9yBkj0c=Ddy3kEGUdsYM8myQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Arnaud,

Arnaud Bertrand wrote:

> Today, I think that tags are not located in objects directory but in
> refs/tags which is a good idea.;-)

Not precisely.  See "git help repository-layout" for more details, or
https://www.kernel.org/pub/software/scm/git/docs/user-manual.html#hacking-git
or the "git internals" chapter of https://git-scm.com/book/.

> The origin of my reflection was that I wanted to find an old file.
>
> I knew that in the past of my project, we had started to write a
> driver for a device and it was abandoned. I wanted to find this file.
> I knew a "key line" to search for and I knew the file was a .c file
> but I didn't know the exact name.

Thanks for this context!  It's very helpful.

> So, the goal was to parse all the database, find all the different .c
> files and grep it to find the the driver.

Git intends to make this kind of history mining not too difficult.
You can run a command like

	git log --all -S'the key line' -- '*.c'

and it should do the right thing.  Or you can do something more
complex using something like "git rev-list --all | git diff-tree
--stdin --name-only --diff-filter=D" (to show deleted files).

Is the problem that that command is too slow?

Hope that helps,
Jonathan
