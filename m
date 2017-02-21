Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E06D7201B3
	for <e@80x24.org>; Tue, 21 Feb 2017 06:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbdBUF73 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 21 Feb 2017 00:59:29 -0500
Received: from elnino.lfos.de ([46.165.227.75]:35157 "EHLO elnino.lfos.de"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751018AbdBUF71 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 00:59:27 -0500
Received: by elnino.lfos.de (OpenSMTPD) with ESMTPSA id 3822d572 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 21 Feb 2017 06:59:24 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Jeff King <peff@peff.net>
From:   Lukas Fleischer <lfleischer@lfos.de>
In-Reply-To: <20170220192103.6v66lpghgir3erhn@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
References: <148761588216.31363.15518967793189077139@typhoon>
 <20170220192103.6v66lpghgir3erhn@sigill.intra.peff.net>
Message-ID: <148765676392.7729.13179395516270132623@typhoon>
User-Agent: alot/0.3.7
Subject: Re: Sending informational messages from upload-pack
Date:   Tue, 21 Feb 2017 06:59:23 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 20 Feb 2017 at 20:21:03, Jeff King wrote:
> On Mon, Feb 20, 2017 at 07:38:02PM +0100, Lukas Fleischer wrote:
> 
> > It would be handy to be able to show a message to the user when
> > cloning/fetching from a repository (e.g. to show a warning if a
> > repository is deprecated). This should technically already be possible
> > using the current pack protocol and sidebands. However, to my knowledge,
> > there is no easy way to configure this on the server side; writing a
> > wrapper around git-upload-pack(1) or replacing git-upload-pack(1) seem
> > to be the only options.
> 
> I wouldn't recommend wrapping upload-pack. You don't know you have a
> sideband until partway through the upload-pack conversation. And clients
> do not expect sideband at all until we get to the pack-sending part of
> the protocol (I think; I just quickly verified the location of the
> demuxer async code in fetch-pack.c, but I didn't dig into it in depth).

By wrapper I meant something that understands the pack protocol itself,
intercepts the traffic, forwards most of it to git-upload-pack(1) and
injects the message at the right time. I agree that it is a fairly ugly
workaround, though.

> [...]
> If my fetch-pack assertion above is right, technically the hook added by
> 20b20a22f is sufficient for your purposes, if your hook looks like:
> 
>   echo >&2 "pre-pack message"
>   git pack-objects "$@"
>   echo >72 "post-pack message"
> 
> but I would not be opposed to having pre-/post- hooks that run
> separately, if only for the convenience of the admin.
> [...]

I will give it a try. And I agree that it would still be convenient to
have pre-upload-pack and post-upload-pack hooks.

Regards,
Lukas
