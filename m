From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 2/6] t9001: check email address is in Cc: field
Date: Thu, 09 Jun 2016 07:55:55 +0200
Message-ID: <vpqinxiykgk.fsf@anie.imag.fr>
References: <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
	<20160607140148.23242-1-tom.russello@grenoble-inp.org>
	<20160607140148.23242-3-tom.russello@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	samuel.groot@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	e@80x24.org, aaron@schrab.com, gitster@pobox.com,
	Tom RUSSELLO <tom.ressullo@grenoble-inp.org>
To: Tom Russello <tom.russello@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 07:56:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAswy-0007K4-VY
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 07:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423190AbcFIF4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 01:56:10 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54834 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934052AbcFIF4J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 01:56:09 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u595tsEd016170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 9 Jun 2016 07:55:55 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u595tt8a026211;
	Thu, 9 Jun 2016 07:55:55 +0200
In-Reply-To: <20160607140148.23242-3-tom.russello@grenoble-inp.org> (Tom
	Russello's message of "Tue, 7 Jun 2016 16:01:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Thu, 09 Jun 2016 07:55:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u595tsEd016170
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1466056558.48616@EDoC287ysXursaQzFmyBig
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296869>

Tom Russello <tom.russello@grenoble-inp.org> writes:

> Check if the given utf-8 email address is in the Cc: field.

I wouldn't harm to explain what was the problem with existing code here.
If I understand correctly, that would be:

  Existing code just checked that the address appeared in a line starting
  with a space, but not to which field the address belonged.

But probably the real motivation for this was that you want to introduce
code that changes the layout and breaks this "address appears on a line
starting with space"?

> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -888,8 +888,8 @@ test_expect_success $PREREQ 'utf8 Cc is rfc2047 encoded' '
>  	--to=nobody@example.com \
>  	--smtp-server="$(pwd)/fake.sendmail" \
>  	outdir/*.patch &&
> -	grep "^	" msgtxt1 |
> -	grep "=?UTF-8?q?=C3=A0=C3=A9=C3=AC=C3=B6=C3=BA?= <utf8@example.com>"
> +	cc_adr=$(awk "/^Cc: /{flag=1}/^Subject: /{flag=0} flag {print}" msgtxt1) &&
> +	echo "$cc_adr" | grep "=?UTF-8?q?=C3=A0=C3=A9=C3=AC=C3=B6=C3=BA?= <utf8@example.com>"
>  '
>  
>  test_expect_success $PREREQ '--compose adds MIME for utf8 body' '

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
