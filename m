From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cherry-pick applies some other changes than the specified one?
Date: Mon, 21 Mar 2011 09:09:03 -0700
Message-ID: <7vwrjssbfk.fsf@alter.siamese.dyndns.org>
References: <AANLkTikE5AqJyShN+GfFYe0kBS=ShGnKQcnwbarNZrjm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 17:09:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1hfS-0005xg-2V
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 17:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497Ab1CUQJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 12:09:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62485 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173Ab1CUQJM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 12:09:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 329674402;
	Mon, 21 Mar 2011 12:10:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=umfMOL6wohz2SGiYdw/ZwO/B+9M=; b=HXp2J7
	AsfZURb9DlRz0YpYI/nfchCG8G8B7Caaoebokykxgmi8q2x2PGjiszmd78p0+sTl
	A9oP3Tl3fbEvWyNeUnEGnkV+wVDaNDRCyKt5q6bbzNkqPn3uPQG23kTtUBKmGff/
	CO8OnGcCTxfJO06FCV856C4ZfV1CjU9+fVfLg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wf2ANoYzQVDXGW9AMKXGWdZnklKR/V0H
	DyiVWNAxk22ZcjYng2jEEEoYlst6SNGHCaY2vM7xfuzlW8UZXWI9q4FceDtofxxg
	nlHphXJvQ4pg3BP0vD0stWlCQISx+D0uWnY60ma1AfFqpkPhfngSR6CTdn68t+H0
	rl0cNLko3F8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F1F44401;
	Mon, 21 Mar 2011 12:10:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E347243FF; Mon, 21 Mar 2011
 12:10:42 -0400 (EDT)
In-Reply-To: <AANLkTikE5AqJyShN+GfFYe0kBS=ShGnKQcnwbarNZrjm@mail.gmail.com>
 (Piotr Krukowiecki's message of "Mon, 21 Mar 2011 10:27:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7690212-53D5-11E0-8844-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169606>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> There's a conflict during the cherry-pick. git status shows:
>
> $ git status
> # On branch 9_0
> # Unmerged paths:
> #   (use "git add/rm <file>..." as appropriate to mark resolution)
> #
> #	both modified:      etc/file
> #
> no changes added to commit (use "git add" and/or "git commit -a")

Correct.  The commit you are applying the change with cherry-pick has
etc/file different from the parent of the commit being cherry-picked, and
the commit being cherry-picked also has it different, hence "both
modified".

> git diff shows a lot of changes:
> ...

Again correct; it is showing the mechanical (half)merge result so that you
know where you had overlapping changes.  The comparison between an
unmerged index and the working tree shows the changes in the file in the
working tree with respect to both versions (the one in the commit you are
on, and the other one in the commit you are cherry-picking), omitting
parts that the file in the working tree match one of the versions.  This
is how you don't have to see any part of the file that was trivially
merged in the output.

> If I edit the file and remove the "<<<< HEAD" marked and code
> between "===" and ">>>"  then
>
> 1. git status shows there are unmerged files:
>
> $ git status
> # On branch 9_0
> # Unmerged paths:
> #   (use "git add/rm <file>..." as appropriate to mark resolution)
> #
> #	both modified:      etc/file
> #
> no changes added to commit (use "git add" and/or "git commit -a")

Correct; until you "git add" to mark the conflict resolved, the path is
unmerged (do not ignore instructions in parentheses).

> 2. git diff shows nothing:
>
> $ git diff
> diff --cc etc/file
> index 815c28f,b8a48da..0000000
> --- a/etc/file
> +++ b/etc/file

Again, correct.  Read the description above on the "git diff" output.  At
this point, you removed the parts that came from one side (cherry-picked
side) by removing the lines between "===" and ">>>", so the lines in the
file in the working tree around that place match the other side (the one
in the commit you are on).  There is no block of lines that do not match
one of the sides, so there is no combined diff to show.

> 3. git diff --cached shows error? warning? info?
>
> $ git diff --cached
> * Unmerged path etc/file

Correct.  It is showing that you haven't run "git add" to resolve the
path, so it still is unmerged.

> 4. When I git add the file then git status, git diff, git diff
> --cached shows nothing:

Correct.  "git diff" is about comparing between the version in the index
you recorded with "git add" and the file in the working tree, so there is
nothing to show.  "git diff --cached [HEAD]" compares the index and the
HEAD, and it is understandable the result in the index matches HEAD if you
discarded what came from the cherry-pick before step 1.

> But when I take a different approach, and in addition to this:
>
>> If I edit the file and remove the "<<<< HEAD" marked and code
>> between "===" and ">>>"  then
>
> I also manually add the "+line" which is the change done in the cherry-picked
> commit, git diff shows a lot of other changes in unrelated lines
> (which lie close
> but still were not modified by the patch, nor were shown previously by
> git diff).
>
> This is very weird.

Sorry, I have no idea what you are talking about.
