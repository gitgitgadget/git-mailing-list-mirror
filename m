From: Chris Packham <judge.packham@gmail.com>
Subject: Re: git loses commits on git pull --rebase with Dictator and
 Lieutenants Workflow
Date: Fri, 30 Jan 2015 06:27:03 +1300
Message-ID: <CAFOYHZDLPr1sJ2Agyq6tT=ahpgNp=eL_Q4c=-iDd9i_JqFNTcg@mail.gmail.com>
References: <loom.20150128T203924-608@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>
To: Dick <dick@mrns.nl>
X-From: git-owner@vger.kernel.org Thu Jan 29 18:27:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGss3-0002qz-0S
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 18:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbbA2R1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 12:27:05 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:48472 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623AbbA2R1D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2015 12:27:03 -0500
Received: by mail-pa0-f47.google.com with SMTP id lj1so41464737pab.6
        for <git@vger.kernel.org>; Thu, 29 Jan 2015 09:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iEEuds+Zx2ifl5WWgnWrZEYwTSRAhOXKYwMnqgAhtl4=;
        b=s0Rdx9fewlT8vWLfQzhXLNuN0ThoULII8xKaryocWxlyPSvx05+F6tm3HE6gifEfFB
         Us2g9HA3EiCPT01kDzKCkM6gdbmHCr5B6FhuDDy60fyf6k9p71iZ0Pjr21XkQx1qRj1L
         fwciERfrYvogl2DhVCEvAsYh42AFdysDwx2r06KZ8kLAkSBbwktzCOABEfq1isxH2qhW
         NgV7Axifsrac8Pb/QciHC07qL+liMYcZN2+sctH2cAiilzW2vNLhFLsZYgZGdCF0bglF
         Ic9sdnWNBcUIpY/8kpZkLDpKmmQr+Br4FGjB7bJQ7FWeWTZh1Ump1WMWZfXcNEJ9oV1S
         Scwg==
X-Received: by 10.68.189.167 with SMTP id gj7mr2500396pbc.58.1422552423183;
 Thu, 29 Jan 2015 09:27:03 -0800 (PST)
Received: by 10.70.109.199 with HTTP; Thu, 29 Jan 2015 09:27:03 -0800 (PST)
In-Reply-To: <loom.20150128T203924-608@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263154>

Hi,

On Thu, Jan 29, 2015 at 8:49 AM, Dick <dick@mrns.nl> wrote:
> Hi all,
>
> I've encountered a problem with the Dictator and Lieutenants Workflow. I've
> configured remote origin so it pulls from the "blessed repository" and
> pushes to the "developer public" repository.
>
> When the "blessed repository" has the same branch name as the "developer
> public" repository git pull seems to drop commits.
>
> I've create a test script to demonstrate, left is the blessed repository,
> right.git is the developer public and right is the developer private
> repository.
>
> rm -rf left/ right/ right.git/
> git init left
> cd left/
> echo "hello world" > test.txt
> git add test.txt
> git commit -m .
> cd ..
> git clone --bare left right.git
> git clone right.git/ right
> cd right
> git remote set-url origin ../left
> git remote set-url origin --push ../right.git
> echo "bye world" >> test.txt
> git commit -a -m .
> git push
> git log
> echo "start: two commits, ok"
> git fetch
> git rebase origin/master
> git log
> echo "manual fetch/rebase: two commits, still ok"
> git pull --rebase
> git log
> echo "pull: one commits, oops?"
>
> Am I using git wrong or is this a git bug?
>
> Thanks for having a look!
>
> Dick

I can confirm the behaviour that Dick is seeing with git 2.0.4
(happens to be what I was running on my laptop). Just rebuilding
2.3.0-rc2 now.

AFAIK 'git fetch && git rebase origin/master' and 'git pull -r' in the
scenario above should be roughly equivalent.

I'll see if I can work the testcase above into an actual test script.
