From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] config.c: change the function signature of `git_config_string()`
Date: Tue, 22 Jul 2014 13:44:48 +0200
Message-ID: <vpqsiltsjm7.fsf@anie.imag.fr>
References: <1406026196-17877-1-git-send-email-tanayabh@gmail.com>
	<20140722110720.GA386@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 22 13:45:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9YVc-0002Fo-9F
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 13:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025AbaGVLpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 07:45:23 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46255 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191AbaGVLpX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 07:45:23 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6MBilJ3025325
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 Jul 2014 13:44:47 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6MBimtW006557;
	Tue, 22 Jul 2014 13:44:48 +0200
In-Reply-To: <20140722110720.GA386@peff.net> (Jeff King's message of "Tue, 22
	Jul 2014 07:07:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 22 Jul 2014 13:44:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6MBilJ3025325
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406634288.16541@ZkytFUwGlyAsd5u0Vvds9w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254015>

Jeff King <peff@peff.net> writes:

> will complain that we are passing a pointer to "const char *", not a
> pointer to "char *". And indeed, compiling with your patch introduces a
> ton of compiler warnings.

Tanay: are you not compiling with gcc -Wall -Werror?

(see my earlier message, just create a file config.mak containing

  CFLAGS += -Wdeclaration-after-statement -Wall -Werror

)

> We would have to convert each of the variables we pass to it to:
>
>   static char *some_global;

OK, it seems I got convinced too quickly by Junio ;-). The function
produces a char * that can be modified, but it also receives a value,
and the function should keep the "const" to allow passing "const char
*".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
