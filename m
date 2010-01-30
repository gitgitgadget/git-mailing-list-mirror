From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5/8 v6] gitweb: add a get function to compliment print_local_time
Date: Sat, 30 Jan 2010 23:30:42 +0100
Message-ID: <1264890645-28310-6-git-send-email-jnareb@gmail.com>
References: <1264890645-28310-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 23:31:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbLqp-0008Ua-AK
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 23:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595Ab0A3Wbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 17:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754620Ab0A3Wbb
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 17:31:31 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:37315 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754148Ab0A3WbG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 17:31:06 -0500
Received: by mail-fx0-f220.google.com with SMTP id 20so3058001fxm.21
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 14:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wn6/QluvoBineKRuXO2aO4hVZa7WYJRq4ViZhd7N48s=;
        b=Y78HCd1pX4SA/V8lcpDC/DClnQOi+8oSJ95crAX9ietnvV/MJ777sIL6YaFml8DW9i
         flFOWvfR89GwncVmKpAIMTyTtmm2Jos1uvUSeYwmptNlkRwVDES5eKNJGn1644+dBiHf
         ubmyLEFdyjjgTGt+x760CLEAJvYxguMn+vMvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AMQnXdHfBljcnfWeBaJZoCIoea8BG2e7ZBMj87hnC1hyXnYL+eSnTOZprOfLbb87Z0
         PVvi6zIl3EqovXEmjImjpU3VgmOy8zeJEaX2rbwTJ7nvttoZKxqT4cEHXzmVaeJGp/I5
         BrZEMBZV9dsLDx8Y9g9L4YvB3uCChti2Zac1U=
Received: by 10.223.13.209 with SMTP id d17mr2184315faa.100.1264890665668;
        Sat, 30 Jan 2010 14:31:05 -0800 (PST)
Received: from localhost.localdomain (abwu191.neoplus.adsl.tpnet.pl [83.8.244.191])
        by mx.google.com with ESMTPS id 15sm1157284fxm.6.2010.01.30.14.31.04
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 30 Jan 2010 14:31:04 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1264890645-28310-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138512>

From: John 'Warthog9' Hawley <warthog9@kernel.org>

This adds a get function (named format_local_time) for print_local_time,
so that the basic function can be used outside of their straight printing
operation.

Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Changes from version from 'Gitweb caching v5' and
  git://git.kernel.org/pub/scm/git/warthog9/gitweb.git gitweb-ml-v5

* Change function name from get_* to format_*, following gitweb
  subroutine naming convention.
* Add final ';'

 gitweb/gitweb.perl |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a4148d3..debaf55 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3509,14 +3509,21 @@ sub git_print_header_div {
 }
 
 sub print_local_time {
+	print format_local_time(@_);
+}
+
+sub format_local_time {
+	my $localtime = '';
 	my %date = @_;
 	if ($date{'hour_local'} < 6) {
-		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
+		$localtime .= sprintf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
 			$date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});
 	} else {
-		printf(" (%02d:%02d %s)",
+		$localtime .= sprintf(" (%02d:%02d %s)",
 			$date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});
 	}
+
+	return $localtime;
 }
 
 # Outputs the author name and date in long form
-- 
1.6.6.1
