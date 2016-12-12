Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AF5F1FF40
	for <e@80x24.org>; Mon, 12 Dec 2016 01:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753900AbcLLB63 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Dec 2016 20:58:29 -0500
Received: from ozlabs.org ([103.22.144.67]:35699 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752666AbcLLB62 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2016 20:58:28 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 3tcQwg1M2gz9s5w; Mon, 12 Dec 2016 12:58:27 +1100 (AEDT)
Date:   Mon, 12 Dec 2016 12:58:23 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Florian =?iso-8859-1?Q?Sch=FCller?= <florian.schueller@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] Gitk Inotify support
Message-ID: <20161212015823.GF18316@fergus.ozlabs.ibm.com>
References: <CAHdOBFrYWxfSXew5wHwcMym9=s+7cu2E9-MJJe29y+3zV89x7g@mail.gmail.com>
 <CAGZ79kbwrdW=XyPXBNcqBJU1dK8ZvfqyWbgtSt7mvT+m3LQB6g@mail.gmail.com>
 <CAHdOBFpOm3hf4XPjpSZ0+8rVgyKj+e3qT0cecU4j9ms=+chnDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHdOBFpOm3hf4XPjpSZ0+8rVgyKj+e3qT0cecU4j9ms=+chnDg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 11, 2016 at 04:06:36PM +0200, Florian Schüller wrote:
> >From 74d2f4c1ec560b358fb50b8b7fe8282e7e1457b0 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Florian=20Sch=C3=BCller?= <florian.schueller@gmail.com>
> Date: Thu, 9 Jun 2016 22:54:43 +0200
> Subject: [PATCH] first support for inotify
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Just automatically update gitk when working in a terminal on the same repo
> 
> Open points for now:
>  - release watches for deleted directories seems to
>    cause problems in tcl-inotify (so I don't)
>    I'm not sure how often that happens in ".git/"
>  - I only call "updatecommits" and I don't know if there is a usecase
>    where I should be calling "reloadcommits"

Thanks for the patch.  It's a nice idea.  I think it needs a couple of
improvements, though, to make it work even better:

* Some users might not want this behaviour, so we need an option in
  the preferences pane to enable/disable this.

* I would expect that the updates to the files in .git would come in
  bursts, so we should probably do something like wait until (say) one
  second has elapsed since the last notification, without any more
  notifications, before starting the update.

* We probably want to rate-limit the updates, since on a large tree
  (e.g. the Linux kernel) the update can take several seconds and the
  UI is less responsive during that time.

Paul.
