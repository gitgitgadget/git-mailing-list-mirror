From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: finding deleted file names
Date: Thu, 03 Jul 2008 02:20:14 -0700 (PDT)
Message-ID: <m3hcb7fho7.fsf@localhost.localdomain>
References: <93c3eada0807021701m13b7adddv51537f4cf9d52533@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Thu Jul 03 14:24:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KENqm-0002ud-KG
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 14:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758834AbYGCMWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 08:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753945AbYGCMWu
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 08:22:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:62670 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186AbYGCMWs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 08:22:48 -0400
Received: by nf-out-0910.google.com with SMTP id d3so257874nfc.21
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 05:22:45 -0700 (PDT)
Received: by 10.210.115.15 with SMTP id n15mr7562218ebc.28.1215076815334;
        Thu, 03 Jul 2008 02:20:15 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.253.104])
        by mx.google.com with ESMTPS id b36sm11970372ika.5.2008.07.03.02.20.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Jul 2008 02:20:14 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m639KApL005794;
	Thu, 3 Jul 2008 11:20:10 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m639K8Cf005790;
	Thu, 3 Jul 2008 11:20:08 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <93c3eada0807021701m13b7adddv51537f4cf9d52533@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87273>

"Geoff Russell" <geoffrey.russell@gmail.com> writes:

> git diff --diff-filter=D --name-only HEAD@{'7 days ago'}

What did you want to find here?

> finds files deleted during the last 7 days, but if my repository is
> only 6 days old I get a fatal error.
> 
> fatal: bad object HEAD@{7 days ago}

First, which version of git do you use? Because with git version 1.5.6.1
I get:

  1000:[master!git]$ git diff --diff-filter=D --name-only HEAD@{'10 years ago'}
  warning: Log for 'HEAD' only goes back to Fri, 4 Apr 2008 15:28:53 +0200.
  Documentation/core-tutorial.txt
  [...]

Second, [<ref>]@{<date>} refers to _local_ history of where _branch tip_
pointed in your repository, and is purely local information retrieved from
reflogs (which gets pruned / expired).  To refer to (find) commits by
commit creation date, use --since=<date>/--after=<date> or --until=<date>/
/--before=<date>.  There was even lately added information to git
documentation about difference bwetween [<ref>]@{<date>} and --before=<date>
and when to use one or the other.

> Is there something that says "since repository creation", ie., go back as far
> as possible, but no further? Is there a symbolic name for the initial commit?

Because git allows joining two repositories into one (either union of
their top directories, or one put into subdirectory in other using so
called 'subtree' merge strategy) there can be more than one "root"
(parentless) commit.  In git repository there are 7 root commits, not
counting "disjoint" branches like 'html', 'man' and 'todo' which share
no history and doesn't join with mainline history.

They are: git-p4 (Perforce importer), git-gui, gitweb, gitk, git mail
tools, git,... and something strange (4e00220243).

 $ git rev-list --parents --branches --not html man todo | grep -v -e ' '

-- 
Jakub Narebski
Poland
ShadeHawk on #git
