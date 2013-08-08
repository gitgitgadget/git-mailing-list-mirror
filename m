From: gitml.jexpert@recursor.net
Subject: Reproducible, corrupt packfile after fresh
Date: Thu, 08 Aug 2013 13:56:30 +0200
Message-ID: <f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 08 13:56:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Opb-0008TL-4K
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 13:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323Ab3HHL4f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Aug 2013 07:56:35 -0400
Received: from gourmet7.spamgourmet.com ([216.75.62.102]:43881 "EHLO
	gourmet8.spamgourmet.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751708Ab3HHL4e convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Aug 2013 07:56:34 -0400
Received: from spamgourmet by gourmet7.spamgourmet.com with local (Exim 4.80)
	(envelope-from <gitml.jexpert@recursor.net>)
	id 1V7OpV-0002PS-TZ
	for git@vger.kernel.org; Thu, 08 Aug 2013 11:56:33 +0000
Received: from mail.exxcellent.de ([217.6.238.198])
	by gourmet7.spamgourmet.com with esmtp (Exim 4.80)
	(envelope-from <gitml.jexpert@recursor.net>)
	id 1V7OpV-0002PE-Ic
	for ; Thu, 08 Aug 2013 11:56:33 +0000
In-Reply-To: <52037F84.9060006@exxcellent.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231872>

I'm a heavy user of git-svn and experience an issue with one specific
(git-svn) repository: 'git fsck' reports a corrupt packfile after every
checkout.

Now I'm totally puzzled about the cause and what do about it.
This is what I do:

    git svn init -s http://svn.foo.com/myproject myproject.git
    cd myproject.git
    git svn fetch         # Much more reliable than 'git-svn clone'

This checks out ~2100 commits and executes 2 git-gc during checkout. Th=
e
final .git repo size is about 940MB. Then I run

    git fsck

=E2=9E=9C myproject.git git:(master) git fsck
Checking object directories: 100% (256/256), done.
error: packed 0f5f33639bfc1a781fe080c31a1f076d9a25c1d3 from
=2Egit/objects/pack/pack-6a6f5355584a5d71215d5fc867ce09602ceab533.pack =
is
corrupt
*** glibc detected *** git: free(): invalid pointer: 0x00007f46a09e9010=
 ***
=3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
/lib/x86_64-linux-gnu/libc.so.6(+0x7eb96)[0x7f46d9ebab96]
git[0x4ddf46]
git[0x4b4123]
git[0x431524]
git[0x405ce8]
git[0x4050e2]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xed)[0x7f46d9e5d76d]
git[0x405529]
=3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D
00400000-0055f000 r-xp 00000000 fc:01 12452043
 /usr/bin/git
0075e000-0075f000 r--p 0015e000 fc:01 12452043
 /usr/bin/git

=2E...


This only affects this very particular git-svn repo (and I have dozens
of them). The error happens reproducible on every fresh checkout as
described above. The backtrace does not appear always. The object is a
very large blob

    git show 0f5f33639bfc1a781fe080c31a1f076d9a25c1d3 | wc -c
    39524691


Any hints what to do?

Thanks
- Ben
