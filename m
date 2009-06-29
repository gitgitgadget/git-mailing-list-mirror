From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv8 6/7] gitweb: picon avatar provider
Date: Tue, 30 Jun 2009 00:00:53 +0200
Message-ID: <1246312854-3365-7-git-send-email-giuseppe.bilotta@gmail.com>
References: <1246312854-3365-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1246312854-3365-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1246312854-3365-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1246312854-3365-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1246312854-3365-5-git-send-email-giuseppe.bilotta@gmail.com>
 <1246312854-3365-6-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 30 00:01:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLOv4-0005Hd-2r
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 00:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758105AbZF2WBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 18:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753716AbZF2WBF
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 18:01:05 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:63590 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758164AbZF2WA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 18:00:59 -0400
Received: by mail-bw0-f213.google.com with SMTP id 9so3551293bwz.37
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 15:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XIxEEmspO2ijPalVpxdOb25DyoKk80U5bwVUoKiVI64=;
        b=GI0ERTxog7ALnI2FRyEJMIDsMdVPWIzxzMdtxInjzipL2vySip+Rj7nHPpBJaWSTdG
         IzcTUCIIqhP0fLNHjb1WBrYmhpQ54eG21ONVpOn4FfSwfKyJx4omgxzPQmN2lzDb1csq
         EYbEuGGuyC6GptQkYfHICXyatnuMar3IWhRns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HxfbVUetp3eaZkgGaQP02+jpveXHUms2o4b+hVujfNBDzdpW4CU89K6wrL5zX//hVQ
         A9pZhv7O3mf4k+8pSJyqTcqUPsEmgJafz7i7k2JkuBjCUYPE+LT0WwsXHHWFWXn8PUV0
         4TEKoiNFaFzPBws9QiHTAIJ3SKodOXwniriL8=
Received: by 10.204.58.130 with SMTP id g2mr7654573bkh.45.1246312862658;
        Mon, 29 Jun 2009 15:01:02 -0700 (PDT)
Received: from localhost (host-78-13-59-48.cust-adsl.tiscali.it [78.13.59.48])
        by mx.google.com with ESMTPS id 21sm2599656fks.9.2009.06.29.15.01.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 15:01:02 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1246312854-3365-6-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122473>

Simple implementation of picon that only relies on the indiana.edu
database.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   34 +++++++++++++++++++++++++++-------
 1 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4d7e4ff..862ea99 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -378,15 +378,18 @@ our %feature = (
 	# shortlog or commit will display an avatar associated with
 	# the email of the committer(s) and/or author(s).
 
-	# Currently only the gravatar provider is available, and it
-	# depends on Digest::MD5. If an unknown provider is specified,
-	# the feature is disabled.
+	# Currently available providers are gravatar and picon.
+	# If an unknown provider is specified, the feature is disabled.
+
+	# Gravatar depends on Digest::MD5.
+	# Picon currently relies on the indiana.edu database.
 
 	# To enable system wide have in $GITWEB_CONFIG
-	# $feature{'avatar'}{'default'} = ['gravatar'];
+	# $feature{'avatar'}{'default'} = ['<provider>'];
+	# where <provider> is either gravatar or picon.
 	# To have project specific config enable override in $GITWEB_CONFIG
 	# $feature{'avatar'}{'override'} = 1;
-	# and in project config gitweb.avatar = gravatar;
+	# and in project config gitweb.avatar = <provider>;
 	'avatar' => {
 		'sub' => \&feature_avatar,
 		'override' => 0,
@@ -853,6 +856,8 @@ our @snapshot_fmts = gitweb_get_feature('snapshot');
 our ($git_avatar) = gitweb_get_feature('avatar');
 if ($git_avatar eq 'gravatar') {
 	$git_avatar = '' unless (eval { require Digest::MD5; 1; });
+} elsif ($git_avatar eq 'picon') {
+	# no dependencies
 } else {
 	$git_avatar = '';
 }
@@ -1520,6 +1525,20 @@ sub format_subject_html {
 # given page, there's no risk for cache conflicts.
 our %avatar_cache = ();
 
+# Compute the picon url for a given email, by using the picon search service over at
+# http://www.cs.indiana.edu/picons/search.html
+sub picon_url {
+	my $email = lc shift;
+	if (!$avatar_cache{$email}) {
+		my ($user, $domain) = split('@', $email);
+		$avatar_cache{$email} =
+			"http://www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/" .
+			"$domain/$user/" .
+			"users+domains+unknown/up/single";
+	}
+	return $avatar_cache{$email};
+}
+
 # Compute the gravatar url for a given email, if it's not in the cache already.
 # Gravatar stores only the part of the URL before the size, since that's the
 # one computationally more expensive. This also allows reuse of the cache for
@@ -1544,9 +1563,10 @@ sub git_get_avatar {
 	my $url = "";
 	if ($git_avatar eq 'gravatar') {
 		$url = gravatar_url($email, $size);
+	} elsif ($git_avatar eq 'picon') {
+		$url = picon_url($email);
 	}
-	# Currently only gravatars are supported, but other forms such as
-	# picons can be added by putting an else up here and defining $url
+	# Other providers can be added by extending the if chain, defining $url
 	# as needed. If no variant puts something in $url, we assume avatars
 	# are completely disabled/unavailable.
 	if ($url) {
-- 
1.6.3.rc1.192.gdbfcb
