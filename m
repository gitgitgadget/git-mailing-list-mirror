From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] Porting builtin/branch.c to use the printing options of ref-filter.{c,h}
Date: Wed, 26 Aug 2015 11:02:18 +0200
Message-ID: <vpqlhcyqv6t.fsf@anie.imag.fr>
References: <CAOLa=ZRpMsFr2p=X+Z7z95W+0wGd9i5XaSDeVSmS-BUFCj6dWw@mail.gmail.com>
	<xmqq4mjnyzfy.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZRZpy8_KGNZL1TahEkOOdQ35e1168pwuCpkxbogRDXNnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 11:02:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUWbM-00042K-Eq
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 11:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582AbbHZJCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 05:02:31 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60266 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951AbbHZJC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 05:02:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t7Q92I5k028788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 26 Aug 2015 11:02:18 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7Q92IhI029451;
	Wed, 26 Aug 2015 11:02:18 +0200
In-Reply-To: <CAOLa=ZRZpy8_KGNZL1TahEkOOdQ35e1168pwuCpkxbogRDXNnw@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 26 Aug 2015 12:09:45 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 26 Aug 2015 11:02:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7Q92I5k028788
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441184538.56727@ZoH1fXPI6vAb9XlrwNA1Iw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276602>

Karthik Nayak <karthik.188@gmail.com> writes:

> It's more than just colors. The whole format changes.
>
> $ git branch -a
> For local:
> "%(if)%(HEAD)%(then)%(HEAD) %(color:green)%(refname:short)%(else)
> %(refname:short)%(end)"
> For remote:
> "  remotes/%(color:red)%(refname:short)%(color:reset)%(if)%(symref)%(then)
> -> %(symref:short)%(end)"

I think both versions are not so different. You have %(if) on one format
strings that would be disabled by construction on the second. For
example, adding %(if)%(HEAD)%(then)%(HEAD) at the start of the
format-string for remotes would be a no-op, right?

And in case a local branch is a symref, "git branch" displays "-> ..."
both for local and for remotes. You just normally don't have local
symref branches other than HEAD, but I tried:

$ git checkout -b branch
$ cat .git/HEAD > .git/refs/heads/symref
$ git branch -a
* branch
  master
  symref -> branch

The only remaining difference I see are the "remotes/" prefix and
colors.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
