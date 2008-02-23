From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Be more verbose when checkout takes a long time
Date: Sat, 23 Feb 2008 15:42:06 -0800
Message-ID: <7vve4fxmsx.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0802231323590.21332@woody.linux-foundation.org>
 <7v8x1b1fiu.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802231430100.21332@woody.linux-foundation.org>
 <7vzltrz4cl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 00:43:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT41D-0007FA-Dm
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 00:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828AbYBWXmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 18:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753709AbYBWXmY
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 18:42:24 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbYBWXmX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 18:42:23 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C1C5817A9;
	Sat, 23 Feb 2008 18:42:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id DD9ED17A8; Sat, 23 Feb 2008 18:42:14 -0500 (EST)
In-Reply-To: <7vzltrz4cl.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 23 Feb 2008 14:37:46 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74883>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> ...
>> Sounds sane to me.
>
> Ok, then.
>
> Unfortunately it will be short-lived on 'master' as I have been
> planning to merge Daniel's rewrite soon ;-)

So here it is ;-)

Thanks to the unpack_trees_options.gently flag, this does not
have to say "Falling back to..." because the first "attempt to
switch normally" would silently fail.

---

 builtin-checkout.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 5f176c6..283831e 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -232,6 +232,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 			topts.update = 1;
 			topts.merge = 1;
 			topts.gently = opts->merge;
+			topts.verbose_update = !opts->quiet;
 			topts.fn = twoway_merge;
 			topts.dir = xcalloc(1, sizeof(*topts.dir));
 			topts.dir->show_ignored = 1;
