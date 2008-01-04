From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git-diff-* --color oddness
Date: Fri, 4 Jan 2008 03:32:52 -0500
Message-ID: <20080104083252.GB3300@coredump.intra.peff.net>
References: <20080104081429.GA30635@coredump.intra.peff.net> <7vabnmm1ww.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, win@wincent.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 09:33:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAhzU-0007im-OI
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 09:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbYADIcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 03:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753458AbYADIcz
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 03:32:55 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1905 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753420AbYADIcy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 03:32:54 -0500
Received: (qmail 15869 invoked by uid 111); 4 Jan 2008 08:32:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 04 Jan 2008 03:32:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2008 03:32:52 -0500
Content-Disposition: inline
In-Reply-To: <7vabnmm1ww.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69560>

On Fri, Jan 04, 2008 at 12:26:55AM -0800, Junio C Hamano wrote:

> > The first two lines of meta-info will be in the stock colors, but
> > everything after will be in the custom colors. So we are actually
> > reading the diff_ui options _during_ the diff. The culprit is
> > funcname_pattern, which calls read_config_if_needed.
> 
> Yuck.  Why is funcname_pattern do ui-config stuff?  I know it
> wants to get custom regexp crap, but that should belong to the
> plumbing part, not Porcelain-only thing, shouldn't it?

It's for user diff drivers, and it looks like the funcname pattern. Not
sure why we want to demand-load that stuff at all...I wonder if it
should just go into git_default_config (or a git_basic_diff_config).

-Peff
