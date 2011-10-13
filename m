From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 21:48:05 +1100
Message-ID: <CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com>
References: <loom.20111013T094053-111@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: arQon <arqon@gmx.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 12:48:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REIq9-0008BS-JU
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 12:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974Ab1JMKsh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Oct 2011 06:48:37 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62090 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571Ab1JMKsg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2011 06:48:36 -0400
Received: by eye27 with SMTP id 27so1691188eye.19
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 03:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=KNfB3cGCIZFyxferWQJhlogas9n4avek2pI53XH2ByE=;
        b=NFfAxEjC6hxKAW0CY1UJaIpovvm9x+2mzkaCio7GjRsNyr+vIsA8hootk3NJhvvHmZ
         f6372z5BoMDB+tiagzypX2rEVUFcV6rKN3a8/PLgvIqfmN/HlmgMExnxp0FDPG6nUO9D
         wkt+Twyno1XcDj8zdQxTR2FLskzPv4b+1ZXNk=
Received: by 10.223.81.205 with SMTP id y13mr5262547fak.34.1318502915161; Thu,
 13 Oct 2011 03:48:35 -0700 (PDT)
Received: by 10.223.88.202 with HTTP; Thu, 13 Oct 2011 03:48:05 -0700 (PDT)
In-Reply-To: <loom.20111013T094053-111@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183466>

On Thu, Oct 13, 2011 at 7:40 PM, arQon <arqon@gmx.com> wrote:
> $ git co master
> M =C2=A0 =C2=A0 =C2=A0 code/renderer/tr_font.cpp
> Switched to branch 'master'
> Your branch is ahead of 'origin/master' by 3 commits.

=2E..

> At this point, reverting the master with "checkout --" also wipes out=
 the
> changes on the other branch. It's like the merge symlinked the two br=
anches
> rather than, well, merging them.

It does show you that there are changes in the working tree and you
could have switched back with "git co -", done whatever you want with
your changes then switched to master again.

> A couple of days ago it DID complain
> when I tried to switch with uncommitted files still present, so it wa=
s working
> properly then. I have no idea what's made it happy to ignore them now=
:
> nothing's changed that I know of.

git tries to keep all changes on working tree you have. If you have
changes in file A and the new branch changes in file B, fine. If the
new branch also changes in file A too, it'll complain because
otherwise it may overwrite your changes. What it actual does is "Two
way merge", there is a table in "git read-tree" man page that
describes exactly how it is done, what cases would fail...

I see it as more choices. As I said above, it does tell you there are
changes and you could do something. You could make alias "co" that
check for worktree/index cleanliness before calling checkout.
Something like this maybe (I have not tested it)

git config alias.co '!git update-index --refresh && git diff-files
--quiet && git diff-index --cached --quiet HEAD && git checkout "$@"'

A config key to enforce this may be nice. I don't know, I have never
had problems with current behavior.
--=20
Duy
