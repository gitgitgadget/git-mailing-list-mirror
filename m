From: David Aguilar <davvid@gmail.com>
Subject: Re: git-ls-files --added?
Date: Fri, 29 May 2009 14:26:42 -0700
Message-ID: <20090529212634.GA86167@gmail.com>
References: <2cfc40320905240054j2c08da8bt4df95c6f1bc9e254@mail.gmail.com> <m3fxeudhho.fsf@localhost.localdomain> <2cfc40320905240212jc111b1xfeb39b1851c606d3@mail.gmail.com> <7vmy921i3j.fsf@alter.siamese.dyndns.org> <7vws85y9n7.fsf@alter.siamese.dyndns.org> <2cfc40320905251756t32e092fdqda769e21669f5d86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 23:26:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA9bN-00048w-7d
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 23:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbZE2V0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 17:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752313AbZE2V0r
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 17:26:47 -0400
Received: from mail-pz0-f177.google.com ([209.85.222.177]:60164 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbZE2V0q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 17:26:46 -0400
Received: by pzk7 with SMTP id 7so4981875pzk.33
        for <git@vger.kernel.org>; Fri, 29 May 2009 14:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JMMT+03cD9hJZXpAfBIUaGzsxNZ+NgBfp0kUnncVd+Q=;
        b=Woe7SjYr+RYZM2MBxPl8q5bHXpLSYFIk8Fy/90WTejn5IdJ5AGZBSJ+JhrezghrbPU
         NexUnDs5JaaOMBOif/KqfkE8iw6Jd66s+5r2Vae72nL4BwDB91zA7PaQR2slIU4E8KbQ
         bNSLbRsXcGOWO8AyPhQs5XGKD1WEVr9cyWNpE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=w8zb99wwO/gTSo5Ds/j7UE9zlL3AQyQGWTQ9zbEQmCe6G/kAA1dyT/iPWIcofJ66zb
         nj5h8Dtsee0HULRSJiHDX/rNbg9afKyhcNDHtU0ER1JF82FTlSnsXA6fHbtCtzTW83C7
         L2G5PJaUfFenfSoIJ123PJUJuJ2XJoW/x6iAU=
Received: by 10.142.192.3 with SMTP id p3mr287716wff.188.1243632407949;
        Fri, 29 May 2009 14:26:47 -0700 (PDT)
Received: from gmail.com (wdas-1.disneyanimation.com [12.188.26.1])
        by mx.google.com with ESMTPS id k2sm3784990rvb.2.2009.05.29.14.26.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 14:26:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2cfc40320905251756t32e092fdqda769e21669f5d86@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120317>

On Tue, May 26, 2009 at 10:56:52AM +1000, Jon Seymour wrote:
> Thanks for your answer's Junio.
> 
> I am indeed writing some porcelain. I currently have some bash tooling


I know that for the purposes of writing scripts it would be
really great if we had a plumbing command that gave us exactly
what git-status tells us, but in a machine-parseable
and stable output format.

Particularly tricky to get both correct and fast is
partially-staged files, but git-status gets it right.
By partially staged I mean it has new uncommitted content
in the index as well as even newer content in the worktree.

Files fall roughly into these categories:

1. Staged:
	1.1 Existing file
	1.2 New file
	1.3 Deleted file
	1.4 File was renamed, this is the old path
	1.5 File was renamed, this is the new path


2. Unmerged

3. Modified
	3.1 File was modified
	3.2 File was deleted

4. Untracked
	4.1 This is a file
	4.2 This is a directory


Here's some semantics I would expect from such a command:

- A file can be both staged and modified.

- A file that is unmerged is only unmerged.
  It is neither modified nor staged.

- Untracked path behavior is nicer with git-status then with
  git-ls-files, the reason being that status special-cases
  directories.


Getting all of this information quickly (without having to run
multiple commands) would be ideal.  This command is a
combination of diff-against-worktree, diff-against-index,
show-untracked-files, etc. so it's not a paradigm that's
easily constructed with the existing plumbing.


-- 
		David
