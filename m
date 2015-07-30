From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] pull.sh: quote $upload_pack when passing it to git-fetch
Date: Thu, 30 Jul 2015 22:40:03 +0200
Message-ID: <1438288803-17953-1-git-send-email-Matthieu.Moy@imag.fr>
References: <CAPc5daXPY7RQSM6oyFYJ2LjYjaT9dDG-+3=nbHONirGh50pdBA@mail.gmail.com>
Cc: git@vger.kernel.org, Joey Hess <id@joeyh.name>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 30 22:40:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKuct-0004K3-C0
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 22:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbbG3UkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 16:40:23 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38781 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950AbbG3UkX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 16:40:23 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t6UKe2ln002867
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 30 Jul 2015 22:40:02 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6UKe5oM011377;
	Thu, 30 Jul 2015 22:40:05 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1ZKucW-0004k7-RN; Thu, 30 Jul 2015 22:40:04 +0200
X-Mailer: git-send-email 2.5.0.rc0.7.ge1edd74.dirty
In-Reply-To: <CAPc5daXPY7RQSM6oyFYJ2LjYjaT9dDG-+3=nbHONirGh50pdBA@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 30 Jul 2015 22:40:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6UKe2ln002867
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1438893607.11838@dmmNu2VZc6lKrvNQMqxwSw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275027>

The previous code broke for example

  git pull --upload-pack 'echo --foo'

Reported-by: Joey Hess <id@joeyh.name>
Fix-suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Junio wrote:
> ${upload_pack+"$upload_pack"} or something.

Indeed, we need to pass nothing, not the empty string if $upload_pack
is not defined.

This should fix it.

 git-pull.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-pull.sh b/git-pull.sh
index a814bf6..26c5e9f 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -295,7 +295,7 @@ test true = "$rebase" && {
 }
 orig_head=$(git rev-parse -q --verify HEAD)
 git fetch $verbosity $progress $dry_run $recurse_submodules $all $append \
-$upload_pack $force $tags $prune $keep $depth $unshallow $update_shallow \
+${upload_pack+"$upload_pack"} $force $tags $prune $keep $depth $unshallow $update_shallow \
 $refmap --update-head-ok "$@" || exit 1
 test -z "$dry_run" || exit 0
 
-- 
2.5.0.rc0.7.ge1edd74.dirty
