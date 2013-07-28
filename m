From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] git_path() returns relative paths
Date: Sun, 28 Jul 2013 05:33:12 +0530
Message-ID: <CALkWK0=FA0g9W7T4=qULJS+FN=WduA3jDmpSq01xayr9SsncgA@mail.gmail.com>
References: <CALkWK0m-4wtpTAcePPWFLT7iwXdcpp+nOy9oG2iFHLsp9XdKZQ@mail.gmail.com>
 <CALkWK0k-23rTohYvNWP_XbuUCSGUE+G_e_7cBbPP5C9OzsJ4XQ@mail.gmail.com>
 <CALkWK0kBesC2=kyygMCt61Fm5GGqX+yF6sbkCRcGYZ=ovgtTAQ@mail.gmail.com>
 <CACsJy8C5Du8zcqVeN7EGuyUxgSZaRq-X8y_hQvqQedYWfP8p+A@mail.gmail.com>
 <CALkWK0kWnge7fVtTXRgTiK1NbyN8X=bmqfPTc+Mp=BCssPc1og@mail.gmail.com>
 <CACsJy8CDg2ORKrpwiph=WdW5GPUYEwT1CSCttQ4fagQoMP4QGA@mail.gmail.com>
 <CALkWK0=xuNGM54=Kodfi9L8_yUOaXrWvqiMHbx2SRTH1CmZxLA@mail.gmail.com> <CANYiYbEiE+S3J3MR=YyK8Tn48zfmhzJjBjnuPtxzd6WtBU8duA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 28 02:04:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3ESt-0001td-II
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jul 2013 02:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847Ab3G1ADz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jul 2013 20:03:55 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:48811 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611Ab3G1ADz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 20:03:55 -0400
Received: by mail-oa0-f47.google.com with SMTP id m6so3464636oag.6
        for <git@vger.kernel.org>; Sat, 27 Jul 2013 17:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lhZ1143UdABzVEfa+mtnwstFLjxytCOeMj6f9kfeSbg=;
        b=WPC6kzEJNJk2Rw3zmVRqN99AEptHuebo10kJ704QO/6KBSC749jFAzfZW/xaVI57Tl
         76OLj1epIvmiGiaJOSNs0pCN5pfFGWmQDFDNw+DSm9SJTNXtiKkmtG9l/K1dGvE4DMW9
         3KIgTzmXN6GuO3JEJaldac9i9GQGI4AkqAP/9fK9bUB74YUE1iKzqMYk5arkfiCVnQB8
         83wItRd5eC3DgKrv2r/uc8O1z93jtG4bsPWHgsvKZVFeI8DT+ZBxolg/tbpn2jVsijKf
         Ip1Iza4nNE2wAaFLDL8ZJrTGDSXVDQPAlKlaE8EYEBrTj9gxe2KLHJlq3+2TgJqijCmG
         z4qA==
X-Received: by 10.43.88.3 with SMTP id ay3mr20593301icc.61.1374969834507; Sat,
 27 Jul 2013 17:03:54 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Sat, 27 Jul 2013 17:03:12 -0700 (PDT)
In-Reply-To: <CANYiYbEiE+S3J3MR=YyK8Tn48zfmhzJjBjnuPtxzd6WtBU8duA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231256>

Jiang Xin wrote:
> I change the EDITOR(GIT_EDITOR) environment in your test script
> as follows:
>
>     GIT_EDITOR="echo PWD: $(pwd); echo REALPATH: $(pwd -P); echo" \
>     git commit --amend

See, what stumps be about this is the no-submodule case:

  #!/bin/sh

  mygit=~/src/git/git
  cd /tmp
  rm -rf clayoven lib
  $mygit clone https://github.com/artagnon/clayoven
  ln -s clayoven/lib
  cd lib/clayoven
  EDITOR="echo PWD: $(pwd); echo REALPATH: $(pwd -P); echo" \
  git commit --amend
  # buffer-file-name = "/tmp/.git/modules/.elisp/flx/COMMIT_EDITMSG"

>From the point of view of $EDITOR, how is this different?  Yet, when
you change EDITOR to "emacs -Q", it works fine.
