From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/12] add --ff option to cherry-pick
Date: Mon, 01 Mar 2010 00:48:45 -0800
Message-ID: <7v635g4ec2.fsf@alter.siamese.dyndns.org>
References: <20100228222038.2260.25016.chriscool@tuxfamily.org>
 <7v3a0kg0qv.fsf@alter.siamese.dyndns.org>
 <201003010800.13996.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Mar 01 09:49:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm1JT-0000Fo-TP
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 09:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780Ab0CAItK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 03:49:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47952 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab0CAItI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 03:49:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C3CCD9D5BF;
	Mon,  1 Mar 2010 03:49:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ygRqvPgFm14ApjkARRKAKfmVPWo=; b=pYWiXj
	q1yrB9Y8tG4AkEDpAJAtqyg51DDpBi7qEU2cy5BkaegSXFo0GTAS/EJP5iSsjCnh
	OUXIJWZGtBTdZXVKB+bw4wAN5Z4ZaGn0k17tARvLpb6k65Y0nAvb3Q9rWwQBmGP7
	x/fnPZnKZx3hzLW3SDOna1vlw0FX//6N5RXlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x0ZyTOD/mPpgZnxPxYzZChRdFjvyD2BX
	NA0jSkUoJDeHTdFOnoc4bWYzkHKNhFIclyfOQFzVpMHFA4M9gUk0ni+43SjcfeY+
	5JAg6jAEdHnWKQmCX+dhdCXHDlfghVSvYsWOVOqREiLKFQU7OrNReI8tW7z9CJmG
	3Anpa4qmsG8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BB9D9D5BB;
	Mon,  1 Mar 2010 03:48:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B35CE9D5B7; Mon,  1 Mar
 2010 03:48:47 -0500 (EST)
In-Reply-To: <201003010800.13996.chriscool@tuxfamily.org> (Christian Couder's
 message of "Mon\, 1 Mar 2010 08\:00\:13 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 45EAA18C-250F-11DF-A68D-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141306>

Christian Couder <chriscool@tuxfamily.org> writes:

> On Monday 01 March 2010 04:49:12 Junio C Hamano wrote:
>> Thanks, but this seems to conflict with too many things in flight (it
>> applies cleanly on top of 'pu' but not on top of 'next').
>> 
>> Given that "rebase--interactive", which is the sole in-tree user of
>> cherry-pick, has its own fast-forwarding logic to skip call to it, it
>> seems to take too much time out of me to deal with the code churn for
>> dubious benefit---the series does not seem to solve any real problem.
>> 
>> After other topics have either graduated to 'master' or dropped out of
>> 'pu', things might look differently, though.
>  
> Ok I will wait for something like a week, and then rebase on top of next and 
> resend.

Actually, waiting, rebasing and resending, without any simplification,
would be the worst thing you could do.  Perhaps the "waiting" time can be
used to think how this can be simplified not to be such a big churn.

For example, why wouldn't the core of a "cherry-pick --ff" be something
like the attached patch, which obviously does not have "fast_forward_to"
yet, but whose implementation should be obvious (the code should already
be in "merge --ff" fast forward codepath, although I didn't look)?

 builtin-revert.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index eff5268..50a40d3 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -284,8 +284,6 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	}
 	discard_cache();
 
-	index_fd = hold_locked_index(&index_lock, 1);
-
 	if (!commit->parents) {
 		if (action == REVERT)
 			die ("Cannot revert a root commit");
@@ -314,6 +312,16 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	else
 		parent = commit->parents->item;
 
+	if (action == CHERRY_PICK && user_asked_fast_forward &&
+	    !no_commit &&
+	    !edit &&
+	    !no_replay
+	    parent &&
+	    !hashcmp(parent->object.sha1, head))
+		return fast_forward_to(parent);
+
+	index_fd = hold_locked_index(&index_lock, 1);
+
 	if (!(message = commit->buffer))
 		die ("Cannot get commit message for %s",
 				sha1_to_hex(commit->object.sha1));
