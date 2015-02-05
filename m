From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Advice on edits to git-rebase man page
Date: Thu, 05 Feb 2015 10:58:21 -0800
Message-ID: <xmqqa90smbhu.fsf@gitster.dls.corp.google.com>
References: <CAH6Pt5pN8nrZzW+JntU5AWS1P4vu_JmdQBM_oR4Rfnh937wFPQ@mail.gmail.com>
	<vpqa90s4oz2.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthew Brett <matthew.brett@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Reuben Thomas <rrt@sc3d.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Feb 05 19:58:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJRdF-0000y6-V1
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 19:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbbBES6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 13:58:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751031AbbBES6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 13:58:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D908735F81;
	Thu,  5 Feb 2015 13:58:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nrg/X1OTuR635YP2UQis/NHO0h8=; b=exQ8pG
	YpZuYHEKX59W4oeQ2O1JIBvY9Mz5VIXCVQLvbjquOvcYsLwngEHpUfoHg2z89RrL
	zFhNUJzOMFzWVUsgegbnkAn6HFIml6AnbralJfLjsoGkS8lDLt+2l1/6qrcqQBix
	iB497HZdh4Jo9FbPx8umnC9sjA3BYz+Mj2zWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qv5iZ9Gb/4gXRircVbHLIdHpd7C4ggWS
	mDmFJKUptU6BJpkv5UjAjcQaGGgx/L+7/wEXibCi6SPyTdYpvP5WUjVHOprvc+3/
	pNy6RcQK3L8TUpanAhvYdsw999D5MF9ckm3v8P4SioqJh+EPHeICA/RzCS9I2Q57
	d57qbC4OuTg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CF11235F80;
	Thu,  5 Feb 2015 13:58:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 554AB35F7F;
	Thu,  5 Feb 2015 13:58:23 -0500 (EST)
In-Reply-To: <vpqa90s4oz2.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	05 Feb 2015 11:44:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F56B4756-AD68-11E4-9A5A-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263382>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>   NAME
>        git-rebase - Forward-port local commits to the updated upstream head
>
> => Quite technical already.

Very much true, and I would say the description is "technically
correct" in the sense that "it is not wrong per-se".  There are a
few points that this fails to state and some that this overspecifies.

 - Rebase is about changing the base of an existing branch, but the
   description does not even mention the word "branch" [*1*].

 - There is nothing "forward" about it.  I often see myself applying
   (tentatively) incoming patches on top of whatever commit I happen
   to have checked out, review it and then rebasing it to apply to
   older maintenance track if the topic is about fixing an old bug.

 - There is no point stressing "local" commits; all the operations
   you do to munge commits are local.

Perhaps something like this instead?

    git-rebase - Rebuild a branch on top of a different commit


>   DESCRIPTION
>        If <branch> is specified, git rebase will perform an automatic
>        git checkout <branch> before doing anything else. Otherwise it
>        remains on the current branch.
>
> => Ouch, do we really want to start a documentation like this?

No.  We should say what the command does and what the command is for
in more general terms first and then describe how arguments can be
used to affect it.

> So, the DESCRIPTION part can definitely be improved IMHO. Your notation
> <graft-point>, <exclude-from> and <include-from> may be an improvement
> already.

<graft-point>, <exclude-from> and <include-from> aren't technically
wrong per-se, but I do not think bulk-replacing the words currently
used in the manual page with these is an improvement at all, unless
the mental picture the explanation draws is also updated to match
these new words.

reBASE is about changing the base of the affected branch, and the
mental picture the current documentation draws is "there is a plant,
from which you cut a branch, scion. Then you graft the scion onto
understock".  It calls the original tree (that the branch being
transplanted is part of) the "old-base", and the understock (that
the scion is going to be grafted onto) the "new-base".  The word
"graft" in "graft point" may better convey that we are doing a
transplanting than the current wording, but the word "point" makes
it unclear to the readers if it refers to the "point" where the
scion was cut from or where it is going to transplanted to, I am
afraid.

Also <exclude-from> and <include-from> is probably too operational,
and describing the command with only these two words would miss the
point that the command is about transplanting a branch.  It is true
that in order to transplant a branch, you first need to figure out
the set of commits whose effects are to be replayed, you would need
<exclude-from>..<include-from> range computation, but it is an
lower-level implemention detail.

> Some concrete examples may help too, like "I started developing against
> origin/foo, on local branch bar, and now want to rebase my work on top
> of origin/boz".

Very much so, but I wonder if it would be better to just refer to
examples in the tutorial (and if we do not have good examples there,
we should add some).

[Footnote]

 *1* Yes, "git rebase $newbase $commit^0" form can be used to
     transplant a part of history leading to the $commit that does
     not sit at the tip of a branch (nor repoint a branch to point
     at the result at the end) as if $commit^0 were at the tip of
     some branch, but the key word here is "as if".  The user is
     allowed to use the command pretending something that is not a
     branch is a branch, but what it tells us is that the command
     *is* about a branch.
