From: Jens Seidel <jensseidel@users.sf.net>
Subject: Re: Bug: "git-svn fetch" segfaults on unknown user
Date: Thu, 6 Nov 2008 16:48:09 +0100
Message-ID: <20081106154808.GA27102@merkur.sol.de>
References: <20081106143826.GA26900@merkur.sol.de> <237967ef0811060643g1037b8dbuf3660dfa8e3ff625@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 16:50:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky77u-0005I2-16
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 16:50:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbYKFPtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 10:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbYKFPtI
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 10:49:08 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:55209 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbYKFPtH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 10:49:07 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id E658DF3F5818
	for <git@vger.kernel.org>; Thu,  6 Nov 2008 16:49:05 +0100 (CET)
Received: from [77.179.124.209] (helo=merkur.sol.de)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1Ky76X-0004cI-00
	for git@vger.kernel.org; Thu, 06 Nov 2008 16:49:05 +0100
Received: from jens by merkur.sol.de with local (Exim 4.69)
	(envelope-from <tux-master@web.de>)
	id 1Ky75d-00073P-Os
	for git@vger.kernel.org; Thu, 06 Nov 2008 16:48:10 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <237967ef0811060643g1037b8dbuf3660dfa8e3ff625@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Sender: tux-master@web.de
X-Provags-ID: V01U2FsdGVkX1/OxUoe3TlW2aohS9Gqpkyx2+g6GR+J5ZL19WlG
	6YCZOpCl5byk95RcDrCz71gZbJfaGxMzjk9eUR0Dt/JAnYV1eN
	jv/2IYiUo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100242>

On Thu, Nov 06, 2008 at 03:43:18PM +0100, Mikael Magnusson wrote:
> 2008/11/6 Jens Seidel <jensseidel@users.sf.net>:
> > I noticed the following bug in git-svn version 1.6.0.3 (svn 1.5.5):
> >
> > "git-svn fetch" segfaults if I provide an incomplete svn.authorsfile config
> > file setting with account<-->email mappings. This happens if an unknown user
> > account is found in the Subversion log.

I should really provide more information:

I imported my Subversion repository in the past succesfully from my server
(svn+ssh protocol). Since I'm new to git (and still confused by the large
amount of git tools) I decided to start on a svnsync'ed copy of my repository
(file protocol) to avoid any harm. I added also some new config settings
including svn.authorsfile and fetching revisions started to fail.  The last
output was:

r38 = 4dca32e3d82a32206fd11545d4f270e118f51f12 (trunk@166)
        M       myproject/file

Revision 39 contained the unknown user account so I suspected the error
is related to an incomplete authors file.

I used following versions of Subversion:
Client: 1.5.5
Server: 1.5.3

After adding the missing account to the authors file it fetched all revisions,
called the garbage collector and stilled crashed with a core dump. Last
output:

Checked out HEAD:
  file:///home/jens/Subversion-Repository.synced/myproject/trunk r1700
Abgebrochen (core dumped)

This happened also after I removed the svn.authorsfile config setting.
My current settings:

[user]
  name = Jens Seidel
  email = jensseidel@users.sf.net
[color]
  diff = auto
  branch = auto
  interactive = auto
[svn]
  findcopiesharder = true
  rmdir = true

"gdb -c core" is useless, it just mentions the error occured in
"perl git-svn fetch" and there is no stacktrace (don't know how to
debug perl).

I removed now both [svn] options and it failed again. So it seems a problem
with file:// access while svn+ssh:// works well.

> Are you sure this isn't the regular svn 1.5.x crash? Ie, does
> compiling subversion with --disable-runtime-module-search fix it?

Huch? I follow the Subversion developer list and I'm not not aware of
such a problem. Will try it now ...

PS: Compared to previous releases of git the import is at least 10 times
faster. Good job!

Jens
