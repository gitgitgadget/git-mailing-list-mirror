From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Recovering from repository corruption
Date: Tue, 10 Jun 2008 10:55:52 -0700 (PDT)
Message-ID: <m3abhtp42o.fsf@localhost.localdomain>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Denis Bueno" <dbueno@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 19:56:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K685S-000722-EH
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 19:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbYFJRz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 13:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752815AbYFJRz4
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 13:55:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:19389 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbYFJRzz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 13:55:55 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1864294fgg.17
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 10:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=uCGimSV03sqbw4nHolLhCrXbROQ+ht/rWiDx/E6Jups=;
        b=C8z/s5uo76nsSRHTD+TlStLzNSobYM5yrw6mziolKgME7un7KsKs/trPSmV/EAf4HC
         mDt5T1raCZwMzV/+d9walG8STmJPe9RuGtH8j0WR2TioRFk/P0lXWP7jSgZBm9XYWjPk
         /XBBCs7hwWhbd3ubSayByVOe8z74WQgG11z4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Pj26yM7BxERF5QN9lOhWqwzW2kN2U7q51w6u5a7O8xRf4ZapEY66Ge0Ohi5pPSVlcq
         1GAH+ntmZ/WlD28dngGEFHK57YKoL1+8yAxCFO53Gp9bYDuc/oCBjpVuErJ3xK/Q0WVZ
         gm6yU6T17zyNW0jdob6yTx2UuFPO7LyJ3dna8=
Received: by 10.86.98.14 with SMTP id v14mr6012447fgb.74.1213120553611;
        Tue, 10 Jun 2008 10:55:53 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.192.165])
        by mx.google.com with ESMTPS id e11sm13612502fga.4.2008.06.10.10.55.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Jun 2008 10:55:52 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5AHti6R032376;
	Tue, 10 Jun 2008 19:55:44 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5AHtir0032373;
	Tue, 10 Jun 2008 19:55:44 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84533>

"Denis Bueno" <dbueno@gmail.com> writes:

> I was told in the thread above that I could use grafts and "git
> filter-branch" to create a new repository that simply got rid of the
> offending object.  That case was simpler, as it was the initial import
> of a file that had only two commits total that was corrupted.
> However, in this case there are changes between the initial and latest
> version of the file, and commits between the corrupted versions, so, I
> can imagine that it would be hard to get rid of in-between commits.
> 
> The thing that makes sense intuitively (read: not as a Git expert, but
> as a user) is to just let me replace the commits associated with the
> problematic objects with new versions of those commits (e.g. make
> change described in the commit message, which is different from the
> actual change that was recorded, due to whitespace/formatting issues).
>  Is this what I should do?  And to do so, should I be reading chapter
> 5 of the manual?

Without checking Git User's Manual, I think the solution could go as
the following.

Assume that history looks like this

    ...---.---a---*---b---.---...

where by '*' is marked corruped commit (commit shich tree contains
corrupted blobs).

First, you can check the commit message for '*' using git-cat-file or
git-show, you can get the difference between 'a' and 'b' using 
"git diff a b".  When you know how repaired commit 'X' should look
like, do something like:

  $ git checkout -b <temp-branch> 'a'
  $ <edit edit edit>
  $ git commit

Then history would look like this

    ...---.---a---*---b---.---...
               \
                \-X

Now with grafts make 'b' be a child of 'X', i.e. modify parent of 'b'
for history to look like below:

    ...---.---a---*   b---.---...
               \     /
                \-X-/

Examine history using git-log, git-show, check tree with git-ls-tree
and examining files, use graphical history browser like gitk.

Then if possible use git-filter-branch to make history recorded in
grafts file permanent...

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
