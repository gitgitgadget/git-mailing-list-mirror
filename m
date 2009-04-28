From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix behavior with non-committish upstream references
Date: Tue, 28 Apr 2009 00:30:05 -0700
Message-ID: <7vab61s0aq.fsf@gitster.siamese.dyndns.org>
References: <49F03A74.5080805@emlix.com>
 <1240849603-26127-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Simon Braunschmidt <sb@emlix.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 28 09:30:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyhlm-00022u-7E
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 09:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520AbZD1HaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 03:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752703AbZD1HaO
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 03:30:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33275 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbZD1HaN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 03:30:13 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4A9CAAEAA8;
	Tue, 28 Apr 2009 03:30:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F0872AEAA7; Tue,
 28 Apr 2009 03:30:07 -0400 (EDT)
In-Reply-To: <1240849603-26127-1-git-send-email-git@drmicha.warpmail.net>
 (Michael J. Gruber's message of "Mon, 27 Apr 2009 18:26:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 68D1D232-33C6-11DE-9079-CABC03BA4B0C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117750>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> stat_tracking_info() assumes that upstream references (as specified by
> --track or set up automatically) are commits. By calling lookup_commit()
> on them, create_objects() creates objects for them with type commit no
> matter what their real type is; this disturbs lookup_tag() later on the
> call sequence, leading to git status, git branch -v  and git checkout
> erroring out.
>
> Fix this by using lookup_commit_reference() instead so that (annotated)
> tags can be used as upstream references.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> I'm sorry I won't be able to write a test any more today. Please let me
> whether it's okay without a test.

I am sorry, but I simply do not see much point in this.  I think you meant
by the title "non-commit upstream ref", as a tag that eventually peels to
a commit is a committish.  Because a tag is meant to be immutable, forking
from that mean your further "merges from upstream" won't do anything, so
the current behaviour of returning without saying anything sounds like the
right thing to do, even though I strongly suspect that it behaves this way
by accident not by design.

Admittedly, I do not "fork and keep up-to-date with an upstream" that
often, so I am in no way making a final decision here.  It would be
healthy for interested people to discuss this patch, but I'd appreciate it
if it happens after 1.6.3 final.
