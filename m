From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] config doc: rewrite push.default section
Date: Mon, 17 Jun 2013 13:09:44 +0200
Message-ID: <vpqip1d803r.fsf@anie.imag.fr>
References: <1371377188-18938-1-git-send-email-artagnon@gmail.com>
	<7vli69iff2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 13:10:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoXJu-0004qh-9S
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 13:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756171Ab3FQLJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 07:09:52 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47827 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756047Ab3FQLJu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 07:09:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5HB9gZP016294
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 17 Jun 2013 13:09:43 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UoXJg-0008TT-B4; Mon, 17 Jun 2013 13:09:44 +0200
In-Reply-To: <7vli69iff2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 16 Jun 2013 20:28:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 17 Jun 2013 13:09:43 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228061>

Junio C Hamano <gitster@pobox.com> writes:

>> +* `matching` - push the refspec ":".  In other words, push all
>> +  branches having the same name in both ends, even if it means
>> +  non-fast-forward updates.  This is for those who prepare all the
>> +  branches into a publishable shape and then push them out with a
>> +  single command.  Dangerous, and inappropriate unless you are the
>> +  only person updating your push destination.
>
> It was already pointed out that unnecessary negativity needs to be
> fixed, but more importantly the above "Dangerous" is not even
> correct.

What's really dangerous is the --force flag. A few weeks ago I had to
help a colleague who did a "git push --force" to update his branch, and
he lost data on his co-worker's branches (thanks to "git reflog", it
wasn't an actual data loss, but still pretty bad).

But then the place to warn loudly is the doc for --force. What about
this?

------- 8< ------- 8< ------- 8< ------- 8< ------- 8< ------- 8< 

>From a529588dd8df84e54e5ec267068248cc555373f5 Mon Sep 17 00:00:00 2001
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Mon, 17 Jun 2013 13:02:39 +0200
Subject: [PATCH] Documentation/git-push.txt: explain better cases where
 --force is dangerous

The behavior of "git push --force" is rather clear when it updates only
one remote ref, but running it when pushing several branches can really
be dangerous. Warn the users a bit more and give them the alternative to
push only one branch.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-push.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 938d1ee..0899a35 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -136,6 +136,13 @@ already exists on the remote side.
        not an ancestor of the local ref used to overwrite it.
        This flag disables the check.  This can cause the
        remote repository to lose commits; use it with care.
+       Note that `--force` applies to all the refs that are pushed,
+       hence using `git push --all --force`, or `git push --force`
+       with `push.default` set to `matching` may override refs other
+       than the current branch (including local refs that are
+       strictly behind their remote counterpart). To force a push to
+       only one branch, use `git push <remote> +<branch>` instead of
+       `--force`.
 
 --repo=<repository>::
        This option is only relevant if no <repository> argument is
-- 
1.8.3.1.495.g13f33cf.dirty


-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
