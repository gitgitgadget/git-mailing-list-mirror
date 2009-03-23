From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool: add support for an extended revision syntax
Date: Mon, 23 Mar 2009 16:50:59 -0700
Message-ID: <7v1vsn6boc.fsf@gitster.siamese.dyndns.org>
References: <1237803348-9329-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 00:52:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lltwh-0002Z7-2s
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 00:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbZCWXvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 19:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbZCWXvI
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 19:51:08 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38420 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbZCWXvG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 19:51:06 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E39C28AAD;
	Mon, 23 Mar 2009 19:51:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 29D3D8AAB; Mon,
 23 Mar 2009 19:51:01 -0400 (EDT)
In-Reply-To: <1237803348-9329-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Mon, 23 Mar 2009 03:15:48 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 783E575E-1805-11DE-8F81-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114367>

David Aguilar <davvid@gmail.com> writes:

> This makes answering that question considerably easier.
> Users can now simply say:
>
> 	$ git difftool <file>~
>
> to compare <file> in the worktree against its
> previous version, and:
>
> 	$ git difftool <file>~2 <file>~
>
> to compare <file> from 2 versions ago to <file>'s
> previous version, etc.

These two examples are not that interesting.  Because you can say:

	$ git log -p -1 file
	$ git log -p -2 file

(admittedly you need to skip the first entry of the output in the latter
one to get to what you are interested in).

What existing syntax does not allow you to say easily is something like:

	$ git difftool <file>~4 <file>

That is, "I do not care about the intermediate states, but want to see the
4 changes consolidated in one".

As I told you in my previous message, I am not convinced a short-and-sweet
notation such as tilde-four is expressive enough for most user's needs (I
suspect most users use git as a fast CVS and have rather linear history,
in which case "Nth commit that changes the file, following only the first
parent chain down from the HEAD" _could_ be a perfectly fine and useful
semantics), but if it is, I think it would not be too involved to patch
revision.c::handle_revision_arg() to make it available to everybody.

> This makes the following statements equivalent:
>
> 	$ git difftool !
> 	$ git difftool HEAD!
> 	$ git difftool HEAD~ HEAD

Which would be:

	$ git log -p -1 file

right?

Perhaps we would want a convenient way for "log -p" or "show -p" to drive
difftool as a backend?
