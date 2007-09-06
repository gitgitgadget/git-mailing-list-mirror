From: Douglas Stockwell <doug@11011.net>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and
 make stat use that implementation too.
Date: Fri, 07 Sep 2007 08:31:53 +0900
Message-ID: <46E08DE9.4060701@11011.net>
References: <46DACD93.9000509@trolltech.com> <200709022228.00733.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.64.0709022133190.28586@racer.site> <200709022342.42733.robin.rosenberg.lists@dewire.com> <46DBB2BE.8030505@eudaptics.com>    =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?20070903112110.G?= =?ISO-8859-1?Q?E148=0453@genesis.?=
	=?ISO-8859-1?Q?frugalware.org>?= <86y7fohtmw.fsf@lola.quinscape.zz> <20070905160206.GY14853@genesis.frugalware.org> <85abs1hr6t.fsf@lola.goethe.zz> <20070906162657.GF2329@genesis.frugalware.org> <85bqcfbvpe.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 01:32:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITQpc-0005FH-2z
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 01:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbXIFXcL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 19:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbXIFXcL
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 19:32:11 -0400
Received: from vsmtp02.dti.ne.jp ([202.216.231.137]:61028 "EHLO
	vsmtp02.dti.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932599AbXIFXcK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 19:32:10 -0400
Received: from [192.168.1.2] (fw21.opt2.point.ne.jp [210.235.203.21]) by vsmtp02.dti.ne.jp (3.11v) with ESMTP AUTH id l86NW0Sg024460;Fri, 7 Sep 2007 08:32:02 +0900 (JST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <85bqcfbvpe.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57947>

David Kastrup wrote:
> If anybody is as fortunate as to actually have Vista available, it
> would be nice if he corroborated that relative links under Vista are
> indeed (as Microsoft appears to claim) relative with regard to the
> current work directory rather than the directory containing the link.

I believe the wording "resolves the path relative to the current 
directory" actually refers to the creation of links, not to their use.

C:\stest>ver

Microsoft Windows [Version 6.0.6000]

C:\stest>echo test > file

C:\stest>mkdir links

C:\stest>cd links

C:\stest\links>echo links > file

C:\stest\links>mklink relative file
symbolic link created for relative <<===>> file

C:\stest\links>mklink dotted .\file
symbolic link created for dotted <<===>> .\file

C:\stest\links>mklink parent ..\file
symbolic link created for parent <<===>> ..\file

C:\stest\links>mklink rooted \stest\links\file
symbolic link created for rooted <<===>> \stest\links\file

C:\stest\links>mklink absolute c:file
symbolic link created for absolute <<===>> c:file

C:\stest\links>dir
07/09/2007  08:09 AM    <DIR>          .
07/09/2007  08:09 AM    <DIR>          ..
07/09/2007  08:09 AM    <SYMLINK>      absolute [C:\stest\links\file]
07/09/2007  08:09 AM    <SYMLINK>      dotted [.\file]
07/09/2007  08:09 AM                 8 file
07/09/2007  08:09 AM    <SYMLINK>      parent [..\file]
07/09/2007  08:09 AM    <SYMLINK>      relative [file]
07/09/2007  08:09 AM    <SYMLINK>      rooted [\stest\links\file]

C:\stest\links>cd ..

C:\stest>type links\relative
links

C:\stest>type links\dotted
links

C:\stest>type links\parent
test

C:\stest>type links\rooted
links

C:\stest>type links\absolute
links

C:\stest>mkdir a

C:\stest>echo a > a\file

C:\stest>move links a
         1 dir(s) moved.

C:\stest>type a\links\relative
links

C:\stest>type a\links\dotted
links

C:\stest>type a\links\parent
a

C:\stest>type a\links\rooted
The system cannot find the path specified.

C:\stest>type a\links\absolute
The system cannot find the path specified.
