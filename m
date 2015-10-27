From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 2/2] sh-setup: explicitly mark CR as a field separator
Date: Tue, 27 Oct 2015 11:01:00 +0100
Message-ID: <vpqd1w07hr7.fsf@grenoble-inp.fr>
References: <cover.1445777347.git.johannes.schindelin@gmx.de>
	<cover.1445782122.git.johannes.schindelin@gmx.de>
	<2b089201404299257f23b3931499ea16202f0f65.1445782122.git.johannes.schindelin@gmx.de>
	<vpqlhaqas8g.fsf@grenoble-inp.fr>
	<xmqq8u6piir8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Chad Boles <chadbo@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 11:01:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr14a-0003Yo-DO
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 11:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbbJ0KBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 06:01:40 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57012 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654AbbJ0KBj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 06:01:39 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t9RA0xNt015833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 27 Oct 2015 11:01:00 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9RA10CL010148;
	Tue, 27 Oct 2015 11:01:00 +0100
In-Reply-To: <xmqq8u6piir8.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 26 Oct 2015 11:31:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 27 Oct 2015 11:01:00 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9RA0xNt015833
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1446544860.84664@KVT3jyOLNIDBNSzRfmGYbA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280257>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>
>>> This is the correct thing to do, really: we already specify LF as
>>> field separator.
>>
>> I'm almost convinced that this is the right thing to do in the long run
>> ("almost" because I'm not sure, not because I have arguments against). I
>> agree with Junio that the commit message should be more convincing, but
>> indeed, accepting LF and not CR is strange.
>
> If there were a single character that denotes CRLF, I'd say that
> including such a character in IFS would make sense on a system with
> CRLF EOL convention.  But that is not the case.

It's not, but there are platforms where the newline convention is
CR-only. AFAIK, they are all "old" architectures (like Mac OS < X), but
there are still CR-only files lying around.

>  * read is not the only user of IFS.  Expressing "list of things"
>    (pre bashism "shell array" days) by concatenating elements into a
>    single string variable, separated with LF, and later iterating
>    over them is a very common use case, e.g.
>
> 	LF='
>         '
> 	list="$thing1"
> 	list="$list$LF$thing2"
> 	list="$list$LF$thing3"
>         ...
>
> 	IFS=$LF
> 	for thing in $list
>         do
>         	...
>
>    And including LF by default in IFS, especially when "things" can
>    contain SP/HT, is handy.

I don't get the argument. You're talking about a case where you
explicitly set IFS, and the patch is about changing the default. The
use-case above would work exactly like before if we modify the default
IFS.

> If you
> have a variable in which "A^MB" is there, "set $variable" would
> split them into two and assign B to $2, which is not what the
> scripts would expect.

The same goes if you replace ^M with a tab or a space. Using unquoted
"set $variable" is sane only if you are sure that $variable does not
contain unexpected special characters. I can't imagine a case where one
would accept space, tab or LF as separator and would need to accept CR
as a non-separator.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
