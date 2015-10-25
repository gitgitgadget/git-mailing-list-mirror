From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: only show "Fetching remote" when verbose mode is enabled
Date: Sun, 25 Oct 2015 11:34:49 -0700
Message-ID: <xmqqwpuakd9y.fsf@gitster.mtv.corp.google.com>
References: <1445741384-30828-1-git-send-email-pabs3@bonedaddy.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Paul Wise <pabs3@bonedaddy.net>
X-From: git-owner@vger.kernel.org Sun Oct 25 19:35:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqQ8F-0008Km-5U
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 19:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbbJYSex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 14:34:53 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55885 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751776AbbJYSew (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 14:34:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 03621245A4;
	Sun, 25 Oct 2015 14:34:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=42ne5HYySZgbw3rm4pwnFV1jSBw=; b=q5AiVODpPuCXeHtt14AY
	xy4TCp6Fo73cvn7XrXKc8USq4j7Z5rL9erJ8qDGQP2slRB4r6ALC2EXcyzEDC0Au
	u2ivRzFQZLzfCzRTw5S5WNA3wVs0r5lTmv1sqsleod0R3uv7GwP3pNIFbE7Mn/A3
	lEn7AGlp+CDW0yTUZ/34XHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=wLptJDtG7CcogcdMFE9ha/Y3tEtya6XeH5xV7pW9ZFduUc
	zKMK6cq6o6/v70HxirD3pio2UNjT9ZMc9kCVYgKHa/61maXGHaTizkraIW33saTc
	YR9tLnlPH4Cf6VyFjdQV9g44E+O8uJmBz6T5ETYQ/fmYXANXxefxGlHbCs4tY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F04A9245A3;
	Sun, 25 Oct 2015 14:34:50 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 79DAF245A2;
	Sun, 25 Oct 2015 14:34:50 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 13865896-7B47-11E5-A9F2-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280162>

Paul Wise <pabs3@bonedaddy.net> writes:

I ignored your patch when you sent it the first time the last week,
due to the same issues I had with this round (see below) and forgot
about it.

> By default when fetching one remote nothing is printed unless there
> are changes that need fetching. This makes fetching multiple remotes
> be just as verbose as fetching a single remote.

I read this several times over a few days and I still cannot tell
what you are trying to say.  Let me disect.

> By default when fetching one remote nothing is printed unless there
> are changes that need fetching.

This is the description of the current behaviour, and a correct one
at that.  We are silent when nothing needs to be done here.

I cannot tell if you are trying to say if that is problematic, or if
you are trying to say if it is a good thing.

> This makes fetching multiple remotes
> be just as verbose as fetching a single remote.

I cannot tell what "This" refers to.

Your earlier sentence was about the behaviour of fetching from one
remote, e.g. "git fetch this".  And this second sentence makes it
sound as if that behaviour has some influence on how verbosely "git
fetch group" (where 'this' and 'that' are members of 'remotes.group')
to fetch from multiple remotes behaves.

Also (and this is the more important part of my complaint), I cannot
tell if you are saying that it is *bad* for fetching multiple to be
just as verbose, or if it is *good*, or what.

If you are fetching from two places, and only one of them has
something new, you would see

    $ git fetch subs
    Fetching paulus
    Fetching l10n
    From git://one.of.the.places.xz/
       aadb70a..74301d6  master     -> this/master

so that you can see how remote.subs group expanded to.
   
> This is needed when fetching multiple repositories using the myrepos
> tool in minimal output mode, where myrepos only prints the repository
> names when git fetch prints some output.

That does not sound like a valid excuse to change the behaviour of
the command everybody, not just "myrepos tool" (whatever it is),
uses.  Your explanation does not seem to give us enough information
to answer this question intelligently: shouldn't you be fixing
myrepos instead, perhaps by making it run 'git fetch' with more
verbose mode, if it wants to see more information, or running 'git
fetch' and parsing different parts of its output?

Having said all that, this time I read the change and the change
itself feels 40% sensible, even for those who do not care about
"myrepos" at all.

I'd sell it like the attached, if I were doing this patch.  The last
paragraph is where the remaining 60% went ;-)

-- sample --
Subject: fetch: do not show remote group component without change

When fetching from a remote group, "Fetching X" is shown, followed
by the URL and ref-update summary, for each component of the remote
group.  With the default verbosity, the URL and ref-update summary
are not shown for repositories without anything new, but "Fetching
X" is always shown, which results in an output like this:

    $ git fetch group
    Fetching X
    From git://the.url.for.X.repo/
       aadb70a..74301d6  master     -> X/master
    Fetching Y
    Fetching Z

if the 'remotes.group' is configured to refer to three remotes, X, Y
and Z.  Given that "git fetch Y" would have produced no output with
the same verbosity, having the last two lines look inconsistent.

Tweak the verbosity so that "Fetching X" lines are given only when a
verbose output was requested with "git fetch -v".

Note that the current output was deliberately designed like this to
give an easy reminder for the user what the components of 'group'
are.  With this change, we are selfishly and unilaterally breaking a
feature that was designed to help them, but if they strongly care,
they can complain and revert this change.

-- end sample --
