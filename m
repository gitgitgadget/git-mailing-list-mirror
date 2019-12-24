Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2363C2D0C0
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 00:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF864206D3
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 00:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t4TDd+oS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfLXA6T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 19:58:19 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40004 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfLXA6T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 19:58:19 -0500
Received: by mail-pj1-f68.google.com with SMTP id bg7so487901pjb.5
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 16:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bE4T6x6N1yHpiuiazb+K4B5sfdYoNZThaIaTh3ODKaA=;
        b=t4TDd+oSglSeQrofFNabU1mUCMcWf4BhT0FWFHJJdIJwFtdZqlSBT1twiAkEY1Y2hm
         K9nWPlgtHsSB1mlnwfQVB7sPvz2h2nXztyI4PTuHgp+8HKlhzUA3xm1fhKUmj3sN0f7h
         aYRQ1x5jrGwQM5VgIoC5Gb4ePoSB+d9Jw95rJwkyveAgbSyhGy2UK3pduPYtzBuPfu8v
         BDWwzv+nlvy2YW5YajgAqVl3TgfueXiNGimTA7Q1spZzs2pphY/0iMQL/sUXRM25v8oR
         FJ8uzP66sGo26i2hY9C78W4hhbxkI9YgWaMQXHfhWLHPdnJNQNm7iY7B8ZxtmSQJG33d
         zPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bE4T6x6N1yHpiuiazb+K4B5sfdYoNZThaIaTh3ODKaA=;
        b=aZh6yLlQjwSy0/6aSMbdKI4ob5Swf7GwURMf63RhRKF3Pf5NeSgZS7exhSacLubBQ4
         XIWGM7IkpdQdzWizc0ZL+qRNKrzAl2bqRhhxmXAtKae4iL14iOcwprH4Rr5exmkNLWPn
         7A3rlNQdp8H25xzwQJ+SpGJcHk0mnyYIgsY0sBZo0BzUZBNB+f6tQdqJdn8OCiGbTEhx
         4FNvZpXyLtgusoqdvJXLCvP6z7mPLzSJ72Ft8wmQtHNrww9DQ2jS4tJdoLwIpqoKKyp2
         QKCxL6hG3eHwD4oJ2KVSSA8SN/XpCKn6mvj7ihbYz8IvWPWKOttlZxegZlAE5fE6CLmB
         UMhQ==
X-Gm-Message-State: APjAAAVzM+zrM+eBw0TsFJC85kgeQEUlEn9yoiHGk0sZEiRGG6sIbHaM
        fkr3TBDq3Fo/3qor08/nfoZMZ6bM
X-Google-Smtp-Source: APXvYqza5MlmmR87wrH6+ZTy2grj/Cjalz5JdRq541esKm268n2hnAeL630f/0vwzsv86JLGC36DNg==
X-Received: by 2002:a17:90a:660b:: with SMTP id l11mr2418326pjj.47.1577149098225;
        Mon, 23 Dec 2019 16:58:18 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id r1sm697918pjp.29.2019.12.23.16.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 16:58:17 -0800 (PST)
Date:   Mon, 23 Dec 2019 16:58:16 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 0/5] Enable protocol v2 by default
Message-ID: <20191224005816.GC38316@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

The Git users at $DAYJOB have been using protocol v2 as a default for
~1.5 years now and others have been also reporting good experiences
with it, so it seems like a good time to propose bumping the default
version.  It produces a significant performance improvement when
fetching from repositories with many refs, such as
https://chromium.googlesource.com/chromium/src.

This only affects the client, not the server.  (The server already
defaults to supporting protocol v2.)

This could go in 2.25 (most of the "next" population is likely already
using protocol.version=2, so the -rc period would be one of the better
ways to expand the user population using this) or could cook in "next"
for a cycle.  Either is fine by me.

Thoughts of all kinds welcome, as always.

Jonathan Nieder (5):
  fetch test: use more robust test for filtered objects
  config doc: protocol.version is not experimental
  test: request GIT_TEST_PROTOCOL_VERSION=0 when appropriate
  protocol test: let protocol.version override GIT_TEST_PROTOCOL_VERSION
  fetch: default to protocol version 2

 Documentation/config/protocol.txt    |  9 ++++-----
 protocol.c                           | 11 +++++------
 t/README                             |  4 ++--
 t/t5400-send-pack.sh                 |  2 +-
 t/t5500-fetch-pack.sh                | 23 ++++++++++++++++-------
 t/t5512-ls-remote.sh                 | 10 +++++-----
 t/t5515-fetch-merge-logic.sh         |  3 ++-
 t/t5516-fetch-push.sh                | 12 ++++++------
 t/t5539-fetch-http-shallow.sh        |  2 +-
 t/t5541-http-push-smart.sh           |  4 ++--
 t/t5551-http-fetch-smart.sh          | 12 ++++++------
 t/t5552-skipping-fetch-negotiator.sh |  2 +-
 t/t5700-protocol-v1.sh               |  3 ++-
 t/t7406-submodule-update.sh          |  2 +-
 14 files changed, 54 insertions(+), 45 deletions(-)

base-commit: 12029dc57db23baef008e77db1909367599210ee
