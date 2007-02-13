From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 14:36:44 -0500
Message-ID: <eqt40c$5ov$1@sea.gmane.org>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com> <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de> <200702131816.27705.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 20:37:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH3Sg-0000qa-0o
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 20:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbXBMThF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 14:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbXBMThF
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 14:37:05 -0500
Received: from main.gmane.org ([80.91.229.2]:33527 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750815AbXBMThE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 14:37:04 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HH3ST-0002c9-HJ
	for git@vger.kernel.org; Tue, 13 Feb 2007 20:36:57 +0100
Received: from sahara.mdnt.com ([12.109.151.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Feb 2007 20:36:57 +0100
Received: from mdl123 by sahara.mdnt.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Feb 2007 20:36:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: sahara.mdnt.com
User-Agent: KNode/0.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39582>

Alexander Litvinov wrote:

> ? ????????? ?? Tuesday 13 February 2007 16:06 Johannes Schindelin
> ???????(a):
>> Hi,
>>
>> On Tue, 13 Feb 2007, Alexander Litvinov wrote:
>> > When I have file that was converted from dos to unix format (or from
>> > unix to dos) git genereta big diff. But anyway, c++ compiler works well
>> > with both formats and in this case I simply convert file to dos format
>> > and git shows again nice diff. If unix format was commited to git I
>> > simply change the format and commit that file again.
>>
>> That's awful!
> If you are tring to build history that looks good - you are right this is
> a terrible workflow.
> 
>> > The only trouble is the rebase, it does not like \r\n ending and othen
>> > produce unexpected merge conflict. But I don't use rebse to othen to
>> > realy investigate and try to solve the problem.
>>
>> Well, if everybody thinks like you, maybe we do not have to change
>> anything for Windows after all?
> I still wish to have working rebase so if git will hanle somehow \r\n it
> would be nice. But please do not produce the same behavior as cvs does:
> under cygwin it still use \n !

Cygwin != Windows, Cygwin is a POSIX emulation layer with the explicit goal
of providing user tools behaving exactly as they do under Linux, and this
includes line ending style.

So, the Cygwin ports of various Linux tools are not expected to satisfy
users who want native Win32 behavior. This is where the mingw port of git
fits in. Yes, under Cygwin git can track files with \r\n endings, but: 
1) Those projects are not portable to non-windows platforms, and 
2) As you noted, git will have trouble with rebase, merge, etc. as there is
an assumption of \n endings throughout.

A proper win32 port will accept any of \n, \r\n as valid line endings (add
\r to support Mac pre-OSX if anyone cares, I still occasionally see such
files), treat any of them as semantically equal, and enforce the user's
chosen style (\n or \r\n) on output. cvsnt and svn under Windows do this
today, serving up "text" files from the same repository with \n endings or
\r\n endings depending upon the client, and is what we need a win32 git to
do as well.

Mark
