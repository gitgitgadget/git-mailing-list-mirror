From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] send-email: squelch warning due to comparing undefined $_ to ""
Date: Wed, 20 Feb 2008 00:55:07 -0500
Message-ID: <1203486907-12304-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 06:55:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRhvp-00049R-W9
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 06:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755922AbYBTFzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 00:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754723AbYBTFzN
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 00:55:13 -0500
Received: from ag-out-0708.google.com ([72.14.246.247]:6929 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934AbYBTFzL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 00:55:11 -0500
Received: by ag-out-0708.google.com with SMTP id 33so3818810agc.1
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 21:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=sPFdiqHfgUTgoRS9lE7YPrDZZuKs7gDLERyw9YYVtFU=;
        b=vxhtGFqi83S5FGJr/7zzg1f6/MUjtY3y1yyTlMp7hTSjm77ffLuOJSzrc4UbgPMuHdif0AknKhhttYuwFPp51ZA+tgQ7zYKlieQRaOVfnjZoJ1kOPt59dny3tGPEKIPu22i98c9xEgpa8XDCRQLSNV5BGVzfPcKYf0lGDngu5yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=IrgavIorRQiBR8qOjXxmDKyw1LEEJXgDzY6KBYPqTi0+kZA3S1KYKTTArBVvPugRWJHy7rDOP5aGy2b1TEE2uCOv6TtdYqykGT7mVAAyJWT5/4fjWPZSYwaGeUmFJKGbKfNSnAYK+XCiBT4BdebUV+nS9COCSuCKLTKy29ngShM=
Received: by 10.100.251.5 with SMTP id y5mr16238685anh.12.1203486909817;
        Tue, 19 Feb 2008 21:55:09 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id d29sm14621056and.28.2008.02.19.21.55.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Feb 2008 21:55:09 -0800 (PST)
X-Mailer: git-send-email 1.5.4.2.208.gfb302
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74503>

The check to see if initial_reply_to is defined was also comparing $_ to
"" for a reason I cannot ascertain (looking at the commit which made the
change didn't provide enlightenment), but if $_ is undefined, perl
generates a warning.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Junio, the commit which introduced the change was yours, but I don't
see why you were comparing $_ to "". 

http://repo.or.cz/w/git.git?a=commit;h=ace9c2a9dd7c9e54194998fc6b7c677dbb7d0902

 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 59601e3..ccb87a2 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -475,7 +475,7 @@ if ($thread && !defined $initial_reply_to && $prompting) {
 
 	$initial_reply_to = $_;
 }
-if (defined $initial_reply_to && $_ ne "") {
+if (defined $initial_reply_to) {
 	$initial_reply_to =~ s/^\s*<?/</;
 	$initial_reply_to =~ s/>?\s*$/>/;
 }
-- 
1.5.4.2.208.gfb302
