From: Ilya Basin <basinilya@gmail.com>
Subject: put THEIR commits AFTER my commits with a single rebase command
Date: Thu, 18 Apr 2013 09:18:07 +0400
Message-ID: <1928280357.20130418091807@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 18 07:18:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UShEi-0005Kz-HS
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 07:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366Ab3DRFSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 01:18:14 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:43997 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754813Ab3DRFSN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 01:18:13 -0400
Received: by mail-la0-f53.google.com with SMTP id fp13so2193712lab.12
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 22:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=U2KdQguRgQ1BpYykaeVJ61si855MNt8ofTXBkzBZQc0=;
        b=0wURBW+H0GA2OBBBgIuuBsaZrWZ7SlqOK1/2sR9GauZP4Mv7nhPyXhVj+EA2YJjhNp
         kJkP9L8neXc4Y9PNR7r5E74LPgFzyNq+HdpSQSf4bVVEv+y11xJMBCKmNbA4tv924VKp
         vqQJ18BcMKbW3qaxYG8TLYho8KVlwl5z8AwlXmF8Cd486IYmDl+x4jPK2JWhapg5SBZi
         UO7DAgPQBXtO4mHHiTPzNqVWR3ThgIBQ4o9nO5+A7OFCrm4j8WMjU8Aw3CJDou4BZL94
         WDkdRgpacxtnerZ6F63F3biUOOmORNTlFzUNUjCC2ByndhVbpscTYf/S5go3fdawqr0D
         OiEA==
X-Received: by 10.112.198.132 with SMTP id jc4mr43846lbc.24.1366262291527;
        Wed, 17 Apr 2013 22:18:11 -0700 (PDT)
Received: from BASIN.reksoft.ru ([2a00:1120:0:1001:84e0:55a3:4150:1bdd])
        by mx.google.com with ESMTPS id op1sm3618294lbb.2.2013.04.17.22.18.09
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 17 Apr 2013 22:18:10 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221609>

I asked this on stackoverflow, but no reply.
http://stackoverflow.com/questions/15971244/git-put-their-commits-after-my-commits-with-a-single-rebase-command

Suppose master and origin/master diverged.
I'm on master and I want to put the commits from origin/master after my commits and then push --force.  

         A---B---C origin/master
        /
    D---E---F---G *master

desired result:

         A---B---C origin/master
        /
    D---E---F---G---A'---B'---C' *master



Variant 1:

    git branch -f tmp
    git reset --hard origin/master
    git rebase tmp

This variant is bad, because 'git reset --hard' checks out some files and 'git rebase' rewrites them again before applying commits. It's a redundant job.  
Variant 2:

    git branch -f tmp origin/master
    git rebase --onto master master tmp
    git branch -f master
    git checkout master

Too many commands. I want to do this with just one command. And I want
to stay be on branch master in case of rebase conflicts.
