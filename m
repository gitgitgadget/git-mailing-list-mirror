From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/2] Make it easy to use branch --track on existing branch
Date: Sun, 17 Jan 2010 15:06:50 +0100
Message-ID: <1263737212-8101-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 17 15:07:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWVme-0002xq-PN
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 15:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342Ab0AQOHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 09:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753169Ab0AQOHH
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 09:07:07 -0500
Received: from mx2.imag.fr ([129.88.30.17]:37810 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753110Ab0AQOHG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 09:07:06 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o0HE6OLH016772
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 17 Jan 2010 15:06:24 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NWVmL-0005ia-9e; Sun, 17 Jan 2010 15:06:57 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NWVmL-00028C-8a; Sun, 17 Jan 2010 15:06:57 +0100
X-Mailer: git-send-email 1.6.6.198.gbaea2
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 17 Jan 2010 15:06:25 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o0HE6OLH016772
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1264341985.52034@ZLNIFBIIkEITMPrRofhU0g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm starting a new thread to avoid hiding the message in another one,
but this is a followup to a message in the "git push --track" thread:

http://article.gmane.org/gmane.comp.version-control.git/137066

I wrote:
> Junio C Hamano <gitster <at> pobox.com> writes:
> 
> > The small nit is that "branch -f --track me origin/me" will happily
> > overwrite "me", even when your "me" is not up to date with "origin/me",
> > losing commits.
> 
> And another issue is:
> 
> $ git branch -f --track my-branch origin/my-branch
> fatal: Cannot force update the current branch.
> $ git branch --track my-branch origin/my-branch
> fatal: A branch named 'my-branch' already exists.
> 
> Actually, I just can't find a natural set of commands doing:
> 
> 1. create a branch (git checkout -b)
> 2. work on it
> 3. send it upstream (git push)
> 4. set the upstream as tracking (???)
> 
> with the current version of Git. I just do 4. with $EDITOR
> .git/config ...

The first patch makes it possible to use branch --track on an existing
branch (checked-out or not, regardless of -f), and the second warns on
a newly introduced irrelevant case.

This should be a nice complement to "push --set-upstream". I think
"push --set-upstream" is the most natural in 99% of cases, but using
"git branch" should work too.

Matthieu Moy (2):
  branch: allow creating a branch with same name and same starting
    point.
  branch: warn and refuse to set a branch as a tracking branch of
    itself.

 branch.c                 |   59 ++++++++++++++++++++++++++++++++-------------
 t/t6040-tracking-info.sh |    8 ++++++
 2 files changed, 50 insertions(+), 17 deletions(-)
