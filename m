From: Nick Andrew <nick@nick-andrew.net>
Subject: Re: [PATCH] be paranoid about closed stdin/stdout/stderr
Date: Wed, 27 Aug 2008 12:04:00 +1000
Message-ID: <20080827020400.GA12189@mail.local.tull.net>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu> <48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org> <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net> <7vbpzgb94q.fsf@gitster.siamese.dyndns.org> <E1KXsL9-0004ef-Co@fencepost.gnu.org> <48B3A948.3080800@viscovery.net> <7vsksrad7o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Paolo Bonzini <bonzini@gnu.org>,
	Karl Chen <quarl@cs.berkeley.edu>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 20:13:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYPW5-0003jo-UD
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 20:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbYH0SMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 14:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbYH0SMI
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 14:12:08 -0400
Received: from vps1.tull.net ([66.180.172.116]:60831 "HELO vps1.tull.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751786AbYH0SMH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 14:12:07 -0400
Received: (qmail 25158 invoked by uid 1015); 28 Aug 2008 04:12:06 +1000
Received: from [10.0.0.67] (HELO tull.net) (10.0.0.67) by vps1.tull.net (qpsmtpd/0.26) with SMTP; Thu, 28 Aug 2008 04:12:06 +1000
Received: (qmail 12309 invoked by uid 1000); 27 Aug 2008 12:04:00 +1000
Content-Disposition: inline
In-Reply-To: <7vsksrad7o.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SMTPD: qpsmtpd/0.26, http://develooper.com/code/qpsmtpd/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93913>

On Tue, Aug 26, 2008 at 10:38:35AM -0700, Junio C Hamano wrote:
> This is going too far.  Have you seen any other sane program that do this?

Hmm. I posted a patch to the "sane" project (scanner daemon) to avoid a
similar problem. The patch was rejected.

saned tries to sanitise its environment, specifically low order fds:

fd = open("/dev/null", O_RDWR);
dup2(fd, 0);
dup2(fd, 1);
fup2(fd, 2);
close(fd);

And I pointed out that if the fds aren't sanitary (all fds open) before
the code snippet, they won't be sanitary after it. My patch was only:

if (fd > 2)
    close(fd);

If closing fd 0/1/2 and then forking a subprocess is the unix equivalent
of delayed shooting yourself in the foot then I can agree; git doesn't
need it.

Nick.
