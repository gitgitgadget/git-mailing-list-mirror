From: Johan Herland <johan@herland.net>
Subject: Re: put THEIR commits AFTER my commits with a single rebase command
Date: Thu, 18 Apr 2013 08:21:18 +0200
Message-ID: <CALKQrgeYrsOOR9z+khOkGWhy38LPXwHFo9wf8RrZr3LsM3zTAg@mail.gmail.com>
References: <1928280357.20130418091807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 08:40:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USiVq-0005nu-VA
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 08:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823Ab3DRGkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 02:40:00 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:61927 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab3DRGj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 02:39:59 -0400
X-Greylist: delayed 1114 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Apr 2013 02:39:59 EDT
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1USiDi-000HGj-6n
	for git@vger.kernel.org; Thu, 18 Apr 2013 08:21:22 +0200
Received: from mail-oa0-f49.google.com ([209.85.219.49])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1USiDh-0002ad-Sg
	for git@vger.kernel.org; Thu, 18 Apr 2013 08:21:22 +0200
Received: by mail-oa0-f49.google.com with SMTP id j6so2371458oag.8
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 23:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=4SlCugAoFp444wEuG8fejcix3ffjSOYyiMfnwtjvKhs=;
        b=Gly/2uHTnIT9G7Q8HqWIB8lhSL8JGi6kcNmOR/qIxklsrEq7CiGxHeFLtkBSu/aQX1
         Ah7arPYl8wggBE3g+kTBSZAdqjkJYuirqfFaC3hFA7RUIbdbppRDlG3C+lND/eUk33BJ
         FTIdpEma5OKtvPDRo7C4YuGu4NUh8fNsD+hTBc9XSvHC6fOnBC5ZIbXBgshZQVT7wQJi
         OZ/PNI5devP7yxBRHPGnMgg/Q70vTEZr+n8z4XgAM5OTuTWAhWdQLrTfXDKN5PpZMugm
         KksCDJoRhdLCr5ludD16A1MKGyN3j5l1YdJZs+GdQItLDBimHuytKS/sHX/xwgzyMpdt
         C6VQ==
X-Received: by 10.60.29.37 with SMTP id g5mr4640029oeh.140.1366266078288; Wed,
 17 Apr 2013 23:21:18 -0700 (PDT)
Received: by 10.182.210.233 with HTTP; Wed, 17 Apr 2013 23:21:18 -0700 (PDT)
In-Reply-To: <1928280357.20130418091807@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221613>

On Thu, Apr 18, 2013 at 7:18 AM, Ilya Basin <basinilya@gmail.com> wrote:
> I asked this on stackoverflow, but no reply.
> http://stackoverflow.com/questions/15971244/git-put-their-commits-after-my-commits-with-a-single-rebase-command
>
> Suppose master and origin/master diverged.
> I'm on master and I want to put the commits from origin/master after my commits and then push --force.
>
>          A---B---C origin/master
>         /
>     D---E---F---G *master
>
> desired result:
>
>          A---B---C origin/master
>         /
>     D---E---F---G---A'---B'---C' *master

Note that if other people are working on top of origin/master, then
what you are proposing is quite rude to them, since they must now
manually rebase their own work on top of your rebased history.
Rewriting public history is generally considered evil.

> Variant 1:
>
>     git branch -f tmp
>     git reset --hard origin/master
>     git rebase tmp
>
> This variant is bad, because 'git reset --hard' checks out some files and 'git rebase' rewrites them again before applying commits. It's a redundant job.
> Variant 2:
>
>     git branch -f tmp origin/master
>     git rebase --onto master master tmp
>     git branch -f master
>     git checkout master
>
> Too many commands. I want to do this with just one command. And I want
> to stay be on branch master in case of rebase conflicts.

git cherry-pick master..origin/master


...Johan

--
Johan Herland, <johan@herland.net>
www.herland.net
