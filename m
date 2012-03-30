From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: Maintaining historical data in a git repo
Date: Fri, 30 Mar 2012 12:18:15 -0400
Message-ID: <201203301618.q2UGIF3Q005388@no.baka.org>
References: <CA+P+rLeyEcZPudhLWavB74CiDAqpn+iNkk4F8=NK_yGaJPMmyA@mail.gmail.com> <201203301510.q2UFAqn6003864@no.baka.org>
        <CA+P+rLcWT0SZQjW2LtFXXCDRwjMp8daJ2hVup=7cnsRGbKw7xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Yuval Adam <yuv.adm@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 18:18:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDeWz-0007fC-Mn
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 18:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761035Ab2C3QSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 12:18:25 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:60024 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755909Ab2C3QSY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 12:18:24 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id q2UGIGSg021615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 30 Mar 2012 12:18:16 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id q2UGIF3Q005388;
	Fri, 30 Mar 2012 12:18:15 -0400
In-reply-to: <CA+P+rLcWT0SZQjW2LtFXXCDRwjMp8daJ2hVup=7cnsRGbKw7xw@mail.gmail.com>
Comments: In reply to a message from "Yuval Adam <yuv.adm@gmail.com>" dated "Fri, 30 Mar 2012 18:55:51 +0300."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194373>


In message <CA+P+rLcWT0SZQjW2LtFXXCDRwjMp8daJ2hVup=7cnsRGbKw7xw@mail.gmail.com>, Yuval Adam writes:

    On Fri, Mar 30, 2012 at 6:10 PM, Seth Robertson <in-gitvger@baka.org> wrote:
    > Revision control shouldn't be used to change the past (even if git
    > allows this with sufficient amounts of pain/warning to all users).
    > What it is extremely good at is preserving the past and tracking the
    > changes that are made.

    This is exactly what we _do_ want to do.

    Is this something that is definitively complicated with git?

Ah, I understand now.  I imagine others will chime in as well, but
this should not be too complex with git.  You can easily go back into
history and change it.  The problem comes in when you have shared your
repository with other people.

In general, rewriting public history is a bad idea because git cannot
tell the difference between someone adding to history for good reasons
(expanding on known history) and bad reasons (retroactively rewriting
the law to add a loophole).

You can absolutely do it, but then you have to "force push" your
changes to the master server to override the history (assuming that is
allowed, and it typically is not by default) and then everyone else
would have to do special things (`git pull --rebase` in the simple
case, rebuilding branches and tags in more complex cases) to get the
new history.  Clearly for something like the law and the probable
complex workflow it will have, this isn't a good method.

What I would probably suggest is having either a historical branch or
a historical repository which is allowed and expected to be rewritten.
The changes would then be confined to places where active
"development" would not be occurring and the process to recover from
the retroactive changes could be automated.  The "git replace" and
"git grafts" (the last might be deprecated) functionality could be
used to merge the two histories together so it is transparent to those
who need a consistent view from now to the beginning.  With a separate
repo then the normal users who only care about the recent changes and
current state don't ever have to do anything special or worry about
the history changes, but it should work in either case.

					-Seth Robertson
