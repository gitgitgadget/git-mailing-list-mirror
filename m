From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 2/4] gitweb: change call pattern for git_commitdiff
Date: Thu, 18 Dec 2008 08:13:17 +0100
Message-ID: <1229584399-23879-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1229584399-23879-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1229584399-23879-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 08:15:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDD66-0007LV-1U
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 08:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbYLRHN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 02:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbYLRHN0
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 02:13:26 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:15163 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbYLRHNY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 02:13:24 -0500
Received: by fg-out-1718.google.com with SMTP id 19so119795fgg.17
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 23:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TsNxinyEI3fmwrtBytETjxeaRYxTTE6loVa3HtkI4II=;
        b=DoGE7OirF/t46YuRznEJ1Gap3Jich3+C5lvAZsfp1bDsTi8zJBCPfoe1fG+8gcmBbl
         iv/V0q7I7b7t8gmBtYmKZZT43ooP/Z8eR7TXHCOWBUuDVuqaPNy7SipGFa7WdZ+DPaSy
         w0Y9dADSk/iKdi3x+FRt7meor3wKnmUZK2who=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FHj36+kFlzEThkNxJSSXvQ3Wh/vrE4fk8o+Y1+XMpPk/X71qJYwotw+swfp2O4Uqu7
         oXMFHCH9kHIbVJwNI0LP8y29/PNoTwdo/lKvcPaUvThKvYTf6UMzI7SPWnfk8MeyY331
         FMFpns9CSWgu86OD6ROSy3eXSPW5/hQZwWC6c=
Received: by 10.86.100.19 with SMTP id x19mr942825fgb.18.1229584403490;
        Wed, 17 Dec 2008 23:13:23 -0800 (PST)
Received: from localhost ([78.13.57.58])
        by mx.google.com with ESMTPS id 4sm5615130fgg.57.2008.12.17.23.13.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Dec 2008 23:13:22 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1229584399-23879-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103439>

Since we are going to introduce an additional parameter for
git_commitdiff to tune patch view, we switch to named/hash-based
parameter passing for clarity and robustness.
---
 gitweb/gitweb.perl |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1006dfe..18d43e7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5412,7 +5412,8 @@ sub git_blobdiff_plain {
 }
 
 sub git_commitdiff {
-	my $format = shift || 'html';
+	my %params = @_;
+	my $format = $params{-format} || 'html';
 
 	my $patch_max;
 	if ($format eq 'patch') {
@@ -5620,12 +5621,12 @@ sub git_commitdiff {
 }
 
 sub git_commitdiff_plain {
-	git_commitdiff('plain');
+	git_commitdiff(-format => 'plain');
 }
 
 # format-patch-style patches
 sub git_patch {
-	git_commitdiff('patch');
+	git_commitdiff(-format => 'patch');
 }
 
 sub git_history {
-- 
1.5.6.5
