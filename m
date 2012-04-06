From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH 3/5] git-cherry-pick: Add ignore-if-made-empty option [v2]
Date: Fri, 6 Apr 2012 14:06:27 -0400
Message-ID: <20120406180627.GB11939@hmsreliant.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-4-git-send-email-nhorman@tuxdriver.com>
 <7vobr551vs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 20:06:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGDYT-0004EA-L0
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 20:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757646Ab2DFSGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 14:06:33 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:40825 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757625Ab2DFSGc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 14:06:32 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SGDYK-0001rg-0u; Fri, 06 Apr 2012 14:06:30 -0400
Content-Disposition: inline
In-Reply-To: <7vobr551vs.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194891>

On Thu, Apr 05, 2012 at 02:01:43PM -0700, Junio C Hamano wrote:
><snip>

> > +	including those which were made empty due to a previous change.
> > +	While this may be desireable, likely it is not.
> 
> Mental note.  Up to this point, the reader is told that "--allow-empty"
> alone is likely to do a wrong thing.
> 
> > +	This option
> > +	restricts the scope of --allow-empty to only those commits which
> > +	were created as empty commits ...
> 
> And the user is asked to give "--ignore-if-made-empty" in addition to
> "--allow-empty" to get a saner and more likely to be useful behaviour.
> Isn't that backwards?  This "the other option is insane, and please make
> it saner" option needs a lot more typing than the more insane option.
> 
> I would expect that "--allow-empty" would by default filter ones that are
> originally non-empty but are made unnecessary (we are allowing empty
> commits in the original history to be cherry-picked, but the general
> principle that unnecessary commits must not be picked still is in effect).
> If you want to give a user the other more insane mode of operation, it is
> OK to let the user give a different option *instead* *of* the saner
> "--allow-empty".
> 
> Perhaps name that "--keep-unnecessary-commit" (it is no longer about
> allowing empty commits in the original history to be picked; it is about
> keeping unnecessary and irrelevant commits in the resulting history).
> 
> And error out if both options are given.
> 
I'm working on this today, and in doing so, I don't think I like the one or the
other option approach.  I think it makes more sense to use an --option /
--option-harder model here.  Theres precident for this in a few other git
command (git format-patch has --find-copies and --find-copies harder).  I think
we can do an --allow-empty option and a --keep-redundant-commits option, where
the former explicitly keeps commits that were non-empty but are now because
their changes have already been applied.  the latter option then naturally
implies the former.

Neil
