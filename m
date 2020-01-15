Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EF7C32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 20:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28852465A
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 20:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="RYadPxFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgAOUHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:07:08 -0500
Received: from mail-pj1-f52.google.com ([209.85.216.52]:51876 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729794AbgAOUHH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 15:07:07 -0500
Received: by mail-pj1-f52.google.com with SMTP id d15so411484pjw.1
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 12:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YZdE7FQz9gIzcP0gRJoFyg2pjX1hS11LSgKx5rVc3OU=;
        b=RYadPxFGxJ4VQIeIS/XKHYFfAS1V7wjVLDq6CE9XhwZ7w6ugA8Cwc38xdDN1iVCG2T
         UZDAPlt8UpQAvhKEKjJ0Y3oC3GxzzlvE/dWaLSMFsBNM2esX6SGGWyf+c6cT2m+zEHav
         E+fWWXtYw1U85FX2+eRgk1OAmojN/HFJpOTUkaYgz6i70jG4RSlEIo4iTwSO8vJAKzgT
         OPOXwFMTzNIwFA+vGnnRKZKbGLz1TvCzglQPpf6tLthSqDFc1gw+QLN0hgMWnQ70qxvj
         vuXYfDSTstvSqX/AAgzJazQkxJqy6i6JP9cV01eCzwfczLn8WxXPV2NcH2GOBJh401gF
         g0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YZdE7FQz9gIzcP0gRJoFyg2pjX1hS11LSgKx5rVc3OU=;
        b=amJF+GlXzLOvbSCjJzLBJiy6mLlbCqPRJxirmbuxqcbl4/VeOPP6RIyqD+bH2f7JUz
         lM51dK2GiL2vcJuvpryvMYeZknJkKjkqoMRMW5aMgWKT4r5OWtn98NvPfU4ii8XPXmhM
         dhCkUeK8tJw6pvtjaqjP7F/T0Hnji0dCC3/pCdVh4uA3yrTelTOBpsstjGNcrI4a6QXZ
         rdxNglqWzDogczV6OgjfZGBpRMGZtDXU5rn0nQSW5UUk4JiWVYt3ZwXgDxqZryAw1gUR
         iEcR6JoFE1n3/G8J7BEyBEGQRLY8GpPgF/pCLG4frgk8kVnLfpDyU7pmfKlMhaJeXWuP
         NG4g==
X-Gm-Message-State: APjAAAXp9shpuxt7v2BdHgyPJGmT70FVikCB664/+m82ie//C1WoD7SA
        JTGrwC0GMF+T8F181KhE3aZ9msP9Y4oOUw==
X-Google-Smtp-Source: APXvYqxdJWKVowEiRDDV1WMCMI2txsjwyTTOS21TfP2tvdP3Av0r3qm89+zcMgjxFDukTShxkgxREA==
X-Received: by 2002:a17:90b:11c4:: with SMTP id gv4mr1936069pjb.126.1579118826586;
        Wed, 15 Jan 2020 12:07:06 -0800 (PST)
Received: from localhost ([205.175.106.239])
        by smtp.gmail.com with ESMTPSA id v10sm21766728pgk.24.2020.01.15.12.07.05
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 12:07:06 -0800 (PST)
From:   Jeff King <me@ttaylorr.com>
X-Google-Original-From: Jeff King <peff@peff.net>
Date:   Wed, 15 Jan 2020 12:07:05 -0800
To:     git@vger.kernel.org
Subject: [ANNOUNCE] Git Contributor Summit Registration, Mar 5, 2020, Los
 Angeles
Message-ID: <20200115200532.GA4101552@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Message-ID: <20200115200705.pxFH9lItfcW1_G4jQHgU46bfNXBeU_e90Ar0IfFjdZ0@z>

Following up on my earlier announcement, I have some more details for
the Contributor Summit at Git Merge this year:

  When: Thursday, March 5th. 10am-5pm.
  Where: Downtown Loft, 1054 S Olive St, Los Angeles, CA 90015
  What: Round-table discussion about Git
  Who: All contributors to Git or related projects in the Git ecosystem
       are invited; if you're not sure if you qualify, please ask!

Note that this is the day _after_ the main Git Merge conference, unlike
previous years. The main conference schedule and agenda is up at:

  https://git-merge.com

To attend, you'll need to register online; please email me off-list for
instructions and a special code. It's bundled with your main conference
registration, so please DO NOT register for the main conference until
you get the code. As with previous years, you'll have the option of
attending for free, or paying the $125 conference fee (all of which goes
to Software Freedom Conservancy).

If you'd like to come but need financial assistance with travel costs,
please reach out as soon as possible to the Git PLC at git@sfconservancy.org.
We'd like to make any funding decisions soon so that people have time to
make travel arrangements. So let's try to have all requests in by next
Monday, January 21st.

When picking a hotel, note that the contributor summit is not at the
same venue as the main conference (but it's nearby). There are some
hotels with special pricing listed on the conference page at
https://git-merge.com/#experience.

We're still working out details of the A/V setup, but the plan is to
have a way for people to join remotely. I'll send details when I have
them.

The afternoon schedule for the main conference is a bit different this
year: we'll have some round-table "Birds of Feather" discussions to get
attendees talking to each other. Think about topics you'd like to
discuss, and also whether you'd like to facilitate a discussion. The
online registration will ask about both. If you're interested, we'll
provide more information and some documentation in advance about how it
will work.

There's also a tentative "Stump the Experts" panel as one of the
sessions. There are still logistics to be worked out (e.g., how far in
advance questions will come), but the general idea is to take attendee
questions about some of the more confusing parts of Git. If you're
interested in being on the panel, let me know.

Sooner is better to make our planning easier, so please let me know if
you're interested by January 31st.

I hope to see everybody there!

-Peff
