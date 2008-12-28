From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/diff-options.txt: unify options
Date: Sat, 27 Dec 2008 22:52:49 -0800
Message-ID: <7vvdt4aj0e.fsf@gitster.siamese.dyndns.org>
References: <7vfxk9cm6w.fsf@gitster.siamese.dyndns.org>
 <87lju1jmp9.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Sun Dec 28 07:54:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGpXX-0000rX-7Y
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 07:54:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbYL1GxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2008 01:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbYL1Gw7
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Dec 2008 01:52:59 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35687 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbYL1Gw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2008 01:52:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A220A8BB75;
	Sun, 28 Dec 2008 01:52:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B31AD8BB74; Sun,
 28 Dec 2008 01:52:52 -0500 (EST)
In-Reply-To: <87lju1jmp9.fsf@jidanni.org> (jidanni@jidanni.org's message of
 "Sun, 28 Dec 2008 06:08:18 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 27B36D02-D4AC-11DD-A1AE-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104041>

jidanni@jidanni.org writes:

> JCH> Sorry, but this patch is very unusual in that it lacks any context lines,
> JCH> which makes it impossible to review.
>
> Trust me, I tried it with the default context lines and it was just
> the same hard reading.

Nonsense.

Here is a snippet from your patch.

        diff --git a/diff-options.txt b/diff-options.txt
        index 5721548..b05503a 100644
        --- a/diff-options.txt
        +++ b/diff-options.txt
        @@ -21,0 +22 @@ ifndef::git-format-patch[]
        +-u::
        @@ -26,3 +26,0 @@ endif::git-format-patch[]
        --u::
        -	Synonym for "-p".
        -

The only thing anybody can guess without looking at the original (that is
what "sending a patch without context" means) is that you moved "-u::" to
somewhere else, and stripped of its description.  There is absolutely no
clue to judge if the new home to "-u::" is an appropriate place.

In a normal patch with context, the same hunk would have looked like this:

        diff --git i/Documentation/diff-options.txt w/Documentation/diff-options.txt
        index c62b45c..c4ca0a9 100644
        --- i/Documentation/diff-options.txt
        +++ w/Documentation/diff-options.txt
        @@ -19,16 +19,12 @@ endif::git-format-patch[]

         ifndef::git-format-patch[]
         -p::
        +-u::
                Generate patch (see section on generating patches).
                {git-diff? This is the default.}
         endif::git-format-patch[]

        --u::
        -	Synonym for "-p".
        -
         -U<n>::
        -	Shorthand for "--unified=<n>".
        -
         --unified=<n>::

Presented this way, it is much more clear what is going on, as there is no
need to go back to the original and see if the new location for "-u::"
makes sense (and I think it does, but that is something I can say after
applying the patch and reviewing the result, because the patch itself is
not reviewable).

If you find yours just as easy to read as the one with context, your patch
reading ability far exceeds mine, and I'd refuse to read your patches in
the future to preserve my sanity.

There is another issue that should be obvious to people who deal with
patches every day.  The context-free patch you sent can be applied *ONLY*
after locating the *EXACT* preimage of the file you used to produce your
patch.  Before your patch is reviewed, other people may have already
modified the same file, perhaps introducing a few new lines at the top of
the file, and then what?  Your first hunk tells us that you would want to
insert a line with "-u::" at line #21, but the context does not match
anymore when your patch is reviewed.
