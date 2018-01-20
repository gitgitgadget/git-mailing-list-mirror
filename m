Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B82091F424
	for <e@80x24.org>; Sat, 20 Jan 2018 13:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753549AbeATNXu convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 20 Jan 2018 08:23:50 -0500
Received: from elephants.elehost.com ([216.66.27.132]:28434 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753416AbeATNXs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 08:23:48 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0KDNkdw027497
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 20 Jan 2018 08:23:47 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'Torsten_B=C3=B6gershausen'?=" <tboegi@web.de>
Cc:     <git@vger.kernel.org>
References: <20180119173406.13324-1-randall.s.becker@rogers.com> <20180120111012.GA26459@tor.lan>
In-Reply-To: <20180120111012.GA26459@tor.lan>
Subject: RE: [PATCH v2 0/6] Force pipes to flush immediately on NonStop platform
Date:   Sat, 20 Jan 2018 08:23:43 -0500
Message-ID: <019501d391f1$e826f750$b874e5f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQH5ceUaUBDLnBuBgyHh9+OiHAZcgwKtGOTzoxuWFRA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 20, 2018 6:10 AM,  Torsten Bögershausen wrote:
> On Fri, Jan 19, 2018 at 12:33:59PM -0500, randall.s.becker@rogers.com
> wrote:
> > From: "Randall S. Becker" <rsbecker@nexbridge.com>
> >
> > * wrapper.c: called setbuf(stream,0) to force pipe flushes not enabled by
> >   default on the NonStop platform.
> >
> > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> > ---
> >  wrapper.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/wrapper.c b/wrapper.c
> > index d20356a77..671cbb4b4 100644
> > --- a/wrapper.c
> > +++ b/wrapper.c
> > @@ -403,6 +403,9 @@ FILE *xfdopen(int fd, const char *mode)
> >  	FILE *stream = fdopen(fd, mode);
> >  	if (stream == NULL)
> >  		die_errno("Out of memory? fdopen failed");
> > +#ifdef __TANDEM
> > +	setbuf(stream,0);
> > +#endif
> 
> Reading the commit message, I would have expected someting similar to
> 
> #ifdef FORCE_PIPE_FLUSHES
> 	setbuf(stream,0);
> #endif
> 
> (Because other systems may need the tweak as well, some day) Of course
> you need to change that in the Makefile and config.mak.uname
> 
> >  	return stream;
> >  }

I can definitely see the point. Would you be agreeable to expanding the scope of this as a separate patch after this one is applied? I would want to bring at least one more Not NonStop machine into the mix for testing, which is more than I can do this weekend 😊.

Cheers,
Randall

