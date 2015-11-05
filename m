From: Junio C Hamano <gitster@pobox.com>
Subject: Re: About global --progress option
Date: Wed, 04 Nov 2015 22:11:14 -0800
Message-ID: <xmqqk2px7z7h.fsf@gitster.mtv.corp.google.com>
References: <CAOc6etYiGV0v4gkkpudi3ACa6kA3H8CnqYYeSksfO4mGGfEyXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 07:11:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuDlZ-0005jP-MA
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 07:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030641AbbKEGLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 01:11:18 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62549 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756510AbbKEGLR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 01:11:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 623731C6AF;
	Thu,  5 Nov 2015 01:11:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KHv/iq+cVdzeMOIcRa2tS0zpRyU=; b=SubCc/
	ISmdSZthlF+ywrC9c4fFFp2zD4US9mwt+aSPoEVWQWTaFkO4+Ma2wBNjlDi3E5+c
	Orz3Hh943vO+f5ZIx+qtQRACNcnf+s8Yqz09IiRv2+3bVckdAn23mrfNb7S62JkS
	bhJZvuR88AfgMkEOP2bZfLHXq9EtJl9Rl/D0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=giAFixNNrVRQluoUAyWdX124eK1F2Du+
	gBW6ioBsTGvHXZf5O/tCGdgaVuX8cAwuy7APZ0AgGUayUFNIZifu9xWDyFr36NLn
	2MANo8CYEi2y8NQf5fflj7K0AqGk3WkAhEn9OuyNtPWsCr4BivlvpUignbQ2sOQq
	OEUfh6SELc4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5A52B1C6AD;
	Thu,  5 Nov 2015 01:11:16 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CF21A1C571;
	Thu,  5 Nov 2015 01:11:15 -0500 (EST)
In-Reply-To: <CAOc6etYiGV0v4gkkpudi3ACa6kA3H8CnqYYeSksfO4mGGfEyXg@mail.gmail.com>
	(Edmundo Carmona Antoranz's message of "Wed, 4 Nov 2015 21:13:20
	-0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 05AA0818-8384-11E5-A450-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280904>

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> Which would be the correct development path?
>
> - Two-step process: First step, implement global --[no-]progress at
> the git level and also support the option from the builtins that
> laready have it. Let it live like that for some releases (so that
> people have the time to dump using the builtin option and start using
> the global option) and then on the second step dump the builtin
> options and keep the global one.
>
> or
>
> - A single step that would remove --[no-]progress from all builtins
> that support it and would place it as a global git option?

Assuming by "dump" you mean "removal of support", I doubt either is
correct.

Existing users know that the way to squelch progress output from
their "git clone" is with "git clone --no-progress".  Introducing
another way to say the same thing, i.e. "git --no-progress clone" is
one thing, but I do not see what value you are adding to the system
by breaking what they know has worked forever and forcing them to
use "git --no-progress clone".  Why should they learn that the
"--no-checkout" option for example has to come after "clone" and
the "--no-progress" option has to come before?  Why should they
adjust their scripts and their finger memory to your whim?

Besides, I am not convinced that you are bringing in a net positive
value by allowing "git --no-progress clone".  You would need to
think what to do when you get two conflicting options (e.g. should
"git --no-progress clone --progress" give progress?  Why?), you
would need to explain to the users why the resulting code works the
way you made it work (most likely, "do nothing special") when the
global one is given to a command that does not give any progress
output, and you would need to make sure whatever answers you would
give to these questions are implemented consistently.  And you would
need more code to do so.  It is unclear to me what value the end
users get out of all that effort, if any, and if the value offered
to the end users outweigh the added complexity, additional code that
has to be maintained, and additional risk to introduce unnecessary
bugs.

A lot more useful thing to do in the same area with a lot smaller
amount of effort would be to find an operation that sometimes take a
long time to perform that does not show the progress report and
teach the codepath involved in the operation to show progress, I
would think.
