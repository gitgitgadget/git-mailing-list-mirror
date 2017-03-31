Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F9CA1FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 15:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933189AbdCaP5z convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 31 Mar 2017 11:57:55 -0400
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:58134 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933149AbdCaP5y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 11:57:54 -0400
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Mar 2017 11:57:54 EDT
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id BD246100065;
        Fri, 31 Mar 2017 15:52:35 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Dw-Yz1LeZFRe; Fri, 31 Mar 2017 15:52:35 +0000 (GMT)
Received: from exmbdft8.ad.twosigma.com (exmbdft8.ad.twosigma.com [172.22.2.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id AC38F80035;
        Fri, 31 Mar 2017 15:52:35 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft8.ad.twosigma.com (172.22.2.84) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Fri, 31 Mar 2017 15:52:35 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Fri, 31 Mar 2017 15:52:35 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
CC:     git <git@vger.kernel.org>
Subject: RE: [PATCH] http.postbuffer: make a size_t
Thread-Topic: [PATCH] http.postbuffer: make a size_t
Thread-Index: AQHSqdZfXYCW+MDS6EGx8AavIUjVVqGvFNbg
Date:   Fri, 31 Mar 2017 15:52:35 +0000
Message-ID: <8d9af9884ccc4f99a01da863cb7ba600@exmbdft7.ad.twosigma.com>
References: <20170330202917.24281-1-dturner@twosigma.com>
 <d312abfe-f87d-3940-ecfa-348fed7ad3a1@web.de>
In-Reply-To: <d312abfe-f87d-3940-ecfa-348fed7ad3a1@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.13]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Torsten Bögershausen [mailto:tboegi@web.de]
> Sent: Friday, March 31, 2017 12:22 AM
> To: David Turner <David.Turner@twosigma.com>; git@vger.kernel.org
> Subject: Re: [PATCH] http.postbuffer: make a size_t
> 
> 
> 
> On 30/03/17 22:29, David Turner wrote:
> > Unfortunately, in order to push some large repos, the http postbuffer
> > must sometimes exceed two gigabytes.  On a 64-bit system, this is OK:
> > we just malloc a larger buffer.
> >
> > Signed-off-by: David Turner <dturner@twosigma.com>
> > ---
> >  cache.h  |  1 +
> >  config.c | 17 +++++++++++++++++
> >  http.c   |  2 +-
> >  3 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/cache.h b/cache.h
> > index fbdf7a815a..a8c1b65db0 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -1900,6 +1900,7 @@ extern int git_parse_maybe_bool(const char *);
> > extern int git_config_int(const char *, const char *);  extern int64_t
> > git_config_int64(const char *, const char *);  extern unsigned long
> > git_config_ulong(const char *, const char *);
> > +extern size_t git_config_size_t(const char *, const char *);
> >  extern int git_config_bool_or_int(const char *, const char *, int *);
> > extern int git_config_bool(const char *, const char *);  extern int
> > git_config_maybe_bool(const char *, const char *); diff --git
> > a/config.c b/config.c index 1a4d85537b..7b706cf27a 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -834,6 +834,15 @@ int git_parse_ulong(const char *value, unsigned
> long *ret)
> >  	return 1;
> >  }
> >
> > +static size_t git_parse_size_t(const char *value, unsigned long *ret)
> > +{
> > +	size_t tmp;
> > +	if (!git_parse_signed(value, &tmp,
> maximum_unsigned_value_of_type(size_t)))
> > +		return 0;
> > +	*ret = tmp;
> > +	return 1;
> > +}
> What is the return value here ?
> Isn't it a size_t we want ?

Yeah, that should return an int, since it's just "parsed" vs "unparsed".

> (There was a recent discussion about "unsigned long" vs "size_t", which
>   are the same on many systems, but not under Win64) Would the following
> work ?
> 
> static int git_parse_size_t(const char *value, size_t *ret) {
> 	if (!git_parse_signed(value, ret,
> maximum_unsigned_value_of_type(size_t)))
> 		return 0;
> 	return 1;
> }
> 
> []
> > +size_t git_config_size_t(const char *name, const char *value) {
> > +	unsigned long ret;
> > +	if (!git_parse_size_t(value, &ret))
> > +		die_bad_number(name, value);
> > +	return ret;
> > +}
> > +
> Same here:
> size_t git_config_size_t(const char *name, const char *value) {
> 	size_t ret;
> 	if (!git_parse_size_t(value, &ret))
> 		die_bad_number(name, value);
> 	return ret;
> }

In v2 I decided to make this a ssize_t, since it was previously a signed int.  I know we're not using negative values right now, but since nobody has 2**63 bytes of ram anyway, it's probably safe to keep it signed to keep our options open.
