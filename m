From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ls-tree: add --full-tree option
Date: Fri, 26 Dec 2008 13:38:06 -0800
Message-ID: <7veizulirl.fsf@gitster.siamese.dyndns.org>
References: <7v63l7rc1s.fsf@gitster.siamese.dyndns.org>
 <200812260916.45401.j6t@kdbg.org> <7vmyejpb6o.fsf@gitster.siamese.dyndns.org>
 <49553561.4030902@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Deskin Miller <deskinm@umich.edu>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Dec 26 22:39:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGKPB-00055V-MX
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 22:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbYLZViQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 16:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752814AbYLZViQ
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 16:38:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58107 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757AbYLZViP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 16:38:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 125E91B25E;
	Fri, 26 Dec 2008 16:38:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8ABB51B25F; Fri,
 26 Dec 2008 16:38:08 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7F51A6E0-D395-11DD-8B62-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103953>

Johannes Sixt <j6t@kdbg.org> writes:

> I'm saying that if a script has to be fixed to use --full-tree, then
> it can be fixed just as well by appending the colon to the ${rev}.

I do not agree with your "just as well"; an existing script that feeds a
tree object to the plumbing would be broken by such a change.

But I think perhaps you were responding to the first paragraph of the
commit log message that you omitted from your quote?

JC> The established behaviour of "git ls-tree $commit" run from a
JC> subdirectory "sub/dir" in a work tree is to...

If that is the case, I understand what you meant.

The patch is about the behaviour of the command for not just $commit but
any $tree_ish, so "git ls-tree ${commit}:" shares the exact same issue
(i.e. historical background that forbids us from changing the behaviour
without an explicit option, and that --full-tree can be a way to help new
scripts without breaking existing scripts' expectations).

I've updated the commit log message with s/$commit/$tree_ish/;

> OTOH, you had yourself argued somewhat in favor of the current ls-tree
> behavior:
>
> http://thread.gmane.org/gmane.comp.version-control.git/46232/focus=46400

That's not really "somewhat in favor".  I can be (and am more often than
not) sympathetic without agreeing to the end result. My sympathy extends
from "I can sort-of-kind-of imagine that it may hurt, and even though I do
not think your approach is a way to properly address it at all, I'd agree
it might be nice to have some solution to the issue" to "I do not think it
is feasible to change this anymore, but I wish we could, too."

In any case, the quoted message was from May 2007, way before v1.6.0 when
we learned the hard way that people do not want any change.

I really hate "take it or leave it", especially when it is not my itch to
scratch, but in this case, I think I've spent enough time making myself
clear that I think (1) that the current behaviour is a result of misguided
attempt for interactive user expectation, which shouldn't have made to the
plumbing, (2) that we cannot change the default behaviour now even (1) is
true; and (3) that the only possible approach to help new scripts would be
a new option.
