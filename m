From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] logging branch deletion to help recovering from
 mistakes
Date: Tue, 7 Dec 2010 10:23:42 -0800
Message-ID: <20101207182342.GA3725@spearce.org>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org>
 <AANLkTikbsyFUzZeu8R6yAND6spV6OnvYL08gYZ+ZgJCh@mail.gmail.com>
 <7vmxoiqeoq.fsf@alter.siamese.dyndns.org>
 <20101207170623.GB21749@sigill.intra.peff.net>
 <AANLkTimnp3xCHp_3E7ry-5OQL3PFnYh=H8PhfzMN307C@mail.gmail.com>
 <20101207182040.GA26770@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 07 19:23:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ2Cf-0005Cm-CY
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 19:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397Ab0LGSXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 13:23:45 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37821 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070Ab0LGSXo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 13:23:44 -0500
Received: by pva4 with SMTP id 4so63180pva.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 10:23:44 -0800 (PST)
Received: by 10.142.194.12 with SMTP id r12mr1266451wff.366.1291746223962;
        Tue, 07 Dec 2010 10:23:43 -0800 (PST)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.74.25])
        by mx.google.com with ESMTPS id q13sm9269878wfc.17.2010.12.07.10.23.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 10:23:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101207182040.GA26770@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163105>

Jeff King <peff@peff.net> wrote:
> On Tue, Dec 07, 2010 at 10:14:19AM -0800, Shawn O. Pearce wrote:
> 
> > Per check-ref-format, ref names cannot contain two dots.  We could
> > archive ref logs by renaming them, $GIT_DIR/logs/refs/heads/foo
> > becomes $GIT_DIR/logs/refs/heads/foo..deleted-1.  If foo is created
> > and deleted again, it becomes foo..deleted-2.
...
> > A different approach might be to have $GIT_DIR/logs/refs/REF_ATTIC,
> 
> That seems a lot less efficient, as we have to linearly search all of
> REF_ATTIC to get:
> 
>   1. the reflog for one deleted branch
> 
>   2. the list of deleted branches
> 
> Neither of those is probably particularly performance critical, but it
> just seems like keeping the logs in files indexed by the original ref
> names is a more natural fit.

Yea, I'm leaning more towards the foo..deleted-n idea too, for the
same reasons.  It also makes it easier to GC a deleted branch's
reflog, we can examine the last record's timestamp in a reasonable
time bound and unlink the log if its really freaking old.

-- 
Shawn.
