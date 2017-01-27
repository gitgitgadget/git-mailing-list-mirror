Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE2661F437
	for <e@80x24.org>; Fri, 27 Jan 2017 17:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933128AbdA0RwS convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 27 Jan 2017 12:52:18 -0500
Received: from elnino.lfos.de ([46.165.227.75]:36560 "EHLO elnino.lfos.de"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S933807AbdA0RwL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 12:52:11 -0500
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Jan 2017 12:52:10 EST
Received: by elnino.lfos.de (OpenSMTPD) with ESMTPSA id 16e20b37 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 27 Jan 2017 18:45:29 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     git@vger.kernel.org
From:   Lukas Fleischer <lfleischer@lfos.de>
In-Reply-To: <xmqqa8aec40a.fsf@gitster.mtv.corp.google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
 <20170124004805.nu3w47isrb4bxgi5@sigill.intra.peff.net>
 <xmqqa8aec40a.fsf@gitster.mtv.corp.google.com>
Message-ID: <148553912610.7898.1319453517642036857@typhoon>
User-Agent: alot/0.3.7
Subject: Re: [PATCH 11/12] receive-pack: treat namespace .have lines like alternates
Date:   Fri, 27 Jan 2017 18:45:26 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 25 Jan 2017 at 20:51:17, Junio C Hamano wrote:
> [...]
> > diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> > index 8f8762e4a..c55e2f993 100644
> > --- a/builtin/receive-pack.c
> > +++ b/builtin/receive-pack.c
> > @@ -251,8 +251,9 @@ static void show_ref(const char *path, const unsigned char *sha1)
> [...]
> >       if (ref_is_hidden(path, path_full))
> [...]
> This is an unrelated tangent, but there may want to be a knob to
> make the code return here without even showing, to make the
> advertisement even smaller and also to stop miniscule information
> leakage?  If the namespaced multiple projects are totally unrelated
> (i.e. "My sysadmin gave me a write access only to this single
> directory, so I am using the namespace feature to host these three
> projects that have nothing to do with each other"), showing objects
> of other namespaces will buy us nothing and the user is better off
> without this code showing these refs as ".have".

I think this is already possible using receive.hideRefs (which causes
the ref_is_hidden() branch above to return if applicable).

Having support for suppressing .have lines corresponding to different
namespaces was actually the reason I implemented 78a766ab6 (hideRefs:
add support for matching full refs, 2015-11-03). We have been using
namespaces for hosting the package Git repositories of the Arch Linux
User Repository [1] with a shared object storage for several months now.
See [2] for *some* technical details on how things are implemented; the
last section explains how the hideRefs mechanism can be used to limit
ref advertisement to the "active" namespace.

Regards,
Lukas

[1] https://aur.archlinux.org/
[2] https://git.archlinux.org/aurweb.git/plain/doc/git-interface.txt
