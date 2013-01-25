From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge error question: The following untracked working tree
 files would be overwritten by merge
Date: Fri, 25 Jan 2013 10:07:01 -0800
Message-ID: <7vehh95e7u.fsf@alter.siamese.dyndns.org>
References: <5102607E.2070106@cafu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Carsten Fuchs <carsten.fuchs@cafu.de>
X-From: git-owner@vger.kernel.org Fri Jan 25 19:07:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyngW-0003Vl-6w
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 19:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472Ab3AYSHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 13:07:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50791 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932373Ab3AYSHF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 13:07:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0796B83D;
	Fri, 25 Jan 2013 13:07:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cy2P5YxRQwM4zJeueik6x+stpEk=; b=QU6TnR
	TZLp6JklCiJ0nUdGG50IGGIH14wcm5PHRPpxW3ISJ4WBD0f1e9WuX/Xy38goYVH7
	m1hqzYHp4m8+gpCGWodY6uWM46xPuL+FXPKDw2lYGVJCqee2WHm7VL5zL+7/ujAY
	sKJQvuurPBFnoUJr+Pv7qXwpbWZZjqaZ3p4n4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nht4I1TXW6wfnYQFJDYHRH7XVG/yfndu
	lWFoueQBayI4L5DYk/vYJ7GzynlJjqhRLPLfdBraOY9PQzXgp8QEhF7aJeHlluEj
	cI9fmCDvst6UR0PoOkP3fT1zMAPJp08wyR0szl0Nb1qUMXus11nN+2gLleMjNP20
	9IQ3T+U5654=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5466B83C;
	Fri, 25 Jan 2013 13:07:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A263B83B; Fri, 25 Jan 2013
 13:07:03 -0500 (EST)
In-Reply-To: <5102607E.2070106@cafu.de> (Carsten Fuchs's message of "Fri, 25
 Jan 2013 11:37:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 057835EC-671A-11E2-8936-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214563>

Carsten Fuchs <carsten.fuchs@cafu.de> writes:

> Hi all,
>
> in my repo, I'm doing this:
>
>> $ git status
>> # On branch master
>> # Your branch is behind 'origin/master' by 2 commits, and can be fast-forwarded.
>> #
>> # Untracked files:
>> #   (use "git add <file>..." to include in what will be committed)
>> #
>> #       obsolete/
>> nothing added to commit but untracked files present (use "git add" to track)
>>
>> $ git merge origin/master --ff-only
>> Updating f419d57..2da6052
>> error: The following untracked working tree files would be overwritten by merge:
>>         obsolete/e107/Readme.txt
>>         obsolete/e107/article.php
>>         obsolete/e107/backend.php
>>         [...]
> ...
> Compare with what Subversion did in an analogous case: When I ran "svn
> update" and the update brought new files for which there already was
> an untracked copy in the working directory, Subversion:
>     - started to consider the file as tracked,
>     - but left the file in the working-copy alone.
>
> As a result, a subsequent "svn status" might
>     a) no longer show the file at all, if the foreign copy in the
> working directory happened to be the same as the one brought by the
> "svn update", or
>     b) flag the file as modified, if different from the one that "svn
> update" would have created in its place.

Interesting.  So before running "status", the merge is recorded (in this
particular case you are doing ff-only so there is nothing new to
record, but if the rest of the tree merges cleanly, the new tree
that contains "obsolete" from the other branch you just merged will
be the contents you record in the merge commit), and working tree is
immediately dirty?  It makes sense, even though I haven't tried to
think things through to see if there are tricky corner cases.

> So my real question is, why does Git not do something analogous?

The answer to that question is "because nobody thought that doing so
would help users very much and bothered to implement it"; it is not
"people thought about doing so and found reasons why that would not
help users".
