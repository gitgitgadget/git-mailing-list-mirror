From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: ssh admin git accidentally deleted
Date: Tue, 7 Jul 2015 16:47:08 +0300
Message-ID: <20150707164708.10cd2b169187636bef4dbe6e@domain007.com>
References: <CAF1FN5CDnUYxjChO2PZFrDnPRUiuqXhko=iDo=tuqwvJJdUg5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: agnes retnaningsih <agnes.monest@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 15:47:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTDd-0001uu-6S
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 15:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757473AbbGGNrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 09:47:17 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:48330 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757463AbbGGNrM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 09:47:12 -0400
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id t67Dl8Uk025850;
	Tue, 7 Jul 2015 16:47:09 +0300
In-Reply-To: <CAF1FN5CDnUYxjChO2PZFrDnPRUiuqXhko=iDo=tuqwvJJdUg5A@mail.gmail.com>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273503>

On Tue, 7 Jul 2015 20:30:59 +0700
agnes retnaningsih <agnes.monest@gmail.com> wrote:

> Dear git , I accidentally delete ssh admin git, unfortunately there
> just one admin so I can't make a change in the config and push to the
> repository. If there's a way undo the change or make an existing user
> become an admin or is there any super admin command?
> 
> I use git version 1.7.5.4

Git itself has no concept of users or user access controls.
From the description of the problem, it appears you're using
Gitolite [1] as a front-end to Git.

I can't unambiguously decode what "delete ssh admin git" means
because to me, it can mean at least two things:
1) You have deleted the SSH account used to push your Gitolite
   configuration on your server.
2) You have deleted the public key of the Gitolite admin user
   from your repository, and pushed.

In the case you have to log into your server (via SSH or other means)
first.

Then, in the first case,
1) Re-create the account;
2) Generate another SSH key for it;
3) Take the public part of this key, clone the Gitolite config
   repo locally (on the server), replace the admin's key there
   with the new key, commit, push.
4) Transport the private admin's key to the machine you're
   administering Gitolite from.

In the second case,
1) Clone the Gitolite config repo locally (on the server);
2) Revert the commit which nuked the admin's key (by using the
   regular `git revert` command, commit and push.

Note that this all implies you have enough permissions on your server.

1. https://github.com/sitaramc/gitolite
