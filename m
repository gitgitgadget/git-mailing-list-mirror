From: Hannu Koivisto <azure@iki.fi>
Subject: .gitattributes glob matching broken
Date: Sun, 02 Nov 2008 18:33:51 +0200
Organization: NOYB
Message-ID: <83od0yaxzk.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 02 17:35:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwfv6-0001yr-Ps
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 17:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbYKBQeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 11:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753722AbYKBQeG
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 11:34:06 -0500
Received: from main.gmane.org ([80.91.229.2]:44971 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753674AbYKBQeE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 11:34:04 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kwftm-0001gG-7H
	for git@vger.kernel.org; Sun, 02 Nov 2008 16:33:58 +0000
Received: from s2.org ([195.197.64.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 16:33:58 +0000
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 16:33:58 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:TBLotvyD9XSi1zjbcacb7JsRDig=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99853>

Greetings,

It seems that, for example, glob pattern *.s matches files with .sh
extension at least with checkout and reset --hard but git status
thinks otherwise:

mkdir test
cd test
git init
echo -e "*.sh -crlf\n*.s crlf" > .gitattributes
echo -e "foobar\nfoobar\nfoobar" > kala.s
echo -e "foobar\nfoobar\nfoobar" > kala.sh
git add .gitattributes kala.s kala.sh
git commit -m "Foo."
cd ..
git clone -n test test2
cd test2
git config core.autocrlf true
git checkout
git status

# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working
# directory)
#
#       modified:   kala.sh
#
no changes added to commit (use "git add" and/or "git commit -a")

file kala.s kala.sh

kala.s:  ASCII text, with CRLF line terminators
kala.sh: ASCII text, with CRLF line terminators

Tested in Linux with git 1.6.0.3.535.g933bb (master as of this
writing) but also witnessed in Windows and with slightly older
git versions.

This makes git use in a Windows environment pretty much impossible
if you don't want to / can't rely on git guessing "text"
vs. "binary" files correctly so I hope a solution is found soon.

It would also be good to document what kind of glob patterns git
actually supports.  I made the assumption that at least on Linux it
supports whatever glob(7) says but even if that assumption is
correct (which it may not be, of course) for example Windows users
may not realize to look for such a manual page.

-- 
Hannu
