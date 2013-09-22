From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-remote-mediawiki: bugfix for pages w/ >500 revisions
Date: Sun, 22 Sep 2013 21:27:04 +0200
Message-ID: <vpqsiwwejxz.fsf@anie.imag.fr>
References: <1379875468-24952-1-git-send-email-benoit.person@gmail.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Benoit Person <benoit.person@gmail.fr>
To: Benoit Person <benoit.person@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 22 21:29:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNpLE-00074Q-Oj
	for gcvg-git-2@plane.gmane.org; Sun, 22 Sep 2013 21:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728Ab3IVT3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Sep 2013 15:29:08 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45711 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752268Ab3IVT3H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Sep 2013 15:29:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r8MJR2Ce007405
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 22 Sep 2013 21:27:02 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VNpJA-0004XX-Da; Sun, 22 Sep 2013 21:27:04 +0200
In-Reply-To: <1379875468-24952-1-git-send-email-benoit.person@gmail.fr>
	(Benoit Person's message of "Sun, 22 Sep 2013 20:44:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 22 Sep 2013 21:28:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8MJR2Ce007405
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1380482882.79713@sIzSMPjUZCMPunEZ53+djQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235170>

Benoit Person <benoit.person@gmail.com> writes:

> Mediawiki introduced a new API for queries w/ more than 500 results in
> version 1.21. That change triggered an infinite loop while cloning a
> mediawiki with such a page.
>
> Fix that while still preserving the old behavior for old APIs.

That would be nice to explain a bit more here. Where did the infinite
loop come from? How does your patch fix it?

> For now, if the tests suite is run without the fix, the new test
> introduces an infinite loop. I am not sure if this should be handled ?
> (a timeout of some kind maybe ?)

If the patch fix this, then it's not a really big problem. The test
failure is an infinite loop. That would be problematic if ran
non-interactively, but I think it's Ok since we only run the testsuite
manually.

> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
> index c9a4805..2d7af57 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -625,6 +625,9 @@ sub fetch_mw_revisions_for_page {
>  		rvstartid => $fetch_from,
>  		rvlimit => 500,
>  		pageids => $id,
> +
> +                # let the mediawiki knows that we support the latest API

s/knows/know/

> +                continue => '',

Indentation with spaces. Please, use tabs.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
