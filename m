From: Junio C Hamano <gitster@pobox.com>
Subject: Re: why no "git fetch --dry-run" ?
Date: Fri, 21 Nov 2008 16:40:13 -0800
Message-ID: <7vtza0pp8y.fsf@gitster.siamese.dyndns.org>
References: <ee2a733e0811211341j1e49fad7o64577605951fa5c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Sat Nov 22 01:41:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3gZK-0000bt-CQ
	for gcvg-git-2@gmane.org; Sat, 22 Nov 2008 01:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925AbYKVAkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 19:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754314AbYKVAkf
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 19:40:35 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38935 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669AbYKVAke (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 19:40:34 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B10E80921;
	Fri, 21 Nov 2008 19:40:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3942380920; Fri,
 21 Nov 2008 19:40:15 -0500 (EST)
In-Reply-To: <ee2a733e0811211341j1e49fad7o64577605951fa5c0@mail.gmail.com>
 (Leo Razoumov's message of "Fri, 21 Nov 2008 16:41:57 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2BA15DA6-B82E-11DD-AB3A-8214C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101548>

"Leo Razoumov" <slonik.az@gmail.com> writes:

> I am curious why there is "git push --dry-run" and no "git fetch
> --dry-run" nor "git pull --dry-run". It would make sense to keep
> push/pull/fetch as symmetric as possible.

There are things that are not implemented in git because they do not make
sense, and there are things that are not implemented in git because nobody
had itch to scratch for.  To put it differently, we tend to implement only
things that there are actual, demonstrated needs for from real world and
only when the addition makes sense as a coherent part of the system.

"fetch --dry-run" falls into the latter category.

"push" is hard to undo because it affects the outside world, but "fetch"
is only about your local object store and its remote tracking branches, so
the need to have --dry-run mode to "push" was much more real than to the
need for "fetch --dry-run" and was implemented.

If you have the itch for the latter, I do not think anybody objects to it
on the ground that such a feature does not make sense.

Having said that, "fetch --dry-run" probably has little value in practice.
You cannot tell how much data will be transferred before actually running
a fetch, so it won't be a tool for you to decide if you can afford the
time to run fetch now or do that later ("push --dry-run" will let you gain
the necessary information for doing this this if your push is
fast-forward, which should mostly be the case).  The only information you
would get is if an actual "fetch" will have any update to each of the
branches you are tracking (so that's one bit per branch) and if you have a
connection to the other end, and that is about it.
