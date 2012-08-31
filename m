From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] merge-base: "--is-ancestor A B"
Date: Fri, 31 Aug 2012 10:25:21 -0700
Message-ID: <7vtxvjnfcu.fsf@alter.siamese.dyndns.org>
References: <1346368388-23576-1-git-send-email-gitster@pobox.com>
 <1346368388-23576-3-git-send-email-gitster@pobox.com>
 <CANiSa6iy60Ts5Rdss6EwGN5Vp9KCqn35BzMC+Aacm+zqWjp4-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 19:25:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7UyK-0001A8-2z
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 19:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662Ab2HaRZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 13:25:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55818 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754365Ab2HaRZY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 13:25:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 804BD8E31;
	Fri, 31 Aug 2012 13:25:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B1Xx3hYaeX9cQW1FaZ3/qZ6Lixo=; b=GKcMYN
	tdzyDPlHq3DBMghwIC8+Sq1FqDspzBxAYJ48DdMgdY3oVR0KTjP3SRuc4B2dEJdB
	HbB6kYtx5PG1vClJq0E4G6/Rrek8lMUQlCreLokQsy7MxnzsH7kvrxTYMFD42AZu
	+lBALaE4nla++YZe3+UEtlrf8io+lVclp/Hds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N25kxXEKpKTPsQx0qN3V6dhKOgsmlvjS
	8aCFSkeoPxWRRmRTJLb4n4FCBJ2xxlacTyGK0MZK29aVU4K18mTkQsEPEnZXpVMq
	XIqOwqljisKPtC8fDQQGnzT7JOoeoXGNC07b9VzJL4rcOWTbcCKm+eMEgvIG3WCF
	ytLW1JjkQwA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 624DE8E30;
	Fri, 31 Aug 2012 13:25:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5E918E2D; Fri, 31 Aug 2012
 13:25:22 -0400 (EDT)
In-Reply-To: <CANiSa6iy60Ts5Rdss6EwGN5Vp9KCqn35BzMC+Aacm+zqWjp4-w@mail.gmail.com> (Martin
 von Zweigbergk's message of "Fri, 31 Aug 2012 08:44:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8426112-F390-11E1-8378-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204596>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

>> +       if (argc != 2)
>> +               die("--is-ancestor takes exactly two commits");
>
> I think git merge-base shows the usage message regardless if argc < 2,
> so this only happens when more than two arguments are given.

Yes, but it is a good discipline not to depend too much on what
other parts of the code may have done, when you do not have to.

> Maybe
> include --is-ancestor in the usage message?

I think "merge-base -h" will get this for free thanks to parseopt.

>> +       if (is_ancestor && (show_all | octopus | reduce))
>> +               die("--is-reachable cannot be used with other options");
>
> I suppose --is-reachable should be --is-ancestor.

Thanks, that was a renaming error.

I'll squash the fix in with documentation.

 Documentation/git-merge-base.txt | 28 ++++++++++++++++++++++++++++
 builtin/merge-base.c             |  6 +++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git i/Documentation/git-merge-base.txt w/Documentation/git-merge-base.txt
index b295bf8..87842e3 100644
--- i/Documentation/git-merge-base.txt
+++ w/Documentation/git-merge-base.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git merge-base' [-a|--all] <commit> <commit>...
 'git merge-base' [-a|--all] --octopus <commit>...
+'git merge-base' --is-ancestor <commit> <commit>
 'git merge-base' --independent <commit>...
 
 DESCRIPTION
@@ -50,6 +51,12 @@ from linkgit:git-show-branch[1] when used with the `--merge-base` option.
 	from any other.  This mimics the behavior of 'git show-branch
 	--independent'.
 
+--is-ancestor::
+	Check if the first <commit> is an ancestor of the second <commit>,
+	and exit with status 0 if true, or with status 1 if not.
+	Errors are signaled by a non-zero status that is not 1.
+
+
 OPTIONS
 -------
 -a::
@@ -110,6 +117,27 @@ both '1' and '2' are merge-bases of A and B.  Neither one is better than
 the other (both are 'best' merge bases).  When the `--all` option is not given,
 it is unspecified which best one is output.
 
+A common idiom to check "fast-forward-ness" between two commits A
+and B is (or at least used to be) to compute the merge base between
+A and B, and check if it is the same as A, in which case, A is an
+ancestor of B.  You will see this idiom used often in older scripts.
+
+	A=$(git rev-parse --verify A)
+	if test "$A" = "$(git merge-base A B)"
+	then
+		... A is an ancestor of B ...
+	fi
+
+In modern git, you can say this in a more direct way:
+
+	if git merge-base --is-ancestor A B
+	then
+		... A is an ancestor of B ...
+	fi
+
+instead.
+
+
 See also
 --------
 linkgit:git-rev-list[1],
diff --git i/builtin/merge-base.c w/builtin/merge-base.c
index 615aa04..447ab7c 100644
--- i/builtin/merge-base.c
+++ w/builtin/merge-base.c
@@ -70,7 +70,7 @@ static int handle_octopus(int count, const char **args, int reduce, int show_all
 	return 0;
 }
 
-static int show_is_ancestor(int argc, const char **argv)
+static int handle_is_ancestor(int argc, const char **argv)
 {
 	struct commit *one, *two;
 
@@ -107,9 +107,9 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	if (!octopus && !reduce && argc < 2)
 		usage_with_options(merge_base_usage, options);
 	if (is_ancestor && (show_all | octopus | reduce))
-		die("--is-reachable cannot be used with other options");
+		die("--is-ancestor cannot be used with other options");
 	if (is_ancestor)
-		return show_is_ancestor(argc, argv);
+		return handle_is_ancestor(argc, argv);
 	if (reduce && (show_all || octopus))
 		die("--independent cannot be used with other options");
 
