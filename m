Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 567BB1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 08:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753545AbeGFICW (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 04:02:22 -0400
Received: from thoth.sbs.de ([192.35.17.2]:33212 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753367AbeGFICP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 04:02:15 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id w668201I020390
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Jul 2018 10:02:00 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w66820xa018682;
        Fri, 6 Jul 2018 10:02:00 +0200
Date:   Fri, 6 Jul 2018 10:01:59 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Ben Toews <mastahyeti@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 7/8] gpg-interface: introduce new signature format
 "X509" using gpgsm
Message-ID: <20180706100159.730054ce@md1pvb1c.ad001.siemens.net>
In-Reply-To: <20180706011013.GB7697@genre.crustytoothpaste.net>
References: <cover.1530616446.git.henning.schild@siemens.com>
 <1f99ef66bc5e115ec06a3c456658ad54ce405ce3.1530616446.git.henning.schild@siemens.com>
 <20180706011013.GB7697@genre.crustytoothpaste.net>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Fri, 6 Jul 2018 01:10:13 +0000
schrieb "brian m. carlson" <sandals@crustytoothpaste.net>:

> On Tue, Jul 03, 2018 at 02:38:19PM +0200, Henning Schild wrote:
> > This commit allows git to create and check X509 type signatures
> > using gpgsm.
> > 
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> >  Documentation/config.txt |  5 ++++-
> >  gpg-interface.c          | 10 +++++++++-
> >  2 files changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index c88903399..337df6e48 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -1828,9 +1828,12 @@ gpg.program::
> >  	signed, and the program is expected to send the result to
> > its standard output.
> >  
> > +gpg.programX509::  
> 
> I'm not super excited about this name.  It seems to indicate we want a
> level of hierarchy involved.
> 
> A hierarchy like sign.openpgp.program (falling back to gpg.program)
> and sign.x509.program might be more logical.
> 
> > diff --git a/gpg-interface.c b/gpg-interface.c
> > index aa747278e..85d721007 100644
> > --- a/gpg-interface.c
> > +++ b/gpg-interface.c
> > @@ -16,13 +16,18 @@ struct gpg_format_data {
> >  
> >  #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
> >  #define PGP_MESSAGE "-----BEGIN PGP MESSAGE-----"
> > +#define X509_SIGNATURE "-----BEGIN SIGNED MESSAGE-----"
> >  
> > -enum gpgformats { PGP_FMT };
> > +enum gpgformats { PGP_FMT, X509_FMT };
> >  struct gpg_format_data gpg_formats[] = {
> >  	{ .format = "PGP", .program = "gpg",
> >  	  .extra_args_verify = { "--keyid-format=long", },
> >  	  .sigs = { PGP_SIGNATURE, PGP_MESSAGE, },
> >  	},
> > +	{ .format = "X509", .program = "gpgsm",  
> 
> Similarly to my comment about "PGP", I think this would do well as
> "x509".

Another naming discussion, lets keep discussing and i will implement it
once settled.

Henning
