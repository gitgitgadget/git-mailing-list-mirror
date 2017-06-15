Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD4FE1FA7B
	for <e@80x24.org>; Thu, 15 Jun 2017 10:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751667AbdFOKcS (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 06:32:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:40565 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750777AbdFOKcS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 06:32:18 -0400
Received: (qmail 14248 invoked by uid 109); 15 Jun 2017 10:32:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 10:32:17 +0000
Received: (qmail 21924 invoked by uid 111); 15 Jun 2017 10:32:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 06:32:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jun 2017 06:32:16 -0400
Date:   Thu, 15 Jun 2017 06:32:16 -0400
From:   Jeff King <peff@peff.net>
To:     Sebastian =?utf-8?B?RHLDtmdl?= <sebastian@centricular.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] git cherry-pick segfaults with local changes in working
 directory
Message-ID: <20170615103215.45sp5adzu6zcorct@sigill.intra.peff.net>
References: <1497517910.2239.105.camel@centricular.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1497517910.2239.105.camel@centricular.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 12:11:50PM +0300, Sebastian Dröge wrote:

> This is with git 2.11.0 (Debian 2.11.0-4) and can be reproduced with
> the packed checkout here:
>   https://people.freedesktop.org/~slomo/git-cherry-pick-segfault_gst-plugins-good.tar.xz
> 
> $ tar xf git-cherry-pick-segfault_gst-plugins-good.tar.xz
> $ cd gst-plugins-good
> $ git cherry-pick 0421fb04470af90e8810e7e5e69955d3192896ba
> Segmentation fault (core dumped)

Note that the tarball doesn't have all the necessary objects. Its
.git/objects/info/alternates points to another full clone of
git://anongit.freedesktop.org/gstreamer/gst-plugins-good.

The segfault was fixed in 55e9f0e5c (merge-recursive: handle NULL in
add_cacheinfo() correctly, 2016-11-26), which is in v2.11.1.

Curiously, after the fix we print:

error: addinfo_cache failed for path 'docs/plugins/inspect/plugin-shout2send.xml'

but the cherry-pick succeeds anyway. I'm not sure if that's a bug or
not.

-Peff
