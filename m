From: David Kastrup <dak@gnu.org>
Subject: Re: "git clone" executed as root on solaris 10 shreds UFS (it is possible to create hardlinks for directories as root under solaris)
Date: Mon, 16 Jul 2007 12:51:46 +0200
Message-ID: <86644kaaf1.fsf@lola.quinscape.zz>
References: <20070716100803.GA24036@cip.informatik.uni-erlangen.de> <20070716104342.GB24036@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 12:55:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAOEW-0003uG-Mz
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 12:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757717AbXGPKzM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 06:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755738AbXGPKzM
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 06:55:12 -0400
Received: from main.gmane.org ([80.91.229.2]:54275 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754862AbXGPKzL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 06:55:11 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IAOEI-0001T0-Tw
	for git@vger.kernel.org; Mon, 16 Jul 2007 12:55:02 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 12:55:02 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 12:55:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:xcG9+TlYicAxcbg+iHzKZ6X2xAs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52660>

Thomas Glanzmann <thomas@glanzmann.de> writes:

> Hello,
> I narrowed it down. It is in "git checkout" if I copy the ".git" dir via
> "cp -a" and type in "git checkout" it breaks. And it _only_ breaks for
> subdirectories:

Another guess: cp -a copies files preserving all permissions and
ownerships (which works only as root).  Nominally, the files now don't
belong to you, and some scripts might take you by the word even if
they _could_ just overwrite things if they actually tried.  Try
making

chown -R root.root .git

on your tree and see whether this makes git more comfortable.

-- 
David Kastrup
