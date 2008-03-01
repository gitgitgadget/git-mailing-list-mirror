From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t6024-recursive-merge.sh: hide spurious output when
	not running verbosely
Date: Fri, 29 Feb 2008 23:10:05 -0500
Message-ID: <20080301041005.GA8969@coredump.intra.peff.net>
References: <1204323805-23185-1-git-send-email-mh@glandium.org> <alpine.LSU.1.00.0802292334040.22527@racer.site> <7v1w6vb9w4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 05:11:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVJ4O-0008Ad-Tb
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 05:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762056AbYCAEKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 23:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757951AbYCAEKM
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 23:10:12 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2364 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762056AbYCAEKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 23:10:09 -0500
Received: (qmail 28965 invoked by uid 111); 1 Mar 2008 04:10:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 29 Feb 2008 23:10:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Feb 2008 23:10:05 -0500
Content-Disposition: inline
In-Reply-To: <7v1w6vb9w4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75605>

On Fri, Feb 29, 2008 at 03:50:03PM -0800, Junio C Hamano wrote:

> Actually, I think this might be a bit more sensible approach.
> 
> -- >8 --
> tests: allow optional clean-up phrase to expect_success/failure
> 
> When one test modifies the state of the test repository that the later
> tests may depend on, you may want to add a clean-up action that is run
> regardless of the outcome of the main part of the test.
> 
> This can now be specified as the third parameter to test_expect_success
> and test_expect_failure functions.

I think your heart is in the right place with this patch, but I doubt
that it is going to be all that productive in practice. Most tests
consist of a long list of commands, and cleaning up properly after every
possible failure case is going to be a lot of work. And worse, since the
tests generally _don't_ fail, you have no way to test that your cleanup
is reasonable.

So I think we will end up in the case where a few failed tests will
properly clean themselves up and let further tests proceed, but most
failures will leave a big question. In other words, what problem have we
solved?  If tests N and N+k both fail, would you, even with this patch,
suspect N+k of actually failing, or would you first go and debug test N?
Is that any different than what you do now?

-Peff
