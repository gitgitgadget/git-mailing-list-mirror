From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v1] travis-ci: build documentation
Date: Mon, 25 Apr 2016 11:37:26 +0200
Message-ID: <vpq8u02yqp5.fsf@anie.imag.fr>
References: <1461314042-3132-1-git-send-email-larsxschneider@gmail.com>
	<vpq37qeovu4.fsf@anie.imag.fr>
	<E752A0BF-92D9-4BCF-ADD2-94F8E7BD66F2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 11:37:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aucxa-0005Yr-87
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 11:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123AbcDYJhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 05:37:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57533 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754087AbcDYJhi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 05:37:38 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u3P9bQK2025800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 25 Apr 2016 11:37:26 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u3P9bQK4010466;
	Mon, 25 Apr 2016 11:37:26 +0200
In-Reply-To: <E752A0BF-92D9-4BCF-ADD2-94F8E7BD66F2@gmail.com> (Lars
	Schneider's message of "Mon, 25 Apr 2016 10:17:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 25 Apr 2016 11:37:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u3P9bQK2025800
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1462181847.44735@Jhzirus+nQgd/LaOiISyXg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292463>

Lars Schneider <larsxschneider@gmail.com> writes:

> On 22 Apr 2016, at 11:07, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>
>> The ; or the newline is not needed either.
> Unfortunately it seems to be required. Travis CI generates a shell script
> out of the yml file and I think they don't respect newlines or something...

OK.

>>> +          then
>>> +          echo ""
>>> +          echo "------------------------------------------------------------------------" &&
>> 
>> I usualy avoid "echo <something-starting-with-dash>" as I'm not sure how
>> portable it is across variants of "echo". Maybe this one is portable
>> enough, I don't know. Perhaps printf, or cat << EOF ...?
> I am curious. Do you have an example on what platform echo "-something" 
> could go wrong? I wasn't aware of such an issue.

echo can, but doesn't have to implement non-POSIX options. For example,

  $ dash -c 'echo -e foo'
  -e foo
  $ bash -c 'echo -e foo'
  foo

This is a good reason to avoid

  echo "$string"

if $string is a user-supplied string.

I don't know if any shell have issue with --------, but I wouldn't be
surprised if some implementation complained with "invalid option
---------".

But it is also likely that I'm the one being paranoid and your code is
fine ;-).

>> test -s Documentation/git.html &&
>> test -s Documentation/git.1
> Great idea. Added to v2! The && is not necessary as Travis runs this script with "set -e".

Maybe I'm doing too much Python, but "explicit is better than
implicit" ;-). I'd keep the && in case someone ever moves the code to a
script that doesn't have -e, but I'm really nit-picking here ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
