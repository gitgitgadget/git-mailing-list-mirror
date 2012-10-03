From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 03 Oct 2012 13:07:39 +0200
Message-ID: <vpqvcer4xvo.fsf@grenoble-inp.fr>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<7vhaqc7in6.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
	<90464C79DA97415C9D66846A77ECAA4A@PhilipOakley>
	<CAB9Jk9ARWnE-cWVjqMUFiua21QjqGEX3VhYjKQMBSotVYXXK1Q@mail.gmail.com>
	<vpq626s6kwu.fsf@grenoble-inp.fr>
	<CAB9Jk9DFb2s4s00yCNUytxFdrOQKPEKZGsXpKzwZDo5WAOdXaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 13:08:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJMo0-0000l1-Nz
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 13:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537Ab2JCLHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 07:07:47 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36878 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386Ab2JCLHq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 07:07:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q93B2AC4025783
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 3 Oct 2012 13:02:10 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TJMnk-0000mu-4U; Wed, 03 Oct 2012 13:07:40 +0200
In-Reply-To: <CAB9Jk9DFb2s4s00yCNUytxFdrOQKPEKZGsXpKzwZDo5WAOdXaQ@mail.gmail.com>
	(Angelo Borsotti's message of "Wed, 3 Oct 2012 10:24:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 03 Oct 2012 13:02:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q93B2AC4025783
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1349866931.75764@9kiDFbyS5XdgJdjiFqNz6w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206878>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

>> You still didn't tell us where the problem was.
>
> I described it few mails above. I wanted to create an orphan branch.

And you did. The branch happens to point to the same commit as another
existing commit, but this is a very common situation. Try this:

# do arbitrary hacking and commit on branch master
git checkout -b new-branch
gitk

You will see branches "master" and "new-branch" pointing to the same
commit (but you HEAD points to new-branch, as "git branch" will tell
you).

You still did not describe a _problem_. Up to now, the only "problem" I
see is that you have twice the same sha1 showing up, but you did not
describe somethine concrete that you wanted to do and did not work.

> However, the branch is not actually created until a commit is done on
> it.

Right, but the definition of "done" in your sentence includes "reusing
an object in the object database".

I just tried this:

rm -fr test
git init test
cd test
date > foo.txt
git add .
git commit --allow-empty -m foo
git checkout --orphan new-branch
git commit --allow-empty -m foo

I ended up with a branch "master" and a branch "new-branch", both
pointing to the same commit. The new branch _is_ created.

(BTW, --allow-empty is useless here as you have no parent)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
