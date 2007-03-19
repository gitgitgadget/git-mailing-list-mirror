From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 5/5] cvsserver: Abort if connect to database fails
Date: Mon, 19 Mar 2007 16:56:01 +0100
Message-ID: <11743197672771-git-send-email-frank@lichtenheld.de>
References: <11743197614111-git-send-email-frank@lichtenheld.de>
Cc: Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 17:01:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTKHU-0003Q1-RO
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 17:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbXCSQAS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 12:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbXCSQAS
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 12:00:18 -0400
Received: from mail.lenk.info ([217.160.134.107]:62959 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030263AbXCSQAR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 12:00:17 -0400
Received: from herkules.lenk.info ([213.239.194.154] helo=smtp.lenk.info)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HTKET-00047U-Pc; Mon, 19 Mar 2007 16:57:14 +0100
Received: from p54b0eb28.dip.t-dialin.net ([84.176.235.40] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HTKE9-0005vD-SC; Mon, 19 Mar 2007 16:56:53 +0100
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HTKDP-0005vx-Cd; Mon, 19 Mar 2007 16:56:07 +0100
X-Mailer: git-send-email 1.5.0.3
In-Reply-To: <11743197614111-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42631>

Currently all calls to the database backend make no
error checking or handling at all. At least abort
if the connection to the database failed since
there is really no way we could do anything useful
after that.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 git-cvsserver.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 6d10aa3..941a91b 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2168,6 +2168,7 @@ sub new
     $self->{dbh} = DBI->connect("$self->{dbdriver}:dbname=$self->{dbname}",
                                 $self->{dbuser},
                                 $self->{dbpass});
+    die "Error connecting to database\n" unless defined $self->{dbh};
 
     $self->{tables} = {};
     foreach my $table ( $self->{dbh}->tables )
-- 
1.5.0.3
