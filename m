From: Joe Eykholt <joe@nuovasystems.com>
Subject: minor makefile issues
Date: Thu, 02 Aug 2007 11:04:41 -0700
Message-ID: <46B21CB9.9050303@nuovasystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 20:20:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGfI7-0005U3-Fb
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 20:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756189AbXHBSUu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 14:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755982AbXHBSUu
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 14:20:50 -0400
Received: from nuova-ex1.nuovasystems.com ([67.91.200.196]:35308 "EHLO
	nuova-ex1.nuovasystems.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753227AbXHBSUt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Aug 2007 14:20:49 -0400
X-Greylist: delayed 973 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Aug 2007 14:20:49 EDT
Received: from [172.16.12.94] ([172.16.12.94] RDNS failed) by nuova-ex1.nuovasystems.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 2 Aug 2007 11:04:35 -0700
User-Agent: Thunderbird 1.5.0.12 (X11/20070509)
X-OriginalArrivalTime: 02 Aug 2007 18:04:35.0980 (UTC) FILETIME=[95FB44C0:01C7D52F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54583>

Hi All,

Due to my unusual environment, I ran into two issues when installing git 
1.5.2.4 from source.
Although these are unusual, they might not be unique and the fixes are easy:

    1.  The make install failed because of line 49 in templates/Makefile:
           (cd blt && $(TAR) cf - .) | \
           (cd '$(DESTDIR_SQ)$(template_dir_SQ)' && $(TAR) xf -)
    because I have CDPATH set, the 'cd blt' actually outputs the new 
directory on stdout
    which confuses the second tar.  Changing this to 'cd ./blt' fixes 
it.  Perhaps this could
    be considered a bash bug.

    2.  My home directory containing my build tree is NFS-mounted, and 
root doesn't have any
    permission to write it.  So, when doing 'make prefix=/usr/local 
install-doc' as root, I got these errors:

    # make prefix=/usr/local install-doc
    make -C Documentation install
    make[1]: Entering directory 
`/net/da01/home/jre/build/git-1.5.2.4/Documentation'
    rm -f doc.dep+ doc.dep
    rm: cannot remove `doc.dep': Permission denied
    make[1]: *** [doc.dep] Error 1
    make[1]: Leaving directory 
`/net/da01/home/jre/build/git-1.5.2.4/Documentation'
    make: *** [install-doc] Error 2

I'm not sure what the best fix is for the second problem.  rm -f ignores 
non-existent files but not permission errors.
I guess you could do 'rm -f doc.dep || true'.

No response necessary.  Just thought you might like to know about 
these.  Otherwise, git seems nice!

    Thanks,
    Joe Eykholt
