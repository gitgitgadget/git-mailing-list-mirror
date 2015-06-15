From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 7/7] bisect: allows any terms set by user
Date: Mon, 15 Jun 2015 10:52:57 +0200
Message-ID: <vpq8ubl73py.fsf@anie.imag.fr>
References: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433962918-6536-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<vpqy4jq2rjr.fsf@anie.imag.fr>
	<323480549.485629.1434310820944.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 15 10:53:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4Q8o-0005nY-67
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 10:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123AbbFOIxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 04:53:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54563 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168AbbFOIxE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 04:53:04 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5F8quCU030855
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Jun 2015 10:52:57 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5F8qwxJ011144;
	Mon, 15 Jun 2015 10:52:58 +0200
In-Reply-To: <323480549.485629.1434310820944.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Antoine Delaite's message of "Sun, 14 Jun 2015 21:40:20 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 15 Jun 2015 10:52:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5F8quCU030855
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434963179.91473@2wyChBWbEc7zEz6oIUUVqw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271665>

Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>>> +        if test -s "$GIT_DIR/TERMS_DEFINED"
>>> +        then
>>> +                terms_defined=1
>>> +                get_terms
>>> +                rm -rf "$GIT_DIR/TERMS_DEFINED"
>>
>>I don't understand why you need to delete this file. I did not review
>>thoroughly so there may be a reason, but you can help the reader with a
>>comment here.
>
> I will just complete Louis' answer. We delete it with backward
> compatibility with old/new in mind (even if old/new is not merged yet).
> For instance, after a old/new mode, if you do a 'bisect start rev1 rev2'
> the mode would be bad/good ie the default mode. So if you defined your
> terms, we decided it would only be for the following bisection.

I would say "for the current bisection", i.e.

$ git bisect start
$ git bisect terms foo bar # Scope starts here
...
The first 'bar' commit is deadbeef. # Scope ends here

$ git bisect terms foo bar
You need to start by "git bisect start"
Do you want me to do it for you [Y/n]?

> The next 'bisect start rev1 rev2' would be in bad/good mode. But this
> have to be discuted, do the user have to type 'git bisect terms' each
> bisection if he wants to use special terms ?

To me, yes. If we allow arbitrary terms, then they will most likely be
specific to one bisect session (e.g. if I bisect "present/absent" once,
it tells me nothing about what I'll want for my next bisection).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
