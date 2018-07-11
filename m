Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F34B21F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 08:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732408AbeGKIoe (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 04:44:34 -0400
Received: from gecko.sbs.de ([194.138.37.40]:35566 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbeGKIoe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 04:44:34 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id w6B8f1Lj013788
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 10:41:02 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w6B8f0pQ007850;
        Wed, 11 Jul 2018 10:41:01 +0200
Date:   Wed, 11 Jul 2018 10:41:00 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/9] gpg-interface: make parse_gpg_output static and
 remove from interface header
Message-ID: <20180711104100.289b1569@md1pvb1c.ad001.siemens.net>
In-Reply-To: <xmqqwou382ch.fsf@gitster-ct.c.googlers.com>
References: <cover.1531208187.git.henning.schild@siemens.com>
        <cover.1531208187.git.henning.schild@siemens.com>
        <192cf9fc4e7a601d2639ec2d82c777d4c7b26e99.1531208187.git.henning.schild@siemens.com>
        <xmqqwou382ch.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Tue, 10 Jul 2018 09:47:26 -0700
schrieb Junio C Hamano <gitster@pobox.com>:

> Henning Schild <henning.schild@siemens.com> writes:
> 
> > This commit turns parse_gpg_output into an internal function, the
> > only outside user was migrated in an earlier commit.  
> 
> It is not too big a deal but as we prefer to see our history speak
> in consistent voice, we would usually phrase the above as if we are
> giving an order to "make it so" to the codebase, e.g.
> 
> 	Turn parse_gpg_output() into a static function, as the only
> 	outside user was removed in the previous step.
> 
> or something like that.
> 
> These two steps, as you said earlier, are nice clean-up patches
> whose goodness can be measured independently, regardless of the
> gpgsm support which is the primary focus of this series.

I updated the comment of the second one and send them as a seperate
series. I do not expect them to change since there was -- so far -- no
feedback suggesting that. So i am tempted to promise that ;).

Henning

> Thanks.
> 
> >
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> >  gpg-interface.c | 2 +-
> >  gpg-interface.h | 2 --
> >  2 files changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/gpg-interface.c b/gpg-interface.c
> > index 0647bd634..09ddfbc26 100644
> > --- a/gpg-interface.c
> > +++ b/gpg-interface.c
> > @@ -35,7 +35,7 @@ static struct {
> >  	{ 'R', "\n[GNUPG:] REVKEYSIG "},
> >  };
> >  
> > -void parse_gpg_output(struct signature_check *sigc)
> > +static void parse_gpg_output(struct signature_check *sigc)
> >  {
> >  	const char *buf = sigc->gpg_status;
> >  	int i;
> > diff --git a/gpg-interface.h b/gpg-interface.h
> > index a5e6517ae..5ecff4aa0 100644
> > --- a/gpg-interface.h
> > +++ b/gpg-interface.h
> > @@ -33,8 +33,6 @@ void signature_check_clear(struct signature_check
> > *sigc); */
> >  size_t parse_signature(const char *buf, size_t size);
> >  
> > -void parse_gpg_output(struct signature_check *);
> > -
> >  /*
> >   * Create a detached signature for the contents of "buffer" and
> > append
> >   * it after "signature"; "buffer" and "signature" can be the same  

