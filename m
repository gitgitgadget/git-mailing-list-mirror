From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH/RFC] cvsserver: Make configuration way more flexible
Date: Mon, 19 Mar 2007 16:55:56 +0100
Message-ID: <11743197614111-git-send-email-frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 17:01:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTKHV-0003Q1-Sq
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 17:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbXCSQAV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 12:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbXCSQAV
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 12:00:21 -0400
Received: from mail.lenk.info ([217.160.134.107]:62959 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030275AbXCSQAS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 12:00:18 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HTKEK-000471-L8
	for <git@vger.kernel.org>; Mon, 19 Mar 2007 16:57:04 +0100
Received: from p54b0eb28.dip.t-dialin.net ([84.176.235.40] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HTKE0-0005uc-OD
	for <git@vger.kernel.org>; Mon, 19 Mar 2007 16:56:44 +0100
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HTKDJ-0005vh-3A
	for git@vger.kernel.org; Mon, 19 Mar 2007 16:56:01 +0100
X-Mailer: git-send-email 1.5.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42632>

Hi.

This patch series started with the thought that it is really cumbersome
to use the pserver access via git-cvsserver without giving the
nobody user write access to the .git directory itself (especially since
SQLite seems to insist on creating temporary files in the
same directory as the database itself on writes).

This problem itself is easily fixable with an one-line patch
to git-cvsserver that uses a gitcvs.dbdir configuration variable.

I tried to abstract the problem a bit more though and created
means to configure all aspects of the database backend in a
very flexible manner. I would glad about comments on wether
I made my solution overly complex on the way...

Most of the changes are tested intensively with test repositories,
exceptions are noted in the individual patches. More testing welcome
of course.

The documentation updates are not yet complete.

Gruesse,
	Frank Lichtenheld

 Documentation/git-cvsserver.txt |   12 ++++++
 git-cvsserver.perl              |   72 ++++++++++++++++++++++++++++------------
 2 files changed, 63 insertions(+), 21 deletions(-)
