From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Running 'git pull' from an unnamed branch
Date: Sun, 05 Apr 2009 18:05:15 -0700
Message-ID: <7v3acmoalw.fsf@gitster.siamese.dyndns.org>
References: <3f4fd2640904051433u199587c3wc9bf080d138944e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 03:11:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqdMP-0006V7-0e
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 03:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218AbZDFBFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 21:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752869AbZDFBFX
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 21:05:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40228 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbZDFBFW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 21:05:22 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B8FD4CC07;
	Sun,  5 Apr 2009 21:05:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 11F45CC06; Sun, 
 5 Apr 2009 21:05:16 -0400 (EDT)
In-Reply-To: <3f4fd2640904051433u199587c3wc9bf080d138944e7@mail.gmail.com>
 (Reece Dunn's message of "Sun, 5 Apr 2009 22:33:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FF7DDD16-2246-11DE-A852-DD19768B9EAE-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115748>

Reece Dunn <msclrhd@googlemail.com> writes:

> diff --git a/git-pull.sh b/git-pull.sh
> index 8a26763..00a72dd 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -97,6 +97,10 @@ error_on_no_merge_candidates () {
>  	echo "try again (e.g. 'git pull <repository> <refspec>')."
>  	echo "See git-pull(1) for details on the refspec."
>  	echo
> +	echo "You may not be on a branch. In this case, you need to move"
> +	echo "onto the branch you want to pull to (usually master):"
> +	echo "    git checkout <branch>"
> +	echo

I do not think that is necessarily what the user wanted to hear.  Often I
create trial merges on a detached HEAD when I hear a pull-request from
others (I have a few work trees that share the repository with my primary
working area, made with contrib/workdir/git-new-workdir script, and their
HEAD are typically detached at the tip of the master), and in such a use
case, the first line of the instruction in the context in your patch is
the right thing to give.  I do not want to have the resulting trial merge
anywhere on my real branches, and do not want to be told to switch to any
of them.

We really should teach people, especially the new ones early on, that "git
push" and "git pull" are meant to be told where-to/from and what, and how
to drive these commands with explicit arguments, before letting them rely
on the default configuration blindly without understanding the underlying
concepts.

The automation given by the configuration variables is certainly nice, and
the default created by "clone", "remote add" and "checkout -b" (with its
implicit "track") may make them simpler to operate for every day life, but
there is a limit.  Working on a detached HEAD is an ultimate free-form
hacking, and you do not even necessarily _want_ to have a "while my HEAD
is detached, please always do this" default configured.
