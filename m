From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] fast-import: Stream very large blobs directly to pack
Date: Wed, 03 Feb 2010 21:28:15 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002032126050.1681@xanadu.home>
References: <20100129012350.GD20488@spearce.org>
 <fabb9a1e1001291035l5cd09cb6q1f12037f96dce8a1@mail.gmail.com>
 <20100129183705.GB22101@spearce.org> <7vockc45ut.fsf@alter.siamese.dyndns.org>
 <7vmxzw15dt.fsf@alter.siamese.dyndns.org>
 <7v3a1oyrkp.fsf@alter.siamese.dyndns.org> <20100201152826.GE8916@spearce.org>
 <7v7hqtzrmq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 03:28:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcrSS-00034F-GP
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 03:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071Ab0BDC2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 21:28:35 -0500
Received: from relais.videotron.ca ([24.201.245.36]:30663 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756044Ab0BDC2f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 21:28:35 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXA002CEPJ3KI81@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 03 Feb 2010 21:28:16 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v7hqtzrmq.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138936>

On Wed, 3 Feb 2010, Junio C Hamano wrote:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > The strtoumax call got messed up.  Squash this into your merge:
> >
> > diff --git a/fast-import.c b/fast-import.c
> > index e6ebcf6..9c65a24 100644
> > --- a/fast-import.c
> > +++ b/fast-import.c
> > @@ -2800,7 +2800,7 @@ static int parse_one_option(const char *option)
> >  	if (!prefixcmp(option, "max-pack-size=")) {
> >  		option_max_pack_size(option + 14);
> >  	} else if (!prefixcmp(option, "big-file-threshold=")) {
> > -		big_file_threshold = strtoumax(option + 21, NULL, 0) * 1024 * 1024;
> > +		big_file_threshold = strtoumax(option + 19, NULL, 0) * 1024 * 1024;
> >  	} else if (!prefixcmp(option, "depth=")) {
> >  		option_depth(option + 6);
> >  	} else if (!prefixcmp(option, "active-branches=")) {
> >  
> >> You may want to add the new option to the output from "cmd -h" and
> >> probably description of the configuration in the doc before any of this
> >> gets official.
> >
> > I'll send an additional patch in a minute with these documentation
> > related updates.
> 
> Well, well, well....
> 
> The documentation says this is counted in bytes, but somehow neither of us
> found the above " * 1024 * 1024" suspicious.
> 
> Shouldn't it be at least like this?  It would probably be a good idea to
> use git_parse_ulong() or somesuch while we are at it.

Yes, definitely.  I'm about to post a patch moving --max-pack-size in 
that direction too.  I just had to fix a couple other unsuspected issues 
to get there though.  Patches will follow shortly.


Nicolas
