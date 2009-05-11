From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/4] gitweb: Remove unused $hash_base parameter from
	normalize_link_target
Date: Mon, 11 May 2009 19:45:11 +0200
Message-ID: <20090511174253.15152.8987.stgit@localhost.localdomain>
References: <20090511173025.15152.94215.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 19:46:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3ZZx-0000mL-4L
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 19:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757470AbZEKRpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 13:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757429AbZEKRpP
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 13:45:15 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:58328 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755495AbZEKRpM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 13:45:12 -0400
Received: by fxm2 with SMTP id 2so2851663fxm.37
        for <git@vger.kernel.org>; Mon, 11 May 2009 10:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=iKe3NhGW0FlP2LAvOkn3y4TMIduHpQanAG/PVLr16FU=;
        b=NfSaQzp/Zjm3RnSNN+h/5dOtRNPwLXwN0esFKxF2Crwmo/pZwEaM8aWw/lg4DcHAeb
         LhWrbMU5tIukXB3MyDesjfmTBRZ0T83eiTUgIbM4DZ8JuvSAEl9V8OAdZ3BaYHl6lSX0
         gEiE865Aw+G8ATnQuhl7QKN2ANFcK20Dd52Vo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=bXFkTTxAFN4SxRBDTXQqH41Hnqxx8nh1Oi1qTtcyJ+yVR8QNfuggk04Pn0Mf/6MZ6/
         DRerJ4QABI2z5RpvsBIMr1j5jC4XY7KKUdScTs+ClbH53Lk4xbLGb7Z3fByA/XS8CMbY
         isiVvNY4CVtEkmze2paZAIbuT5tuB6+vkm1tQ=
Received: by 10.86.1.18 with SMTP id 18mr6769756fga.19.1242063912204;
        Mon, 11 May 2009 10:45:12 -0700 (PDT)
Received: from localhost.localdomain (absh130.neoplus.adsl.tpnet.pl [83.8.127.130])
        by mx.google.com with ESMTPS id 12sm7237372fgg.10.2009.05.11.10.45.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 May 2009 10:45:11 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4BHjBgm016803;
	Mon, 11 May 2009 19:45:11 +0200
In-Reply-To: <20090511173025.15152.94215.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118816>

...since it was decided for normalize_link_target to only mangle
pathname, and do not try to check if target is present in $hash_base
tree, for performance reasons.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This was caugth by Perl::Critic::Policy::Variables::ProhibitReusedNames 
 - Do not reuse a variable name in a lexical scope.

(That was probably me that forgot to remove parameter, but I didn't
search for authorship of this fragment.)

 gitweb/gitweb.perl |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c72ae10..05702e4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3339,10 +3339,7 @@ sub git_get_link_target {
 # return target of link relative to top directory (top tree);
 # return undef if it is not possible (including absolute links).
 sub normalize_link_target {
-	my ($link_target, $basedir, $hash_base) = @_;
-
-	# we can normalize symlink target only if $hash_base is provided
-	return unless $hash_base;
+	my ($link_target, $basedir) = @_;
 
 	# absolute symlinks (beginning with '/') cannot be normalized
 	return if (substr($link_target, 0, 1) eq '/');
@@ -3398,7 +3395,7 @@ sub git_print_tree_entry {
 		if (S_ISLNK(oct $t->{'mode'})) {
 			my $link_target = git_get_link_target($t->{'hash'});
 			if ($link_target) {
-				my $norm_target = normalize_link_target($link_target, $basedir, $hash_base);
+				my $norm_target = normalize_link_target($link_target, $basedir);
 				if (defined $norm_target) {
 					print " -> " .
 					      $cgi->a({-href => href(action=>"object", hash_base=>$hash_base,
