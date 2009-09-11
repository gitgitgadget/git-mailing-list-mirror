From: Jeff King <peff@peff.net>
Subject: Re: bash_completion outside repo
Date: Fri, 11 Sep 2009 17:29:38 -0400
Message-ID: <20090911212938.GA26589@coredump.intra.peff.net>
References: <a3b675320909100813i3e70ab3at66408aebb9952c7d@mail.gmail.com>
 <20090911133313.GF2582@inocybe.localdomain>
 <a3b675320909110700k7eb7286qc8cb5691aae214c7@mail.gmail.com>
 <20090911141730.GA384@coredump.intra.peff.net>
 <20090911143651.GE1033@spearce.org>
 <20090911150934.GB977@coredump.intra.peff.net>
 <20090911164730.GA21536@coredump.intra.peff.net>
 <7viqfpw6tv.fsf@alter.siamese.dyndns.org>
 <7vvdjpuqgx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	james bardin <jbardin@bu.edu>, Todd Zullinger <tmz@pobox.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 23:30:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmDgu-0002te-5O
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 23:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756902AbZIKV3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 17:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756879AbZIKV3k
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 17:29:40 -0400
Received: from peff.net ([208.65.91.99]:58003 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756851AbZIKV3j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 17:29:39 -0400
Received: (qmail 9247 invoked by uid 107); 11 Sep 2009 21:29:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 11 Sep 2009 17:29:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Sep 2009 17:29:38 -0400
Content-Disposition: inline
In-Reply-To: <7vvdjpuqgx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128222>

On Fri, Sep 11, 2009 at 02:22:06PM -0700, Junio C Hamano wrote:

> So here is an illustration to handle _only_ a misspelled
> branch.autosetupmerge.
> 
> If you have this in your .git/config file:
> 
> 	[branch]
>         	autosetupmerge = nevver
> 
> you cannot run "git diff" without this patch.  But with this patch, only
> the commands that _care_ about this misconfiguration would notice and
> report.

OK, that example makes sense. But I'm a little dubious of how this
scales to something like color.diff.plain. Who is responsible for
checking? Do we do it at the beginning of every program which cares
about diff values? If so, what is the failure mode when we forget (and I
suspect we will, because it is easy for programs to call into unexpected
code that is three layers deep)?

I think something like that needs to "belong" to the diff code itself. I
guess in the case of "diff", we could check all diff-related config at
diff setup time. But what about something used in several places, like
core.quotepath?

-Peff
