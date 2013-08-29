From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: the pager
Date: Thu, 29 Aug 2013 17:55:29 +0200
Message-ID: <vpqsixsv6dq.fsf@anie.imag.fr>
References: <201308261957.r7QJvfjF028935@freeze.ariadne.com>
	<xmqqd2ozhhob.fsf@gitster.dls.corp.google.com>
	<201308281819.r7SIJmnh025977@freeze.ariadne.com>
	<xmqqr4dd8suz.fsf@gitster.dls.corp.google.com>
	<201308291541.r7TFfuJr023110@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: worley@alum.mit.edu (Dale R. Worley)
X-From: git-owner@vger.kernel.org Thu Aug 29 17:57:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF4b4-0004oY-Os
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 17:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754814Ab3H2P5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 11:57:18 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52489 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754082Ab3H2P5S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 11:57:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7TFtSb4015548
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Aug 2013 17:55:28 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VF4ZG-0001fu-1a; Thu, 29 Aug 2013 17:55:30 +0200
In-Reply-To: <201308291541.r7TFfuJr023110@freeze.ariadne.com> (Dale R.
	Worley's message of "Thu, 29 Aug 2013 11:41:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 29 Aug 2013 17:55:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7TFtSb4015548
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378396532.95524@0JLscdcJp8W2rZc0bHzjZA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233281>

worley@alum.mit.edu (Dale R. Worley) writes:

>     const char *git_pager(int stdout_is_tty)
>     {
>             const char *pager;
>
>             if (!stdout_is_tty)
>                     return NULL;
>
>             pager = getenv("GIT_PAGER");
>             if (!pager) {
>                     if (!pager_program)
>                             git_config(git_default_config, NULL);
>                     pager = pager_program;
>             }
>             if (!pager)
>                     pager = getenv("PAGER");
>             if (!pager)
>                     pager = DEFAULT_PAGER;
>             else if (!*pager || !strcmp(pager, "cat"))
>                     pager = NULL;

I guess the "else" could and should be dropped. If you do so (and
possibly insert a blank line between the DEFAULT_PAGER case and the
"pager = NULL" case), you get a nice pattern

if (!pager)
	try_something();
if (!pager)
	try_next_option();
...

> Commenting your code is what you learn first in programming.

Not commenting too much is the second thing you learn ;-).

I agree that a comment like this would help, though:

--- a/cache.h
+++ b/cache.h
@@ -1266,7 +1266,7 @@ static inline ssize_t write_str_in_full(int fd, const char *str)
 
 /* pager.c */
 extern void setup_pager(void);
-extern const char *pager_program;
+extern const char *pager_program; /* value read from git_config() */
 extern int pager_in_use(void);
 extern int pager_use_color;
 extern int term_columns(void);


-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
