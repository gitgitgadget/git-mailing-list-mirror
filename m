From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv4 3/3] Advices about 'git rm' during conflicts (unmerged paths) more relevant
Date: Thu, 31 May 2012 09:06:43 +0200
Message-ID: <vpq7gvsrfr0.fsf@bauges.imag.fr>
References: <1338226598-16056-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338384216-18782-3-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu May 31 09:06:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZzTH-0004zn-42
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 09:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392Ab2EaHGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 03:06:48 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37501 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742Ab2EaHGr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 03:06:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4V6wOci025776
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 31 May 2012 08:58:25 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SZzT2-000306-NE; Thu, 31 May 2012 09:06:44 +0200
In-Reply-To: <1338384216-18782-3-git-send-email-Lucien.Kong@ensimag.imag.fr>
	(Kong Lucien's message of "Wed, 30 May 2012 15:23:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 31 May 2012 08:58:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4V6wOci025776
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339052305.47563@WN/HH5KaBwWuVxVKMwHDqQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198867>

Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:

> Subject: Re: [PATCHv4 3/3] Advices about 'git rm' during conflicts (unmerged paths) more relevant

"more relevant" doesn't say much, and your subject line doesn't say it's
about "status". What about

status: don't suggest "git rm" if not appropriate

?

> +test_expect_success 'status when conflicts without rm advice (both modified)' '

How is this different from the other existing tests? Avoid adding
redundant tests, they slow down the test suite without added value.

> +test_expect_success 'status when conflicts with add and rm advice (deleted by us)' '
> +test_expect_success 'status when conflicts with add and rm advice (deleted by them)' '

You can probably save a few line (and test execution time) by reusing
the same repository in the second test, like

git reset --hard
git checkout master
git merge second_branch

(i.e. reply the merge, but symmetrically, from the other branch)

Perhaps this sould be added to t7060-wtstatus.sh (basic work tree status
reporting) instead, which already tests "deleted by us:". Ideally, you
could add tests for "deleted by them" and "both deleted" in a first
patch, and turn the add/rm into add in the implementation patch.

+	# Unmerged paths:
+	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#
+	#	deleted by us:      main.txt
+	#

To really test the logic, you need to have more than one file in the
list (the logic should say "suggest rm if _at least one_ file may need
it", but currently, a patch implementing "if _all_ files" would pass the
test).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
