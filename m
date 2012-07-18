From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Wed, 18 Jul 2012 09:52:32 +0200
Message-ID: <vpqobndld4v.fsf@bauges.imag.fr>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Jul 18 09:52:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrP3r-0005Tg-WD
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 09:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871Ab2GRHwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 03:52:40 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39851 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999Ab2GRHwi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 03:52:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6I7oqnX029669
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 18 Jul 2012 09:50:52 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SrP3g-000159-Tp; Wed, 18 Jul 2012 09:52:32 +0200
In-Reply-To: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu>
	(mhagger@alum.mit.edu's message of "Sat, 14 Jul 2012 08:59:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 18 Jul 2012 09:50:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6I7oqnX029669
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343202654.42126@QVMAuZeEr5DBPBYqN3Oasw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201668>

mhagger@alum.mit.edu writes:

> * One email per commit [1].  For each reference change, the script
>   first emits one email summarizing the reference change (including
>   one-line summaries of the new commits), then emits a separate email
>   for each new commit that was introduced, including patches.

I have a dirty hack to do that on my private repositories (instead of
sending mail on receive, the script runs as a cron job, does a "git
fetch" on each repo on my machine, and sends me patches for new commits
with "git send-email"). I had several problems with it:

* Binary content was sometimes embedded in the patch. It's cool that
  "git send-email" can base64-encode content when I send a patch to
  someone, but it's counter-productive when used for code review. So, I
  used "git format-patch --no-binary".

* Even with that, I sometimes had overly long lines (e.g. non-text files
  that were shown as a one long line, I don't remember exactly the
  use-case, probably postscript files or so) that were confusing my
  mailer. So, I added

    # Truncate long lines
    perl -pi -e 's/^(.{500}).*/$1 [...]/' $patches

  to my script to truncate them.

You probably want to test these cases, and allow (configurably) the user
to do some cleanup on patches before they are sent.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
