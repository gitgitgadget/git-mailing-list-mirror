From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git svn: optionally trim imported log messages
Date: Sun, 19 Aug 2012 16:59:41 -0700
Message-ID: <7vsjbio2ky.fsf@alter.siamese.dyndns.org>
References: <50315ED1.6080803@debian.org>
 <1345413170-2519-1-git-send-email-robert@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Robert Luberda <robert@debian.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 01:59:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3FPR-00057d-NZ
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 01:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038Ab2HSX7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 19:59:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49019 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787Ab2HSX7o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 19:59:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E62368C61;
	Sun, 19 Aug 2012 19:59:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4cqCJ5cobC/NGzYOndBDwryLDfA=; b=v4s7qj
	z63XaT5Vym0GfiPfszIYw7lJtZpGZ08RrVwyVghGFw5oCUvgbaELhHOK6dDbHEtT
	o48xdLsi3/w5G46g4HSp4SqrzAFRgiq2vervArVscdQ1oYPnczeLAUDTHTiHtr+c
	Koh2OdDFNHA8QFOtP4rPL8/OfofNZeSukLrr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lg1QpIQAArlR5LYLJiM8uRIkwvOD4380
	+8erNzEluFEFGir1BDKFonJNUbR8P7wsfyqUboxXXLbUYjeihgOMTiDFfo5zzGeS
	5uNb3ROOxkka/he9XgEDxSGaXGTOB7GcOtrOSUeuo1uzJmiUlPYSJlQwc14GK6Ur
	hTyN7AABigM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D45508C60;
	Sun, 19 Aug 2012 19:59:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE8EB8C5F; Sun, 19 Aug 2012
 19:59:42 -0400 (EDT)
In-Reply-To: <1345413170-2519-1-git-send-email-robert@debian.org> (Robert
 Luberda's message of "Sun, 19 Aug 2012 23:52:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1E5FF2E-EA59-11E1-A9FA-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203743>

Robert Luberda <robert@debian.org> writes:

> Introduce a `--trim-svn-log' option and svn.trimsvnlog boolean
> configuration key for git svn commands.
>
> When enabled while retrieving commits from svn, git svn will strip any
> white spaces from beginnings and endings of SVN commit messages and will
> skip adding an extra new line character before `git-svn-id:' line in case
> the commit message already ends with a pseudo-headers section (a section
> starting with an empty line followed by one or more pseudo-headers like
> `From: ', `Signed-off-by: ', or `Change-Id: ').
>
> Additionally, while creating new commits in svn when the new option is
> enabled and `--add-author-from' is in effect, git svn will not add
> a new line character before the `From: ' pseudo-header if the commit
> message already ends with a pseudo-headers section.
>
> The new option allows one to use gerrit code review system on
> git-svn-managed repositories. gerrit expects its `Change-Id:' header
> to appear in the last paragraph of commit message and the standard
> behaviour of preceding `git-svn-id:' line with a new line character
> was breaking this expectation.
> ---

Sign-off?

>  Documentation/git-svn.txt          |   16 ++
>  git-svn.perl                       |    8 +-
>  perl/Git/SVN.pm                    |   19 +-
>  t/t9165-git-svn-import-messages.sh |  387 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 427 insertions(+), 3 deletions(-)
>  create mode 100755 t/t9165-git-svn-import-messages.sh
>
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index cfe8d2b..79c21ee 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -603,6 +603,22 @@ creating the branch or tag.
>  	git commit's author string.  If you use this, then `--use-log-author`
>  	will retrieve a valid author string for all commits.
>  
> +--trim-svn-log::
> +	When retrieving svn commits into git (as part of 'fetch', 'rebase',
> +	or 'dcommit') trim the whitespaces from beginnings and endings
> +	of the svn log messages and avoid preceding `git-svn-id:` line with
> +	a new line character in case the log message already ends with a
> +	pseudo-headers section (i.e. section starting with an empty line
> +	followed by one or more lines like `Signed-off-by: `, `From: `,
> +	or `Change-Id: `).
> ++
> +When committing to svn from git (as part of 'commit-diff', 'set-tree'
> +or 'dcommit') and '--add-author-from' is in effect, a new line character
> +is not added before the `From: ` line if the log message ends with
> +a pseudo-headers section.

I think it would be saner to call them "trailers" to avoid
confusion.

I've seen S-o-b, Cc and Change-Id there, but does anybody actually
put "From: " there?

There needs an explanation to the reader why this is an optional
feature.

> --- /dev/null
> +++ b/t/t9165-git-svn-import-messages.sh
> @@ -0,0 +1,387 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2012 Robert Luberda
> +#
> +
> +test_description='checks behaviour of --trim-svn-log option of git svn'
> +. ./lib-git-svn.sh
> +
> +# The test cases in this file check if the --trim-svn-log option
> +# of git svn works as expected.
> +#
> +# Basically the test cases use two git repositories:
> +# * work-TRIM.git, created by git svn clone with the option enabled,
> +# * work-NOTR.git, created with the option disabled.
> +#
> +# Each test case (except for the first two) does the following:
> +# 1. commit a change to svn with either svn commit, or git svn dcommit
> +#    (what is important is the commit log message, not the changed file)
> +# 2. git svn rebase the  work-NOTR.git repository and check its most recent
> +#    log message against some expected output
> +# 3. git svn rebase the work-TRIM.git repository and similarly check the
> +#    latest log message
> +#
> +# The following two prerequisites are defined mostly for debugging purposes
> +# to make it possible to skip test cases or parts of the test cases that
> +# operate on one of the two git repositories. For example to ignore checking

The prerequisite mechanism is to allow some tests in an environment
where they cannot be run (e.g. no SVN available on the platform);
any code that uses set_prereq unconditionally looks extremely
strange.  It is OK while the patch is in RFC stage under active
debugging, but they would want to go away before the polishing is
done.

> +# of log messages imported when --trim-svn-log is enabled, one needs to comment
> +# out the PRQ_TRIM pre-requisite (this makes it possible to run the test with
> +# a version of git svn that does not support the option yet). Similarly
> +# commenting out the PRQ_NOTR pre-requisite will check only the effects of the
> +# svn log trimming option.
> +# Please note that a whole test case must be marked as requiring one of
> +# those pre-requisites if and only if it uses `git svn dcommit' for committing
> +# changes to svn.
> +test_set_prereq PRQ_TRIM
> +test_set_prereq PRQ_NOTR

> +N=0
> +NL=""	# for better readability only, e.g.:
> +	# "$NL" "   " "$NL" is cleaner than "" "   " ""

What does En-El stand for?  We often see (but not in Git where we
prefer LF for that purpose)

	NL='
        ' ;# newline

and using $NL to mean "empty" may be misleading to the readers.

> +next_N()
> +{
> +	N=$((N + 1)) &&
> +	echo "N is $N"
> +}

Most shells tolerate writing a bare N inside arith substitution, but
for better portability, please spell this as

	next_N () {
		N=$(($N + 1)) &&
                ...
	}

(the above also has two style fixes).

> +
> +# An utility function used for writing log messages to files
> +get_file_contents()
> +{
> +	for line in "$@"; do
> +		echo "$line"
> +	done
> +}

(Style)
	get_file_contents () {
                for line
                do
                        ...
                done
	}
