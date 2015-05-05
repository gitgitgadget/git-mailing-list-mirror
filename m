From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: t5570 - not cloned error
Date: Tue, 5 May 2015 15:28:20 -0400
Message-ID: <013701d08769$a5bbab80$f1330280$@nexbridge.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Joachim Schmitz'" <jojo@schmitz-digital.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 05 21:28:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpiW8-0001eV-W7
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 21:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756830AbbEET22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 15:28:28 -0400
Received: from elephants.elehost.com ([216.66.27.132]:61302 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306AbbEET22 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 15:28:28 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t45JSMcC024991
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 5 May 2015 15:28:22 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
X-Mailer: Microsoft Outlook 15.0
Content-language: en-ca
Thread-index: AdCHaXoJt6eT4/LXQH+n+D0enyNSYw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268417>

Sorry to repost - ended up in my own spam trap.

On May 1, 2015 11:05 AM, I wrote, in my haste:
> 
> Greetings - and asking for a bit of help resolving test failures.
> 
> I'm having an issue with t5570 at 2.3.7 which seems to be a regression
from
> 2.3.3 (currently installed), but I cannot be sure. This test failed prior
to
> 2.3.0 in the box, worked from 2.3.0 to 2.3.3 - suggesting that it may be
> environmental, not actually in git. Making some assumptions, it looks like
> the URL for the test repository is not correct and may depend on localhost
> resolving properly - which DNS does not do well on this box (outside my
> control, we are multi-home, and localhost does not resolve to 127.0.0.1 or
> [::1]). Only t5570 #'s 3-5 fail and I found a strange message in the
output
> of the test seemingly referring to a bad repo name. I would really
> appreciate some pointers on where to look next and how to go about
resolving
> this. I am happy to try to work through this on 2.4.0 if that would be
more
> efficient for the team. Anything relating to git-daemon makes me nervous
in
> terms of installing the code.
> 
> Platform is HP NonStop (Posix-esque environment):
> 
> In the test output:
> *** t5570-git-daemon.sh ***
> <snip>
> not ok 3 - clone git repository
> #
> #               git clone "$GIT_DAEMON_URL/repo.git" clone &&
> #               test_cmp file clone/file
> #
> not ok 4 - fetch changes via git protocol
> #
> #               echo content >>file &&
> #               git commit -a -m two &&
> #               git push public &&
> #               (cd clone && git pull) &&
> #               test_cmp file clone/file
> #
> not ok 5 - remote detects correct HEAD
> #
> #               git push public master:other &&
> #               (cd clone &&
> #                git remote set-head -d origin &&
> #                git remote set-head -a origin &&
> 
> And
> 
> ../git/t/trash directory.t5570-git-daemon: cat output
> fatal: remote error: repository not exported: /repo.git
> 
> Additional context: t0025, t0301, t3900, t9001, t9020 are not 100% but the
> issues are acceptable - we can discuss separately.

We definitely have an issue with localhost. When forcing the DNS resolver to
return 127.0.0.1, we pass 1-16 then 17 fails as I expected to happen based
on my DNS futzing. Heads up that this test is not-surprisingly sensitive to
DNS problems. My environment is still in a messy state where I can reproduce
the original problem so it might be a useful moment for me to find a way to
modify the test script to harden it. Any suggestion on that score (as in
where and
roughly how it might be made more reliable)?

Note: Since the original post, I moved the fork to 2.4.0.

Cheers,
Randall

