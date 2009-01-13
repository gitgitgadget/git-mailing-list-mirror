From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Simple update to bash completions to prevent unbound
 variable errors.
Date: Tue, 13 Jan 2009 00:01:08 -0800
Message-ID: <7vab9veit7.fsf@gitster.siamese.dyndns.org>
References: <496C0003.7040909@tedpavlic.com>
 <7vy6xfew2n.fsf@gitster.siamese.dyndns.org>
 <200901122157.03658.bss@iguanasuicide.net> <496C19E0.6060308@tedpavlic.com>
 <496C1D90.1020609@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 09:02:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMeEY-0002Jm-UJ
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 09:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754946AbZAMIBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 03:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754436AbZAMIBW
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 03:01:22 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33492 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837AbZAMIBV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 03:01:21 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B301D8FD0E;
	Tue, 13 Jan 2009 03:01:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6BC178FD0D; Tue,
 13 Jan 2009 03:01:10 -0500 (EST)
In-Reply-To: <496C1D90.1020609@tedpavlic.com> (Ted Pavlic's message of "Mon,
 12 Jan 2009 23:50:24 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5A244970-E148-11DD-AC1D-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105468>

Ted Pavlic <ted@tedpavlic.com> writes:

> An alternative (to a Vim modeline) is to put
>
> #!bash

I actually like this much better than "# vim:" thing.

It talks about WHAT the file is ("It is a bash scriptlet"), as opposed to
"# vim:" that tells HOW one user wants to edit the file ("with this
settings I use vim to edit this file").  In case somebody misunderstood
me, my "Yuck" was not about Emacs vs vi holy war. [*1*].

As people noted, it may not have any meaning to the shell, but it serves
as an important documentation to humans.  As the maintainer, I try to be
reasonably strict about keeping our shell scripts free of bash-ism to help
people on platforms without bash, but this file is about bash (and bash
only).  We are free to use all bash-isms we usually try to stay away from
in our scripts marked with #!/bin/sh (namely, "local", "let", shell
arrays, and substitutions outside POSIX such as ${parameter:offset:length}
substring, ${#parameter} length, and ${parameter/pattern/string} regexp
replacement), as long as they are compatible across recent bash versions.

If tools like vim notice the same hint that says "this is bash" and
adjusts its behaviour accordingly, that is great.

Even though I've grown to know Shawn well enough to be able to tell that
certain kinds of changes would get his Ack and often apply patches myself
without waiting him to give his Ack, the completion script is ultimately
his code and you do not necessarily have to make me like it.

Your updated patch still had [ $# -eq 0 -o -z "$1" ] even though the
commit log message (which is not the place to describe changes between v1
and v2 submissions, by the way) claimed that you replaced them with
"${1-}".  I am guessing it would need at least one more iteration to clean
up, but I think this patch is improving _provided if_ supporting "set -u"
in the user's interactive environment is a good idea to begin with.

I just hope that next person who complains about bash completion scripts
would not say that he has "set -e" in his interactive environment ;-) I
personally consider that "set -u" is equally silly, but it probably is
just me.

[Footnote]

*1* For the same reason, Local Variables section to please Emacs is
equally offending; it tends to be much bigger which is even worse.
