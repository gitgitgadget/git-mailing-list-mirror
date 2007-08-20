From: Mike Hommey <mh@glandium.org>
Subject: Re: confused about preserved permissions
Date: Mon, 20 Aug 2007 19:41:42 +0200
Organization: glandium.org
Message-ID: <20070820174142.GA7943@glandium.org>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 19:42:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INBGr-0001uE-66
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 19:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbXHTRm3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 13:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbXHTRm3
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 13:42:29 -0400
Received: from vawad.err.no ([85.19.200.177]:53634 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765AbXHTRm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 13:42:28 -0400
Received: from aputeaux-153-1-3-249.w82-124.abo.wanadoo.fr ([82.124.49.249] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1INBGZ-0004Jc-13
	for git@vger.kernel.org; Mon, 20 Aug 2007 19:42:23 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1INBG2-00026Z-Vj
	for git@vger.kernel.org; Mon, 20 Aug 2007 19:41:42 +0200
Content-Disposition: inline
In-Reply-To: <20070820164411.GA15637@piper.oerlikon.madduck.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56228>

On Mon, Aug 20, 2007 at 06:44:11PM +0200, martin f krafft <madduck@madduck.net> wrote:
> Why does git bother saving a mode when later it never seems to use
> it again?

Same applies to git-archive, which generates files with mode 666 and
directories with 777, while it could follow the modes in the
repository... or at least, that's what the manpage claims, but facts
seem to be quite different...

mh@namakemono:~/git/git$ git-archive --format=tar HEAD | tar -tvf -
-rw-rw-r-- root/root      2365 2007-08-19 20:45 .gitignore
-rw-rw-r-- root/root      1973 2007-08-19 20:45 .mailmap
-rw-rw-r-- root/root     18787 2007-08-19 20:45 COPYING
drwxrwxr-x root/root         0 2007-08-19 20:45 Documentation/
-rw-rw-r-- root/root        63 2007-08-19 20:45 Documentation/.gitignore
-rw-rw-r-- root/root      4553 2007-08-19 20:45 Documentation/Makefile
(...)
mh@namakemono:~/git/git$ git-ls-tree HEAD
100644 blob 63c918c667fa005ff12ad89437f2fdc80926e21c    .gitignore
100644 blob 5529b198e8d14decbe4ad99db3f7fb632de0439d    .mailmap
100644 blob 6ff87c4664981e4397625791c8ea3bbb5f2279a3    COPYING
040000 tree 865a32f4b417cbb601524ac2b78ca64ff232302c    Documentation
100755 blob 3c0032cec592a765692234f1cba47dfdcc3a9200    GIT-VERSION-GEN
(...)

mh@namakemono:~/git/git$ umask
0022

And no value is set for umask in git config...

I also never understood why there were no permissions set on directories
in trees... nor why, while the sha1 for child objects are "packed", the
modes aren't...

Mike
