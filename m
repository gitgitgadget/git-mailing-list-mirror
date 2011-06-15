From: Andreas Ericsson <ae@op5.se>
Subject: Re: git checkout running very slowly (>12s)
Date: Thu, 16 Jun 2011 00:46:23 +0200
Message-ID: <4DF9363F.6080009@op5.se>
References: <loom.20110615T213016-856@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andrew Cameron <andrew@worksmartlabs.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 00:46:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWyr4-0005wT-0E
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 00:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755687Ab1FOWq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 18:46:29 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33034 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677Ab1FOWq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 18:46:28 -0400
Received: by fxm17 with SMTP id 17so735176fxm.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 15:46:27 -0700 (PDT)
Received: by 10.223.96.130 with SMTP id h2mr180909fan.142.1308177985384;
        Wed, 15 Jun 2011 15:46:25 -0700 (PDT)
Received: from vix.int.op5.se (c83-248-99-226.bredband.comhem.se [83.248.99.226])
        by mx.google.com with ESMTPS id b25sm480806fab.28.2011.06.15.15.46.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 15 Jun 2011 15:46:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Thunderbird/3.1.10 ThunderGit/0.1a
In-Reply-To: <loom.20110615T213016-856@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175865>

On 06/15/2011 09:30 PM, Andrew Cameron wrote:
> Some git operations (notably checkouts) are taking a very long time to execute.
> Here is a shell session which illustrates the problem.
> 
> $ time git branch foo
> git branch foo  0.01s user 0.00s system 77% cpu 0.016 total

Creating a branch is just a matter of creating a new ref. In this
case, you're doing it on the currently checked out ref. That's a
constant-time operation that is always very quick.

> $ time git checkout foo
> Switched to branch 'foo'
> git checkout foo  11.73s user 0.18s system 99% cpu 11.937 total

If this sequence of commands is accurate, that's a bit weird. If
you've got another branch checked out first and then switch it
would be understandable, considering the size of the repository.
We should probably still do a tree-by-tree comparison to see
which files are changed though, but I thought that's already
done to avoid superfluous work and allow worktree changes to
carry over to other branches. What version of git are you using?

> $ time git checkout master
> Switched to branch 'master'
> git checkout master  11.62s user 0.18s system 99% cpu 11.813 total
> $ git count-objects -v
> count: 953
> size: 527012
> in-pack: 153432
> packs: 7
> size-pack: 1986072
> prune-packable: 0
> garbage: 0
> 

These figures are nowhere near as interesting as those from
  git ls-files | wc -l
after the checkout is completed.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
