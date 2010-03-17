From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git checkout -b: unparent the new branch with -o
Date: Wed, 17 Mar 2010 14:48:06 -0700
Message-ID: <7vk4ta7h7t.fsf@alter.siamese.dyndns.org>
References: <1268851584-10988-1-git-send-email-erick.mattos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 22:48:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ns16D-0003JW-4D
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 22:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587Ab0CQVsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 17:48:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34000 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab0CQVsO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 17:48:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EFE59A2B01;
	Wed, 17 Mar 2010 17:48:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Gf5nlBbvqKGNJvvsfZJH02MJzBk=; b=XZPDfKRt4d2KQ9GXdBhx2nz
	O/SHY2yBAu3R1vAToh7cX2tO4CTl6h6j1SY4lD4Y8I+XAt1Ivt9aaNEjw83dlzYh
	iB+jV+7fhYAfVY4iOKFkT/kTaQ8/txZz061Qo/07+FjWoAedzxmEtudFVCaC8i80
	UJOQhklSU76LGTYwIfuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=EUJv45LGun1x+wUj3LyBJ3bXhVqzmGrokdid4+GfeCEX6FkII
	QXQhzQOAdL7twtW0buT+DjRV0P3EOMjU3y9yimJpKd0wTa+uRPEWnq0GQ3ALKWfZ
	Zt8dQ6+l0ixlAkii3zxKCN1yFGyZ/2VIO9Q/wUmWzsm+sZj2pdA82R62is=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CE196A2AFE;
	Wed, 17 Mar 2010 17:48:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D27C9A2AF8; Wed, 17 Mar
 2010 17:48:07 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C7D7E2D4-320E-11DF-B566-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142439>

Erick Mattos <erick.mattos@gmail.com> writes:

> Sometimes it is interesting to start a new unparented branch in an
> existing repository.

You don't have to be "interesting".  It is enough to say what it does and
how it is used; leave it to readers to judge if they find it useful and
worthwhile addition.

> The new -o/--orphan is intended to solve this situation allowing the
> creation of a new branch unparented to any other.
>
> After the 'checkout -o -b' you are in an new unborn branch ready to be
> committed which will start a new history without any ancestry.
>
> By a 'git commit -a' the commit tree is going to resemble the one from
> the previous branch.  This way you begin a "mostly common paths" work
> flow.
>
> In case you are doing this orphan branch intending to start a "no common
> paths" work flow then with a 'git rm -rf .' you are ready to go.
>
> Signed-off-by: Erick Mattos <erick.mattos@gmail.com>
> ---
>
> Trying to be concise and more positive on this new option descriptions.  :-)

Here is my take on it:

    Similar to -b, --orphan creates a new branch, but it starts without
    any commit.  After running "git checkout --orphan newbranch", you are
    on a new branch "newbranch", and the first commit you create from this
    state will start a new history without any ancestry before it.

    "git checkout --orphan" keeps the index and the working tree files
    intact, in order to make it convenient for creating a new history
    whose trees either resemble, the one from the original branch.

    When creating a branch whose trees have no resemblance to the one from
    the original branch. it may be easier to start work on the new branch
    by untracking and removing all working tree files that came from the
    original branch, by running a 'git rm -rf .' immediately after running
    "checkout --orphan".

I realized that -o shouldn't be an additional option to -b, but should be
an option that is incompatible with -b (and everything that is
incompatible with -b); --orphan without -b does not make any sense, and
having to type -b when you mean to also say --orphan feels silly.

Also it is a very special purpose mode of operation that would be rarely
used in a normal workflow, so I'd rather not give it short-and-sweet -o
from the beginning.  It is not too late to consider adding a short-hand
only after people gained experience with it, and found that they were
using the option every hour.

> +'git checkout' [-q] [-f] [-m] [-b <new_branch> [-o]]
>  'git checkout' [-q] [-f] [-m] [-b <new_branch>] [<start_point>]

So I think these two lines should instead be a single:

'git checkout' [-q] [-f] [-m] [[-b|--orphan] <new_branch>] [<start_point>]

I didn't see anything wrong to start a new rootless branch starting from a
commit that is different from where you currently are (did your
implementation forbid giving an explicit <start_point>, by the way?).

        Side note:
        Quiz: What does this sequence do?
	$ git checkout --orphan new
        $ git checkout -

> @@ -26,6 +27,18 @@ use the --track or --no-track options, which will be passed to `git
>  branch`.  As a convenience, --track without `-b` implies branch
>  creation; see the description of --track below.
>  
> +When using -b, it is possible to use the option -o to set the new branch
> +as unparented thus unrelated to the previous branch.  After the command
> +you are in an new unborn branch ready to be committed which will start a
> +new history without any ancestry.
> +
> +By a 'git commit -a' the commit tree is going to resemble the one from
> +the previous branch.  This way you begin a "mostly common paths" work
> +flow.
> +In case you are doing this orphan branch intending to start a "no common
> +paths" work flow then with a 'git rm -rf .' you are ready to go.
> +

Readers won't know what you are talking about by "mostly common paths
workflow" nor "no common paths workflow".

In any case, I am suggesting to make --orphan separate and parallel to -b,
so how about removing all of the above, and instead have this:

  --orphan::
    Creates a new branch and switches to it, but unlike "-b", the new
    branch you switch to does not have any commit (yet).  The first commit
    in this state will become the root commit of the new history that is
    disconnected from all the other branches.
  +
  When you use "--orphan", the index and the working tree are kept intact;
  this allows you to start a new history that records set of paths similar
  to that of the start-point commit, which is useful when you want to
  ... [insert the "the original history cannot be shown" example here],
  for example.
  +
  If you want to start a disconnected history that records set of paths
  totally different from the original branch, you may want to first clear
  the index and the files in the working tree, by running "git rm -rf ."
  from the top-level of the working tree, before preparing your files (by
  copying from elsewhere, extracting a tarball, etc.) in the working tree.

If you cannot give a good use example in-line, you may instead only say
"see EXAMPLES section to see how this is useful" in the above, and then
give a more detailed description in the EXAMPLES section.

I already suggested a replacement above, so everything below is a bit of
moot point, but I am giving it just for a future reference.

> +-o::
> +--orphan::
> +	When creating a new branch, set it up as unparented thus
> +	unrelated to the previous branch.

One good trick I learned when writing
manual pages is that if you said "A thus B" or "A (in other words B)",
stop and read it again to see if the description makes sense with only "B"
without any frills.  It often becomes easier to understand, and if it
doesn't then it often means your rephasing with "thus" or "in other words"
weren't very helpful for readers.  E.g.

    Create a new branch that is unrelated to the previous branch.

I think "unrelated" does not convey what we want to say.  Two topic
branches that fork from the same commit may be "unrelated" in the sense
that they try to fix two independent bugs.  What we want to say is not
"related or not", but "with a separate root", or "disconnected".
