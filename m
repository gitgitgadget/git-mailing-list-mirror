From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Test case for "git diff" outside a git repo
Date: Mon, 23 Jul 2007 23:14:28 -0700
Message-ID: <7vy7h6ib0b.fsf@assigned-by-dhcp.cox.net>
References: <20070723132248.GA24122@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 08:14:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDDfF-0001uc-No
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 08:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840AbXGXGOa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 02:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753830AbXGXGOa
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 02:14:30 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:61955 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572AbXGXGO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 02:14:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070724061429.RMDL1399.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 24 Jul 2007 02:14:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TJEU1X00H1kojtg0000000; Tue, 24 Jul 2007 02:14:29 -0400
In-Reply-To: Junio C. Hamano's message of "(unknown date)"
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53525>

Junio C Hamano <gitster@pobox.com> writes:

> Steven Grimm <koreth@midwinter.com> writes:
>
>> Signed-off-by: Steven Grimm <koreth@midwinter.com>
>> ---
>> 	git-diff --quiet is pretty broken right now. If you do
>> 	"strace git diff --quiet file1 file2" you will see that
>> 	it never calls open() on either file! And it always
>> 	returns a zero exit code whether or not the files are
>> 	different.
>>
>> 	I'm trying to follow the code to figure out what's going on,
>> 	but meanwhile, here's a test case. Perhaps someone more
>> 	familiar with the diff code will beat me to a fix.

The code to do "untracked diff" is an ugly stepchild and not
really part of git-diff proper.  In fact, --quiet also is an
afterthought and I would not be too surprised if the "untracked
diff" code does not work with it.

>> diff --git a/t/t4021-diff-norepo.sh b/t/t4021-diff-norepo.sh
>> new file mode 100755
>> index 0000000..dfee3d7
>> --- /dev/null
>> +++ b/t/t4021-diff-norepo.sh
>> @@ -0,0 +1,26 @@
>> +#!/bin/sh
>> +
>> +test_description='test git diff outside a repo'
>> +
>> +. ./test-lib.sh
>> +
>> +rm -rf .git

Unless you are testing the t/ directory and git.git suite from a
tarball, the only effect of this is to make t/trash controlled
by its ../../.git repository (i.e. the git.git repository).  You
are still inside a git repository.
