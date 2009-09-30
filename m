From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] send-email: fix mutt regex for grouped aliases
Date: Wed, 30 Sep 2009 03:08:43 +0300
Message-ID: <1254269323-16600-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 30 02:09:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Msmkh-0003qg-Ky
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 02:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbZI3AIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 20:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbZI3AIw
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 20:08:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:52738 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbZI3AIv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 20:08:51 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1956811fge.1
        for <git@vger.kernel.org>; Tue, 29 Sep 2009 17:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=sr8IfOmIpqufXo3wNk7yQtOxZpau0EPdQJqdjkezmUE=;
        b=K4wZ2YUaWrM8U1GQgh4dzAUvIwD0TOCsb1O5+6nzsiaE9V/Vczlhd3AP/KGWkzuYTs
         wrh33M8vUkVrtAb3d4gxSNHXJLTK4I+j4f5n3CXGhbBjdUlDd6V/mulrosdDLBW8CacO
         gs78gV+XP5aYtI8YaEjEIdl/W3iSGIcFa22ts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=s3SlRKxlInFRInuN0Ke1o1KqHP8awgh+wW+48uW4ooh4nreTy1r9OcigYQRON/c4E+
         QNCp7/+rq/fZG9tb9ZG7rkGKHacjj5WQxUVe2WCAmtVwDeXAXO2XNhw+lTwkj8FABPdL
         5lUWoCDcPwCcbWH1khg0FOGhvU2c7Fc2uJn84=
Received: by 10.86.173.4 with SMTP id v4mr4736492fge.78.1254269334674;
        Tue, 29 Sep 2009 17:08:54 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 4sm356742fge.5.2009.09.29.17.08.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Sep 2009 17:08:54 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc2.1.gec34
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129328>

For example:
alias -group friends foo Foo Bar <foo@bar.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 0700d80..ec43a5e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -401,7 +401,7 @@ my %aliases;
 my %parse_alias = (
 	# multiline formats can be supported in the future
 	mutt => sub { my $fh = shift; while (<$fh>) {
-		if (/^\s*alias\s+(\S+)\s+(.*)$/) {
+		if (/^\s*alias\s+(?:-group\s+\S+\s+)?(\S+)\s+(.*)$/) {
 			my ($alias, $addr) = ($1, $2);
 			$addr =~ s/#.*$//; # mutt allows # comments
 			 # commas delimit multiple addresses
-- 
1.6.5.rc2.1.gec34
