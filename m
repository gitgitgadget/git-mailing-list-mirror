From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [BUG] git_path() returns relative paths
Date: Sun, 28 Jul 2013 07:25:43 +0800
Message-ID: <CANYiYbEiE+S3J3MR=YyK8Tn48zfmhzJjBjnuPtxzd6WtBU8duA@mail.gmail.com>
References: <CALkWK0m-4wtpTAcePPWFLT7iwXdcpp+nOy9oG2iFHLsp9XdKZQ@mail.gmail.com>
	<CALkWK0k-23rTohYvNWP_XbuUCSGUE+G_e_7cBbPP5C9OzsJ4XQ@mail.gmail.com>
	<CALkWK0kBesC2=kyygMCt61Fm5GGqX+yF6sbkCRcGYZ=ovgtTAQ@mail.gmail.com>
	<CACsJy8C5Du8zcqVeN7EGuyUxgSZaRq-X8y_hQvqQedYWfP8p+A@mail.gmail.com>
	<CALkWK0kWnge7fVtTXRgTiK1NbyN8X=bmqfPTc+Mp=BCssPc1og@mail.gmail.com>
	<CACsJy8CDg2ORKrpwiph=WdW5GPUYEwT1CSCttQ4fagQoMP4QGA@mail.gmail.com>
	<CALkWK0=xuNGM54=Kodfi9L8_yUOaXrWvqiMHbx2SRTH1CmZxLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 28 01:25:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3Drx-00081K-Iu
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jul 2013 01:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732Ab3G0XZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jul 2013 19:25:45 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:59548 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630Ab3G0XZp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 19:25:45 -0400
Received: by mail-we0-f179.google.com with SMTP id t57so2904898wes.38
        for <git@vger.kernel.org>; Sat, 27 Jul 2013 16:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1ZFveX9VdTExUXxJujWPUZlXCDj5yrselIXxGPoqLfo=;
        b=TeTbUaL0i/PKELB5SEpirwjE1T3sf9VHkHincTpbT2ydZp43NFYAxbaS5h8Bm/4mhi
         HL/X5s5g7iaKJUmmTah5Su2S+s8OCdpRppBzKhrddaZrmON8Q+6NEK2J84qovwscZelu
         91R3XFls9jta9bXkh0aNWiIHbNkgosYLeszusLNzWg8PSN5WUJb2v82OWzt0EvS1osAI
         RkDadB9gr0yUk2790px9LE6N57umYEfETzVTxLjSPEEfcnLPRoKzc3dU1fDsTOgUPIr2
         4l+zTgi3JFKsJ6ec4PnSO0eYb830VK75WAXDoBLkfiC8rMUzfKI/lcivJYumHsrG/1ns
         hpRA==
X-Received: by 10.194.133.106 with SMTP id pb10mr38354943wjb.62.1374967543394;
 Sat, 27 Jul 2013 16:25:43 -0700 (PDT)
Received: by 10.194.176.129 with HTTP; Sat, 27 Jul 2013 16:25:43 -0700 (PDT)
In-Reply-To: <CALkWK0=xuNGM54=Kodfi9L8_yUOaXrWvqiMHbx2SRTH1CmZxLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231255>

2013/7/28 Ramkumar Ramachandra <artagnon@gmail.com>:
> Duy Nguyen wrote:
>> I was involved with this code (the gitdir setup code, not submodule)
>> and am interested to know what's going on too. Could you produce a
>> small script to reproduce it?
>
> Here's your reduced testcase. Just point mygit to a HEAD build.
>
>   #!/bin/sh
>
>   mygit=~/src/git/git
>   cd /tmp
>   $mygit clone https://github.com/artagnon/clayoven
>   cd clayoven
>   $mygit submodule add https://github.com/lewang/flx .elisp/flx
>   $mygit commit -a -m "Added submodule"
>   cd /tmp
>   ln -s clayoven/.elisp
>   cd .elisp/flx
>   EDITOR="emacs -Q" git commit --amend

The keypoint is that you set GIT_EDITOR to "emacs -Q". Last night
I can not reproduce the bug, because I use vim as the editor.
Vim as a editor may call realpath before open file.

I change the EDITOR(GIT_EDITOR) environment in your test script
as follows:

    GIT_EDITOR="echo PWD: $(pwd); echo REALPATH: $(pwd -P); echo" \
    git commit --amend

And the result is :

    PWD: /tmp/.elisp/flx
    REALPATH: /private/tmp/clayoven/.elisp/flx
    ../../.git/modules/.elisp/flx/COMMIT_EDITMSG
    [master 248e49e] add usage information
     Author: Le Wang <le.wang@agworld.com.au>
     1 file changed, 27 insertions(+)

How to fix this bug, I have no idea now.

-- 
Jiang Xin
