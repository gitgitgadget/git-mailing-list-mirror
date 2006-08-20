From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Object hash (was: Re: [ANNOUNCE] git-rev-size: calculate sizes
 of repository)
Date: Sun, 20 Aug 2006 18:51:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608201846110.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060820105452.GA19630@nospam.com> <20060820152404.GA5679@nospam.com>
 <Pine.LNX.4.63.0608201805070.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <200608201837.33577.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rutger Nijlunsing <git@wingding.demon.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 20 18:52:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEqWl-0005gf-3s
	for gcvg-git@gmane.org; Sun, 20 Aug 2006 18:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWHTQv4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 12:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWHTQv4
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 12:51:56 -0400
Received: from mail.gmx.de ([213.165.64.20]:27269 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750901AbWHTQvz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Aug 2006 12:51:55 -0400
Received: (qmail invoked by alias); 20 Aug 2006 16:51:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 20 Aug 2006 18:51:54 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200608201837.33577.Josef.Weidendorfer@gmx.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25757>

Hi,

On Sun, 20 Aug 2006, Josef Weidendorfer wrote:

> On Sunday 20 August 2006 18:09, Johannes Schindelin wrote:
> 
> > +static unsigned int hash_index(struct hash_map *hash, const char *sha1)
> > +{
> > +	unsigned int index = *(unsigned int *)sha1;
> 
> If you have the same SHA1, stored at different addresses, you get different
> indexes for the same SHA1. Index probably should be calculated from the
> SHA1 string.

Actually, it does! "*(unsigned int *)sha1" means that the first 4 bytes 
of the sha1 are interpreted as a number.

> > +void hash_put(struct hash_map *hash, struct object *obj)
> > +{
> > +	if (++hash->nr > hash->alloc / 2)
> > +		grow_hash(hash);
> 
> If you insert the same object multiple times, hash->nr will get too big.

First, you cannot put the same object multiple times. That is not what a 
hash does (at least in this case): it stores unique objects (identified by 
their sha1 in this case). If you put another object with the same sha1, 
the first will be replaced.

Second, since you call hash_put() once per object, hash->nr cannot grow 
too big, because grow_hash() doubles hash->alloc. And I call grow_hash() 
once the hash map is half-full; Somebody once told me that would be the 
optimal growing strategy.

Ciao,
Dscho
 
