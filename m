From: Joshua ben Jore <twists@gmail.com>
Subject: Commit ending in \ breaks rebase commitlog parsing
Date: Mon, 5 Jul 2010 13:24:22 -0700
Message-ID: <AANLkTim8BGaTvaBFdNDeQp26hwMCztScZFoIHI00DjkD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 05 22:24:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVsDN-0000wW-DE
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 22:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754343Ab0GEUYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 16:24:24 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36980 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab0GEUYX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 16:24:23 -0400
Received: by vws5 with SMTP id 5so6497056vws.19
        for <git@vger.kernel.org>; Mon, 05 Jul 2010 13:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=ZBh38G2abXGlKHCcQ5WqXGWto5OGYRMBfJbUuoSr2MU=;
        b=wiS2/b34PE4mrDiTU68kAFBjrsng3zxo+/utPTw2mGaKJ9GUg5NtV+ytavNxnazDjW
         /S2k5EEdmdHf9xpDAEFGQgP3+DE/pxesBqzTmV0/wfMBAjYI7l7jgUk4r6iEGacn0nWU
         RvMoaF9iQ6TOe9L+a58ATO45eWlEtvPrH7xUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=X9+7p2iQ07jfkOR3BAFfzDsSykwRbYxi3J1/+miJ9C4m/KjKdTfVOpXDdnZgB5pjtQ
         Bns4EdWoPJFBiqr0YQ3PhyqqHoXsH5GCm7hkHVPQp6JdXfzJBPuo+nfUI6HU2X7tZ3Q8
         pcWyG8urVzB9V9ZWjxRI/kXuSkxw+hJBt/6jU=
Received: by 10.220.159.14 with SMTP id h14mr1805341vcx.255.1278361462854; 
	Mon, 05 Jul 2010 13:24:22 -0700 (PDT)
Received: by 10.220.48.35 with HTTP; Mon, 5 Jul 2010 13:24:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150293>

Hi,
Through typos on my part, I have a commit with a message ending in a \.

    Prefer ! and && to \\not\ and 'and\

The rebase command or something it is using is parsing this
incorrectly and leaving my .git in a "bad" state.

    pick 43d2369 Prefer ! and && to
    ot and 'and8c7ee99 Upgrade to Devel::PPPort-3.19

That should have read:

    pick 43d2369 Perefer ! and && to \\not\ and 'and\
    pick 8c7ee99 Upgrade to Devel::PPPort-3.19

Initially, I started editing my pick list to be proper and was
receiving some strange sort of parsing errors but now am not. I'd
manually edited the backup picklist file in .git as well. For a repro,
I tried the following. This also seems to show up a perhaps related
problem of a commit message consisting of only a single backslash. The
pick list just *drops* the commit, perhaps because some layer thinks
the commit message is empty?

    mkdir slash
    cd slash
    git init

    echo data1 > foo
    git add foo
    git commit -m root
    export PARENT=$(git rev-parse HEAD)

    echo data2 > foo
    git add foo
    git commit -m \\

    echo data3 > foo
    git add foo
    git commit -m next

    git rebase -i $PARENT
    # .git/rebase-merge/git-rebase-todo is now incorrect

Josh
