From: Charles Strahan <charles@cstrahan.com>
Subject: Change in .gitignore handling: intended or bug?
Date: Thu, 03 Mar 2016 21:11:56 -0500
Message-ID: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 03:12:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abfDn-00031o-3b
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 03:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661AbcCDCL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 21:11:58 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33228 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753278AbcCDCL5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Mar 2016 21:11:57 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id D527B2268D
	for <git@vger.kernel.org>; Thu,  3 Mar 2016 21:11:56 -0500 (EST)
Received: from web5 ([10.202.2.215])
  by compute2.internal (MEProxy); Thu, 03 Mar 2016 21:11:56 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=cstrahan.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=rvv
	ApzhroHZ3GNV6EHntwq4C4B8=; b=bG0+0QV3QWNjkEpKQ1jNYI1TWKqMUSgzvOo
	XPkhsS9R2xowpoEOJQ+WouwTfuaaPKJuBPoq8ORkJW0MuwxKAvJ1t5y2kxhfFT27
	+nT07RajNoElHGv0xUmOa8oc+3tLkQv2eCQxeq+mOUVgqFoanuGxyjP7MRsaON8t
	Ulmt0v10=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=rvvApzhroHZ3GNV6EHntwq4C4B8=; b=q55CL
	irZ28/JvgDuCvI6Hp+1dC13grW2HuwVaZdHntNGzE21p3cVzgvNnay7M2IbPx2Vt
	OopihMwP8xZ6i6+x4OuLl70YXT0tnZfdXTpRvqGF/cE8zpKorz9eoOVaTe21lgTt
	8/6hvfgWfXeLUdNnKEA8MHlVS5k5xVFt8zgRz4=
Received: by web5.nyi.internal (Postfix, from userid 99)
	id 963B6AC3A36; Thu,  3 Mar 2016 21:11:56 -0500 (EST)
X-Sasl-Enc: dEttNshLh91wwywCWyu7Lx1/XSc4UauQXM3JfXe2rKWb 1457057516
X-Mailer: MessagingEngine.com Webmail Interface - ajax-b8d6474a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288228>

Hello,

I've found a change in the way .gitignore works, and I'm not sure if
it's a bug
or intended.

Previously, one could use the following .gitignore:

    *
    !/foo
    !/foo/bar.txt
    !/baz
    !/baz/quux
    !/baz/quux/**/*

And these files would be seen by git:

    foo/bar.txt
    baz/quux/grault.txt
    baz/quux/corge/wibble.txt

And these files would be ignored:

    foo/garply.txt
    baz/waldo.txt

At some point (between git 2.6.0 and 2.7.0, I think), the behavior
changed such
that _none_ of the files above would be ignored. Previously, git would
treat
!/foo as an indication that it should not prune /foo, but that
_wouldn't_ be
sufficient to un-ignore the contents thereof. Now, it seems the new
scheme
treats !/foo as functionally equivalent to !/foo followed by !/foo/**/*
in the
old scheme.

I manage my home directory by making it a git repo, and using
~/.gitignore to
selectively permit certain files or subdirectories to be seen by git.
The recent
change in behavior has resulted in sensitive directories like ~/.gpg
being
un-ignored. For reference, I've appended my .gitignore to the end of
this email.

So, is this behavior intended, or is this a bug? If the former, is there
an
announcement explaining this change?

-Charles

(.gitignore is as follows)

*
!/.Xdefaults
!/.Xresources
!/.ackrc
!/.bash_profile
!/.config
!/.config/dunst
!/.config/dunst/dunstrc
!/.config/taffybar
!/.config/taffybar/taffybar.hs
!/.config/taffybar/taffybar.rc
!/.ctags
!/.gdb
!/.gdb/**/*
!/.gdbinit
!/.gemrc
!/.ghci
!/.git_template
!/.git_template/**/*
!/.gitexcludes
!/.gitignore
!/.gnupg
!/.gnupg/dirmngr.conf
!/.gnupg/gpg.conf
!/.goobook/
!/.goobook/decipher
!/.goobook/decipher/goobookrc
!/.inputrc
!/.irbrc
!/.irssi
!/.irssi/**/*
!/.mbsyncrc
!/.msmtprc
!/.mutt
!/.mutt/accounts
!/.mutt/accounts/*
!/.mutt/gpg.rc
!/.mutt/mailcap
!/.mutt/muttrc
!/.mutt/signature
!/.mutt/theme/*
!/.nixpkgs
!/.nixpkgs/**/*
!/.notmuch-config
!/.pystartup
!/.tmux
!/.tmux.conf
!/.tmux/**/*
!/.vim
!/.vim/**/*
!/.vimrc
!/.xmonad
!/.xmonad/xmonad.hs
!/.xsession
!/.zlogin
!/.zprofile
!/.zsh
!/.zsh/**/*
!/.zshenv
!/.zshrc
!/osx
