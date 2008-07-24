From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Moving .git around
Date: Thu, 24 Jul 2008 09:12:19 +0700
Message-ID: <fcaeb9bf0807231912t6f20d508va1381f324a8981aa@mail.gmail.com>
References: <93c3eada0807231832o6b7689c4j2913253d7ced62ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Thu Jul 24 04:13:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLqKX-0001ly-OY
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 04:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbYGXCMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 22:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbYGXCMW
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 22:12:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:6731 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbYGXCMV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 22:12:21 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1288327fgg.17
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 19:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=J8HuKBYGQ4vgqZJPlQx7VZ8YAkENvASqOskDd6DHCQQ=;
        b=a9y47GV9QgyIRmisfGSboZGCgdV302o11c3FjPzp7EIn9EnRIHq14POOlJzDO7KXJu
         rqJfdyp4ivcRVn9mgCt9eemopW2ybotZWeiBpX8z602C2ikjR0y+9p1k1CPJwKPVm7ou
         xwq6ozMnENVE7fDloyZSgAF171ziOHCutIdLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Kik+05kmhI1o4r7KKr5vxb4NUUlfMZ+OsY0b02ZZvyvZoEBRA9pxV2KDfQsaGAikDB
         WkdqIbLEC7+7ZueSh2SI0cZjdTWB8ae9/ITuCfHGzXqFvNv+xqp/NZVat6u+5yRSn0i0
         1/5UGa/hnrQQxhWxoZA/TDdiyQUNBh+G0PaJg=
Received: by 10.86.98.10 with SMTP id v10mr348030fgb.39.1216865539737;
        Wed, 23 Jul 2008 19:12:19 -0700 (PDT)
Received: by 10.86.91.2 with HTTP; Wed, 23 Jul 2008 19:12:19 -0700 (PDT)
In-Reply-To: <93c3eada0807231832o6b7689c4j2913253d7ced62ba@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89828>

On 7/24/08, Geoff Russell <geoffrey.russell@gmail.com> wrote:
> For reasons which would take a while to explain, I'm building a repository
>  in a directory  using "--git-dir=xxxx/.git --work-tree=." and
>  then doing an "mv  xxxx/.git ./.git"  and then trying to work with
>  that repository  --- but can't
>
>  Below is a sample script. The last line (git add) fails with
>
>  fatal: unable to create
>  '/usr/local/AusTop/AuPrograms/AuServer/testgit/aaa/bbb/.git/index.lock':
>  No such file or directory
>
>  git doesn't seem to realise that there is a .git back up the tree.

It's because when you did git --work-tree=. init, worktree is stored
in .git/config. The code that chdir() in setup_git_directory()
probably forgot to chdir() back to toplevel worktree. Workaround could
be just remove core.worktree in .git/config.

>  I'm using 1.5.5.1
>
>  Cheers,
>  Geoff Russell
>
>  ------------------------ sample script
>  #!/bin/sh
>  if [ -d "testgit" ] ; then
>     echo "remove testgit"
>     /bin/rm -rf testgit
>  fi
>  mkdir testgit && echo yyyy >testgit/sample.sh && cd testgit
>  mkdir aaa && mkdir aaa/bbb
>  echo xxxx > aaa/bbb/sample2.sh
>  mkdir xxx
>  git --git-dir=xxx/.git --work-tree=. init
>  git --git-dir=xxx/.git --work-tree=. add *.sh
>  git --git-dir=xxx/.git --work-tree=. commit  -m demo
>  mv xxx/.git .
>  cd aaa/bbb
>  git add sample2.sh
>
> --
>  To unsubscribe from this list: send the line "unsubscribe git" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Duy
