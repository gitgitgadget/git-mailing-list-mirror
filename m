From: Junio C Hamano <gitster@pobox.com>
Subject: Applying patches from gmane can be dangerous.
Date: Wed, 06 Feb 2008 20:14:31 -0800
Message-ID: <7vodatqu6w.fsf@gitster.siamese.dyndns.org>
References: <20080205211044.GP26392@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Downing <bdowning@lavos.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Magne Ingebrigtsen <larsi+gmane@gnus.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 05:15:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMyAU-0004DH-IB
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 05:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbYBGEOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 23:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753216AbYBGEOu
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 23:14:50 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61746 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbYBGEOt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 23:14:49 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D45372F89;
	Wed,  6 Feb 2008 23:14:47 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 220202F84;
	Wed,  6 Feb 2008 23:14:40 -0500 (EST)
In-Reply-To: <20080205211044.GP26392@lavos.net> (Brian Downing's message of
	"Tue, 5 Feb 2008 15:10:44 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72889>

I picked up the qsort patch from Brian while reading the list
via gmane's newsfeed and applied it without realizing that it
was one of the articles whose addresses on all the address
header fields _and_ all strings that look like e-mail addresses
have been mangled by gmane.  Sign-offs by Dscho and Steffen
Prohaska have also been munged (even though that are not part of
headers).

It already is part of 'next', and we have the policy of not
rewinding 'next', so the record of this mistake will
unfortunately be with us forever.  Sorry, Brian, Dscho and
Steffen.

For the curious, the message was:

    http://article.gmane.org/gmane.comp.version-control.git/72699/raw

I've added the following in my .git/hooks/applypatch-msg and
made it executable, so hopefully it won't happen again.

    #!/bin/sh
    case "$GIT_AUTHOR_EMAIL" in
    *@public.gmane.org)
            echo >&2 "Gmane munged the author's email address, aborting."
            echo >&2 "Pick up the original message from your mbox!"
            exit 1
            ;;
    esac

This is really sad.  gmane gives us a clean threaded interface
(both in web and newsreader), and it never forgets. Whenever I
need to refer somebody to an old discussion, I can give an URL
to it and allmost all the discussion messages are there with a
single paste and clicking around.  It has been an indispensable
service to me ever since I started reading the git list with it.
It is really a shame that I have to prevent picking up patch
messages from it with the above hook.

I am wondering if other development communities had a similar
issue already, and if so how they are dealing with it.
