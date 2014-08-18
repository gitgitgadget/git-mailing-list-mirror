From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] make config --add behave correctly for empty and NULL values
Date: Mon, 18 Aug 2014 14:33:51 +0200
Message-ID: <vpq61hqc6z4.fsf@anie.imag.fr>
References: <1408357077-4745-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 14:33:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJM8N-0004RN-7h
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 14:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbaHRMdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 08:33:55 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34144 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751284AbaHRMdy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 08:33:54 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s7ICXncx019467
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 18 Aug 2014 14:33:49 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s7ICXp1A007783;
	Mon, 18 Aug 2014 14:33:51 +0200
In-Reply-To: <1408357077-4745-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 18 Aug 2014 03:17:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 18 Aug 2014 14:33:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s7ICXncx019467
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1408970029.62105@h4Kb/+X+h2lZMrJl3vE87A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255386>

Tanay Abhra <tanayabh@gmail.com> writes:

> Currently if we have a config file like,
> [foo]
>         baz
>         bar =
>
> and we try something like, "git config --add foo.baz roll", Git will
> segfault. Moreover, for "git config --add foo.bar roll", it will
> overwrite the original value instead of appending after the existing
> empty value.
>
> The problem lies with the regexp used for simulating --add in
> `git_config_set_multivar_in_file()`, "^$", which in ideal case should
> not match with any string but is true for empty strings. Instead use a
> regexp like "a^" which can not be true for any string, empty or not.
>
> For removing the segfault add a check for NULL values in `matches()` in
> config.c.

I would have prefered two separate patches (or even better, 3, the first
one being "demonstrate failure of ..." with test_expect_failure) for
each issues.

But the fixes are straightforward, and the test actually test what it
has to test, so I think we can keep the patch as-is.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
