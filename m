Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F25C120323
	for <e@80x24.org>; Thu, 16 Mar 2017 17:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753075AbdCPRkS (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 13:40:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:45228 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753194AbdCPRkN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 13:40:13 -0400
Received: (qmail 16974 invoked by uid 109); 16 Mar 2017 17:40:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 17:40:11 +0000
Received: (qmail 10845 invoked by uid 111); 16 Mar 2017 17:40:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 13:40:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Mar 2017 13:40:07 -0400
Date:   Thu, 16 Mar 2017 13:40:07 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] sha1_file.c: make pack-name helper globally
 accessible
Message-ID: <20170316174007.gwficwtsqocld4h4@sigill.intra.peff.net>
References: <20170316142647.t6tthkcgon3rpg4m@sigill.intra.peff.net>
 <20170316142706.kt56a43phiuhhra7@sigill.intra.peff.net>
 <20170316143152.gdeaprlsercvwmiw@sigill.intra.peff.net>
 <fefb69e1-325d-5ec6-0954-1445ce8ad9be@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fefb69e1-325d-5ec6-0954-1445ce8ad9be@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 05:03:03PM +0000, Ramsay Jones wrote:

> > Incidentally, this entire function could be implemented as:
> > 
> >   return git_path_buf(buf, "objects/pack/pack-%s.%s",
> >                       sha1_to_hex(sha1), ext);
> > 
> > as the git_path() functions are smart enough to replace "objects/" with
> > the true object directory when necessary. I don't know if people find
> > that more or less readable. Since it's buried in a helper function, I
> > doubt it matters much either way. The git_path functions do also do some
> > path normalization, which might be of value.
> 
> Hmm, I don't have strong feelings either way.
> 
> However, I note that the only normalization going on (that I can see)
> is to remove .//* from the beginning of the resulting string. I don't
> know why, but I guess it is to cater to people using the various
> GIT_ environment variables doing things like:
> 
>    $ GIT_OBJECT_DIRECTORY=./my-objects git ....
> 
> It has always puzzled me slightly, why the git_path functions do this
> normalization, but (for example) setup_git_env(), git_path_from_env(),
> get_common_dir(), ... don't! ;-)

I think there's some double-slash normalization (though not consistent
or thorough). So yeah, I'm not really sure the normalization is of great
value. I am surprised that there isn't a call to "convert_slashes()" in
there on Windows, as it seems to be sprinkled other places (like
prefix_filename()).

<shrug> If nobody's complaining, I'm happy to leave it as-is for now,
and if somebody comes up with a case where git_path normalization makes
a difference, we can look at switching it.

-Peff
