From: Jon Loeliger <jdl@jdl.com>
Subject: [BUG] Failed to make install-info
Date: Thu, 13 Dec 2007 09:38:40 -0600
Message-ID: <E1J2q92-0001YT-BZ@jdl.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 17:12:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2qgB-0004UC-Ey
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 17:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbXLMQMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 11:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753186AbXLMQMd
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 11:12:33 -0500
Received: from jdl.com ([208.123.74.7]:51227 "EHLO jdl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753148AbXLMQMc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 11:12:32 -0500
X-Greylist: delayed 2028 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Dec 2007 11:12:32 EST
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>)
	id 1J2q92-0001YT-BZ
	for git@vger.kernel.org; Thu, 13 Dec 2007 09:38:41 -0600
X-Spam-Score: -1.6 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68169>


Guys,
I managed to fail to install info files during:

    /usr/src/git# make prefix=/usr install-info

The /usr/share/info/dir file is readable.  But it
looks like our build isn't supplying a description
that is needed by install-info?  Is my info really
old or something?

This is:

    1693 % pwd
    /usr/src/git
    1694 % git describe
    v1.5.4-rc0
    1695 % git rev-parse HEAD
    1e8df762b38e01685f3aa3613e2d61f73346fcbe

and:

    1698 % install-info --version
    Debian install-info version 1.14.5.

Thanks,
jdl



make -C Documentation install-info
make[1]: Entering directory `/usr/src/git/Documentation'
rm -f doc.dep+ doc.dep
/usr/bin/perl ./build-docdep.perl >doc.dep+
mv doc.dep+ doc.dep
make -C ../ GIT-VERSION-FILE
make[2]: Entering directory `/usr/src/git'
make[2]: `GIT-VERSION-FILE' is up to date.
make[2]: Leaving directory `/usr/src/git'
make[1]: Leaving directory `/usr/src/git/Documentation'
make[1]: Entering directory `/usr/src/git/Documentation'
make -C ../ GIT-VERSION-FILE
make[2]: Entering directory `/usr/src/git'
make[2]: `GIT-VERSION-FILE' is up to date.
make[2]: Leaving directory `/usr/src/git'
install -d -m 755 /usr/share/info
install -m 644 git.info gitman.info /usr/share/info
if test -r /usr/share/info/dir; then \
          install-info --info-dir=/usr/share/info git.info ;\
          install-info --info-dir=/usr/share/info gitman.info ;\
        else \
          echo "No directory found in /usr/share/info" >&2 ; \
        fi

No `START-INFO-DIR-ENTRY' and no `This file documents'.
install-info(git.info): unable to determine description for `dir' entry - giving up

No `START-INFO-DIR-ENTRY' and no `This file documents'.
install-info(gitman.info): unable to determine description for `dir' entry - giving up
make[1]: *** [install-info] Error 1
make[1]: Leaving directory `/usr/src/git/Documentation'
make: *** [install-info] Error 2
