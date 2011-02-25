From: seanh <snhmnd@gmail.com>
Subject: git commit not committing, confused
Date: Fri, 25 Feb 2011 19:02:35 +0000
Message-ID: <20110225190235.GB15815@kisimul>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 25 19:57:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt2rH-0000Rx-0P
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 19:57:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274Ab1BYS5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 13:57:38 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:45644 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325Ab1BYS5h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 13:57:37 -0500
Received: by wwe15 with SMTP id 15so978357wwe.1
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 10:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:subject:message-id
         :mail-followup-to:mime-version:content-type:content-disposition
         :user-agent;
        bh=+7enOMtXQgDtzTjpwfOUAu8XlmUnzVYU2VGylOnsVKU=;
        b=uUx9UYA9fFsZ1Qc/rhbTj+Kxh7tMCKtPdGrxl4gD6vLA83MC3nk/Wsw6295r94ZxPo
         lJwRAHOZYgQANTK0FJu0jR5SZWHF7HBIijYLsVDxP5UJauXn+ysAtbiaYwf5HKmyV7T3
         3LG5A9W5lHwIfzKgVdwf17VeT9lg+b538Exjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        b=t9hbwmQ5f7LQXDWReCoHgQIYDxlW7LF7UQzvv9+vWbaatB1cEgKRDEryixn3Kf0jsh
         cfVIAB+tshNWMiKJmUL+/2IqnT2ctB1MVUwMAUL3G9VcJ2bt4NlbDZE9kO0t2ieBu3T4
         qTfre21nnf7cJjlRvP0cXg8IraGNcdvmIIkbQ=
Received: by 10.216.172.15 with SMTP id s15mr7220024wel.70.1298660255929;
        Fri, 25 Feb 2011 10:57:35 -0800 (PST)
Received: from kisimul (kisimul.inf.ed.ac.uk [129.215.197.9])
        by mx.google.com with ESMTPS id n11sm478612wej.19.2011.02.25.10.57.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Feb 2011 10:57:34 -0800 (PST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167918>

How did this happen?

I have a git repo containing a LOG.txt file. I made some changes to this
file and committed them. Actually, I called this script which did so:

	#!/bin/sh -e
	# Append timestamped one-liners to a file and commit the file to git.
	logdir=~/txt
	logfile=LOG.txt
	cd "$logdir"
	if [ $# = 0 ]; then
		# No command-line arguments, just print out the last entry.
		tail -n 1 $logfile
	else
		entry="[`date`] [`hostname`] $*"
		echo $entry >> $logfile
		git commit $logfile -m "$logfile: $*"
		git push
		tail -n 1 $logfile
	fi

The script executes (and shows output from git) with no errors. `git
log` shows the commit, `git log -p` shows the changes committed to the
LOG.txt file.

However, `git log LOG.txt` does _not_ show the commit.
`git status` shows LOG.txt as modified and unstaged.
`git diff LOG.txt` shows a diff of the changes to LOG.txt, the same changes so
that show up in `git log -P`.
After running `git add LOG.txt` again, `git status` still shows LOG.txt
as modified and unstaged!
`git commit LOG.txt` reports 'no changes added to commit'.

So this doesn't make sense. I don't know what happened or how. git's
index seems to have got into a mess. If I clone the repo then cd into
the clone and run git status it shows LOG.txt as modified and unstaged,
even though this is a brand new fresh clone!
