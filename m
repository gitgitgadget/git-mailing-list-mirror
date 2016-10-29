Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C56692022A
	for <e@80x24.org>; Sat, 29 Oct 2016 18:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753393AbcJ2SCP (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 14:02:15 -0400
Received: from mylo.jdl.com ([208.123.73.151]:55511 "EHLO mylo.jdl.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751584AbcJ2SCO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2016 14:02:14 -0400
X-Greylist: delayed 1412 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Oct 2016 14:02:14 EDT
Received: from jdl (helo=mylo)
        by mylo.jdl.com with local-esmtp (Exim 4.82)
        (envelope-from <jdl@jdl.com>)
        id 1c0XaZ-0007Ab-QI; Sat, 29 Oct 2016 12:38:40 -0500
From:   Jon Loeliger <jdl@jdl.com>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
Subject: Re: Fetch/push lets a malicious server steal the targets of "have" lines
In-reply-to: <xmqq7f8sx8lg.fsf@gitster.mtv.corp.google.com>
References: <1477690790.2904.22.camel@mattmccutchen.net> <xmqqmvhoxhfp.fsf@gitster.mtv.corp.google.com> <1477692961.2904.36.camel@mattmccutchen.net> <xmqq7f8sx8lg.fsf@gitster.mtv.corp.google.com>
Comments: In-reply-to Junio C Hamano <gitster@pobox.com>
   message dated "Fri, 28 Oct 2016 18:11:23 -0700."
Date:   Sat, 29 Oct 2016 12:38:39 -0500
Message-Id: <E1c0XaZ-0007Ab-QI@mylo.jdl.com>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: jdl@jdl.com
X-SA-Exim-Scanned: No (on mylo.jdl.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So, like, Junio C Hamano said:
> Matt McCutchen <matt@mattmccutchen.net> writes:
> 
> > Then the server generates a commit X3 that lists Y2 as a parent, even
> > though it doesn't have Y2, and advances 'x' to X3.  The victim fetches
> > 'x':
> >
> >            victim                  server
> >
> >              Y1---Y2----                      (Y2)
> >             /           \                         \ 
> >     ---O---O---X1---X2---X3   ---O---O---X1---X2---X3
> >
> > Then the server rolls back 'x' to X2:
> >
> >            victim                  server
> >
> >              Y1---Y2----
> >             /           \
> >     ---O---O---X1---X2---X3   ---O---O---X1---X2
> 
> Ah, I see.  My immediate reaction is that you can do worse things in
> the reverse direction compared to this, but your scenario does sound
> bad already.

Is there an existing protocol provision, or an extension to
the protocol that would allow a distrustful client to say to
the server, "Really, you have Y2?  Prove it."  And expect the
server to respond with a SHA1 sequence back to a common SHA
(in this case the left-most O).  If so, a user could designate
some branch (Y) as "sensitive".  Or, a whole repo could be
so designated and the client then effectivey treats the server
as a semi-hostile witness.

Dunno.

jdl

