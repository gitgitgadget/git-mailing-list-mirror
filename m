From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Unable to shrink repository size
Date: Wed, 5 Mar 2014 20:55:30 -0600
Message-ID: <CAHd499AW6nev81iVVhuoYfT0us28SSBDwbHCBa3teYB=cJR99g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 03:55:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLOTC-00057o-7j
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 03:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758050AbaCFCzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 21:55:32 -0500
Received: from mail-vc0-f181.google.com ([209.85.220.181]:39440 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757908AbaCFCzb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 21:55:31 -0500
Received: by mail-vc0-f181.google.com with SMTP id lg15so1939918vcb.40
        for <git@vger.kernel.org>; Wed, 05 Mar 2014 18:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=2cubtMkIgwmhZx5e8L8Fo/xtpPIRrwI5nPi6kBm6jak=;
        b=PGxK/DgE8oPprlkK6oZdxzciBmfvM4n5/lPE1FHdtGnTD8nfgtL0yA9zK0VOkgB79b
         qW8EkZ7KDMTw1PBJdkcf0JeV5L6MPNXKQMef9ggGjYffriQL2ZO+ExAkKdJCYh9LCIfd
         +KLOjgh7+t7wbjU4gMUhPWButbG+t6PTLjsOLAHcLZTEq+t9TWZ9d0NALH5+Fbkm2aIe
         /NAKkaIOrA/89AtNgwGCkfShozi8ZcpTzndTtH+BHTih6GlJXfUTYrXkyWPvT4N+NnwH
         f2T+40au+MHBNovvvjQCX2LTxkr1ZjsOR7Egn9p51QJLKiKFD/CMGlewVJr1nhu+bgvz
         hrxA==
X-Received: by 10.52.27.9 with SMTP id p9mr6144633vdg.28.1394074530040; Wed,
 05 Mar 2014 18:55:30 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.2.79 with HTTP; Wed, 5 Mar 2014 18:55:30 -0800 (PST)
X-Google-Sender-Auth: rjSvwwKizFDheIA2opK2y_Y9y58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243498>

I have a git-svn clone that I've been working on which is a full and
complete conversion of our SVN repository at work.

It started out as 1.4GB (git count-objects -v, looking at
'size-pack'). I have run the following script to clean up a directory
in the repo history that I suspect are huge (we had a third party
library checked in that, uncompressed, was about 1.2GB in size):

-------------------------------
files=$@
echo "Removing: $files..."
git filter-branch --index-filter "git rm -rf --cached --ignore-unmatch
$files" -- --all

# remove the temporary history git-filter-branch otherwise leaves
behind for a long time
rm -rf .git/refs/original/ && git reflog expire --expire=now --all &&
git gc --aggressive --prune=now
-------------------------------

Even though I seem to have removed it, the repository size (looking at
'size-pack' again) only went down about 200MB, so it's at 1.2GB now.
There is about 3-5 years of commit history in this repository.

What I'd like to do is somehow hunt down the largest commit (*not*
blob) in the entire history of the repository to hopefully find out
where huge directories have been checked in.

I can't do a search for largest file (which most google results seem
to show to do) since the culprit is really thousands of unnecessary
files checked into a single subdirectory somewhere in history.

Can anyone offer me some advice to help me reduce the size of my repo
further? Thanks.
