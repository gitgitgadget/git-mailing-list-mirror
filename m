From: Junio C Hamano <gitster@pobox.com>
Subject: Re: You have local changes; cannot switch branches error question
Date: Thu, 24 Dec 2009 15:32:24 -0800
Message-ID: <7vhbrghrsn.fsf@alter.siamese.dyndns.org>
References: <76c5b8580912241425k741b24e9ie8ed92ca7cb8a659@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 25 00:34:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNxCh-0000iT-Nk
	for gcvg-git-2@lo.gmane.org; Fri, 25 Dec 2009 00:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893AbZLXXce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2009 18:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753669AbZLXXce
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Dec 2009 18:32:34 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47833 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544AbZLXXcd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2009 18:32:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AB508A876;
	Thu, 24 Dec 2009 18:32:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TfaJ9pNItOAyN11iek9Ql6rCAfg=; b=P4PHn+
	gOi0ztDjA+TGbkwiYilwmhjLrZw+kDuekO2ENfk7M5KdsYOn/BVJZaXMS8wPs/uZ
	RXja+gjXrQbB42iaXPtv+ZQRwzjkBJJ07EFu/ELO3LyGLdwa6xOA4f9Xrc673AU0
	ShC7zOhBfmhCQqPGc/csjL5L99tT7uF8S9L1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VhAG/FMCHVBd/RC76wRBigH3kz433f5w
	6Dw+0JjgLUf1xKoeNEd5GmzjGx0PAnj3JUfmwGohBPAmnK5lNZo5CtaL4M5w50Dx
	7rsEdIVDD6G3xsDvs4wly5lghRqRb+uGJXwlZTNDx4AjesSMtUHQt2flBqokBt/A
	+49U1vgf0oY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 28D2D8A874;
	Thu, 24 Dec 2009 18:32:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C8D78A873; Thu, 24 Dec
 2009 18:32:26 -0500 (EST)
In-Reply-To: <76c5b8580912241425k741b24e9ie8ed92ca7cb8a659@mail.gmail.com>
 (Eugene Sajine's message of "Thu\, 24 Dec 2009 17\:25\:37 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 99CEF6A4-F0E4-11DE-BDD9-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135663>

Eugene Sajine <euguess@gmail.com> writes:

> For example in one of my repos I somehow got to a state when I have
> three files modified, and when I'm trying to switch branches it
> complains about one of them being changed locally, so it refuses to
> switch branch

Suppose you have a history like this:

         o---B side
        /
    ---o----o----A master

and both branches 'master' and 'side' have file, F and G.  G is different
between commits A and B while F is the same between these two commits.

You have 'master' checked out, and modified both F and G.  This table
shows the contents you have in each path:

    path    master      work tree    side
    -----------------------------------------
       F    F1          F2           F1
       G    G1          G2           G3

In git, your local modification does _not_ belong to any branch.  You need
to commit them if you want to make them part of the history of your
current branch.  Checking out a different branch means you switch to the
branch and carry these changes along with you.  But it is not necessarily
be possible to do so without modifying what is in your work tree.

For path F, your local change is (F2-F1), and switching to branch 'side'
means you would transplant that change on top of what that branch has,
which happens to be F1.  That means the result is F2 (= F1 + (F2-F1)).
IOW, because F is identical between master and side, the file in your work
tree can stay the same.

Now, think what should happen to path G.  The local change is (G2-G1), and
you need to transplant that change on top of G3, that is different from
G1.  This computation will involve a merge, which you may or may not be
prepared to resolve.

If you are used to CVS/SVN workflow where you "update" to merge other's
changes to your work tree with your own local changes, you will know that
with such a merge, depending on the amount of change between G1 and G3,
you may end up losing quite a lot of work of your own (G2-G1), when the
merge is too complicated for you to handle.  The message you saw is a
safety valve to prevent you from trashing your work that way.

There are two ways to deal with this situation, one safely, and another
quickly.

 - You can "stash save" to first save the changes in your work tree,
   "checkout" to switch to branch 'side', and then "stash pop" to attempt
   the merge.

   The last step of unstashing on the new branch _will_ give you the same
   kind of conflict while computing G3 + (G2 - G1) to update file G, but
   the approach has one huge advantage compared to CVS/SVN's "update", in
   that you can "reset --hard" and "stash pop" to reset to a clean state
   and attempt resolution if you failed resolve conflicts and end up
   making a mess in your first try.

 - If you _know_ that the changes between G1 and G3 do not conflict with
   what you did between G1 and G2, you can "checkout -m" to instruct it to
   act as if it were CVS/SVN's "update" command.

   This can potentially make an unresolvable mess in your work tree, and
   you can end up losing your changes G2-G1, but it is quicker than "stash
   save"/"stash pop" pair.
