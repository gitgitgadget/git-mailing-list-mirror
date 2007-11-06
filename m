From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/10] Migrate git-clone to use git-rev-parse --parseopt
Date: Tue, 06 Nov 2007 11:39:01 -0800
Message-ID: <7vmytrgo4q.fsf@gitster.siamese.dyndns.org>
References: <1194172262-1563-1-git-send-email-madcoder@debian.org>
	<1194172262-1563-2-git-send-email-madcoder@debian.org>
	<1194172262-1563-3-git-send-email-madcoder@debian.org>
	<1194172262-1563-4-git-send-email-madcoder@debian.org>
	<1194172262-1563-5-git-send-email-madcoder@debian.org>
	<alpine.LFD.0.9999.0711061355330.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Nov 06 20:39:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpUGj-0005j4-Df
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 20:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504AbXKFTjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 14:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754386AbXKFTjK
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 14:39:10 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:59590 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140AbXKFTjI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 14:39:08 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E52E92EF;
	Tue,  6 Nov 2007 14:39:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6707091C9F;
	Tue,  6 Nov 2007 14:39:25 -0500 (EST)
In-Reply-To: <alpine.LFD.0.9999.0711061355330.21255@xanadu.home> (Nicolas
	Pitre's message of "Tue, 06 Nov 2007 14:04:07 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63706>

Nicolas Pitre <nico@cam.org> writes:

> On Sun, 4 Nov 2007, Pierre Habouzit wrote:
>
>> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
>> ---
>>  git-clone.sh |  102 +++++++++++++++++++++++++++++++++-------------------------
>>  1 files changed, 58 insertions(+), 44 deletions(-)
>
> Well, this patch was merged in "next" and broke git-clone rather badly.
>
> Just try something as fundamental as this:
>
> 	$ git clone git://git.kernel.org/pub/scm/git/git.git
> 	fatal: Not a git repository
>
> Don't we have test cases covering this really basic operation?

We do, but RUN_SETUP will happily go up to find the .git/ next
to t/ directory that is the parent of trash/ directory, in which
the tests run, without reporting errors.  As parseopt does not
depend on anything in git, this will not do any harm other than
falsely succeeding the test that should not pass.

We could probably introduce an environment variable, GIT_CEILING,
that tells the setup_git_directory_gentry() never go up beyond
that point, and set it to the t/trash directory while running
the test.

Something like that may have other uses in practice.  Often
people wonder what would happen if there is /.git repository and
they would want to make sure they would not accidentally add to
the repository controlled by /.git when they have bunch of other
repositories /some/where/.git in which they usually work.
