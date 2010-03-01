From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Better cooperation between checkouts and stashing
Date: Mon, 01 Mar 2010 09:02:39 -0800 (PST)
Message-ID: <4b8bf32f.0706c00a.26cb.691d@mx.google.com>
References: <4B67227A.7030908@web.de> <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> <4B898F97.90706@web.de> <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> <4B8B9BF1.10408@web.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 01 18:02:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm917-00010Q-RF
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 18:02:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435Ab0CARCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 12:02:43 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51331 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295Ab0CARCm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 12:02:42 -0500
Received: by gyh20 with SMTP id 20so1237933gyh.19
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 09:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:cc
         :subject:in-reply-to:references;
        bh=un/eT+NGDmcv1NCFyNvtEioZA9aKx6QmcTvhHfez318=;
        b=lxcA0VPVUgPrZnqjXjXHgXpBqNqvf2FkU5ak4pFbDeJGiLij+SvoyFa616pa3mst87
         Q7z1ZL/YNuBRG966mDbKqbHl2YlqMNVT2zXqLr3YUshwwo2Jt+8ilzWfE2Uiide804q2
         NdEXliWQOn4e0NojWmCIOXgp7qpRpBPYD7j4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:cc:subject:in-reply-to:references;
        b=jQi4ZEjNwNd1+NqkWQRwCHp/Jm9fQUI1eAdKY5CngsiXFA7HXqyfo7YvrRc7NpHTJ7
         ZSkSQNKQxMMEHSwQnYGA/902yKIhvV3oVpP9uZ9w5rifN6v8lE07aYVtnBfEglsoG4Ec
         N661cUWRL2fmnb0TuZY+wIGB3kDG36vOaVuiM=
Received: by 10.101.130.35 with SMTP id h35mr5264658ann.109.1267462961111;
        Mon, 01 Mar 2010 09:02:41 -0800 (PST)
Received: from gmail.com (tor-proxy.fejk.se [66.90.75.206])
        by mx.google.com with ESMTPS id 7sm1250566ywf.40.2010.03.01.09.02.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 09:02:39 -0800 (PST)
In-Reply-To: <4B8B9BF1.10408@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141331>


To Junio in particular: See the very bottom of this email.


On Mon, Mar 1, 2010 at 04:50, Markus Elfring <Markus.Elfring@web.de> wrote:
>>  - The branch you happen to have checked out was 'next', but the solution
>>    is a bugfix, and should go to 'maint'.
>>
>> Now, at this point, you want to checkout 'maint' without losing your local
>> change.  The paths you touched with your quick fix are often not different
>> between the two branches, and "checkout maint" will checkout the branch
>> while keeping your local changes intact.
>
> Does the wording in the manual fit to the mentioned software development practice?
>
> "When <paths> are not given, this command switches branches by updating the
> index, working tree, and HEAD to reflect the specified branch."
>
> I see a need for further clarifications of the involved details.

Junio pointed out that the documentation is currently lacking:

  [Unfortunately,] I don't see anything that states
  clearly that "checkout" is designed to carry your
  local changes across in any documentation (I gave
  a cursory look to the user manual, tutorial and
  checkout manual page). Probably "git checkout --help"
  needs a "Switching branches" section, just like the
  planned enhancement for "Detached HEAD" section.

In other words, the documentation NEEDS to be updated to include
the explanation and rationale that Junio also supplied:

  Checking out another branch (branch switching) is
  designed to carry your local modification across
  with you. This is to allow you to start working on
  something, realize that your changes are better suited
  for another branch, and at that point after the fact
  "git checkout" that other branch, while keeping what
  you have done so far.

  If the original branch you started your work from and
  the branch you are checking out have different contents
  in files you have changed (aka "your changes conflict
  at the paths level"), without -m option, "git checkout"
  refuses to check out the other branch, because it will
  need a three-way merge to carry your changes forward,
  and you might not be prepared to resolve conflicts
  resulting from such a merge.

  In practice, however, your changes often don't conflict
  with the changes between the branches at the paths
  level, and "git checkout" lets you carry your local
  changes across just fine. I'd say this is the majority
  of the case especially for experienced git users, as
  they tend to commit in smaller and more logical units
  than those from other SCM background.

and Junio expanded on this later:

  It is important to understand that a local change does
  not belong to your current branch (it does not belong to
  _any_ branch). It belongs to you, and you can take it
  around while switching between branches. And that is a
  big time-saving feature.
  
  This lets you work like this:
  
   - You are reading a mailing list message that
   asks for help, and you know the solution---you
   can give the help real quick.
  
   - You hack in whatever branch that happen to be
   checked out. The change is perfect, it works.
  
   - The branch you happen to have checked out
   was 'next', but the solution is a bugfix, and
   should go to 'maint'.
  
  Now, at this point, you want to checkout 'maint' without
  losing your local change. The paths you touched with
  your quick fix are often not different between the two
  branches, and "checkout maint" will checkout the branch
  while keeping your local changes intact. All that is
  left for you to do is to run another round of test to
  make sure that your fix didn't depend on anything not
  in 'maint' and commit the change with appropriate log
  message, and then you can go back to whatever you were
  doing with "checkout next".
  
  When the change involves paths that were touched
  between 'maint' and 'next', of course you won't be
  able to switch without merging the local change to the
  difference between 'next' and 'maint'. There are a few
  workflows to deal with such a case, and the easiest is
  "checkout -m", if you are confident that you can resolve
  it.

  In a case where "checkout -m" would result in a conflict
  too big to resolve, the original fix you made would not
  be applicable to 'maint' (iow, you should have solved it
  differently starting from 'maint'), and you may end up
  doing "reset --hard" and start from scratch, but that is
  a rare worst case.

  I said it is rare, because you would notice, while doing
  the "quick fix" based on 'next' codebase, that the code
  you are touching have changed since 'maint' and won't be
  applicable to its final destination (by that time you
  know you are "fixing"), and you won't waste too much
  time continuing to work in a checkout of 'next'.

I think it would be a great contribution if you could clean up
Junio's explanation and submit a patch that includes it in the
documentation for "git checkout".

> - Would it be useful if it will become configurable if the corresponding
> contents will also be automatically restored by a checkout?

>From what you've said, I think you essentially want to implement
"git checkout" with something like the following (this hack is **not**
meant as a solution; it is only meant to illustrate what I think is
Markus Elfring's desire):

  # Utility:

    get_stash_id()
    {
      local branch=$(git rev-parse --symbolic-full-name HEAD)
      [ $branch = HEAD ] && return 1 # don't stash for detached HEAD
      echo -n "$branch" | md5sum | awk -F" " '{print $1}'
    }

  # New implementation:

    checkout()
    {
      # Stash local modifications (including index modifications) if
      # necessary, using an easily identifiable message known as the
      # 'stash id':

	local stash_id
        stash_id=$(get_stash_id) &&
          git stash save -q "$stash_id" ||    # Save local modifications
            git reset --hard HEAD             # Throw away changes on detached HEAD

      # Do the checkout that was requested:

        git checkout "$@"

      # Unstash previously stashed local modifications (including
      # index modifications) if they were automatically stashed
      # before (the lookup is done with the relevant 'stash id'):

        stash_id=$(get_stash_id)                                            &&
          stash_id=$(git stash list | awk -F': ' "/$stash_id/ {print \$1}") &&
            [ -n "$stash_id" ]                                              &&
              git stash pop --index "$stash_id"
    }

Sincerely,
Michael Witten
