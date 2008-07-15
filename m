From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: git stash save --keep-index
Date: Tue, 15 Jul 2008 14:31:54 +0200
Message-ID: <bd6139dc0807150531k4f0a1a4yee2c8ec2b98ee39c@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailinglist" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 14:33:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIjiF-0001Bv-Ol
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 14:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755961AbYGOMbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 08:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756118AbYGOMbz
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 08:31:55 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:5894 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755726AbYGOMby (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 08:31:54 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5328460wfd.4
        for <git@vger.kernel.org>; Tue, 15 Jul 2008 05:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=3+Kl4PpjBUK7zMBFRBkhuWoAz5dpSz/Rg7XXEISVDgI=;
        b=Hnu+6j80Fp9Q8t5Kn7tO9DbXu06lyI95oQVkX4U5jj15v9Yw7idd0HGGxQtg9+dj2l
         uI8Z/AhLBx0dsoOnDEJiXBaLz4du/nvsmTNq0mbJcv14x6qxe0yiYujQ+sXshgq22S+o
         mT5OVxOfs65OcT/XnV22PMUyBdttFgwsfPzRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=X694/CJiRxGPLjFOJTpA0+KcSSB5jLRjd7fuVZH96MxOF/qXJ4ia8HQyfE87dhUWik
         zs2gzhZGFcYxVnAOWB8TtT7Cvmgs90lTjc/2v0m5fxRFx5aFdqm1/uTts5tZJQVU4fSG
         +/qrLthws/SeZV2xiqApkD3K1KIefi7Qjl03s=
Received: by 10.142.11.2 with SMTP id 2mr4639323wfk.307.1216125114161;
        Tue, 15 Jul 2008 05:31:54 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Tue, 15 Jul 2008 05:31:54 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88553>

Heya,

I have switched to using next/ recently and have had the chance to try
out the new '--keep-index' option to 'git stash'. I must say that 'git
stash save --keep-index' in combination with 'git add -p' followed by
'e' allows for a really nice workflow where I can split up patches
very easily, and test them before committing anything. IIUC the
'--keep-index' option was added as a response to the request to
support a workflow something like this:
<hack hack hack>
$ git add # or -i / -p
$ git stash save --keep-index
<test if staged changes are ready to be commited>
$ git commit
$ git stash pop
<lather, rinse, repeat>

But what happens if in the testing phase you detect that the commit is
not ready yet, or even, some of the changes you staged should have
been kept? It would make sense to 'undo' the stash the usual way:
$ git stash pop
But alas, it is not possible to apply on a dirty working directory, so
one has to resort to:
$ git commit -m "tmp"
$ git stash pop
$ git reset HEAD^
Nothing too bad surely, but I thought that the '--keep-index' option
was exactly to prevent having to do:
<hack hack hack>
$ git add # or -i / -p
$ git commit -m "tmp"
$ git stash save
<test if now committed changes were indeed ready to be comitted>
So the '--keep-index' option eliminates the need for such a temporary
commit in the (hopefully) common case where the selected changes were
indeed good, but we still need it in the case that the changes were
not ready / need something from the stashed changes.

Am I missing something here? Or is the only/best solution here to just
alias 'git commit -m "tmp" && git stash pop && git reset HEAD^' to
'git undo-stash'?

PS: It'd be nice if I could do 'git stash --keep-index' since I"m used
to 'git stash' automagically defaulting to 'git stash save'.

-- 
Cheers,

Sverre Rabbelier
