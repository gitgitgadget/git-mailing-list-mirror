From: Junio C Hamano <gitster@pobox.com>
Subject: Re: a few beginner git questions
Date: Sun, 07 Mar 2010 01:39:47 -0800
Message-ID: <7vd3zgxyfw.fsf@alter.siamese.dyndns.org>
References: <15b345f1003052242r7d812fe4q6ade253283696304@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Anderson <zelnaga@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 10:40:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoCxx-0005j3-CG
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 10:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094Ab0CGJj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 04:39:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42340 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477Ab0CGJj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 04:39:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 89DAC9FAF6;
	Sun,  7 Mar 2010 04:39:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QuD4MN/M1nbEPqoZtBjK/QXMf/w=; b=wWQ4E1
	gLGB4YkQRt4/m63R4ZY7YbQk5LwmrmJd+x8IyX0UBqmM0Kjy7ByHBJHL/4nAYcWl
	8xxC+Ui3G3HdF1nIkz2I982hlMA7+/mhEedrQrjpVzTROguwmv9J7fvVlzGUxY14
	1f9RnRb7od9tIg2mbTgIwu8DGZq3xALZLUNf0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lvjne2thyvn0RBH72VoK5pndM6NcSf+W
	9m1LVvDleks7JPrGjzcO1zqNfomqmnAc4UeHqjcBAIQ5P1PbaVS0hGuzjHYkEQ+9
	jApzOthJyR0UB57D766HGR04lJfFOlRpLPb1O6bSlG6lQKx/dJSd/qOatH5V2EOa
	kU6owNl/s0g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 568699FAF5;
	Sun,  7 Mar 2010 04:39:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8DD869FAF4; Sun,  7 Mar
 2010 04:39:49 -0500 (EST)
In-Reply-To: <15b345f1003052242r7d812fe4q6ade253283696304@mail.gmail.com>
 (Thomas Anderson's message of "Sat\, 6 Mar 2010 00\:42\:40 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6157AC0E-29CD-11DF-9ABA-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141618>

Thomas Anderson <zelnaga@gmail.com> writes:

> 1. When do you commit changes and when do you stage changes?  Or maybe
> more to the point, what's the difference between doing "stage, commit,
> stage, commit" and "stage, stage, commit"?

"git add file" is a way to let you say "I have examined the changes since
the last commit to this file, and I do not want to see them in the output
from my later invocations of 'git diff'".  The intent is to let you focus
on one detail without getting distracted by other changes.

So typically you repeat the following steps:

 - change your files in the working tree;
 - run 'git diff' to check your progress _incrementally_; and
 - run 'git add that-file' to mark that the changes so far is satisfactory.

"add then commit" would be just running the above cycle once between
commits.  "add, add then commit" would be running the cycle twice.

This doesn't help you very much when you are always making small commits.
You might never encounter a case where you need to do more than one cycle
of the above before creating a commit.  But in real-life, the extent of
changes that need to be contained in a single logically independent unit
you would want to record as a commit is sometimes large enough that it
helps to be able to work incrementally.  Also often people keep small
changes that they do not want to commit yet in their working tree (and of
course they never say "git add" on them until they are ready).  If you are
interested, you can read more on this:

  http://thread.gmane.org/gmane.comp.version-control.git/15148/focus=15476

Other times, you can always do "commit -a".

Also, all of the above doesn't really matter in projects that tolerate
incoherent and/or unfocused commits, as they do not care how well you
choose commit boundaries.
