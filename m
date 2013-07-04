From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Feature request: prevent push -f from pushing all branches at once
Date: Thu, 04 Jul 2013 10:06:59 +0200
Message-ID: <vpq7gh67nq4.fsf@anie.imag.fr>
References: <ADE9FE42-FC10-4976-8E6A-290B101DD17A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dany <nessup@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 10:07:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UueZa-0003Zp-W3
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 10:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756454Ab3GDIHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 04:07:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50638 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756158Ab3GDIHH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 04:07:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r6486xf8018308
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 4 Jul 2013 10:06:59 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UueZA-0007i7-5t; Thu, 04 Jul 2013 10:07:00 +0200
In-Reply-To: <ADE9FE42-FC10-4976-8E6A-290B101DD17A@gmail.com> (Dany's message
	of "Wed, 3 Jul 2013 16:30:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 04 Jul 2013 10:06:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r6486xf8018308
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1373530023.22321@SmHMlQBevxf8ut7vwldwkg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229558>

Dany <nessup@gmail.com> writes:

> Again, I think the case where one intends to force push many branches
> is certainly not as common as the case where one intends to force push
> one branch, so why does git's default behavior leave the user in the
> position of fscking himself over pretty badly?

I don't think the case of "force push" is very different from the
"non-force push". If you're surprised that "git push -f" pushes
everything, most likely you didn't want a plain "git push" to push
everything either.

There are already several measures against this. The first is mentionned
in Jonathan's message: Git 2.0 will only push one branch by default (-f
or not). You can already get this behavior by setting push.default (if
your Git version is too old, set it to "current" for example, read "git
config --help").

Another measure is a better documentation. We've just merged the change
below. In short: don't run "git push -f", but run e.g. "git push origin
+master".

commit 70495b556f5685afe0e41988e42d48b2331d77a0
Author: Matthieu Moy <Matthieu.Moy@imag.fr>
Date:   Mon Jun 17 19:52:41 2013 +0200

    Documentation/git-push.txt: explain better cases where --force is dangerous
    
    The behavior of "git push --force" is rather clear when it updates only
    one remote ref, but running it when pushing several branches can really
    be dangerous. Warn the users a bit more and give them the alternative to
    push only one branch.
    
    Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 8b637d3..28a17c3 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -124,6 +124,15 @@ no `push.default` configuration variable is set.
        not an ancestor of the local ref used to overwrite it.
        This flag disables the check.  This can cause the
        remote repository to lose commits; use it with care.
+       Note that `--force` applies to all the refs that are pushed,
+       hence using it with `push.default` set to `matching` or with
+       multiple push destinations configured with `remote.*.push`
+       may overwrite refs other than the current branch (including
+       local refs that are strictly behind their remote counterpart).
+       To force a push to only one branch, use a `+` in front of the
+       refspec to push (e.g `git push origin +master` to force a push
+       to the `master` branch). See the `<refspec>...` section above
+       for details.
 
 --repo=<repository>::
        This option is only relevant if no <repository> argument is


-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
