From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 7/9] gitweb: picon avatar provider
Date: Sat, 27 Jun 2009 14:05:03 +0200
Message-ID: <1246104305-15191-8-git-send-email-giuseppe.bilotta@gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-5-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-6-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-7-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 27 14:06:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKWfl-0007Dq-LX
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 14:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754118AbZF0MFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 08:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754109AbZF0MFd
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 08:05:33 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:36837 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474AbZF0MFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 08:05:16 -0400
Received: by fxm18 with SMTP id 18so161012fxm.37
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 05:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=WumgySTlAEvRJ6Y6plq4CCIAJbdEpG1RUHvzdDpxSi8=;
        b=n9BmqEtZ/NfrCzLK4mcnQ2jtUQXsP5B4UF0p5JRlHNudjCvT4AlBZcGBYX//WGC51A
         RLfgWp4JyBP+cwV1lgcD7FyDLarHUAd+rVXPrpWaVGxyUmXyiHqQFc7ItgW+bOhuTPyC
         BtvfmR0h2zRB3q9wS/KBTGxtN7AcMspuwA3Js=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=n49cQvvVN6MPd4wimbz13lpnVRfqj02gY6Uc8gc1mkt10xupRq+EB2AlEzN8TTaOu4
         u2mkyLhZDAvbLlgFysMpnz83q8118oYH8TWGRXtEqmG4vjel/GGOHQ9X9T/YfnNvE0iW
         eqvSeOz8Xb9/kq/I1athjbjp459+0hCCLqNdA=
Received: by 10.86.25.14 with SMTP id 14mr287763fgy.14.1246104316805;
        Sat, 27 Jun 2009 05:05:16 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-10-227.clienti.tiscali.it [94.37.10.227])
        by mx.google.com with ESMTPS id e11sm2151006fga.1.2009.06.27.05.05.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Jun 2009 05:05:16 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1246104305-15191-7-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122362>

Simple implementation of picon that only relies on the indiana.edu
database.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index de4cc63..ae73d45 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -378,14 +378,17 @@ our %feature = (
 	# shortlog or commit will display an avatar associated with
 	# the email of the committer(s) and/or author(s).
 
-	# Currently only the gravatar provider is available, and it
-	# depends on Digest::MD5.
+	# Currently available providers are gravatar and picon.
+
+	# Gravatar depends on Digest::MD5.
+	# Picon currently relies on the indiana.edu database.
 
 	# To enable system wide have in $GITWEB_CONFIG
-	# $feature{'avatar'}{'default'} = ['gravatar'];
+	# $feature{'avatar'}{'default'} = ['provider'];
+	# where provider is either gravatar or picon.
 	# To have project specific config enable override in $GITWEB_CONFIG
 	# $feature{'avatar'}{'override'} = 1;
-	# and in project config gitweb.avatar = gravatar;
+	# and in project config gitweb.avatar = provider;
 	'avatar' => {
 		'sub' => \&feature_avatar,
 		'override' => 0,
@@ -856,6 +859,8 @@ our @snapshot_fmts = gitweb_get_feature('snapshot');
 our ($git_avatar) = gitweb_get_feature('avatar');
 if ($git_avatar eq 'gravatar') {
 	$git_avatar = '' unless (eval { require Digest::MD5; 1; });
+} elsif ($git_avatar eq 'picon') {
+	# no dependencies
 } else {
 	$git_avatar = '';
 }
@@ -1523,6 +1528,17 @@ sub format_subject_html {
 # given page, there's no risk for cache conflicts.
 our %avatar_cache = ();
 
+# Compute the picon url for a given email, by using the picon search service over at
+# http://www.cs.indiana.edu/picons/search.html
+sub picon_url {
+	my $email = lc shift;
+	if (!$avatar_cache{$email}) {
+		my ($user, $domain) = split('@', $email);
+		$avatar_cache{$email} = "http://www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/$domain/$user/users+domains+unknown/up/single";
+	}
+	return $avatar_cache{$email};
+}
+
 # Compute the gravatar url for a given email, if it's not in the cache already.
 # Gravatar stores only the part of the URL before the size, since that's the
 # one computationally more expensive. This also allows reuse of the cache for
@@ -1546,6 +1562,8 @@ sub git_get_avatar {
 	my $url = "";
 	if ($git_avatar eq 'gravatar') {
 		$url = gravatar_url($email, $size);
+	} elsif ($git_avatar eq 'picon') {
+		$url = picon_url($email);
 	}
 	# Currently only gravatars are supported, but other forms such as
 	# picons can be added by putting an else up here and defining $url
-- 
1.6.3.rc1.192.gdbfcb
