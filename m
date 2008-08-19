From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] test-lib.sh: work around ksh's trap shortcomings
Date: Tue, 19 Aug 2008 09:59:52 -0500
Message-ID: <nRhBKqCwHxZZH8zh17SOnUKHFp0V5HZj8_Lcmybj49DM7L4TYYoZbQ@cipher.nrlssc.navy.mil>
References: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil> <gPlIc7E6mNDrXE6mwaHXFoin7rDpLmjvuzlhJfCp-YmuyVK3pEzqNA@cipher.nrlssc.navy.mil> <7vbpzplw9o.fsf@gitster.siamese.dyndns.org> <ZqhiQsjr6llIQS0q8PP8utINgu-mnafhFeUc119IDyjsaBEePvtv9g@cipher.nrlssc.navy.mil> <7v3al1h2rk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 17:02:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVSic-0004IV-KF
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 17:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbYHSPAy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Aug 2008 11:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752500AbYHSPAy
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 11:00:54 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57853 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbYHSPAx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 11:00:53 -0400
Received: by mail.nrlssc.navy.mil id m7JExqLl027633; Tue, 19 Aug 2008 09:59:52 -0500
In-Reply-To: <7v3al1h2rk.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 19 Aug 2008 14:59:51.0997 (UTC) FILETIME=[3B9FEED0:01C9020C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92873>

Junio C Hamano wrote:

> Yeah, I think I got the subtle distinction between [PATCH FYI], [PATC=
H]
> and ones with and without sign-offs.

Heh, so subtle as to be unintentional. I think I mucked up that posting=
=2E
I should have labeled them all FYI and numbered them. I did hope there
would be some discussion that would result in a followup patch for
submission.

> I've read "trap" section of 1003.1 2004 three times but I do not see =
the
> exact definition of "EXIT" condition mentioned.  Is the behaviour to
> consider "function return" the EXIT condition considered a "shortcomi=
ng"
> (aka bug)?

No, I think it is the defined behavior for the Korn shell.

The SunOS 5.7 man page states:

     If sig  is  0 or EXIT and the trap  statement is exe-
     cuted inside the body of a function, then the com-
     mand arg is executed after the function completes.
     If sig is 0 or EXIT for a trap   set  outside  any
     function, the command arg is executed on exit from
     the shell.

The IRIX 6.5 man page has the exact same wording.

On linux, the man page for the public domain Korn shell states

    Functions  defined with the function reserved word are treated diff=
er-
    ently in the following ways from functions defined with the  ()  no=
ta-
    tion:

        ...

      - The EXIT trap, if set in a function, will be executed after the
        function returns.

But then later in the trap section:

    The original Korn shell=92s DEBUG trap and the  handling  of  ERR
    and EXIT traps in functions are not yet implemented.


If Korn shell is to be supported, it seems that trap on EXIT must be
avoided within functions. I think the only one is in git-bisect.

-brandon
