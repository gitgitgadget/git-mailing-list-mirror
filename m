From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] path_treatment: also ignore $GIT_DIR if it's not .git
Date: Mon, 2 Dec 2013 19:01:13 +0700
Message-ID: <CACsJy8Afhr1syRW8UetKKHss2r9e2pN2dCmc99Aj9418SxAUMg@mail.gmail.com>
References: <1385922611.3240.6.camel@localhost> <20131201190447.GA31367@kaarsemaker.net>
 <CACsJy8CxR+wj-P+fxF37DU=Tzk=su+V=UudbO7NkqTMS8qTn_w@mail.gmail.com>
 <877gbop3so.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
 <1385941093.3240.10.camel@localhost> <CACsJy8CSQ2RfZub6As9TJc2Vd-wmp75ZVnjQ4nr1QY4mZ4f_TA@mail.gmail.com>
 <1385971274.3240.14.camel@localhost> <CACsJy8AuSej7Pwm5Tbo5r_FNaND1-E62Btk=7dZ74YD8K6UJDg@mail.gmail.com>
 <1385984412.3240.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <tr@thomasrast.ch>,
	Git Mailing List <git@vger.kernel.org>, ingy@ingy.net
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Mon Dec 02 13:01:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnSCD-0003jo-5T
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 13:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787Ab3LBMBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 07:01:45 -0500
Received: from mail-qa0-f45.google.com ([209.85.216.45]:46275 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762Ab3LBMBo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 07:01:44 -0500
Received: by mail-qa0-f45.google.com with SMTP id o15so4258068qap.11
        for <git@vger.kernel.org>; Mon, 02 Dec 2013 04:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QNGyw3d6NAUjjeDxcS3eUaaZlY88t7i9H9n7o95G7nA=;
        b=kvmtUSIQKyb9zA7oBcOxaEDcXW1ZEp83EGUu4W+ZyvM8NcTmsDRRBxxK3CCOKGDWuq
         5jYFcYVwqu+KMCKnU41IkXn4berNqQ0WpVsmhyvgKNkGEF7IApnwoj8q36wwEhXT4IfS
         S/n642NZO5bjajsg6QN//A6y9E2IlvtNFfubL77/5UucKiDWOI0sJdbmPfBm73EPxuh1
         TTfZqmaohiwjwOQxnx23LMW4Zj5c2XeTAOuKOhVXL4sS+xgkpIhrbhOJdhuyJJ8/eFv5
         JqWnCpoKGn+/tR+IxhvpLBiqZNplNptmQJoctfQ2di7+XJKrL8QYiRlLK4aom2pDuH5/
         dFlA==
X-Received: by 10.224.171.196 with SMTP id i4mr114336335qaz.38.1385985703971;
 Mon, 02 Dec 2013 04:01:43 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Mon, 2 Dec 2013 04:01:13 -0800 (PST)
In-Reply-To: <1385984412.3240.17.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238627>

On Mon, Dec 2, 2013 at 6:40 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
>> ~/w/git $ cd t
>> ~/w/git/t $ GIT_TRACE_SETUP=1 ../git --git-dir=../.git --work-tree=..
>> --no-pager status
>> setup: git_dir: /home/pclouds/w/git/.git
>> setup: worktree: /home/pclouds/w/git
>> setup: cwd: /home/pclouds/w/git
>> setup: prefix: t/
>> On branch exclude-pathspec
>> Your branch and 'origin/master' have diverged,
>> and have 2 and 5 different commits each, respectively.
>>
>> I can't say this is the only case though. One has to audit to all
>> possible setup cases in setup_git_directory() to make that claim.
>
> I'm probably missing something, but that's the same as my second
> example, and works. I also tried running it from completely outside the
> repo:
>
> dennis@lightning:~$ code/git/git --git-dir=code/git/.foo --work-tree=code/git status
> On branch master
> nothing to commit, working directory clean
> dennis@lightning:~$ code/git/git --git-dir=/home/dennis/code/git/.foo --work-tree=code/git status
> On branch master
> nothing to commit, working directory clean

It looks like we try to convert git_dir relative to work_tree (in
setup_work_tree) so get_git_dir() probably always returns a path
relative to worktree if it's set. I don't know, it looks like so.
-- 
Duy
