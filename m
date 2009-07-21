From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 11/12] Cleanup Config's MAGIC_EMPTY_VALUE to be
	more safe
Date: Tue, 21 Jul 2009 14:54:51 -0700
Message-ID: <20090721215451.GU11191@spearce.org>
References: <1248207570-13880-1-git-send-email-spearce@spearce.org> <1248207570-13880-11-git-send-email-spearce@spearce.org> <1248207570-13880-12-git-send-email-spearce@spearce.org> <200907212351.21760.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 23:55:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTNIz-00034G-Cy
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 23:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032AbZGUVyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 17:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755855AbZGUVyv
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 17:54:51 -0400
Received: from george.spearce.org ([209.20.77.23]:42778 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111AbZGUVyv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 17:54:51 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3F729381FD; Tue, 21 Jul 2009 21:54:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200907212351.21760.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123722>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> tisdag 21 juli 2009 22:19:29 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> > The magic value "%%magic%%empty%%" is just too magic; 
...
> > -	private static final String MAGIC_EMPTY_VALUE = "%%magic%%empty%%";
> > +	private static final String MAGIC_EMPTY_VALUE = new StringBuilder(0)
> > +			.toString();
> 
> Can we be sure an implementation doesn't "optimize" toString() here? But an
> explicit new String() shouldn't be..?

*sigh*

I used this form because FindBugs dislikes new String("").  But yea,
at least with new String() we know its a new string object and
there is no pooling of the empty string going on under the covers.

I can't imagine it being a common enough case to convert a
StringBuilder to an empty string that a runtime implementation would
waste instructions over checking for it and reusing a pooled copy,
but eh, yea, maybe this should be new String("") and include a
FindBugs entry to disable the warning here.

-- 
Shawn.
