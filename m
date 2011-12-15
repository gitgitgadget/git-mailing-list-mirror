From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH 2/4] test-lib: allow testing another git build tree
Date: Thu, 15 Dec 2011 11:33:45 +0100
Message-ID: <3016269.uH93UWUbx5@thomas.inf.ethz.ch>
References: <cover.1323876121.git.trast@student.ethz.ch> <94f64a03398829bb9a11c18577efb39d9b153eca.1323876121.git.trast@student.ethz.ch> <7vsjkmpm6g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 11:45:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rb8ov-0000Bf-Ok
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 11:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755874Ab1LOKpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 05:45:45 -0500
Received: from psi.thgersdorf.net ([188.40.92.130]:46415 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365Ab1LOKpo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 05:45:44 -0500
X-Greylist: delayed 639 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Dec 2011 05:45:44 EST
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 95B87133D9F;
	Thu, 15 Dec 2011 11:17:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id xOsJ2SKfI9BI; Thu, 15 Dec 2011 11:17:14 +0100 (CET)
Received: from thomas.inf.ethz.ch (pctrast.inf.ethz.ch [129.132.153.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 67CF7133D8C;
	Thu, 15 Dec 2011 11:17:14 +0100 (CET)
User-Agent: KMail/4.7.2 (Linux/3.1.5-1-desktop; KDE/4.7.2; x86_64; ; )
In-Reply-To: <7vsjkmpm6g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187204>

On Wednesday 14 December 2011 19:07:35 Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> > The perf-lib work wants this feature, so we may as well do it for
> > test-lib in general.
> 
> How is this different from what GIT_TEST_INSTALLED already gives us
> (other than "needs more diskspace to keep another source tree fully
> built", that is)?

I was scared away by the note that it would use (among others) perl
libs from the current build tree.  Upon investigation I also see that
the test-* situation is still not satisfactory.  Some (like
test-chmtime) are used by the tests for a vital task, and if they ever
have to be fixed, we would want to use the fixed version in any "test
an old git" run.  OTOH, others (e.g., test-dump-cache-tree) are linked
with the rest of the code and serve to test an otherwise not
accessible part of it, and testing an old git should use them from the
tested tree.

The disk space argument is moot IMO: for sane perf testing you need
the extra build tree anyway because you cannot checkout another
version in the current tree.  Otherwise the scripts may change and/or
disappear from under themselves.

An optimization might be to have the run script only use a single
build tree and several install trees.  However, while such a built
tree takes just over 100MB of space in my tests, everything installed
$PREFIX/libexec/git-core is also already 65MB here.  So the latter
scheme would only amortize itself if you had at least 3 trees tested
simultaneously.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
