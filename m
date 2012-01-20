From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-add: allow --ignore-missing always, not just in dry
 run
Date: Fri, 20 Jan 2012 10:03:05 -0800
Message-ID: <7vobtyfe06.fsf@alter.siamese.dyndns.org>
References: <1326923544-8287-1-git-send-email-dieter@plaetinck.be>
 <7vobu0liwj.fsf@alter.siamese.dyndns.org> <8762g87y4q.fsf@thomas.inf.ethz.ch>
 <7v8vl3jzst.fsf@alter.siamese.dyndns.org> <87mx9icz28.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jan 20 19:03:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoIo0-0005nn-8R
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 19:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471Ab2ATSDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 13:03:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44098 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754861Ab2ATSDI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 13:03:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F8DA6928;
	Fri, 20 Jan 2012 13:03:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bsPmVxYntrhQY2cdRRlI8/qFFJM=; b=tzD2+R
	DuYsrUuMaiwUla4VdT/hjqiBk0eW9wwHFw/iMbyXlaDPETk5kyIxinhqtbZqQsmP
	g0H8XE+kUKP1Kj5Nz2JKWHL6ofI8FzMbV81g85S4dEHSXqfwK+YlStlY+le2YE9A
	4JKK+YiY4XOVoFhItn1NEHjP/S6z7+QcMT49s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K0Jt3CflobYaUIp1LgjoNFEYpq9kFHpY
	GrrdYLnmNzJEgGUK9+FquAc98tDWVfkRX1aJR2iJh+vtkQhKTo6n5coBNwb4ue2s
	Ouzed4WA9WHbbB/UdA+fcZn2moHjPstACMx3jnpJvYpKaEoUcWT23lKYJEW0YLh2
	hOIdDHqn4fQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 671EB6927;
	Fri, 20 Jan 2012 13:03:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9FA06924; Fri, 20 Jan 2012
 13:03:06 -0500 (EST)
In-Reply-To: <87mx9icz28.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Fri, 20 Jan 2012 13:56:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 014DF57C-4391-11E1-8E48-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188887>

Thomas Rast <trast@student.ethz.ch> writes:

>> More generally, scripts in t/ directories are "scripts", but it is totally
>> different from the kind of "user facing script that behaves as if it is a
>> complete command, taking its own command line arguments, passing them
>> through to the underlying plumbing commands".
>
> I don't understand what distinction you are trying to make here.  Maybe
> my mental model of the plumbing/porcelain separation (which is mostly
> about interface stability) is wrong?

What's so hard to understand that these tests are very different from
end-user scripts?

We could have shipped you a written instruction to type these commands
from your shell and made you responsible for running them every time we
release a new version. That would have been more true to the intent of
these test scripts. The test being implemented as scripts is merely a
substitute for hiring one Thomas Rast as a test engineer to type them from
the terminal ;-).

User-facing scripts (Porcelain enhancements) people write are in a totally
different boat. They take input and have code to make their own decision
what kind of arguments and inputs to feed to their underlying building
blocks. They may even parse output from the commands they invoke to base
their decision that affects what happens next. Our tests start from a
known state (i.e. empty trash directory), take input from neither command
line, human interaction nor the filesystem content of the day, that affect
the input to the commands they drive.

To put it another way, if you have a cron job that does

    cd $HOME/diary && git add MyDiary.txt

that is perfectly fine. You are letting the machine do the typing for you
every hour, instead of having you type these yourself. It is even OK if
the filename was derived from `date` or something, i.e.

    N=$(date +'%Y-%m-%d').txt &&
    if test -f "$N"
    then
	git add "$N"
    fi

What is not OK is to attempt parsing from Porcelain output to decide what
to do next. "git branch | sed -ne 's/^\* //p'" is a typical example.

Our tests are different for another important reason you seem to be
missing. The tests we ship are tied very closely with the version of Git
they are testing. Even parsing the command output is acceptable for our
tests for this reason (obviously that is the only way to make sure that we
are issuing an appropriate error, warning, or advice message to the end
user). End-user scripts do not have that property.

And the biggest thing you should consider is that 99% of users are too
busy to bother thinking for themselves and instead prefer to be handed
down a concise recipe to follow blindly. You could include "in this, that,
and that other situation, it is OK to use Porcelain command" to the
recipe, but doing so defeats the whole purpose of having a recipe to begin
with, by making the readers responsible for thinking for themselves again.
That is why we just give a concise "Do not use Porcelain commands in your
scripts as their behaviour is subject to change."
