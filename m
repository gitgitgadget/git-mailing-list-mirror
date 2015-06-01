From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] solving a bug with hunks starting at line 1 in git apply
Date: Mon, 01 Jun 2015 20:00:46 +0200
Message-ID: <vpqa8wj48c1.fsf@anie.imag.fr>
References: <87k2vnqrv8.fsf@ensimag.grenoble-inp.fr>
	<xmqqiob773iy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 20:01:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzU1J-0003Im-P9
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 20:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752935AbbFASBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 14:01:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44893 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752850AbbFASA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 14:00:59 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t51I0itP019800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Jun 2015 20:00:44 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t51I0ksh024945;
	Mon, 1 Jun 2015 20:00:46 +0200
In-Reply-To: <xmqqiob773iy.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 01 Jun 2015 10:16:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 01 Jun 2015 20:00:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t51I0itP019800
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433786447.61982@+utlpdTpgQtmjaAHr7mrag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270450>

Junio C Hamano <gitster@pobox.com> writes:

> Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr> writes:
>
>> first original file:
>>
>> 10
>> 20
>> 30
>> 40
>>
>> for the following diff file:
>>
>> @@ -1,2 +1,2 @@
>>  20
>> -30
>> +35
>>  40
>>
>> The patch will not be applied with a git apply command, but it will
>> with a basic patch command.
>
> Doesn't that merely indicate a bug in "patch", though?

No, it's just that patch does a fuzzy match in this case:

$ patch < patch.diff 
patching file pre.txt
Hunk #1 succeeded at 2 with fuzz 1 (offset 1 line).

It's different from the other case:

Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> @@ -1,1 +1,2 @@
> +5
>  10
> @@ -1,3 +2,3 @@
>  10
> +15
> -20
>  30

With this one, I get:

$ git apply < p2.diff   
error: patch failed: pre.txt:1
error: pre.txt: patch does not apply
$ patch < p2.diff 
patching file pre.txt

=> no fuzzy matching for patch, git apply should actually work.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
