From: "Matthias Kestenholz" <lists@spinlock.ch>
Subject: Re: Obliterating a commit
Date: Sun, 30 Sep 2007 14:15:27 +0200
Message-ID: <1f6632e50709300515h57f4b4ffh9a18fef29b134f13@mail.gmail.com>
References: <D2BD14BD-44F2-4D01-AAEE-6CBC2A2DE85B@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Wincent Colaiuta" <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Sep 30 14:15:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibxhz-0007k2-VP
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 14:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757511AbXI3MPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 08:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757470AbXI3MPa
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 08:15:30 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:40443 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792AbXI3MP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 08:15:29 -0400
Received: by wa-out-1112.google.com with SMTP id v27so4198512wah
        for <git@vger.kernel.org>; Sun, 30 Sep 2007 05:15:28 -0700 (PDT)
Received: by 10.114.190.6 with SMTP id n6mr2259629waf.1191154528019;
        Sun, 30 Sep 2007 05:15:28 -0700 (PDT)
Received: by 10.141.154.13 with HTTP; Sun, 30 Sep 2007 05:15:27 -0700 (PDT)
In-Reply-To: <D2BD14BD-44F2-4D01-AAEE-6CBC2A2DE85B@wincent.com>
Content-Disposition: inline
X-Google-Sender-Auth: 536b13f4ce2a15d5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59535>

Hello,

2007/9/30, Wincent Colaiuta <win@wincent.com>:
> A couple of days ago I mistakenly checked in a file that had some
> confidential information in it. I immediately realized and amended my
> commit, and this is a local repository whose contents won't be
> visible until I push them out.
>
> So how do I *really* get rid of the that commit before publishing? I
> couldn't find any porcelain or plumbing to do this. Do I have to
> manually destroy it? ie. wind back the HEAD, manually remove the
> commit object, the corresponding tree object, the corresponding file
> blobs, and probably manually remove the entry from the reflog as well?
>

If you use ssh to push your changes (that is, you are not copying
or rsyncing packfiles), only commits, trees and blobs, which are reachable
through the DAG will be published. Commits and Blobs which are only
reachable through your reflog are not published, since the reflog only applies
to your local repository.

The simplest thing you could do is remove the reflog for HEAD and
refs/heads/master respectively your current branch and run 'git prune'
afterwards (if you have not repacked
already, otherwise you'd need to run 'git repack -a -d' or 'git gc' to get
rid of blobs inside your packfile.

> Is there a "shortcut" wherein I can somehow mark this commit and its
> related tree and file blobs as unreachable, and then use git-prune to
> erradicate them?
>

You don't need to mark anything -- it's sufficient that the blob with the
confidential information is only reachable through the reflog (which you
need to remove, obviously, if you want to get rid of the blob locally too)


Cheers,
Matthias
