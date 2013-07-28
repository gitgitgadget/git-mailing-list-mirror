From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG] git_path() returns relative paths
Date: Sun, 28 Jul 2013 11:37:55 +0700
Message-ID: <CACsJy8AuAy7PnEU20k23gVRQoFrLhJrM6hfESZKshUA578c3Ew@mail.gmail.com>
References: <CALkWK0m-4wtpTAcePPWFLT7iwXdcpp+nOy9oG2iFHLsp9XdKZQ@mail.gmail.com>
 <CALkWK0k-23rTohYvNWP_XbuUCSGUE+G_e_7cBbPP5C9OzsJ4XQ@mail.gmail.com>
 <CALkWK0kBesC2=kyygMCt61Fm5GGqX+yF6sbkCRcGYZ=ovgtTAQ@mail.gmail.com>
 <CACsJy8C5Du8zcqVeN7EGuyUxgSZaRq-X8y_hQvqQedYWfP8p+A@mail.gmail.com>
 <CALkWK0kWnge7fVtTXRgTiK1NbyN8X=bmqfPTc+Mp=BCssPc1og@mail.gmail.com>
 <CACsJy8CDg2ORKrpwiph=WdW5GPUYEwT1CSCttQ4fagQoMP4QGA@mail.gmail.com> <CALkWK0=xuNGM54=Kodfi9L8_yUOaXrWvqiMHbx2SRTH1CmZxLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Xin Jiang <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 28 06:38:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3Ikp-0002S5-BH
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jul 2013 06:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891Ab3G1Ei0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jul 2013 00:38:26 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:46303 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab3G1EiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jul 2013 00:38:25 -0400
Received: by mail-oa0-f52.google.com with SMTP id g12so10639280oah.11
        for <git@vger.kernel.org>; Sat, 27 Jul 2013 21:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XOs2LgaeRGYIsUfWDOQhEwnnwWI/7nyQAa1hT3DfLMs=;
        b=gKkuqDBvgIFavRzi5M3qhsXCfz144E7SoHcZuwO5Xl2RvVL/KwkpNf2UBJcyK7nJ4D
         jK+Movf5xPGkkZqYVsO0yMypUr77KNTWej49WtV7FfXK76M4FlG+8B0wCgLUZmeEI6vQ
         iqGwR62Hu5wf7p5yOVIqoDAY70tzL8KHl6xIyttwvMmvjYFVUvEDfoJMnquf1VpaUcwY
         invWufkIRSCJpu9yENTmuNNWe5kPbtO6QmcP7QZVgFYvRc5/JfHpjIC4LI/SABDMydCg
         0aLFS/6+nwOk0pz3W6SM0/KLcvJj3b0OK0JTCzkje9Kj/I/18EOT8+pKRUSyehXVhGDM
         zN7A==
X-Received: by 10.182.34.166 with SMTP id a6mr48172570obj.102.1374986305313;
 Sat, 27 Jul 2013 21:38:25 -0700 (PDT)
Received: by 10.182.240.168 with HTTP; Sat, 27 Jul 2013 21:37:55 -0700 (PDT)
In-Reply-To: <CALkWK0=xuNGM54=Kodfi9L8_yUOaXrWvqiMHbx2SRTH1CmZxLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231258>

On Sat, Jul 27, 2013 at 11:05 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
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
>   # buffer-file-name = "/tmp/.git/modules/.elisp/flx/COMMIT_EDITMSG"

Here cwd is /tmp/.elisp/flx but "setup: cwd: " returns
/tmp/clayoven/.elisp/flx. The COMMIT_EDITMSG path is
../../.git/modules/.elisp/flx/COMMIT_EDITMSG. If you follow the former
cwd (without symlink resolution), you end up at /tmp/.git/modules. If
you follow the latter cwd, you end up at /tmp/clayoven/.git/modules...
I think instead of letting the kernel walk the path, emacs does it by
itself. Still looking for documents about this behavior..

> Note that this is emacs 24.3. I used -Q to make sure that none of my
> init magic (magit etc.) was responsible for changing directories or
> doing something equally stupid. However, considering that it's
> impossible to reproduce the problem with either cat or vim as the
> EDITOR, you might be inclined to classify this as an Emacs bug. In
> that case, why can't I reproduce it without submodules?
>
> I'm going off to eat cake before I tear my hair out in frustration.
-- 
Duy
