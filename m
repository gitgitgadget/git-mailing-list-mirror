From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Correct git-pull documentation
Date: Sat, 16 Feb 2008 01:31:03 -0800
Message-ID: <7vodahb63s.fsf@gitster.siamese.dyndns.org>
References: <1203137441-52448-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 10:32:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQJOu-0001Uq-Hr
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 10:32:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbYBPJba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 04:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752530AbYBPJb3
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 04:31:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbYBPJb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 04:31:27 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FB083954;
	Sat, 16 Feb 2008 04:31:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 37F1F3953; Sat, 16 Feb 2008 04:31:21 -0500 (EST)
In-Reply-To: <1203137441-52448-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Fri, 15 Feb 2008 23:50:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74034>

Jay Soffian <jaysoffian@gmail.com> writes:

> The --rebase option was documented in the wrong place (under MERGE
> STRATEGIES instead of OPTIONS). Noted the branch.<name>.rebase
> option and clarified the use '.' in a few places. Switched
> "git-<command>" to "git command".

Clarifying that --rebase is not a strategy is a good
improvement.  Thanks.

> @@ -55,12 +57,13 @@ Often people use `git pull` without giving any parameter.
>  Traditionally, this has been equivalent to saying `git pull
>  origin`.  However, when configuration `branch.<name>.remote` is
>  present while on branch `<name>`, that value is used instead of
> -`origin`.
> +`origin`. (`branch.<name>.remote` may be set to `.` to pull from 
> +the local repository by default.)

I am not sure if this special case deserves mentioning here.

> -In order to determine what URL to use to fetch from, the value
> -of the configuration `remote.<origin>.url` is consulted
> -and if there is not any such variable, the value on `URL: ` line
> -in `$GIT_DIR/remotes/<origin>` file is used.
> +Unless pulling from the local repository, a URL must be determined
> +for the origin. This is done by first consulting
> +`remote.<origin>.url`. If there is not any such variable, the value
> +on `URL: ` line in `$GIT_DIR/remotes/<origin>` file is used.

Likewise.

> @@ -138,6 +141,9 @@ You should refrain from abusing this option to sneak substantial
>  changes into a merge commit.  Small fixups like bumping
>  release/version name would be acceptable.
>  
> +git pull --rebase . master::
> +	This syntax is equivalent to calling `git rebase master`; see
> +	linkgit:git-rebase[1] for details.

Likewise.  That is a very roundabout way to say "git rebase
master".  It happens to work as a logical consequence of two
facts (1) that you can pull from any remote and (2) that "." is
a valid remote that names local.  I am personally happy that the
command works consistently, but I think we should rather teach
people the more natural way to do their rebase in our
documentation.

The fact that we earlier talked about "git pull ." does not
justify this addition.  Even though "git pull ." is also a
roundabout way, it used to be the only way (we did not have the
"git merge" callable as the top-level command) and there are
existing documents that show the "git pull ." form out there on
the web, and that is the primary reason we mention this ancient
form, so that people who saw such an ancient notation can find
out what it is about in our documentation.  Some people still
prefer it from pure inertia, and we have no reason to deprecate
it, but I do not think it is something we should advertise as
the first class interface.
