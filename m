From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] all: new command used for multi-repo operations
Date: Wed, 23 Jan 2013 15:39:18 +0700
Message-ID: <CACsJy8CTJ--u+KCYmK-2+K3NpEn72xnYwh_Pb+3Wn7nEtL1gqQ@mail.gmail.com>
References: <1358889019-4554-1-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 09:40:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxvsR-0002k0-Ld
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 09:40:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127Ab3AWIju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 03:39:50 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43454 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022Ab3AWIjt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 03:39:49 -0500
Received: by mail-ob0-f174.google.com with SMTP id 16so2100686obc.33
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 00:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=PvDoJFhed7r/nPUXrp9HcCiuPUae5lAgbsqRl2VyS/Y=;
        b=qSAUR31o7n/4Bhij4cO/Zwz+HhSGha0kc/uJgku7f8oKuDV/Ft7/fuL6qRwL7Jk2FD
         Zd1AsC7gOCVIpx/qbOnxglFjSVVDx541pOMj2tiOX6nV1NK032Oar3RQbepkYpCH6cI7
         pYjrG3GPGOEqhby3Xnu+iPzzKNUaLtOxapCGNgDR7iK9UplNHdXHkUyRWdM6mNWdscK5
         6Sa3wXFnQhvMdExu8cV48SwEwNinpsi/ouPRyGnR6dnOXipBkLcZ2ZwatXftUDvD193T
         AiCke7sOVNiZPQ9tvG5NIR55IKSskn/zGkjBXZSCNvVCf2Z07ZPph24BplRXIJ4gTGmR
         GxOA==
X-Received: by 10.60.154.169 with SMTP id vp9mr340684oeb.109.1358930388799;
 Wed, 23 Jan 2013 00:39:48 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Wed, 23 Jan 2013 00:39:18 -0800 (PST)
In-Reply-To: <1358889019-4554-1-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214298>

On Wed, Jan 23, 2013 at 4:10 AM, Lars Hjemli <hjemli@gmail.com> wrote:
> When working with multiple, unrelated (or loosly related) git repos,
> there is often a need to locate all repos with uncommitted work and
> perform some action on them (say, commit and push). Before this patch,
> such tasks would require manually visiting all repositories, running
> `git status` within each one and then decide what to do next.
>
> This mundane task can now be automated by e.g. `git all --dirty status`,
> which will find all git repositories below the current directory (even
> nested ones), check if they are dirty (as defined by `git diff --quiet &&
> git diff --cached --quiet`), and for each dirty repo print the path to the
> repo and then execute `git status` within the repo.

I think it should leave out the execute part. The command, say
ls-repo, lists repositories in specified state. The execute part could
be easily done by

xargs -I{} git --git-dir={} status blah

I haven't thought it through. I know xargs does not support chdir'ing
into a repo, so maybe a new git-xargs could be introduced for that.
But there's still a problem with git-xargs (or git-all), printed paths
are relative to the subrepos, not where the git-all/xargs command is
executed. This could be confusing. Personally I'd like to do it
without chdir. That is

xargs -I{} git --git-dir={}/.git --work-tree={} status blah

should print paths relative to current working directory even if cwd
is outside the repo.
-- 
Duy
