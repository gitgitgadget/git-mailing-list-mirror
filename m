From: cho <tobutaz@gmail.com>
Subject: Re: [BUG] git-svn not following svn moves
Date: Thu, 18 Oct 2007 13:11:47 +0000 (UTC)
Message-ID: <ff7m2j$2eu$2@ger.gmane.org>
References: <ff7fhg$2eu$1@ger.gmane.org>
	<20071018121328.GA5358@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 15:12:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiVAq-00072e-Bl
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 15:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbXJRNMR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2007 09:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbXJRNMR
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 09:12:17 -0400
Received: from main.gmane.org ([80.91.229.2]:59123 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbXJRNMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 09:12:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IiVAO-0005Yq-7e
	for git@vger.kernel.org; Thu, 18 Oct 2007 13:12:00 +0000
Received: from dhcp26-237.enst.fr ([137.194.26.237])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Oct 2007 13:12:00 +0000
Received: from tobutaz by dhcp26-237.enst.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Oct 2007 13:12:00 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dhcp26-237.enst.fr
User-Agent: Pan/0.129 (Benson & Hedges Moscow Gold)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61527>

Le Thu, 18 Oct 2007 14:13:28 +0200, Peter Baumann a =C3=A9crit=C2=A0:
> Any chance you could provide a testcase which is similar to what
> happened in your private repo so that the problem could be reproduced
> here?

I've surprised myself but yes, there is a simple testcase.

svnadmin create repo
svn checkout file://$PWD/repo checkout
cd checkout/
svn mkdir trunk tags branches
svn ci -m 'Standard svn layout.'
cd trunk/
svn mkdir doc
touch doc/README
svn add doc/README
svn ci -m 'Add README.'
cd ..
svn mv trunk/ branches/oldtrunk
svn ci -m 'Moved trunk.'
svn mkdir trunk
svn ci -m 'New trunk.'
cd trunk/
touch THIS_IS_THE_NEW_TRUNK
svn add THIS_IS_THE_NEW_TRUNK
svn ci -m 'Add marker.'
cd ../..
git svn clone file://$PWD/repo --stdlayout git-clone
cd git-clone/
tree

So the testcase basically involves moving the trunk.
git-svn gets very confused and keeps a mixture of the old and new trunk=
=2E
