From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git push requires a subsequent git reset --hard ?
Date: Tue, 01 Jul 2008 10:29:38 -0700 (PDT)
Message-ID: <m3vdzpfr16.fsf@localhost.localdomain>
References: <912ec82a0807010951j9e970f2k9624682b33c8af7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Neshama Parhoti" <pneshama@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 19:30:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDjgf-0005nx-Ds
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 19:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbYGAR3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 13:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753691AbYGAR3n
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 13:29:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:36641 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129AbYGAR3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 13:29:41 -0400
Received: by nf-out-0910.google.com with SMTP id d3so616379nfc.21
        for <git@vger.kernel.org>; Tue, 01 Jul 2008 10:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=B+2aRGYQifarA3I+ag4bndk8AeE63H62djOC1VxzMn8=;
        b=jbM1rKB1Sdz1nsAXliMcOZzRIGT5bf0UXDIfe6o3T1AFNvo4UU+/3mKPEjh1GtWHo7
         crQ9ZX0IFjNvcK/xCbhqlfuWwR9tu1zThySGQCE/FwxZggej93BhYOC8uBkFoFYuEXE6
         YWQRnvJ47tuba8kcIvATzSkUCFF3tCvCEzsmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=xdEd7SVH+RrD7Tg8iGmAenD8NzqpYWOX2enjCNuvHG4nzfKIXzJw7QG88bQr/utEom
         I0EL0vLFLyX2fYMxkyL9IkuKkXh93etWH4mRvYuC8/2fXFCBUAgNxwj3aBKDEU1vucM8
         FGinSlxliu6p7Yo2f3CQbsiUJ3wRysmzJXeyw=
Received: by 10.210.26.10 with SMTP id 10mr5604709ebz.63.1214933379365;
        Tue, 01 Jul 2008 10:29:39 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.248.226])
        by mx.google.com with ESMTPS id y37sm8850180iky.8.2008.07.01.10.29.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jul 2008 10:29:38 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m61HXQ8t032738;
	Tue, 1 Jul 2008 19:33:26 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m61HXPdf032735;
	Tue, 1 Jul 2008 19:33:25 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <912ec82a0807010951j9e970f2k9624682b33c8af7d@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87057>

"Neshama Parhoti" <pneshama@gmail.com> writes:

> I took with me a copy of a local repository to a week away from my station
> (just rsync'ed it to my laptop).
> 
> On my return, I just "git push myuser@my-station:/my/git/repo" from my laptop.
> It seemed to work with no probs.
>
> On my station the git repo got the new commits, as I can see in
> git-log, but the actual files were left untouched.
> 
> So I need to do something like "git reset --hard HEAD" to get
> the changes into the local files.
> 
> Is that considered normal ?

This is considered normal.  Push would never touch index nor working
area (although if you are the only user, and you know what you are
doing, you can add "git reset --hard HEAD" to post-receive hook).  It
is the only way: "push" cannot be opposite of "pull" and do a merge
because there is nobody to resolve conflict on remote side.

So you should either do mirroring (1:1 refspec) push into bare
repository (without working directory), or push into remotes section,
remotes/satellite or remotes/mothership, like shown in GitFaq, below.

See also:
* "Why won't I see changes in the remote repo after "git push"?"
  http://git.or.cz/gitwiki/GitFaq#head-b96f48bc9c925074be9f95c0fce69bcece5f6e73
* "How would I use "git push" to sync out of a firewalled host?"
  http://git.or.cz/gitwiki/GitFaq#head-46de97a5ac549d3adf406c22674b3325ae25d09c
-- 
Jakub Narebski
Poland
ShadeHawk on #git
