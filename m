From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFD] builtin-revert.c: release index lock when
 cherry-picking an empty commit
Date: Sat, 07 Mar 2009 20:14:34 -0800
Message-ID: <7v63ikmz11.fsf@gitster.siamese.dyndns.org>
References: <1236418251-16947-1-git-send-email-chris_johnsen@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 05:16:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgAQu-0004FQ-85
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 05:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740AbZCHEOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 23:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbZCHEOn
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 23:14:43 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42196 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbZCHEOn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 23:14:43 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7D0F6A087B;
	Sat,  7 Mar 2009 23:14:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 460A0A0873; Sat,
  7 Mar 2009 23:14:35 -0500 (EST)
In-Reply-To: <1236418251-16947-1-git-send-email-chris_johnsen@pobox.com>
 (Chris Johnsen's message of "Sat, 7 Mar 2009 03:30:51 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A50F20F8-0B97-11DE-9FC3-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112611>

Chris Johnsen <chris_johnsen@pobox.com> writes:

> When a cherry-pick of an empty commit is done, release the lock
> held on the index.
>
> The fix is the same as was applied to similar code in 4271666046.
>
> Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>

Thanks.  Will apply.  We should handle possible refactoring as a separate
topic.

> UNEVEN TREATMENT OF EMPTY CHANGES
>
> It seems that empty commits suffer uneven treatment under various
> patch-transport/history-rewriting mechanisms. They seem to be
> handled okay in the most of the core (fetch, push, bundle all
> seem to preserve empty commits, though I have not done rigorous
> testing).

They just transfer an existing history from one place to another without
modifying, so it is unfortunately true that they preserve such a broken
history with empty commits.

> 'format-patch', 'send-email', 'apply', 'am', 'rebase' (automatic,
> non-fast-forward; and --interactive).

These are all about creating history afresh, and they actively discourage
empty commits to be (re)created.

There is no "uneven treatment".

> 36863af16e (git-commit --allow-empty) says "This is primarily for
> use by foreign scm interface scripts.". Is this the only case
> where empty commits _should_ be used?

If foreign scm recorded an empty commit, it would be nice to be able to
recreate such a broken history _if the user wanted to_, and that is where
the --allow-empty option can be used.
