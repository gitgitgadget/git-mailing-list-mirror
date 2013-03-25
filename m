From: Richard Weinberger <richard@nod.at>
Subject: git ate my home directory :-(
Date: Mon, 25 Mar 2013 22:38:52 +0100
Message-ID: <5150C3EC.6010608@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 25 22:39:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKF75-0005Pk-7G
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 22:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758944Ab3CYVjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 17:39:01 -0400
Received: from a.ns.miles-group.at ([95.130.255.143]:47834 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758665Ab3CYVjA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 17:39:00 -0400
Received: (qmail 24473 invoked by uid 89); 25 Mar 2013 21:39:00 -0000
Received: by simscan 1.3.1 ppid: 24465, pid: 24469, t: 0.0701s
         scanners: attach: 1.3.1 clamav: 0.96.5/m:
Received: from unknown (HELO ?192.168.0.18?) (richard@nod.at@212.186.22.124)
  by radon.swed.at with ESMTPA; 25 Mar 2013 21:39:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219096>

Hi!

Today I've discovered that on the build server my home directory was empty.
A post-mortem analysis showed that the git-clean command I've added to my kernel build script
is the evil doer.
In my scripts I'm setting GIT_DIR to use git-fetch and git-reset without changing the
current working directory all the time.
But calling git-clean with GIT_DIR acts basically like a "rm -Rf .".

Here a small demo:

test@linux:~> git --version
git version 1.8.1.4
test@linux:~> ls
test@linux:~> touch a b c d e
test@linux:~> mkdir x
test@linux:~> cd x
test@linux:~/x> git init
Initialized empty Git repository in /home/test/x/.git/
test@linux:~/x> cd ..
test@linux:~> ls
a  b  c  d  e  x
test@linux:~> export GIT_DIR=/home/test/x/.git/
test@linux:~> git clean -d -f
Removing a
Removing b
Removing c
Removing d
Removing e
Removing x/
test@linux:~> ls
test@linux:~>
test@linux:~> # :-(

Is this behavior intended?

Thanks,
//richard
