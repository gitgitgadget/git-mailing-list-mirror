From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] tests: use "git xyzzy" form
Date: Wed, 03 Sep 2008 13:45:46 -0700
Message-ID: <7vwsht9cw5.fsf@gitster.siamese.dyndns.org>
References: <20080903175925.6117@nanako3.lavabit.com>
 <48BE6D1F.1060603@op5.se> <7v8wu9athn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 22:47:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KazFl-0001yc-4v
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 22:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328AbYICUpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 16:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752667AbYICUpy
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 16:45:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48486 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbYICUpy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 16:45:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D89C45B386;
	Wed,  3 Sep 2008 16:45:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CED715B385; Wed,  3 Sep 2008 16:45:48 -0400 (EDT)
In-Reply-To: <7v8wu9athn.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 03 Sep 2008 13:01:56 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4C8779A6-79F9-11DD-89A2-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94851>

Thanks.

I looked at the output from:

    $ git grep -e git-'[a-z]' t/t[0-8]???-*.sh t/t9001-*.sh

after applying these patches to the tip of ho/dashless topic, 7e44c93
('git foo' program identifies itself without dash in die() messages,
2008-08-31) to review what you did not change are reasonable.

I won't quote the whole output from the above grep, but there are a few
lines worth commenting on.

t/t5300-pack-object.sh:test_description='git-pack-object
t/t5305-include-tag.sh:test_description='git-pack-object --include-tag'

These might want changing.

t/t5602-clone-remote-exec.sh:	echo "localhost git-upload-pack '\''/path/to/repo'\''" >expected
t/t5602-clone-remote-exec.sh:	GIT_SSH=./not_ssh git clone -u /something/bin/git-upload-pack localhost:/path/to/repo junk
t/t5602-clone-remote-exec.sh:	echo "localhost /something/bin/git-upload-pack '\''/path/to/repo'\''" >expected

These we do want to keep in git-foo form

The remainder of the grep output looked all reasonable; they hit options
like "--git-dir" and "is-inside-git-dir", and pathnames like "git-gui" and
".git/rebase-merge/git-rebase-todo".

Doing this _carefully_ (otherwise the result would be useless) must have
been quite a lot of effort, and what was posted seems to have been done
quite carefully.

The cross-checking I did with "grep" in this message does *not* catch if
you converted something that shouldn't have been converted (e.g. changing
the pathname ".git/rebase-merge/git-rebase-todo" to "git rebase-todo"
would have been a disaster).  It needs real eyeballing of the patches
themselves to catch such an error, and we would need help from people.

Volunteers?  Just please say "I'll go through patch [n/4] line by line"
now to avoid duplicated work with others (more eyeballs looking at the
same thing will catch more errors, but I do not think we have that many
volunteers here), and then after you are done, come back with "They all
are command invocations and conversion is correct" or with "This one is
incorrect and should be kept."

Oh, also, there are many other t9XXX series of tests.  Can somebody
volunteer to do the same for the rest of them?

Puh-leeeeze?
