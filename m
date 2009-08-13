From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/4] fast-import: define a new option command
Date: Thu, 13 Aug 2009 08:04:46 -0700
Message-ID: <20090813150446.GM1033@spearce.org>
References: <1250140186-12363-1-git-send-email-srabbelier@gmail.com> <1250140186-12363-2-git-send-email-srabbelier@gmail.com> <1250140186-12363-3-git-send-email-srabbelier@gmail.com> <20090813144327.GK1033@spearce.org> <alpine.DEB.1.00.0908131652190.7429@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 13 17:05:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbbrt-0007LE-Fh
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 17:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689AbZHMPEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 11:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754625AbZHMPEr
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 11:04:47 -0400
Received: from george.spearce.org ([209.20.77.23]:51161 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbZHMPEp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 11:04:45 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CB267381FD; Thu, 13 Aug 2009 15:04:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0908131652190.7429@intel-tinevez-2-302>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125826>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 13 Aug 2009, Shawn O. Pearce wrote:
> > Sverre Rabbelier <srabbelier@gmail.com> wrote:
> >
> > > +Note that options specified by the frontend override any options the
> > > +user may specify to git fast-import itself.
> > 
> > Hmmph.  Do we really want that?  I would think the command line options 
> > should override the stream, such that we can then do something like:
> > 
> >   hg fast-export >foo
> >   git fast-import --export-marks=mymarks <foo
> > 
> > even though 'option export-marks=bar' appears in foo.
> 
> I guess the reason is that this is harder to implement.  The problem is 
> that you _have_ to parse the command line options first.  So you need to 
> record with every option you set that it has been set by the command line, 
> and must not be overridden by the in-stream options.

It might be easy enough to just save the argv into a global, and
reparse the argv immediately before the first non-option command.

> OTOH,
> 
> 	hg fast-export |
> 	sed '1,/^blob/s/^option export-marks=.*$//' > foo
> 
> is relatively easy.

Just for the archives, but that sed expression won't catch inline
data under a file command.  Its legal for a stream to not use the
blob command at all.  I guess it would need to be:

 	hg fast-export |
 	sed '1,/^(blob|commit)/s/^option export-marks=.*$//' > foo

-- 
Shawn.
