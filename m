Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C75C32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 20:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188212081E
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 20:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="HiTHsoiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgAOUJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:09:48 -0500
Received: from mail-pj1-f53.google.com ([209.85.216.53]:53471 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbgAOUJs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 15:09:48 -0500
Received: by mail-pj1-f53.google.com with SMTP id n96so410521pjc.3
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 12:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YZdE7FQz9gIzcP0gRJoFyg2pjX1hS11LSgKx5rVc3OU=;
        b=HiTHsoiD6kLxl/H1pBi47ghbtjXMchbZwRQUdc12VEdb9+YDm+z4TlkbI7MWxOX38i
         q05vucTfmn3bhwdlOIv+tiH1NTtzO7u+Nr5y4JjjLbH2Jh0uBWOWhva5RUah0JCQbEJt
         ocr9JbhCfj0yy2jgxpLrl229yEZJGTiuYVBdtP//ojz9sraYu0W+bh2QqhPKorxyqQ/K
         BCNeJTi/Yy4YAg80v0nhayOvZPKImd9cYid1X8+WTwPPEQSBo7Epxhrm3OOSUuA7zP13
         IyFlm8xLfEDXmyAAic904eZxBR8h6oSOrJ1AIBonICpkwNt3aHwJ1RqUt/fMn1LU4rBw
         p1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YZdE7FQz9gIzcP0gRJoFyg2pjX1hS11LSgKx5rVc3OU=;
        b=SpNWbOwj074J9uDxA2D4tcfadMDYu+FrtcmP37eE6+3IyXJ4BnVG/prLQR8vwqSEf6
         B+DREGrbVG93Cl/jyJmQ0P9znvGWRhqkW0rvygw13ciVdLx8ZmgcVGcEeb5mCGp9rvE2
         IzyPY8c575Vg0/WznXIjcazxKeFDCfttfvkgtzQltgRig7/ktONR39BGT/VvJZz081hj
         qEu1uEZDtc9rHEE6j9gzmuPolN1EHC9CwakZWtHS+UrCQd5R2Z63onLyb+flVe4yAC2V
         kAUChe/59HarxSITeBBasn6wo9+B/MkMYS6kCsF6CxEJluaKvwQAJOQuGp3tTM4yHjal
         peTw==
X-Gm-Message-State: APjAAAX4IW/uv5nUDuSWD4g42eMODTWMfUp6LjTTX/mSknDjCR2nI37d
        gTA3MG6ynq6RjNqSS1IeyB8C2RIpJAprnA==
X-Google-Smtp-Source: APXvYqzlLMhcaxhnjx5WCJXat0XuI3+qX6JdbySxMAbDDQWZFH3CtWLKsD03BJRwmolATFcZfDffxw==
X-Received: by 2002:a17:902:34a:: with SMTP id 68mr26905242pld.250.1579118987138;
        Wed, 15 Jan 2020 12:09:47 -0800 (PST)
Received: from localhost ([205.175.106.239])
        by smtp.gmail.com with ESMTPSA id q10sm23536099pfn.5.2020.01.15.12.09.46
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 12:09:46 -0800 (PST)
Date:   Wed, 15 Jan 2020 12:09:46 -0800
From:   Jeff King <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] Git Contributor Summit Registration, Mar 5, 2020, Los
 Angeles
Message-ID: <20200115200705.pxFH9lItfcW1_G4jQHgU46bfNXBeU_e90Ar0IfFjdZ0@z>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Message-ID: <20200115200946.-yeFGSj2zoo2hOuu9u-9uiXrD_sqTZ-g6C3X7DO2gCw@z>

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
