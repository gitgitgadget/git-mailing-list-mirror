Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45010C2D0C3
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 07:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4FC20803
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 07:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hjy78vDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfLDHYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:24:41 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36472 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfLDHYl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 02:24:41 -0500
Received: by mail-pf1-f196.google.com with SMTP id b19so3185226pfd.3
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 23:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kg6JSHzKDLj/oMkAU9c8gQoL9W0PuInQLHtHDZngbEg=;
        b=Hjy78vDNLYb/IC4qx1JCVe6Zw0Se2dvlWUH0FzBJ2QHVMrqLkDtpD7+LRSBFFL/RJB
         LuQrQ74Q3oxjNS9e6U9xEMPu9Yl1T2prZpK54AJjwcO7SBPe5S4gyMEe1znQWZVlT2gP
         FXUFn034A+JnjTXWkxKWWJ4BOg6OFu+4nNJZx4YwFzf+91D4j7cuWGUxJffDSkntxJvG
         JiO4TCIxhGaHGSmCXHBYia8gseMJRxshTv/pd/O/EDRC3dO3zoGUV4cXmDYaVp0Qyo2W
         noNxE9lFpr66EbTaES2sCS1BYLld2Q3Rp9JbakTgqYQlcTZjSU1FdgCGqzXgh9up0z+S
         9HTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kg6JSHzKDLj/oMkAU9c8gQoL9W0PuInQLHtHDZngbEg=;
        b=ddE8948jGs3whRqr1+jnEHApq5tVjueR2mMy7mLfaf+nKEMEaypWsfb1CSceCpMEtB
         nctoDsPrNMt1hQlUleqYcSeKHMpdyPmPhysWAB/EeoOh/J0UhC/IJHM+20QDX1SQB5rG
         OepmOxgGTA4JpoVJ1MYScU1UHkammfoiHR2XgoD1+gMqaYiYbYCZJEedh6PN0YD6GNmz
         Gcwiw8tlZdZehxlLn9GbIhyIIo0suMAFRYjaBiQGNOr0YCJDaX1wKe+Ybe9yzwmd9ZXg
         uxT+mshPlB2QkfJFfALgSnSSKx8RXV+ouQidtDqoGdG7e1Pvs3rUitNoCXq1y5IbNsWN
         ogWA==
X-Gm-Message-State: APjAAAUTR7CFEJqrlqGLi1fdUohKgmFNJIISfiq6Ki0jp56XUwrggCEx
        xcMtOSe3oXhFGViaKFI1cnY=
X-Google-Smtp-Source: APXvYqwX/IlNhxgh2r+v3+8hZoR3XOGtkwaEWu3kTP/erzXIbtMl4CqlVjDkQ3KIrm9AKWQUb3Pz8A==
X-Received: by 2002:aa7:85d3:: with SMTP id z19mr2151445pfn.62.1575444280873;
        Tue, 03 Dec 2019 23:24:40 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id q11sm6284115pff.111.2019.12.03.23.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 23:24:40 -0800 (PST)
Date:   Tue, 3 Dec 2019 23:24:37 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 22/26] t7700: consolidate code into
 test_no_missing_in_packs()
Message-ID: <20191204072437.GA3395833@generichostname>
References: <cover.1574731022.git.liu.denton@gmail.com>
 <cover.1574884302.git.liu.denton@gmail.com>
 <a99a45cb6f2cc7328ef0e52fc2ea8fec537bfba9.1574884302.git.liu.denton@gmail.com>
 <xmqq7e3i4b1p.fsf@gitster-ct.c.googlers.com>
 <20191202205037.GA43606@generichostname>
 <xmqqo8wqwd9m.fsf@gitster-ct.c.googlers.com>
 <20191202232816.GA26892@generichostname>
 <xmqqblsp76xs.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqblsp76xs.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Dec 03, 2019 at 07:41:19AM -0800, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> >> Especially if it is near the end of the series, just a single step
> >> is OK.  But is there anything that is glaringly wrong that needs a
> >> reroll?  Or would it be "this is good enough, so let's have them
> >> cook in 'next' and graduate to 'master'---further clean-up can be
> >> done after all the dust settles"?  I have an impression that we
> >> reached the latter by now.
> >
> > Perhaps the log message could use some improvement to document the
> > discussion we had? I don't know if that's worth a reroll, though. Aside
> > from that, I agree that it's ready for 'next'.
> 
> Sure, let's see what you have in mind.

Here's a complete replacement for the commit message:

	t7700: consolidate code into test_no_missing_in_packs()

	The code to test that objects were not missing from the packfile was
	duplicated many times. Extract the duplicated code into
	test_no_missing_in_packs() and use that instead.

	Refactor the resulting extraction so that if any git commands fail,
	their return codes are not silently lost.

	We were using sed to filter lines. Although not incorrect, this is
	exactly what grep is built for. Replace this invocation of sed with grep
	so that we use the correct tool for the job.

	Instead of verifying each file of `alt_objects/pack/*.idx` individually
	in a for-loop, batch them together into one verification step.

	The original testing construct was O(n^2): it used a grep in a loop to
	test whether any objects were missing in the packfile. Rewrite this to
	sort the files then use `comm -23` so that finding missing lines from
	the original file is done more efficiently.

	The result of this is that we end up with a `grep | cut | sort`
	pipeline. Previously, we were extracting the `sha1` as part of the
	`while read sha1 rest` loop. Since we removed the while-loop, we need to
	use `cut` to extract the `sha1` field. Note that we could have chosen to
	combine the `grep | cut` into a single `sed` invocation but we
	consciously leave it separate as it makes the intent more clear.

	While we're at it, add a space to `commit_and_pack ()` for style.

	Signed-off-by: Denton Liu <liu.denton@gmail.com>

The only change between this and the old commit message is the addition
of the "The result of this..." paragraph.

Thanks,

Denton

> 
> Thanks for working on this.
