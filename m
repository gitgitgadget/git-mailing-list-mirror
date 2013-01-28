From: Andrej E Baranov <admin@andrej-andb.ru>
Subject: [PATCH] The images from picon and gravatar are always used over http://, and browsers give mixed contents warning when gitweb is served over https://.
Date: Tue, 29 Jan 2013 00:41:32 +0100
Message-ID: <1359416492-8597-1-git-send-email-admin@andrej-andb.ru>
Cc: gitster@pobox.com, jrnieder@gmail.com, giuseppe.bilotta@gmail.com,
	jnareb@gmail.com, Andrej E Baranov <admin@andrej-andb.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 00:42:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzyLF-0002iv-0l
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 00:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755511Ab3A1Xl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 18:41:59 -0500
Received: from mail-ea0-f175.google.com ([209.85.215.175]:37799 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927Ab3A1Xl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 18:41:57 -0500
Received: by mail-ea0-f175.google.com with SMTP id d1so1369982eab.6
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 15:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrej-andb.ru; s=google;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=DapEssgL3LEBsvLQ3Xcfm0GnxqgJIeFIFRdJOvWkOOw=;
        b=ED5qFecTFcTBvMGoGQO+BUWorxVqTfRQ11WGnfSKHqrw9shFlrUrHcqqMCyRJitpuY
         EdrXUUzuxEZ3Ktp5TodUIAymlS8XjO0y83UMt+bNIP0sVRR9PR7b0UG+vx1TFAryMqHL
         rp+kQOPvYUWV5WDmMAi/iB1qcnmPp7rK7Xa1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=DapEssgL3LEBsvLQ3Xcfm0GnxqgJIeFIFRdJOvWkOOw=;
        b=X4dhdxcJx/j8ixlGDxxlhFhRTENdVkjDuMkus7sEJVCjmf6E3Fq0TEsMgRmiAT63Ml
         FKMJN8fPJFEfXeLdmoXHpjUFtHlzpo1oH9Rt5qSqwDxY+gMlBWyDQlAfGzZ5tJfETMS+
         9nb/ZNB9h+7pBUlIyAc3s/Ms0ia95hzeCiTso2D0YypZ06c/lysFjR1TDQHJH0WCmgms
         XH+t0XxUyt1lc5r/IiHiUoGPWUDcVbSLjlxVBKiG6eGSrz3ZVY8uoReQez6FS2jmvYfn
         vjxQ/V/FoOZlYKEBfaELMoNjrHHGnZQpH0iBF1dXYrDr/zP1toaxgil/J5BZHVxjFfeZ
         mqbQ==
X-Received: by 10.14.225.133 with SMTP id z5mr133979eep.15.1359416516369;
        Mon, 28 Jan 2013 15:41:56 -0800 (PST)
Received: from andrej-andb.ru.ru (andrej-andb.ru. [78.46.145.210])
        by mx.google.com with ESMTPS id l3sm18037539een.14.2013.01.28.15.41.54
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 15:41:55 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1
X-Gm-Message-State: ALoCoQmAw6Q/Ke+dgO8UkSyUWIFW3I4g0mBql2TGGqQC8g07H0p+kjd9JlZjQofmxQZatQWEo4r/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214886>

Just drop the scheme: part from the URL, so that these
external sites are accessed over https:// in such a case.

Signed-off-by: Andrej E Baranov <admin@andrej-andb.ru>
---
 gitweb/gitweb.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c6bafe6..1309196 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2068,7 +2068,7 @@ sub picon_url {
 	if (!$avatar_cache{$email}) {
 		my ($user, $domain) = split('@', $email);
 		$avatar_cache{$email} =
-			"http://www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/" .
+			"//www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/" .
 			"$domain/$user/" .
 			"users+domains+unknown/up/single";
 	}
@@ -2083,7 +2083,7 @@ sub gravatar_url {
 	my $email = lc shift;
 	my $size = shift;
 	$avatar_cache{$email} ||=
-		"http://www.gravatar.com/avatar/" .
+		"//www.gravatar.com/avatar/" .
 			Digest::MD5::md5_hex($email) . "?s=";
 	return $avatar_cache{$email} . $size;
 }
-- 
1.8.1.1
