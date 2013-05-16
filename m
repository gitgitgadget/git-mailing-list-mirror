From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 2/3] pull: trivial cleanups
Date: Thu, 16 May 2013 05:15:06 -0500
Message-ID: <CAMP44s08Q3xn13iqptf5jAUThHcEWQK5b77=pWLvOnjGsBfSMw@mail.gmail.com>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
	<1368675828-27418-3-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=tP=v=3Q4dzPc=W0=j_7iFYdGnzkaV6U_MFSg=NCE49w@mail.gmail.com>
	<CAMP44s0sg6zQc9=cD1X61joxSd=LK7qT1k-suej3dYDD826hgw@mail.gmail.com>
	<CALkWK0=RF4cjQ4Lz4Qi2iac_NgLdzBRw5Q9uf8KjYJju8swWDQ@mail.gmail.com>
	<CAMP44s1vMTfrSaU+0S8EOM5g4L0885780SvT_THBr7u==bJ06A@mail.gmail.com>
	<CALkWK0kP1yhdhV7oLA4gYJTJ7VtU2WuhtJ_Q5UsZSS00y=FP_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 12:15:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcvDO-0001Wr-Vb
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 12:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431Ab3EPKPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 06:15:10 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:59876 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab3EPKPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 06:15:09 -0400
Received: by mail-la0-f47.google.com with SMTP id fq12so2822038lab.34
        for <git@vger.kernel.org>; Thu, 16 May 2013 03:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=my24t2gd6BBlR7dtAr/dtLkFkS6p08VDkXjY/3Qhllk=;
        b=APtLjH+0PLrDu20dg/GF805ZmanpzYtyELcgipgWXB07V5ChrBkzOXWadlgkB2Z17C
         6Xj+0cWp51rWORAGqeLJvSKxH5SCxtXLPS9Yq1Nsf5VjWD9kpo6cCqyg0yGVqxrdoTa3
         9pYabxiN0a+W5CIEhfI9qZyxYvGJWK4Ddwcnky/WhiaLxwdWm7dMXuQTjJZQnRXWsuC6
         dugwosKwlSwHiBQZWRf1N6C2kkQjLHXMZDScO+AISC2R94IC0rVNyw1aJ7CSwyOyjh5C
         vWazv8l3FHs2pW2D3IR1df2XnltoA/rqKb5N44xay7eflOQc4U9846fMxkol0V6L1bWi
         6UhA==
X-Received: by 10.152.120.4 with SMTP id ky4mr20122057lab.5.1368699307026;
 Thu, 16 May 2013 03:15:07 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 03:15:06 -0700 (PDT)
In-Reply-To: <CALkWK0kP1yhdhV7oLA4gYJTJ7VtU2WuhtJ_Q5UsZSS00y=FP_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224547>

On Thu, May 16, 2013 at 4:54 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> % git fetch origin 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs/heads/*'
>> fatal: Refusing to fetch into current branch
>> refs/heads/fc/fast-export/cleanup of non-bare repository
>> fatal: The remote end hung up unexpectedly
>
> That's because your HEAD is pointing to something under refs/heads/*:
> it would work otherwise.  When I'm developing on my personal branch, I
> sometimes do 'git fetch origin master:master +pu:pu +next:next', and
> it works as expected.  When on master branch, I can't git fetch origin
> master:master and this is a cute safety feature.

Now you know what's the problem.

> Either way, I think it's a bad practice to fetch directly into
> refs/heads/*: you should really be fetching to refs/remotes and then
> merging your changes in.  I do want shortcuts though, which is why I'm
> interested in fixing pull: there is nothing to fix in fetch as far as
> I'm concerned.

It doesn't matter if you think it's a bad practice or not, 'git push
--mirror' works, and it's possible to update a branch even if HEAD is
point to it. There should be a possibility to do the same with 'git
fetch'.

Right now the user is forced to do something like:

	git checkout -q -b tmp &&
	git fetch origin 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs/heads/*' &&
	git checkout -q @{-1} &&
	git branch -q -D tmp 2> /dev/null

Which doesn't seem to be quite right.

-- 
Felipe Contreras
