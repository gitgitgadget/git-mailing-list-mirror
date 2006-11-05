X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 3/3] Remove unsupported C99 style struct initializers in git-archive.
Date: Sun, 5 Nov 2006 02:36:34 -0500
Message-ID: <20061105073634.GA4616@spearce.org>
References: <20061105053723.GC4193@spearce.org> <7vd582uz5b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 07:36:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vd582uz5b.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30957>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgcYc-000060-GA for gcvg-git@gmane.org; Sun, 05 Nov
 2006 08:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161209AbWKEHgj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 02:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161216AbWKEHgj
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 02:36:39 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42963 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1161209AbWKEHgi
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 02:36:38 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GgcYV-0002cC-47; Sun, 05 Nov 2006 02:36:35 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 B735E20E491; Sun,  5 Nov 2006 02:36:34 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > +static struct archiver_desc
> > +{
> > +	const char *name;
> > +	write_archive_fn_t write_archive;
> > +	parse_extra_args_fn_t parse_extra;
> > +} archivers[] = {
> > +	{ "tar", write_tar_archive, NULL },
> > +	{ "zip", write_zip_archive, parse_extra_zip_args },
> >  };
> 
> If this were a struct with bazillions of fields I might have had
> trouble swallowing the change, but this is so small that it is
> no brainer.

Right; if it was larger I would have been in trouble.  :-)

> I think this actually is an improvement.
> 
> >  static int run_remote_archiver(const char *remote, int argc,
> > @@ -88,7 +86,10 @@ static int init_archiver(const char *nam
> >  
> >  	for (i = 0; i < ARRAY_SIZE(archivers); i++) {
> >  		if (!strcmp(name, archivers[i].name)) {
> > -			memcpy(ar, &archivers[i], sizeof(struct archiver));
> > +			memset(ar, 0, sizeof(*ar));
> > +			ar->name = archivers[i].name;
> > +			ar->write_archive = archivers[i].write_archive;
> > +			ar->parse_extra = archivers[i].parse_extra;
> 
> But is this change really needed?  Shouldn't a structure
> assignment just work?

No, they are different structs...

Which I did to reduce the size of the initializer (see above)
so that it was a no brainer for you to swallow.  :-)

-- 
