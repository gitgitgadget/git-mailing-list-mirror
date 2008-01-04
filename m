From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git-diff-* --color oddness
Date: Fri, 4 Jan 2008 03:43:46 -0500
Message-ID: <20080104084345.GA3472@coredump.intra.peff.net>
References: <20080104081429.GA30635@coredump.intra.peff.net> <7vejcym21q.fsf@gitster.siamese.dyndns.org> <20080104082842.GA3300@coredump.intra.peff.net> <7v63yam1i9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, win@wincent.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 09:44:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAiA2-0001js-Aq
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 09:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbYADInt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 03:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753027AbYADIns
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 03:43:48 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3540 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752921AbYADIns (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 03:43:48 -0500
Received: (qmail 15998 invoked by uid 111); 4 Jan 2008 08:43:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 04 Jan 2008 03:43:47 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2008 03:43:46 -0500
Content-Disposition: inline
In-Reply-To: <7v63yam1i9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69565>

On Fri, Jan 04, 2008 at 12:35:42AM -0800, Junio C Hamano wrote:

> What I meant is "git diff" without --color can be colorized
> because of config but we should never allow "git diff-files"
> without --color to be colorized by user's config.  I realize
> that you were talking about the choice of colors, which is a
> different issue.
> 
> I do not much care ;-), but I guess we would want to be
> consistent.

OK, yes, I knew that about diff.color already. But I think it is a bug
to not use the user's colors in "git add -i", and I think the right fix
is to make diff-files consistent in its color choices. Patch will
follow.

> That one _is_ a bug.  diff-files should not be affected by
> "diff.color = auto" or somesuch in the config, even when the
> user uses custom function header crap.

It doesn't use it, actually, but I think that is a happy accident of the
way most config options are used (i.e., we _do_ read and change the
config, but we just never look at it again because we have done our
diff_setup). If you could provoke any of the diff plumbing to call
diff_setup twice, you would be in trouble (but even diff-tree --stdin
doesn't do that).

-Peff
