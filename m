Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 077AA211B9
	for <e@80x24.org>; Wed, 26 Dec 2018 10:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbeLZKjE (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Dec 2018 05:39:04 -0500
Received: from elephants.elehost.com ([216.66.27.132]:43164 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeLZKjD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Dec 2018 05:39:03 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id wBQAcqRM062435
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Dec 2018 05:38:53 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Stefan Beller'" <sbeller@google.com>,
        "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     "'Joachim Schmitz'" <jojo@schmitz-digital.de>
Subject: Missed Commit in 2.20.1
Date:   Wed, 26 Dec 2018 05:38:46 -0500
Message-ID: <002401d49d07$325c7900$97156b00$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdSdBBB+IP4/wN2rSGKqpbG3LfPvOw==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 2, 2018 4:02 PM, Stefan Beller found my change:
> On Mon, Apr 2, 2018 at 12:57 PM, Randall S. Becker
> <rsbecker@nexbridge.com> wrote:
> > On April 2, 2018 3:34 PM, Junio C Hamano wrote:
> >> The latest feature release Git v2.17.0 is now available at the usual
> >> places.  It is comprised of 516 non-merge commits since v2.16.0,
> >> contributed by 71 people, 20 of which are new faces.
> >
> > Just a heads up. I think this one might have gotten missed at some point
a
> few months back. I think it was submitted back in January. Not sure where
it
> fell off or whether it was just dropped.
> >
> > diff --git a/transport-helper.c b/transport-helper.c index
> > 3f380d87d..5ee7007f6 100644
> > --- a/transport-helper.c
> > +++ b/transport-helper.c
> > @@ -1212,7 +1212,7 @@ static int udt_do_read(struct
> unidirectional_transfer *t)
> >                 return 0;       /* No space for more. */
> >
> >         transfer_debug("%s is readable", t->src_name);
> > -       bytes = read(t->src, t->buf + t->bufuse, BUFFERSIZE -
t->bufuse);
> > +       bytes = xread(t->src, t->buf + t->bufuse, BUFFERSIZE -
t->bufuse);
> >         if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
> >                 errno != EINTR) {
> >                 error_errno("read(%s) failed", t->src_name);
> 
> Patch at https://public-
> inbox.org/git/010f01d38a9e$a5c4f290$f14ed7b0$@nexbridge.com/

Just a subtle reminder that this particular change does not seem to have
made it into 2.20.1. I've retrofitted xread into the NonStop port and will
be re-submitting it with the remaining platform changes assuming the test
suite runs at least as well as our last port at 2.17.0 (in progress as we
speak). We are down to four variances from standard code:

*    git-compat-util.h referencing FLOSS headers needed on platform.
*    this one (xread instead of read in transport-helper.c)
*    config.mak.uname specific settings for NonStop not currently present.
*    t/Makefile - have to comment out all test-lint dependencies because of
segfault at 2.20.1. (to be investigated but we don't submit this unless we
find a good fix)

Please stay tuned for patches. We are very much looking forward to having
the two (or three) different NonStop hardware personalities supported
without mods in the very near future. Our goal, assuming those patches are
acceptable, is to move our build/test/distro into a Jenkins config that runs
with minimal human involvement (a.k.a. me).

Cheers,
Randall

-- Brief whoami:
  NonStop developer since approximately NonStop(211288444200000000)
  UNIX developer since approximately 421664400
-- In my real life, I talk too much.



