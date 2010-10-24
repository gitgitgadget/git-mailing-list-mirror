From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 08/10] gitweb: refactor repository URL printing
Date: Sun, 24 Oct 2010 12:45:34 +0200
Message-ID: <1287917136-26103-9-git-send-email-giuseppe.bilotta@gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 12:46:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9y5y-0004rf-Sh
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 12:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482Ab0JXKqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 06:46:20 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39237 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932465Ab0JXKqS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 06:46:18 -0400
Received: by mail-ww0-f44.google.com with SMTP id 15so2499176wwe.1
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 03:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QCgoNsHxeMgISwmRudn4WL4WC0uv1GiRoQEN+50e4AQ=;
        b=eOL8rzjbNlEH3z+T5O5TG8zqzgH+Cl8YmjjcFvgq5DawTM9cmqpfqwDGywbwVpsz7a
         VqYKriOXnUv78T3+Nztgvn8rAXTA6JigJ1rLVizgv8VqflZd331XjJzhe1Tdger6ecXl
         LOVo1F6RVQl4+r7z28ujGo+iswc1RgR7GESw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=I/PaQHuY8Vup/SDKjxh7sDk4eXdCF8UkgB7IH9ODFzMQu8oi4PgetDjAONEOEe0piH
         hnw7gyevE9guuEf1SF0uY112HzGvRUSiD5ZB+xHMVYOFWu0lGMBwZNiMgJLbbQojwRwC
         e4soZsoLDbZaSeNU24/GhH5H7+z7AyvF7uMIM=
Received: by 10.216.56.65 with SMTP id l43mr1600555wec.113.1287917177429;
        Sun, 24 Oct 2010 03:46:17 -0700 (PDT)
Received: from localhost ([151.60.176.122])
        by mx.google.com with ESMTPS id b10sm3310774wer.41.2010.10.24.03.46.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 03:46:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159853>

Factor out the code to display the repository URL(s) from summary view
into a format_rep_url() routine.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index aa80748..ec2626d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3800,6 +3800,11 @@ sub git_print_header_div {
 	      "\n</div>\n";
 }
 
+sub format_repo_url {
+	my ($name, $url) = @_;
+	return "<tr class=\"metadata_url\"><td>$name</td><td>$url</td></tr>\n";
+}
+
 sub print_local_time {
 	print format_local_time(@_);
 }
@@ -5183,7 +5188,7 @@ sub git_summary {
 	@url_list = map { "$_/$project" } @git_base_url_list unless @url_list;
 	foreach my $git_url (@url_list) {
 		next unless $git_url;
-		print "<tr class=\"metadata_url\"><td>$url_tag</td><td>$git_url</td></tr>\n";
+		print format_repo_url($url_tag, $git_url);
 		$url_tag = "";
 	}
 
-- 
1.7.3.68.g6ec8
