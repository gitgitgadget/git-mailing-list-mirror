From: Cedric Staniewski <cedric@gmx.ca>
Subject: Cross-directory hard links
Date: Mon, 11 May 2009 10:41:31 +0000 (UTC)
Message-ID: <loom.20090511T101424-212@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 12:45:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3T0W-0007Yf-4K
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 12:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbZEKKpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 06:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbZEKKpG
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 06:45:06 -0400
Received: from main.gmane.org ([80.91.229.2]:36473 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751406AbZEKKpE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 06:45:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1M3T0I-0007DV-U9
	for git@vger.kernel.org; Mon, 11 May 2009 10:45:03 +0000
Received: from f053230164.adsl.alicedsl.de ([78.53.230.164])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 May 2009 10:45:02 +0000
Received: from cedric by f053230164.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 May 2009 10:45:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 78.53.230.164 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.10) Gecko/2009042316 Firefox/3.0.10 (.NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118789>

Hi everybody,

git commit 6a0861 [1] made bin/git the target of the builtins hard links which
results in 'cross-directory' hard links. While the Makefile always works fine
for the local installation via 'make install', these links can raise trouble
when installing git via package manager.

The problem only occurs on systems where git's bin and lib directories will be
installed on different file systems, e.g. if /usr and /usr/lib are different
mount points. If you attempt to install a git package which was built with
DESTDIR=/usr and contains such hard links, tar will fail to extract either
bin/git or the builtins (depending on how tar resolves the hard links)
complaining about a 'Invalid cross-device link'.

I know such a setup is probably quite rare, but the problem can easily be fixed
by always copying bin/git to lib/git-add instead of hard linking it.

Cheers,
Cedric

[1]
http://git.kernel.org/?p=git/git.git;a=commit;h=6a0861a8a3295395238c8126c6e74c66b715c595
