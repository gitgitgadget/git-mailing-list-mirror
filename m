From: Junio C Hamano <gitster@pobox.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Tue, 02 Oct 2012 12:56:13 -0700
Message-ID: <7vhaqc7in6.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
 <506AA51E.9010209@viscovery.net> <7vzk449449.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 21:56:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ8Zv-00069p-80
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 21:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896Ab2JBT4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 15:56:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51027 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751766Ab2JBT4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 15:56:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB9D49084;
	Tue,  2 Oct 2012 15:56:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+I/2lWQQEBuGoF4qhiHBB3mS7Ug=; b=u23zfZ
	j5K/r2r1a5rPBbOCSVE5pnmOn0vAAuke6QMZaaT8EpsExNCIZpVrDxt4ArnV0thF
	bqW27fIkpTijql0zaYNSebNdy7tcw8XdhyisJ7ZO5CXf+wNyYlz75K197Vs487AI
	wrOj8Xhhpu8AT5bwfjKMKT1zFdASyiO6/wyYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZSdtgz1lgK+dq3yqtZybOENVwL9BnZfD
	IzmEciKLeRkvz6ff0oYr7jeam68p2v9ctnpowqDwUb9SV7EFrq213HY2i0siFYBf
	eYWfjvWgfWH9/Fb+btPpM/+pKea4QFsmzy9gJudHXd67P5mcsoE6LLVDg9t/3UYP
	3z46xhpSEvg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C72A49082;
	Tue,  2 Oct 2012 15:56:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E539907D; Tue,  2 Oct 2012
 15:56:15 -0400 (EDT)
In-Reply-To: <CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com> (Angelo
 Borsotti's message of "Tue, 2 Oct 2012 21:34:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3931724E-0CCB-11E2-B962-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206843>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> "Usually recording a commit that has the exact same tree as its sole
> parent commit is a mistake, and the command prevents you from making
> such a commit. This option bypasses the safety, and is primarily for
> use by foreign SCM interface scripts."
>
> I cannot find any clue in it that lets me know that is does not
> create a commit if the time is within the same second as the other
> commit.

It does create one; it just is the same one you already happen to have,
when you record the same state on top of the same history as the
same person at the same time.

> My suggestion is either to include a sleep in the command so as to
> guarantee that a commit is created, or to remove the option.

And how would it help what to insert a sleep for 1 second (or 1 year
for that matter)?  As you said, it reads from the system clock, and
there are millions of systems in the world that have Git installed.
You may record the same state on top of the same history as the same
person on two different machines 5 minutes in wallclock time in
between doing so.  These two machines may end up creating the same
commit because one of them had a clock skewed by 5 minutes.

What problem are you really trying to solve?  You mentioned
importing from the foreign SCM, but in that case, you would be
building commits on top of other commits, and some commits may
not have any change recorded in them, i.e. you could validly
have (as always, time flows from left to right)

	---o---o---o---o---A---B---C

where differences between A and B is nothing, and differences
between B and C is nothing.  You may be a script that records these
commits in rapid succession.

When you create B and C, you may be recording the same state as the
same person with the same timestamp. *BUT* you are not recording
these two commits on top of the same history.  B is done on top of
the history leading to A, but C is done on top of the history
leading to B.  They will get different commit object name.

So what problem are you trying to solve?

You also did not seem to have read what I wrote, or deliberately
ignored it (in which case I am wasting even more time writing this,
so I'll stop).

This does not have anything to do with "--allow-empty"; removing
"the option" would not help anything, either.  Run the following on
a fast-enough machine.

    git init
    >file
    git add file
    git commit -m initial
    echo foo >file
    git add file
    git commit -a -m second
    H1=$(git rev-parse HEAD)
    git reset --soft HEAD^
    git commit -a -m second
    H2=$(git rev-parse HEAD)
    if test "$H1" = "$H2"
    then
	echo I was quick enough
    else
	echo I was not quick enough
    fi
