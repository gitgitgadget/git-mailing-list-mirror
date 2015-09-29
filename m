From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: 2.6.0: Comment in rebase instruction has become too rigid
Date: Tue, 29 Sep 2015 17:05:06 +0200
Message-ID: <vpqr3lhb719.fsf@grenoble-inp.fr>
References: <CAEY4ZpN0C96jU4Tgvqt-hWEviR-sapDoyAv88H+opPSr-cs=mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 17:05:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgwSz-0003Xl-R8
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 17:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756711AbbI2PFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2015 11:05:13 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45451 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756215AbbI2PFL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2015 11:05:11 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8TF540K017001
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 29 Sep 2015 17:05:05 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8TF56jN024675;
	Tue, 29 Sep 2015 17:05:06 +0200
In-Reply-To: <CAEY4ZpN0C96jU4Tgvqt-hWEviR-sapDoyAv88H+opPSr-cs=mg@mail.gmail.com>
	(Nazri Ramliy's message of "Tue, 29 Sep 2015 22:02:37 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 29 Sep 2015 17:05:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8TF540K017001
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444143907.44381@u7kQiRGiDkxqI+x3l7cG2g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278826>

Nazri Ramliy <ayiehere@gmail.com> writes:

> I'd hit that key in my editor that filters the pick instructions add
> inserts the list of the modified files in each commit so that the
> instruction sheet becomes like this:
>
>   pick deadbeef some commit message
>      # M path/to/foo.txt | 15 ++++----------
>   pick cafebabe another commit message
>      # M bar.txt | 2 +-
>
>
> IIRC before git 2.6.0 this worked fine.

Confirmed: Git 2.1.4 accepts this, 2.6 doesn't:

Warning: the command isn't recognized in the following line:
 - # pick dbafac11052a0075233bdcf0b71f54d1503aa82d test

You can fix this with 'git rebase --edit-todo'.
Or you can abort the rebase with 'git rebase --abort'.

I didn't bisect, but I guess this was introduced in the series
introducing this check on the todolist before starting the bisection.

Actually, I think we accepted indented comments by mistake: the
semantics of comments in Git is usually that it must start at the first
column (try an indented # in a commit buffer, it's not a comment). But
since Git accepted it in the past, we should continue accepting it to
avoid breaking the user experience.

No time to send a patch right now, but I will hopefully be able to do
this within the next few days. It should be essentially a s/^ *// before
calling stripspaces.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
