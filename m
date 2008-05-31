From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Add charset info to "raw" blob output
Date: Sat, 31 May 2008 13:27:01 +0200
Message-ID: <20080531112513.30913.44393.stgit@localhost.localdomain>
References: <m3tzgg1a06.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jan Engelhardt <jengelh@medozas.de>,
	Lea Wiemann <lewiemann@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 31 13:28:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2PFs-0007jV-01
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 13:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbYEaL1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 07:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbYEaL1M
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 07:27:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:40379 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbYEaL1L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 07:27:11 -0400
Received: by fg-out-1718.google.com with SMTP id 19so299623fgg.17
        for <git@vger.kernel.org>; Sat, 31 May 2008 04:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        bh=I5hL06SeeoHE932D4auG2fRBA8JbfNEptrqJ9QP1zcg=;
        b=HJHNpAYrOG7YY8Gs+w7V2KS7CFDKB3josv//XLVJVsvpWxg+55VIyUfnL1WNzZehqrspXDHBWbNvDQaJWYkfcslqb6v387Yzk+AU8R9LuMeI/l8HB2+7iPH2Y70MMaA+4tmW5IIWExOWZOe3cxeWLZSdBKPUqWDHZv2R0KWvxbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        b=Um2LAZICoztiupuHJE2DtA2iQSlX+yKdWDalooWACWvUH+yi2wJJPiuP0E7Q8dTlDU/pC4LW0xw9JPYvbjDBXRCmGK5mo4Ix+VjEglUr4zCT9zJWnH6NmNH3XEnJP/6o5g7mAnh5UDwfeUR2498WNuWGJSjDPVt1v6lXfR8nCXs=
Received: by 10.86.26.11 with SMTP id 11mr1547930fgz.23.1212233228742;
        Sat, 31 May 2008 04:27:08 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.238.103])
        by mx.google.com with ESMTPS id l12sm1002943fgb.6.2008.05.31.04.27.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 May 2008 04:27:05 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4VBR1DP030951;
	Sat, 31 May 2008 13:27:01 +0200
In-Reply-To: <m3tzgg1a06.fsf@localhost.localdomain>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83375>

Always add charset info from $default_text_plain_charset (if it is
defined) to "raw" (a=blob_plain) output for 'text/plain' blobs.
Adding charset info in a special case was removed from blob_mimetype().

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Please note that to have utf-8 for 'text/plain' blobs in blob_plain
view ("raw" output) you still have to set $default_text_plain_charset
to 'utf-8' (in gitweb configuration file).

 gitweb/gitweb.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 57a1905..dd0f0ac 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2481,8 +2481,7 @@ sub blob_mimetype {
 	return $default_blob_plain_mimetype unless $fd;
 
 	if (-T $fd) {
-		return 'text/plain' .
-		       ($default_text_plain_charset ? '; charset='.$default_text_plain_charset : '');
+		return 'text/plain';
 	} elsif (! $filename) {
 		return 'application/octet-stream';
 	} elsif ($filename =~ m/\.png$/i) {
@@ -4397,6 +4396,9 @@ sub git_blob_plain {
 		or die_error(undef, "Couldn't cat $file_name, $hash");
 
 	$type ||= blob_mimetype($fd, $file_name);
+	if ($type eq 'text/plain' && defined $default_text_plain_charset) {
+		$type .= "; charset=$default_text_plain_charset";
+	}
 
 	# save as filename, even when no $file_name is given
 	my $save_as = "$hash";
