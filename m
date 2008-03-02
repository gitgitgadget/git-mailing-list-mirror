From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Mark first match when searching commit messages
Date: Sun,  2 Mar 2008 16:57:14 +0100
Message-ID: <1204473434-26023-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 16:57:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVqZV-0006lF-1p
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 16:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbYCBP5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 10:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753441AbYCBP5P
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 10:57:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:58078 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbYCBP5P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 10:57:15 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1450208ugc.16
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 07:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=cUf68rjk05fyGZUm1FhKozT3QMD/4hjkZ6m9q0pbUiA=;
        b=XnQCcB3WbLwrLnhfNiEAqZnenE7PUj9FDkmCc1y5Dt8lJQKk8Bq2sK35iPIDYQ/7CZR1MK7RWMyR+0WTulaaiVCb8Y6RAwWhgK/alkTs+JQwrxXeQJjXPycemuIxzC8hSBYgQRREqFOKvJu5a8I5h0ccgPx1WpsVVUj3UmAO23M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=e6FwHhthCu0H3JXet4mWTGCbN287xAQbfzGHP0mgH72Y/nTTUQ0jLRtKUlFLlNqOlTBigrKBOAY81UHtuoC3iMruNRpxOonoaHXlR0U3bl8kR3hldO+y8HmDbce7U5q5+u7wuDAQvqYOyFY2R21nzsVO1vrj0yeHvbu5TQZ2R6E=
Received: by 10.78.188.10 with SMTP id l10mr15587227huf.9.1204473433312;
        Sun, 02 Mar 2008 07:57:13 -0800 (PST)
Received: from localhost.localdomain ( [83.8.212.124])
        by mx.google.com with ESMTPS id b33sm20816302ika.5.2008.03.02.07.57.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Mar 2008 07:57:12 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m22FvGlw026045;
	Sun, 2 Mar 2008 16:57:16 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m22FvFmZ026044;
	Sun, 2 Mar 2008 16:57:15 +0100
X-Mailer: git-send-email 1.5.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75798>

Due to greediness of a pattern, gitweb used to mark (show) last match
in line, if there are more than one match in line. Now it shows first.
Showing all matches in a line would require further work.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 20dc5d5..922dee9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3837,7 +3837,7 @@ sub git_search_grep_body {
 		              chop_and_escape_str($co{'title'}, 50) . "<br/>");
 		my $comment = $co{'comment'};
 		foreach my $line (@$comment) {
-			if ($line =~ m/^(.*)($search_regexp)(.*)$/i) {
+			if ($line =~ m/^(.*?)($search_regexp)(.*)$/i) {
 				my ($lead, $match, $trail) = ($1, $2, $3);
 				$match = chop_str($match, 70, 5, 'center');
 				my $contextlen = int((80 - length($match))/2);
-- 
1.5.4.2

