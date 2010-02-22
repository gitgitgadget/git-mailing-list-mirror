From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: [BUG] git gui blame: Show History Context broken since 29e5573d
Date: Mon, 22 Feb 2010 09:27:00 +0100
Message-ID: <vpqaav1llpn.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 11:02:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjTgN-0000lM-GL
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 09:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846Ab0BVIaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 03:30:18 -0500
Received: from imag.imag.fr ([129.88.30.1]:53132 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654Ab0BVIaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 03:30:16 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o1M8R4Di025058
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 22 Feb 2010 09:27:04 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NjTd6-0003LD-Eb; Mon, 22 Feb 2010 09:27:00 +0100
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 22 Feb 2010 09:27:05 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140652>

Hi,

In "git gui blame", right-clicking on the left fringe and chosing
"Show History Context" in the context-menu doesn't work for me in the
latest git. It says:

couldn't change working directory to "": no such file or directory
couldn't change working directory to "": no such file or directory
    while executing
"cd $_gitworktree"
    (procedure "do_gitk" line 25)
    invoked from within
"do_gitk $cmdline"
    (procedure "blame::_gitkcommit" line 47)
    invoked from within
"blame::_gitkcommit ::blame::__o1::__d"
    invoked from within
".ctxm invoke active"
    ("uplevel" body line 1)
    invoked from within
"uplevel #0 [list $w invoke active]"
    (procedure "tk::MenuInvoke" line 50)
    invoked from within
"tk::MenuInvoke .ctxm 1"
    (command bound to event)

Git bisect shows me the guilty commit:

commit 29e5573d1ef67c92314c39e55d26504fee119c04
Author: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Date:   Sat Jan 23 11:03:35 2010 +0100

    git-gui: handle bare repos correctly
    
    Refactor checking for a bare repository into its own proc, that relies
    on git rev-parse --is-bare-repository if possible. For older versions of
    git we fall back to a logic such that the repository is considered bare
    if:
     * either the core.bare setting is true
     * or the worktree is not set and the directory name ends with .git
    The error message for the case of an unhandled bare repository is also
    updated to reflect the fact that the problem is not the funny name but
    the bareness.
    
    The new refactored proc is also used to disable the menu entry to
    explore the working copy, and to skip changing to the worktree before
    the gitk invocation.
    
    Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
    Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

This is in a non-bare repo.

Anyone to fix this?

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
