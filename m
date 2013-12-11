From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: [PATCH v7 1/4] gitweb: Move check-ref-format code into separate function
Date: Wed, 11 Dec 2013 12:54:41 +0100
Message-ID: <1386762884-7564-2-git-send-email-krzesimir@endocode.com>
References: <1386762884-7564-1-git-send-email-krzesimir@endocode.com>
Cc: gitster@pobox.com, jnareb@gmail.com, sunshine@sunshineco.com,
	Krzesimir Nowak <krzesimir@endocode.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 11 12:55:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqiO5-0003A9-6c
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 12:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909Ab3LKLzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 06:55:25 -0500
Received: from mail-ea0-f173.google.com ([209.85.215.173]:43792 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812Ab3LKLzX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 06:55:23 -0500
Received: by mail-ea0-f173.google.com with SMTP id o10so2870992eaj.4
        for <git@vger.kernel.org>; Wed, 11 Dec 2013 03:55:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wdAUHDp+Gw4Uica1AwrVeuuak8ihuGMvqCf3ODQ9H1U=;
        b=KTw0G3VdC2QUBBrDZQwsJmKPAqOn15FRzpgjYKeh0wLXsAXUvLbseiqKfQFeGPI9bG
         +N5KfGICI3KtltTTlmWmSyqmZVVqqplg83nKYiVnq6LqMxctGN5Nni76wcYO4u6fnuNL
         coqrBMkh+PPJQ2MAalHBk4y6IlpwmnUPO5w5XI7wdnBDkWRusX1EN0Ln5nIBjZsueNZX
         qegDS+b/MWO9kxzJPh+us/UfNF9MqeqPt6Xvy1/1SBeymrpte2ZihCzmGXmPe9mOlBw9
         4eeI+R2tl4nj6kJ4Y629rQb6iyeV0wjVhxGEkmrnWqmc0NYIVobKOaFicg6zCYX76uQd
         PlIw==
X-Gm-Message-State: ALoCoQmETlEyS63B6cYpkjzi43U9Iqv1lcb0Lw1+LlprJL/I4plPRwMCF7xbEK/LfaYtMrvGGu5W
X-Received: by 10.15.53.193 with SMTP id r41mr1542072eew.2.1386762920534;
        Wed, 11 Dec 2013 03:55:20 -0800 (PST)
Received: from localhost.home (95-91-241-58-dynip.superkabel.de. [95.91.241.58])
        by mx.google.com with ESMTPSA id z42sm52742677eeo.17.2013.12.11.03.55.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2013 03:55:19 -0800 (PST)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1386762884-7564-1-git-send-email-krzesimir@endocode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239189>

This check will be used in more than one place later.

Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
---
 gitweb/gitweb.perl | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 68c77f6..46bd6ac 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1452,6 +1452,16 @@ sub validate_pathname {
 	return $input;
 }
 
+sub is_valid_ref_format {
+	my $input = shift || return undef;
+
+	# restrictions on ref name according to git-check-ref-format
+	if ($input =~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
+		return undef;
+	}
+	return $input;
+}
+
 sub validate_refname {
 	my $input = shift || return undef;
 
@@ -1462,10 +1472,9 @@ sub validate_refname {
 	# it must be correct pathname
 	$input = validate_pathname($input)
 		or return undef;
-	# restrictions on ref name according to git-check-ref-format
-	if ($input =~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
-		return undef;
-	}
+	# check git-check-ref-format restrictions
+	is_valid_ref_format($input)
+		or return undef;
 	return $input;
 }
 
-- 
1.8.3.1
