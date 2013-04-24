From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-prompt.sh: Show where rebase is at when interrupted
 by a merge conflict
Date: Wed, 24 Apr 2013 03:05:03 -0400
Message-ID: <CAPig+cR2rvgptVvyDNOJijUZEGN5T_=uJ6xjs_sN9E+=5+sAvQ@mail.gmail.com>
References: <1366720507-16504-1-git-send-email-zoltan.klinger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 09:05:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUtlT-0003W6-CB
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 09:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757516Ab3DXHFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 03:05:07 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:62009 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274Ab3DXHFG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 03:05:06 -0400
Received: by mail-la0-f42.google.com with SMTP id fn20so1287460lab.1
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 00:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=5sRkPQk4ePwcnszfplSg/vsm3RFoMx7wkKl/kYwNxDE=;
        b=gtDt+QEq3hkgHhFwNerzmBScLjyQPVcMWruTrN4OERNXUdunRrNcocKYIljSoSOQNs
         sIihA3dG7A2BJdX0QfxQG1iWTO/i7DXbvHn3tvjP7GBap9lOhKdfLWsUdtclGcn1j5wP
         1POUIj60NBv/MlImmWv0wfB50y+4Qzw1CaT7htjBjpLAeEAYEKr+BS5mdJFW3oWcqn2s
         DLRBaZe/mKlk3SODuCY/WhRmV/Xf8s7XCop4YRbP4EaOwfDH/WXmbgtVI+eyqW4/JxtM
         fYZwF6/f5VgskOzX+DTPVXMsDg6fwuNAzTWkz/emUpPVy2K1pGAYuARzVpThZj7JRnQp
         Tg5Q==
X-Received: by 10.112.157.165 with SMTP id wn5mr16688206lbb.29.1366787104117;
 Wed, 24 Apr 2013 00:05:04 -0700 (PDT)
Received: by 10.114.199.11 with HTTP; Wed, 24 Apr 2013 00:05:03 -0700 (PDT)
In-Reply-To: <1366720507-16504-1-git-send-email-zoltan.klinger@gmail.com>
X-Google-Sender-Auth: Suh4DHF7UEgKnQk37GMajREGTOk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222226>

On Tue, Apr 23, 2013 at 8:35 AM, Zoltan Klinger
<zoltan.klinger@gmail.com> wrote:
> When a rebase is interrupted by a merge conflict it could be useful to
> know how far a rebase has progressed and how many commits in total this
> rebase will apply. Teach the __git_ps1() command to display the number
> of commits so far applied and the total number of commits to be applied.
>
> Below is a sample output of the improved __git_ps1() command:
>   ((3ec0a6a...)|REBASE|2/5)
>
> In the example above the rebase has stopped at the second commit due to
> a merge conflict and there are a total number of five commits to be
> applied by this rebase.
>
> This information can be alredy obtained from the following files which are

s/alredy/already/

> being generated during the rebase:
>     GIT_DIR/.git/rebase-merge/msgnum (git-rebase--merge.sh)
>     GIT_DIR/.git/rebase-merge/end    (git-rebase--merge.sh)
>     GIT_DIR/.git/rebase-apply/next   (git-am.sh)
>     GIT_DIR/.git/rebase-apply/last   (git-am.sh)
>
> 1) Modify git-rebase--interactive.sh to also create
>       GIT_DIR/.git/rebase-merge/msgnum
>       GIT_DIR/.git/rebase-merge/end
>    files for the number of commits so far applied and the total number of
>    commits to be applied.
> 2) Modify git-prompt.sh to read and display info from the above files
> 3) Update test t9903-bash-prompt.sh to reflect changes introduced by
>    this patch.
>
> Signed-off-by: Zoltan Klinger <zoltan.klinger@gmail.com>
