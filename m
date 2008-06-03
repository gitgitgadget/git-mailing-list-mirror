From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add an optional <mode> argument to commit/status
 -u|--untracked-files option
Date: Tue, 03 Jun 2008 13:02:34 -0700
Message-ID: <7vod6i1e3p.fsf@gitster.siamese.dyndns.org>
References: <7viqwvk04y.fsf@gitster.siamese.dyndns.org>
 <c9062d05cabcbd45657e89b03eac9715a46f8b79.1212498900.git.marius@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 22:03:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3cjW-0000Jh-6T
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 22:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbYFCUC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 16:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754564AbYFCUC5
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 16:02:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60297 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645AbYFCUC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 16:02:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F1CAC4C38;
	Tue,  3 Jun 2008 16:02:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3193A4C36; Tue,  3 Jun 2008 16:02:47 -0400 (EDT)
In-Reply-To: <c9062d05cabcbd45657e89b03eac9715a46f8b79.1212498900.git.marius@trolltech.com> (Marius Storm-Olsen's message of "Tue, 3 Jun 2008 15:09:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0D62044C-31A8-11DD-A163-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83696>

Marius Storm-Olsen <marius@trolltech.com> writes:

> Determining untracked files can be a very slow operation on large trees.
> This commit adds a <mode> argument, which allows you to avoid showing the
> untracked files in a repository. Possible options are:
>     none   - Show no untracked files
>     normal - Show untracked files and directories
>     all    - Show all untracked files
>
> If the optional argument is not specified, the option defaults to 'all'.

You got me worried.  You are defaulting the parameter of "-u" to 'all',
not making the command default (in the absense of -u anything) to "-u
all", which was what I misunderstood on my first reading.  "the optional
parameter defaults to 'all'" is what you meant...

enum {NONE,NORMAL,ALL}_UNTRACKED are named (1) too generic, in a sense
that it is not clear _what_ is done to the class of untracked worktree
entities, and/or (2) opposite from other enums where common prefix is
followed by differing part.

Perhaps renaming them to SHOW_{NONE,NORMAL,ALL}_UNTRACKED would make it
easier to read.

It would have been nicer if this patch was further split into two; the
first one to introduce NORMAL and ALL without changing any behaviour, then
the second one to add NONE to introduce a new behaviour, with tests so
that other people will not break this new feature in their later changes.

> @@ -150,12 +150,15 @@ but can be used to amend a merge commit.
>  	the last commit without committing changes that have
>  	already been staged.
>  
> --u|--untracked-files::
> -	Show all untracked files, also those in uninteresting
> -	directories, in the "Untracked files:" section of commit
> -	message template.  Without this option only its name and
> -	a trailing slash are displayed for each untracked
> -	directory.
> +-u[<mode>]|--untracked-files[=<mode>]::
> +	Show all untracked files.
> +	The mode parameter is optional, and is used to specify
> +	the handling of untracked files. The possible options are:
> +		none   - Show no untracked files
> +		normal - Shows untracked files and directories
> +		all    - Also shows individual files in untracked directories.
> +	If the mode parameter is not specified, the defaults is
> +	'all'.

Does this mark-up actually work?
