From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Best way to specify all local branches and all remote branches.
Date: Mon, 11 Feb 2008 11:10:44 -0800 (PST)
Message-ID: <m3ir0ve2c1.fsf@localhost.localdomain>
References: <47B09921.2070109@glidos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Gardiner <osronline@glidos.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 20:12:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOe58-0004NK-Ex
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 20:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740AbYBKTLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 14:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754025AbYBKTKt
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 14:10:49 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:36549 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbYBKTKr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 14:10:47 -0500
Received: by ug-out-1314.google.com with SMTP id z38so351122ugc.16
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 11:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=RVyirY2g64Me0ND/M5Vt0kG9A6yo9+ZtRyUt3krb0Jw=;
        b=N5tjTYBtYCzOwS+h3BZz7v0NEIx9/L6WX04u86ZSxqRJ1dxfRb53i0e14WxdgI9UmrSVHVr9b5h7QZPqNCxx+rnupskCoMfDBPZq6yDosJLJTLjqBPhQJhOIQn8qrisyQlInGW1wbJbAccpXM+5Bo3KKTHXNERCEO2zc9Rx8BS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=LKiqyXUdLHWfU8BL1I1y098Jz0y2DXAng+isIohWW1HJ2AiK7TEra2iJA13EKxaP6mp9mS351BCyLFGaUc6E4sMCKHK82wYLiBIHBUVUgI/shj+DU1QkcVr2t9qmEGEyrmslcmKePiBtQlUW9MIsfW21TGGCpzkOG/Lhc5PV4UI=
Received: by 10.67.196.4 with SMTP id y4mr9433446ugp.39.1202757046465;
        Mon, 11 Feb 2008 11:10:46 -0800 (PST)
Received: from localhost.localdomain ( [83.8.220.23])
        by mx.google.com with ESMTPS id m1sm7827638uge.69.2008.02.11.11.10.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Feb 2008 11:10:44 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1BJAdoE016780;
	Mon, 11 Feb 2008 20:10:40 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1BJAc1h016777;
	Mon, 11 Feb 2008 20:10:38 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <47B09921.2070109@glidos.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73565>

Paul Gardiner <osronline@glidos.net> writes:

> New to git, and often finding it hard to specify the correct
> refs for a command. Here's an example where I was converting
> all the files in all the commits from unix line endings to
> DOS line endings. You can see I've ended up using cd and ls.
> I'm sure there must be a better way.

git-for-each-ref, git-show-ref, git-ls-remote / git-peek-remote.
 
> $ cd /home/public/tmp/git/
> $ yes |rm -r vdos32
> $ git clone /export/git/vdos32.git vdos32
> $ cd vdos32/
> $ for f in `(cd /export/git/vdos32.git/refs/heads; ls)|sed -e
>     '/master/d' -e '/origin/d'`; do git fetch origin $f:$f; done
> $ git-filter-branch --tag-name-filter cat --tree-filter 'find . -type f
>     ! -name \*.gif ! -name \*.ico|xargs unix2dos -q' `(cd
>     .git/refs/heads;ls)`

If you want to fetch all branches, you can specify globbing refspec;
of course if you use separate remotes layout, or mirror layout.

If you want to pass all branches to git command, usually --all would
be enough (sometimes --heads).
 
> With git-filter-branch, I'm surprised I can't use --all.

git-filter-branch is about single branch; I'm not sure if it should
support --all.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
