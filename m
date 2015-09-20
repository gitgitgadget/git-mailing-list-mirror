From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 0/8] port the filtering part of branch.c to use ref-filter APIs
Date: Sun, 20 Sep 2015 21:00:08 +0200
Message-ID: <vpqwpvkgblz.fsf@anie.imag.fr>
References: <1442772627-25421-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 20 21:00:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdjqY-0004Me-FG
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 21:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219AbbITTAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2015 15:00:15 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42378 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755196AbbITTAO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2015 15:00:14 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8KJ065b005233
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 20 Sep 2015 21:00:06 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8KJ08sC009244;
	Sun, 20 Sep 2015 21:00:08 +0200
In-Reply-To: <1442772627-25421-1-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sun, 20 Sep 2015 23:40:19 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 20 Sep 2015 21:00:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8KJ065b005233
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443380407.22723@kxgXJoM00BoGZtE8HL1e5g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278258>

Karthik Nayak <karthik.188@gmail.com> writes:

> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -145,8 +145,8 @@ EOF
>  
>  test_expect_success 'git branch `--sort` option' '
>  	cat >expect <<-\EOF &&
> -	* (HEAD detached from fromtag)
>  	  branch-two
> +	* (HEAD detached from fromtag)
>  	  branch-one
>  	  master
>  	EOF

I thought this was obviously wrong, but this tests uses
--sort=objectsize, so it's OK. Indeed, HEAD and branch-one have
objectsize=215, and branch-two has objectsize=167.

So, the previous code was hardcoding "detached HEAD always comes first",
but we now sort the whole list, including detached HEAD, so branch-two
comes first.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
