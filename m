From: Ciaran McCreesh <ciaran.mccreesh@googlemail.com>
Subject: [PATCH] Highlight every 5th line for add -i
Date: Fri, 13 Aug 2010 13:46:09 +0100
Message-ID: <1281703569-8833-1-git-send-email-ciaran.mccreesh@googlemail.com>
Cc: Ciaran McCreesh <ciaran.mccreesh@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 14:46:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjteW-00071u-RY
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 14:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934256Ab0HMMqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 08:46:19 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53764 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934206Ab0HMMqT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 08:46:19 -0400
Received: by wyb32 with SMTP id 32so2590774wyb.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 05:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=BaIWT3mCF9IC6Lu65qThLqI4F9eEUzAI6beAekoXnnU=;
        b=T+dSyfi+zAnG1oEyiSVLrYoKU8cOgVzS0gJQRVKB+S0gDR2mg41QLI1kHKrYqD/pPO
         VDn2DEVEDToL5uU7C1zzubTZYVj0+J5nhVbavpNr1Qnh8HM+NQ+DZKRmeqPuMpCojREq
         OBMTn6K89h1YhNq3AEZqt6K6yVCLTPN3O0ed0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=c0WVVITq6mR0qyl377YmgzXKoCWHgrCqr86C3oRo5jcF5ou1Hw1wftnnZtzA69xXbG
         yOQmE0PFYvApWfyO9WLP3kYFvyvXEmtRBjt8MqXsKke2T96PW+9NQbvt6hxYokFZ120c
         jv5Kk92VpGwmdzN7FQpd6zDIUZB90pXZN57Lw=
Received: by 10.227.153.211 with SMTP id l19mr1214471wbw.224.1281703577646;
        Fri, 13 Aug 2010 05:46:17 -0700 (PDT)
Received: from localhost.localdomain ([92.16.35.83])
        by mx.google.com with ESMTPS id r10sm2279444wbe.6.2010.08.13.05.46.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 05:46:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153471>

It's easier to match up numbers to filenames when there's lots of output
that way.
---
 git-add--interactive.perl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 27fc793..542c29c 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -498,6 +498,7 @@ sub list_and_choose {
 			my $ref = ref $print;
 			my $highlighted = highlight_prefix(@{$prefixes[$i]})
 			    if @prefixes;
+			my $this_line_color = '';
 			if ($ref eq 'ARRAY') {
 				$print = $highlighted || $print->[0];
 			}
@@ -511,7 +512,10 @@ sub list_and_choose {
 			else {
 				$print = $highlighted || $print;
 			}
-			printf("%s%2d: %s", $chosen, $i+1, $print);
+			if ((! $opts->{LIST_FLAT}) && (($i + 1) % 5 == 0) && (@stuff >= 10)) {
+				$this_line_color = $header_color;
+			}
+			printf("%s%s%2d: %s%s", $chosen, $this_line_color, $i+1, $print, $normal_color);
 			if (($opts->{LIST_FLAT}) &&
 			    (($i + 1) % ($opts->{LIST_FLAT}))) {
 				print "\t";
-- 
1.7.2
