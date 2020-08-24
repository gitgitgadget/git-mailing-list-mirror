Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274B8C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 09:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023582075B
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 09:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/3mBvXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbgHXJjV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729370AbgHXIqm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 04:46:42 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEA6C061573
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 01:46:42 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y206so4451377pfb.10
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 01:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=BuGf73noIFttUo9XGOuU4mN5smsw8la05OTpH/Ns7zg=;
        b=T/3mBvXXclg0Pn4s4uWNtIyP7GKLXK3Z2XJc37Tt/I2lV+XRvf3s/YbWJvkyiWKRrW
         Y4EWK4Q7kWZPKoiBsQwq2HSM6IekR78uibJ53X/NBgph1kX9IOY1EMLbv/r3n4tbnexE
         6xNZG89+JqzIYoTrxhyIQD+pcRL+v7kTF0B/gjLgm2zZS49UeAzvrHCsqEYtmFyiHKjU
         NquH9k/MEKdMw1IS7NDyUbHyCMX2XHEZeZ6mhy+SiBXhOfXhDuxKmJEnLF8zaBz8jfbk
         OYQFoDHKX559ni29/lDcgmVU1OJ996rY62ZNZDzy+hUwBhT8PajBa51uhlwtfK7sjRl0
         3ajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=BuGf73noIFttUo9XGOuU4mN5smsw8la05OTpH/Ns7zg=;
        b=Mh92Z69oryuzv/VFNUfhqig+W3m3aY7m1go/msL8zQYoKu6RQl28jk/C0W7Ueu6ob9
         gdeCw44SlrGU+x1YJCJ29aBR5ZReQym7Oi1KwE9ZmxX7s3ebRWMJJZv/dAA46kNbdYOs
         LFedHHzWGvXvXYDF/Tu483LUImRxaUJjKabJPXjkGJbcieCjHYLlVC56KEg1PxA5pnF5
         +s1eYyCSh2v6SPy+UxOATaRpby5q1qbe35gCfvIEiETaHwgOXlRh0SSVAUr1nLAYmxQX
         yxVA7uoVh4efuFFyZ+oOeSicPRguLWra/52TNqNIqxAYz6yCqjaA36kuig4vIZ0AnehC
         Xtiw==
X-Gm-Message-State: AOAM532jkI94BzLapH/o4X03Zx+unCVjmHkbqEDdzKv27th0UdLayHIX
        5ViOTVpL5dbqgRao1IWugIs=
X-Google-Smtp-Source: ABdhPJyy/FZBlBrfkwkWgJNULCGo06DJeUefkGmV75ioVZt7hX/on9wDXFToW7tyVlQyDKAoHRnwKA==
X-Received: by 2002:a65:66c4:: with SMTP id c4mr2957843pgw.442.1598258802266;
        Mon, 24 Aug 2020 01:46:42 -0700 (PDT)
Received: from konoha ([27.7.229.188])
        by smtp.gmail.com with ESMTPSA id e7sm9009777pgn.64.2020.08.24.01.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 01:46:41 -0700 (PDT)
Date:   Mon, 24 Aug 2020 14:16:34 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     shouryashukla.oo@gmail.com
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, pc44800@gmail.com, stefanbeller@gmail.com
Subject: Re: [PATCH v3 4/4] submodule: port submodule subcommand 'summary'
 from shell to C
Message-ID: <20200824084634.GA377527@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824072633.GA38870@konoha>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Or rather, we can do this:

-----8<-----
if (S_ISGITLINK(p->mod_src)) {
		struct strbuf sb = STRBUF_INIT;
		strbuf_addstr(&sb, p->sm_path);
		if (is_nonbare_repository_dir(&sb))
			src_abbrev = verify_submodule_committish(p->sm_path,
								                     oid_to_hex(&p->oid_src));
		strbuf_release(&sb);
		if (!src_abbrev) {
			missing_src = 1;
			/*
			 * As `rev-parse` failed, we fallback to getting
			 * the abbreviated hash using oid_src. We do
			 * this as we might still need the abbreviated
			 * hash in cases like a submodule type change, etc.
			 */
			src_abbrev = xstrndup(oid_to_hex(&p->oid_src), 7);
		}
	} else {
		/*
		 * The source does not point to a submodule.
		 * So, we fallback to getting the abbreviation using
		 * oid_src as we might still need the abbreviated
		 * hash in cases like submodule add, etc.
		 */
		src_abbrev = xstrndup(oid_to_hex(&p->oid_src), 7);
	}
----->8-----

Similarly for dst as well. This solution passes all the tests and does
not call 'verify_submodule_committish()' all the time. The previous
approach failed a couple of tests, this one seems fine to me.

How is this one?

