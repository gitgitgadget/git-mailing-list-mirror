From: "Denis Bueno" <dbueno@gmail.com>
Subject: Re: Recovering from repository corruption
Date: Tue, 10 Jun 2008 15:38:09 -0400
Message-ID: <6dbd4d000806101238v2bb975abqd39916e45d4bf866@mail.gmail.com>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>
	 <m3abhtp42o.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 21:39:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K69gS-0006QG-Fi
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 21:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757AbYFJTiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 15:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753826AbYFJTiO
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 15:38:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:1754 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644AbYFJTiN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 15:38:13 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1892208fgg.17
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 12:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FypXT1ZrQxDkxiZh2kd7/NHTct4j/jkq3qTjFGwELHI=;
        b=dLaYcPlpLOI9COPqrTSGJl0b/ISqHKsh5DO7ItRUt3AE2mTjxxEaKgItF+mZikoiRK
         KPmtGtuOTactTmvIp+uiEPMjDkTAapGSNKgQBAZYsjtMOUxSPzvDuo2Xkl3KAh5EywMu
         x6CDTbMeXvaEfiIx82Lhk02/WHb0/4Di1DGYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cTWGqLQiKbd1/BjBsGFN2wCSYjC5/xCjwo4F5XfXM5KL02q8vgeUKV3fOhqBhvN61q
         F2gKhUEC2EsDtNHt8pJ9PjrVxVSC4j9XCu5JMAHA2F7HBoA38Kfk3vrG8soIMIYx5+mR
         jLw7HvDX8oRob5JBwhqV6h6gC5ve5YJ0Mnh0Q=
Received: by 10.86.72.3 with SMTP id u3mr1102042fga.35.1213126689496;
        Tue, 10 Jun 2008 12:38:09 -0700 (PDT)
Received: by 10.86.59.7 with HTTP; Tue, 10 Jun 2008 12:38:09 -0700 (PDT)
In-Reply-To: <m3abhtp42o.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84536>

On Tue, Jun 10, 2008 at 13:55, Jakub Narebski <jnareb@gmail.com> wrote:
> Assume that history looks like this
>
>    ...---.---a---*---b---.---...
>
> where by '*' is marked corruped commit (commit shich tree contains
> corrupted blobs).
>
> First, you can check the commit message for '*' using git-cat-file or
> git-show, you can get the difference between 'a' and 'b' using
> "git diff a b".  When you know how repaired commit 'X' should look
> like, do something like:
>
>  $ git checkout -b <temp-branch> 'a'
>  $ <edit edit edit>
>  $ git commit
>
> Then history would look like this
>
>    ...---.---a---*---b---.---...
>               \
>                \-X
>
> Now with grafts make 'b' be a child of 'X', i.e. modify parent of 'b'
> for history to look like below:
>
>    ...---.---a---*   b---.---...
>               \     /
>                \-X-/
>
> Examine history using git-log, git-show, check tree with git-ls-tree
> and examining files, use graphical history browser like gitk.
>
> Then if possible use git-filter-branch to make history recorded in
> grafts file permanent...
>
> HTH
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
>

Thanks for the help.

My situation was:

    ...---a---*---b---c---d---*---e---...

Following your example, I believe I got this to:

    ...---a---*   b---c---d---*   e---...
           \     /         \     /
            \-X-/           \---/

That is, I replaced the first problematic commit and deleted the
second, since I forgot how I changed 'd' to get that commit.  I put
the following in .git/info/grafts:

    'b' X
    'e' 'd'

(which I gathered from here:
http://thread.gmane.org/gmane.comp.version-control.git/66398/focus=66402.
 I've never use grafts before.  A bit about them should be put in the
manual, if it's not there already. =])

Then I ran:

    git-filter-branch HEAD ^X ^'d'

Now "git log --raw --all" doesn't show any of the problematic SHA-1
hashes anymore!

However:

identity.fb[173] > git fsck --full
    error: 320bd6e82267b71dd2ca7043ea3f61dbbca16109: object corrupt or missing
    error: 4d0be2816d5eea5ae2b40990235e2225c1715927: object corrupt or missing
    missing blob 320bd6e82267b71dd2ca7043ea3f61dbbca16109
    missing blob 4d0be2816d5eea5ae2b40990235e2225c1715927

Shouldn't these be unreferenced now that I've run filter-branch?

-- 
                              Denis
