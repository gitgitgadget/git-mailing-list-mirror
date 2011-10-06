From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: git-cherry-pick and git-commit --amend in version 1.7.6.4
Date: Thu, 06 Oct 2011 15:22:56 +0200
Organization: 6WIND
Message-ID: <4E8DABB0.4090206@6wind.com>
References: <4E8C6F2F.1070306@6wind.com>	<CAG+J_DynqAK8uXDPtHwWpGhfA5qFZifucs91qL79Pu_DmCxG3g@mail.gmail.com>	<4E8D5AD0.2040509@6wind.com> <CAG+J_DzY6oW3CgCPDhD81Eue1Ygh+3pR7Q_NZEhauH_qkyUwqQ@mail.gmail.com>
Reply-To: nicolas.dichtel@6wind.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 15:23:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBnuk-0000Xp-PV
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 15:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863Ab1JFNXA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 09:23:00 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55692 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964826Ab1JFNXA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 09:23:00 -0400
Received: by wyg34 with SMTP id 34so2797490wyg.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 06:22:59 -0700 (PDT)
Received: by 10.227.62.196 with SMTP id y4mr1024575wbh.19.1317907379048;
        Thu, 06 Oct 2011 06:22:59 -0700 (PDT)
Received: from [192.168.1.4] (schneckos.n1c0.com. [88.182.61.195])
        by mx.google.com with ESMTPS id n21sm10255266wbp.2.2011.10.06.06.22.57
        (version=SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 06:22:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Thunderbird/3.1.15
In-Reply-To: <CAG+J_DzY6oW3CgCPDhD81Eue1Ygh+3pR7Q_NZEhauH_qkyUwqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182945>

Le 06/10/2011 15:09, Jay Soffian a =C3=A9crit :
> On Thu, Oct 6, 2011 at 3:37 AM, Nicolas Dichtel
> <nicolas.dichtel@6wind.com>  wrote:
>> # ls .git
>> branches  COMMIT_EDITMSG  config  description  FETCH_HEAD  HEAD  hoo=
ks
>>   index info  logs  objects  ORIG_HEAD  packed-refs  refs
>
> No CHERRY_PICK_HEAD, so far so good.
>
>> # git cherry-pick 3f78d1f210ff89af77f042ab7f4a8fee39feb1c9
>> [dev 4cca2c2] drivers/net/usb/asix.c: Fix unaligned accesses
>>   1 files changed, 33 insertions(+), 1 deletions(-)
>
> cherry-pick completes successfully.
>
>> # ls .git
>> branches  CHERRY_PICK_HEAD  COMMIT_EDITMSG  config  description  FET=
CH_HEAD
>> HEAD  hooks  index  info  logs  objects  ORIG_HEAD  packed-refs  ref=
s
>
> This is bad. CHERRY_PICK_HEAD should only exist if the cherry-pick fa=
iled.
>
> I really don't know what could cause this. Possibly a hook in your re=
po?
No hooks:
# ls .git/hooks/
applypatch-msg.sample  post-commit.sample   post-update.sample=20
pre-commit.sample          pre-rebase.sample
commit-msg.sample      post-receive.sample  pre-applypatch.sample=20
prepare-commit-msg.sample  update.sample

>
> Using "GIT_TRACE=3D1 git cherry-pick
> 3f78d1f210ff89af77f042ab7f4a8fee39feb1c9" will tell you whether git i=
s
> running any hooks.
Here is the output:
# GIT_TRACE=3D1 git cherry-pick 3f78d1f210ff89af77f042ab7f4a8fee39feb1c=
9
trace: built-in: git 'cherry-pick' '3f78d1f210ff89af77f042ab7f4a8fee39f=
eb1c9'
trace: run_command: 'commit' '-n' '-F' '.git/MERGE_MSG'
trace: exec: 'git' 'commit' '-n' '-F' '.git/MERGE_MSG'
setup: git_dir: .git
setup: worktree: /home/dichtel/DEV/linux-2.6
setup: cwd: /home/dichtel/DEV/linux-2.6
setup: prefix: (null)
trace: built-in: git 'commit' '-n' '-F' '.git/MERGE_MSG'
[master 8372873] drivers/net/usb/asix.c: Fix unaligned accesses
  1 files changed, 33 insertions(+), 1 deletions(-)
#

>
> I can't think of anything config-wise that would cause this behavior.
With a very basic config, the pb he still here:
cat ~/.gitconfig
[user]
         name =3D Nicolas Dichtel
         email =3D nicolas.dichtel@6wind.com

I will try to do some other tests.


Regards,
Nicolas
