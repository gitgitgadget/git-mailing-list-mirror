From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: no-op "rebase -i" failures (easily reproduceable)
Date: Thu, 01 Mar 2012 12:18:28 -0800
Message-ID: <7v399sm5wr.fsf@alter.siamese.dyndns.org>
References: <CAFjr8EukvC6zsa2vzUWL+YDNLMUh5apmwGQZ1s5WkHg-bC17Kw@mail.gmail.com>
 <7vboogm7g3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luiz-Otavio Zorzella <zorzella@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 21:18:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3CST-0003ki-5n
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 21:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841Ab2CAUSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 15:18:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53542 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752573Ab2CAUSb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 15:18:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94C696D8E;
	Thu,  1 Mar 2012 15:18:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3z/bdv+a760XdkucTnUDX+jEcrg=; b=qRQFJ4
	neeagdLTlM87LNd3vAR+Gb73kpD+2IJOtRHN8ATtaRwq9pD8NPyIviQoA7jGKARk
	JUZwvkf+im5sPDsML0TRT12mBErJ3V95giD2YZ0jJsEi6nsjBRu0gAZvXHbAY6dq
	hQu0RpOsJw/KtKYLvqq3CbhCaErlxrjbwoid4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=guwsEV5D5MGe1+ETzAv0aPBlenR8AsrI
	V4W94buwoj5RviFK70g+h1n/ugyfcU7JIfao2fKMq19MpthUOHbNCwPvPrAYr17v
	XzSETwe6zdpXQ3k81jKWpFDxg2W6Kz9uHq6TnIE8n9HXXHCgImMFYdQTsy17MeFA
	EIeLYMLmjSw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C6BA6D8D;
	Thu,  1 Mar 2012 15:18:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E645C6D89; Thu,  1 Mar 2012
 15:18:29 -0500 (EST)
In-Reply-To: <7vboogm7g3.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 01 Mar 2012 11:45:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5F53E08-63DB-11E1-A142-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191967>

Junio C Hamano <gitster@pobox.com> writes:

> Luiz-Otavio Zorzella <zorzella@gmail.com> writes:
>
>> $ EDITOR=echo git rebase -i HEAD~40
>> /usr/local/google/z/gitblow/git/.git/rebase-merge/git-rebase-todo
>> error: could not apply ec7ff5b... make lineno_width() from blame
>> reusable for others
>>
>> When you have resolved this problem run "git rebase --continue".
>> If you would prefer to skip this patch, instead run "git rebase --skip".
>> To check out the original branch and stop rebasing run "git rebase --abort".
>> Could not apply ec7ff5b... make lineno_width() from blame reusable for others
>
> That is hardly surprising, given that you asked to flatten the history
> since the 40 commits before the tip of your history, and it is done out of
> a history that is full of merges from side branches.
>
> And it is not even an error, let alone a bug.  The command is asking you
> to resolve conflict it cannot resolve mechanically.  If you do as you are
> asked, you will do just fine.
>
> It is expected that you will see conflicts in such a rebase, because by
> attempting to flatten the history you are telling Git to replay a commit
> to a context that is different from its original context.

Just for fun, I tried this experiment to completion, starting at f051ad6
(Update draft release notes to 1.7.10, 2012-02-28)

    $ git checkout f051ad6
    $ git rebase -i HEAD~40

which pulls in 89 commits to be rebased (that is the number of commits not
in HEAD~40 and in HEAD).  After resolving and issuing "rebase --continue"
several times [*1*], the resulting tree mostly matched the tree I started
from.

An interesting thing to notice is that I just said "mostly".  It misses
the change made with an evil merge at 8080906 (Merge branch 'maint',
2012-02-26) that removes a couple of items out of the "fixed bugs" section
in the 1.7.10 draft release notes, as they already appear in the 1.7.9.x
release notes.  Perhaps I should try to refrain from making these "Sync
with maint, its release notes have "fixed" items that we have in 1.7.10
release notes so remove them from the latter" evil merges.


[Footnote]

*1* This is fairly easy for me to do, as my rerere database already knows
most of the conflicts this rebase would see---they are the ones I resolved
manually when the topics first hit 'next' or even 'pu'.
