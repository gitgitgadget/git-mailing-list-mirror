From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git add -e: Explicitly specify that patch should have no color
Date: Fri, 19 Jul 2013 10:49:41 +0200
Message-ID: <vpqehavndcq.fsf@anie.imag.fr>
References: <1374188284-27638-1-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 10:49:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V06Nw-0006QC-NN
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 10:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760019Ab3GSItv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 04:49:51 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42062 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759877Ab3GSIts (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 04:49:48 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r6J8nfEU028597
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 19 Jul 2013 10:49:41 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V06Ni-0000YA-5t; Fri, 19 Jul 2013 10:49:42 +0200
In-Reply-To: <1374188284-27638-1-git-send-email-andrew.kw.w@gmail.com> (Andrew
	Wong's message of "Thu, 18 Jul 2013 18:58:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 19 Jul 2013 10:49:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r6J8nfEU028597
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1374828583.81347@rLqbW+YWpisif9SCTy8Idw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230785>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> After this commit:
>     4c7f1819b3c142ace98269a556bc929c80e7c9fd make color.ui default to 'auto'
> the patch file for 'git add -e' receives all the color codes.  This is because
> diffopt.use_color defaults to -1, which causes want_color to now return 'auto'.

Oops, indeed. The code was relying on the user's config not being loaded
(hence color.ui was previously ignored), and now has to explicitely
disable color.

I'm wondering whether there are other instances of this. I checked that
"git format-patch" is not broken, but I hope we did not forget others.

> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -343,6 +343,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
>  
>  	argc = setup_revisions(argc, argv, &rev, NULL);
>  	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
> +	rev.diffopt.use_color = 0;
>  	DIFF_OPT_SET(&rev.diffopt, IGNORE_DIRTY_SUBMODULES);
>  	out = open(file, O_CREAT | O_WRONLY, 0666);
>  	if (out < 0)

Acknowledged-by: Matthieu Moy <Matthieu.Moy@imag.fr>

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
