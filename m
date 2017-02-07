Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAB051FAFC
	for <e@80x24.org>; Tue,  7 Feb 2017 00:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752462AbdBGA4f (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 19:56:35 -0500
Received: from havoc.proulx.com ([96.88.95.61]:43226 "EHLO havoc.proulx.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751447AbdBGA4e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 19:56:34 -0500
Received: from joseki.proulx.com (localhost [127.0.0.1])
        by havoc.proulx.com (Postfix) with ESMTP id EFAE9191
        for <git@vger.kernel.org>; Mon,  6 Feb 2017 17:56:33 -0700 (MST)
Received: from hysteria.proulx.com (hysteria.proulx.com [192.168.230.119])
        by joseki.proulx.com (Postfix) with ESMTP id B7984217E0
        for <git@vger.kernel.org>; Mon,  6 Feb 2017 17:56:33 -0700 (MST)
Received: by hysteria.proulx.com (Postfix, from userid 1000)
        id 97F2E2DC5F; Mon,  6 Feb 2017 17:56:33 -0700 (MST)
Date:   Mon, 6 Feb 2017 17:56:33 -0700
From:   Bob Proulx <bob@proulx.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git-daemon shallow checkout fail
Message-ID: <20170206174000357620972@bob.proulx.com>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
References: <20170129002932.GA19359@dismay.proulx.com>
 <20170130172730.x5guphyqf5fsfi7m@sigill.intra.peff.net>
 <CACsJy8DED9WRr_T6g43bxHUGQYVnfaTx15hqSGiiajvi0TxtuA@mail.gmail.com>
 <20170206171225215133282@bob.proulx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170206171225215133282@bob.proulx.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bob Proulx wrote:
>   17:20:40.590177 pkt-line.c:46           packet:        clone< 34e7202270c381f4e5734180dc19426ce69f2e1e HEAD\0multi_ack thin-pack side-band side-band-64k ofs-delta shallow no-progress include-tag multi_ack_detailed symref=HEAD:refs/heads/master agent=git/1.9.1

The evidence of it running the wrong version being the 1.9.1 which is
not the bits I built.

> Therefore it looks like it is invoking some other command by a hard
> coded path and avoiding PATH to my development bits.  It must be
> invoking some other binary.  I will get more agressive about disabling
> the packaged version and hopefully find out which one.

I did and of course it is /usr/bin/git-upload-pack and if I disable
that binary then git-daemon no longer operates.

  error: cannot run upload-pack: No such file or directory

But shouldn't it find git-upload-pack from PATH?  Since I have
git-upload-pack installed in PATH?  Apparently not.  At least not when
invoking as /path/to/git-daemon directly.

In any case with the all of your very good help, especially the
version echo print, guiding me to the problem that I was able to make
this work.

  cd /run/git && env -i HOME=/run/git PATH=$HOME/src/git-stuff/git:/usr/bin:/bin $HOME/src/git-stuff/git/git --exec-path=$HOME/src/git-stuff/git daemon --export-all --base-path=/srv/git --verbose

That works for the git-daemon.  It does not require me to modify
anything else on the system.  Good enough.  Problem solved.

Thanks!
Bob
