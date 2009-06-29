From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv8 2/7] gitweb: uniform author info for commit and commitdiff
Date: Tue, 30 Jun 2009 00:00:49 +0200
Message-ID: <1246312854-3365-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1246312854-3365-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1246312854-3365-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 30 00:01:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLOv0-0005Hd-59
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 00:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757528AbZF2WAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 18:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755739AbZF2WAw
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 18:00:52 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:57224 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758543AbZF2WAt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 18:00:49 -0400
Received: by bwz9 with SMTP id 9so3551355bwz.37
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 15:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=RE/5CSlAw93Y7EK0iDtSgf+u3NLTiZt77ToSyX/E6Dc=;
        b=vp3vNWlpYhuACxURSrEwp3jn9UtFIjwlBfdZi8/iO/mcePLfI6aMeWJzAyyIE5JHHE
         JVT5weIG1SdOdIYqCZb5GBWQbNcs2cYPNMYX0BS+JeAZgL5o3SsycfjLMUosomTMyL+M
         mjh3kAOgfz4imqrZRxcGOLn+gSCrlLX/fukOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VnYHbMPwqYaIZ5NXnGdO0PWVqKEOcIRqz5MHt7NrLkW58ARVsSKBPMz8M80DiejWGo
         SaeFPw5jyoD9JeK47WBoGFabuzqNDOr77vBjxLVN4hs719I+QTex/FQVKBYKNn0meRO9
         HT9/fVVU05lPZStZwkfnpiYaYUCXGbr4sQXMg=
Received: by 10.204.100.201 with SMTP id z9mr7570450bkn.168.1246312851872;
        Mon, 29 Jun 2009 15:00:51 -0700 (PDT)
Received: from localhost (host-78-13-59-48.cust-adsl.tiscali.it [78.13.59.48])
        by mx.google.com with ESMTPS id h2sm8030211fkh.46.2009.06.29.15.00.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 15:00:51 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1246312854-3365-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122474>

Switch from 'log'-like layout

    A U Thor <email@example.com> [date time]

to 'commit'-like layout

    author    A U Thor <email@example.com>
              date time
    committer C O Mitter <other.email@example.com>
              committer date time

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7fd53f6..9a8d775 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5596,7 +5596,11 @@ sub git_commitdiff {
 		git_header_html(undef, $expires);
 		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
-		git_print_authorship(\%co, -localtime => 1);
+		print "<div class=\"title_text\">\n" .
+		      "<table class=\"object_header\">\n";
+		git_print_authorship_rows(\%co);
+		print "</table>".
+		      "</div>\n";
 		print "<div class=\"page_body\">\n";
 		if (@{$co{'comment'}} > 1) {
 			print "<div class=\"log\">\n";
-- 
1.6.3.rc1.192.gdbfcb
