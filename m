From: Alexander Gladysh <agladysh@gmail.com>
Subject: Re: Cherry-pick with symlinks fails horribly
Date: Wed, 10 Mar 2010 21:54:05 +0300
Message-ID: <c6c947f61003101054j514d8d19g5810deb124ac2106@mail.gmail.com>
References: <c6c947f61003081728u48292de4x6f2c26e1ea9c1756@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 10 20:01:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpR9x-0003tm-E7
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 20:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932751Ab0CJTBY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Mar 2010 14:01:24 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58590 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932417Ab0CJTBX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Mar 2010 14:01:23 -0500
Received: by pwj5 with SMTP id 5so440603pwj.19
        for <git@vger.kernel.org>; Wed, 10 Mar 2010 11:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=uILGFFItHJX9ceRKTj+wHqsz01IJ9eURkKxISfBFR2c=;
        b=hTd1GwGEW+RY7y+kZsQTIkqesFwyj3jlMWOZBH/5jl5vPR53udCywmix0oevVLNI61
         vrT1hv/gZDFZsaFFKkd2EobnfGePYXixdJySK4RgZpTLkxZhrdGWgZD4qgXxEm31jkzZ
         Wnn8fF1adexNV1tqzMjjkExQy65UnFbfWDnBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=N4ShCT+0ryqjIISBlMpohfDi5FU+rduN1pGO6bAIlNHQdqZG4kUGif//BXS6aJzawa
         GFlq385VAczpzYyc8zA7bCwCwP/mc2UJQheFD964+rl95aWavNcutC//qWLNxQMLcm9e
         CkNwESVKEjVFY9EOxcYPaFULHDPxnb/IaTcm8=
Received: by 10.141.14.21 with SMTP id r21mr1067904rvi.70.1268247245508; Wed, 
	10 Mar 2010 10:54:05 -0800 (PST)
In-Reply-To: <c6c947f61003081728u48292de4x6f2c26e1ea9c1756@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141912>

Sorry to nag, but... any help?

Alexander.

On Tue, Mar 9, 2010 at 04:28, Alexander Gladysh <agladysh@gmail.com> wr=
ote:
> Hi, list!
>
> OS X 10.6.2
> Git 1.7.0.2
>
> I'm complaining about Git symlink handling again. This time it is che=
rry-pick.
>
> In my repo I have a symlink pointing to a directory.
>
> I swap symlink with the directory in a single commit.
>
> Now, if I try to cherry-pick any later commit from the branch that ha=
s
> that swap commit to a branch that have not, cherry-pick fails
> horribly.
>
> See script to reproduce the bug below (run it in a clean directory).
>
> Output example:
>
> $ git cherry-pick <SHA>
>
> Automatic cherry-pick failed. =A0After resolving the conflicts,
> mark the corrected paths with 'git add <paths>' or 'git rm <paths>'
> and commit the result with:
>
> =A0 =A0 =A0 =A0git commit -c 6a398597ce7a00fe05f43ff88808303eb151dfb5
>
> $ git status # Note the "Untracked files" section
>
> # On branch master
> # Changes to be committed:
> # =A0 (use "git reset HEAD <file>..." to unstage)
> #
> # =A0 =A0 =A0 renamed: =A0 =A0a/f -> f1
> #
> # Unmerged paths:
> # =A0 (use "git reset HEAD <file>..." to unstage)
> # =A0 (use "git add/rm <file>..." as appropriate to mark resolution)
> #
> # =A0 =A0 =A0 added by us: =A0 =A0 =A0 =A0b/a
> #
> # Untracked files:
> # =A0 (use "git add <file>..." to include in what will be committed)
> #
> # =A0 =A0 =A0 b/a~HEAD
>
> (Also I've seen git reset --hard to fail afterwards, complaining it
> can't delete a directory, but I can't reproduce it now.)
>
> I see a similar behaviour if I try to do interactive rebase accross
> symlink swap commit.
>
> Alexander.
>
> #! /bin/bash
>
> git init
>
> mkdir a
> touch a/f
> git add a
> git commit -m "a"
>
> mkdir b
> ln -s ../a b/a
> git add b
> git commit -m "b"
>
> git checkout -b branch
> rm b/a
> mv a b/
> ln -s b/a a
> git add .
> git commit -m "swap"
>
> touch f1
> git add f1
> git commit -m "f1"
>
> git checkout master
>
> git cherry-pick `git rev-parse branch` # This one breaks horribly
>
