From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git should not use a default user.email config value
Date: Tue, 13 Aug 2013 10:29:14 +0200
Message-ID: <vpqwqnqgfj9.fsf@anie.imag.fr>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
	<20130809194214.GV14690@google.com>
	<Pine.BSM.4.64L.1308091956060.28970@herc.mirbsd.org>
	<CAMP44s1SxSd-cM_P-JL2+skB6mDmar_QwFv9mYp5BrXUKTz61w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thorsten Glaser <tg@mirbsd.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 13 10:29:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V99zA-0004Sh-U5
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 10:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430Ab3HMI3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 04:29:44 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51504 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751122Ab3HMI3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 04:29:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7D8TD7S026517
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 13 Aug 2013 10:29:13 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V99yc-0007wC-MS; Tue, 13 Aug 2013 10:29:14 +0200
In-Reply-To: <CAMP44s1SxSd-cM_P-JL2+skB6mDmar_QwFv9mYp5BrXUKTz61w@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 9 Aug 2013 15:30:17 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 13 Aug 2013 10:29:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7D8TD7S026517
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1376987357.81751@YBgxUtq4iL+9x0fGKNpsiA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232217>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This is how to implement that:
>
> From f1feaa05ce3772d8006078c4aeabcbd55b52d58e Mon Sep 17 00:00:00 2001
> From: Felipe Contreras 2nd <felipe.contreras+2@gmail.com>
> Date: Tue, 13 Nov 2012 07:33:12 +0100
> Subject: [PATCH] ident: don't allow implicit email addresses
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  ident.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/ident.c b/ident.c
> index 1c123e6..85fc729 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -301,9 +301,9 @@ const char *fmt_ident(const char *name, const char *email,
>  	}
>
>  	if (strict && email == git_default_email.buf &&
> -	    strstr(email, "(none)")) {
> +		!(user_ident_explicitly_given & IDENT_MAIL_GIVEN)) {
>  		fputs(env_hint, stderr);
> -		die("unable to auto-detect email address (got '%s')", email);
> +		die("no explicit email address");
>  	}
>
>  	if (want_date) {

That's a first step, but something should also be done in
builtin/commit.c, which currently displays a detailed warning
(implicit_ident_advice) /after/ performing the commit. I think your
patch would turn this warning into dead code.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
