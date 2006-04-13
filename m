From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] diff-options: add --stat
Date: Thu, 13 Apr 2006 11:39:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604131138080.14565@g5.osdl.org>
References: <Pine.LNX.4.63.0604130301240.28688@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64ld2uyv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 13 20:39:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FU6jL-0000w2-3Z
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 20:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWDMSjn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 14:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWDMSjn
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 14:39:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14257 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932283AbWDMSjn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Apr 2006 14:39:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3DIdNtH025331
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 13 Apr 2006 11:39:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3DIdMsg026128;
	Thu, 13 Apr 2006 11:39:23 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64ld2uyv.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18665>



On Thu, 13 Apr 2006, Junio C Hamano wrote:
> 
> I like what this tries to do (as I already said), but there are
> issues with the way it does it; here are some comments.
> 
> > +static int fn_diffstat(void *priv, mmbuffer_t *mb, int nbuf)
> > +{
> > +...
> > +	for (i = 0; i < nbuf; i++)
> > +		if (mb[i].ptr[0] == '+')
> > +			x->added++;
> > +		else if (mb[i].ptr[0] == '-')
> > +			x->deleted++;
> > +	return 0;
> > +}
> 
> This is broken if you have a hunk that adds, deletes or
> leaves a line that happens to begin with a plus or a minus.

I think you can just depend on it being in mb[0].ptr[0], no?

xdiff always gives full lines at a time, afaik, and mb[0] always ends up 
being available.

		Linus
