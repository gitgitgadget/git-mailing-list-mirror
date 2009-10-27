From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git vs hg commit counts?
Date: Mon, 26 Oct 2009 18:14:43 -0700 (PDT)
Message-ID: <m3zl7dd4g6.fsf@localhost.localdomain>
References: <1256602127.29938.8.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>, git <git@vger.kernel.org>,
	mercurial@selenic.com, Marti Raudsepp <marti@juffo.org>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 02:15:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2aeT-0006kK-VG
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 02:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755911AbZJ0BOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 21:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755888AbZJ0BOm
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 21:14:42 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:40507 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755894AbZJ0BOl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 21:14:41 -0400
Received: by fxm18 with SMTP id 18so12587218fxm.37
        for <multiple recipients>; Mon, 26 Oct 2009 18:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=h2v7TYM87in5PUrcfyoJtqkyNuIgZ7EwThuwdtXlFWw=;
        b=dFIFQfXaKu/l9iBihOVzYEv3b1LXQo1hIILfuuidT5dFTc8ihejv6OydGTxrvDdg+1
         rSasFU7r6ZNEVCAq4juXYZriuNepVi/8g8o+5dsOyHi/1zIWtybFWzJJI5kknkA/Wj50
         KbxQtn7hMsH09MNQDbtsKpIdiZV3S7D4dBJTk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=XdJXysRZUvqgtrquX306+e5lCvi6haVtyedDwr85kgMr6YXcT9MW+SWT4bU/Fq4EEW
         81Yi46KLFlO0TsqCNRllVkwv3tqTP08UbzAZ+g7ZVRv6aGaK/pUKnZW5LiayeJ4EmkR6
         HN27mxpsGW7jFGE4sbnJjrOdS94C1bG1buMHc=
Received: by 10.204.23.203 with SMTP id s11mr252171bkb.17.1256606085181;
        Mon, 26 Oct 2009 18:14:45 -0700 (PDT)
Received: from localhost.localdomain (abwn128.neoplus.adsl.tpnet.pl [83.8.237.128])
        by mx.google.com with ESMTPS id 26sm1409266fks.32.2009.10.26.18.14.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Oct 2009 18:14:43 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n9R1Dwwv027542;
	Tue, 27 Oct 2009 02:14:09 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n9R1DURY027534;
	Tue, 27 Oct 2009 02:13:30 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1256602127.29938.8.camel@Joe-Laptop.home>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131299>

Joe Perches <joe@perches.com> writes:

> I'm comparing linux-kernel git vs hg repositories.
> 
> While testing some changes to scripts/get_maintainer.pl,
> I noticed that git and hg have different commit counts
> for the same files.
> 
> For instance:
> 
> $ git log --since=1-year-ago -- MAINTAINERS | \
> 	grep -P "^commit [0-9a-f]{40,40}$"  | wc -l
> 514
> 
> $ hg log --template="commit {node}\n" --date -365 -- MAINTAINERS  | \
> 	grep -P "^commit [0-9a-f]{40,40}$" | wc -l
> 601
> 
> Anyone have any understanding why?

It *might* be caused by the fact that in Mercurial commit can have
only up to two parents.  This means that octopus merges (merge commits
with more than two parents: there are a few of them in linux-kernel
history) have to be represented as a set of two-parent merges.

-- 
Jakub Narebski

http://stackoverflow.com/questions/1598759/git-and-mercurial-compare-and-contrast/1599930#1599930
