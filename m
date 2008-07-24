From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: Moving .git around
Date: Thu, 24 Jul 2008 12:06:28 +0930
Message-ID: <93c3eada0807231936ib103824u9204f1109119e1c2@mail.gmail.com>
References: <93c3eada0807231832o6b7689c4j2913253d7ced62ba@mail.gmail.com>
	 <fcaeb9bf0807231912t6f20d508va1381f324a8981aa@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 04:37:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLqhx-00078D-PM
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 04:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbYGXCgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 22:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbYGXCgb
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 22:36:31 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:3790 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbYGXCga (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 22:36:30 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1543886wri.5
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 19:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ypONSY9b6ZjoXiEoIML8nGvMqT+C3RofhAARfsV9UhY=;
        b=KsVM9oqvJBIR0952iPe5KV00MshZGq5h5AgcgdvbZ+kb+kdb6tbzLJvTZntPSde2ez
         xBsigGJECN6y0a6F00Ugu52gg8ulWRUKuSARWOaa/xBRaLDGECBPlbK27JioOpnpLNUP
         FxU1DMW9Wt8GWEOhBGt23qgl+FfJsn536fojU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=R3bs3QxeSR/cYU3/9qRPSEHSGr0EECD7ltI5HDJ/trRwBFRt2P/ckM0t5FOhOkJrPx
         uuJGaYu+1BAWPVxUhJ90mSVx8+wBLTuW38ixVdlK2Gkv+GBCHhZWDYmSCSLnVW4VoKeN
         sMwU3W4aeaskkXmBMELn7x6bwovsV16lkRvf4=
Received: by 10.90.68.20 with SMTP id q20mr735300aga.23.1216866988588;
        Wed, 23 Jul 2008 19:36:28 -0700 (PDT)
Received: by 10.150.57.11 with HTTP; Wed, 23 Jul 2008 19:36:28 -0700 (PDT)
In-Reply-To: <fcaeb9bf0807231912t6f20d508va1381f324a8981aa@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89829>

On Thu, Jul 24, 2008 at 11:42 AM, Nguyen Thai Ngoc Duy
<pclouds@gmail.com> wrote:
> On 7/24/08, Geoff Russell <geoffrey.russell@gmail.com> wrote:
>> For reasons which would take a while to explain, I'm building a repository
>>  in a directory  using "--git-dir=xxxx/.git --work-tree=." and
>>  then doing an "mv  xxxx/.git ./.git"  and then trying to work with
>>  that repository  --- but can't
>>
>>  Below is a sample script. The last line (git add) fails with
>>
>>  fatal: unable to create
>>  '/usr/local/AusTop/AuPrograms/AuServer/testgit/aaa/bbb/.git/index.lock':
>>  No such file or directory
>>
>>  git doesn't seem to realise that there is a .git back up the tree.
>
> It's because when you did git --work-tree=. init, worktree is stored
> in .git/config. The code that chdir() in setup_git_directory()
> probably forgot to chdir() back to toplevel worktree. Workaround could
> be just remove core.worktree in .git/config.

Many thanks, the work-around works. I'm not sure if this is a bug or
a feature, but I'm happy either way.

Cheers,
Geoff Russell

>
>>  I'm using 1.5.5.1
>>
>>  Cheers,
>>  Geoff Russell
>>
>>  ------------------------ sample script
>>  #!/bin/sh
>>  if [ -d "testgit" ] ; then
>>     echo "remove testgit"
>>     /bin/rm -rf testgit
>>  fi
>>  mkdir testgit && echo yyyy >testgit/sample.sh && cd testgit
>>  mkdir aaa && mkdir aaa/bbb
>>  echo xxxx > aaa/bbb/sample2.sh
>>  mkdir xxx
>>  git --git-dir=xxx/.git --work-tree=. init
>>  git --git-dir=xxx/.git --work-tree=. add *.sh
>>  git --git-dir=xxx/.git --work-tree=. commit  -m demo
>>  mv xxx/.git .
>>  cd aaa/bbb
>>  git add sample2.sh
>>
>> --
>>  To unsubscribe from this list: send the line "unsubscribe git" in
>>  the body of a message to majordomo@vger.kernel.org
>>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> --
> Duy
>



-- 
6 Fifth Ave,
St Morris, S.A. 5068
Australia
Ph: 041 8805 184 / 08 8332 5069
