From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Make config_to_multi return [] instead of [undef]
Date: Sat, 15 Dec 2007 15:36:32 +0100
Message-ID: <200712151536.33296.jnareb@gmail.com>
References: <200712151534.50951.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 15:42:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3YDs-0004XE-8J
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 15:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332AbXLOOmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 09:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757323AbXLOOmK
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 09:42:10 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:18877 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754332AbXLOOmH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 09:42:07 -0500
Received: by fg-out-1718.google.com with SMTP id e21so72311fga.17
        for <git@vger.kernel.org>; Sat, 15 Dec 2007 06:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=iWKm1mMes6XjznD91M0bhbPkA+3CUU0QAh+Z8lj2+6g=;
        b=wptWsJhzshCDrxjPKjitMkdX99LufV15/o6AZ826/Ox+2PlKgyRNMJM1/DjS38wpBAxBk6MbHJ3IrvcqU4GjxnhVRxi9eHh0YY43HyerMZKf4S4Hcaz69sfFRYziRWsUj9/E6wi/daDylH+arS38hMzkP9JyYjC7tMTv4gODZFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Kor/vZ9QjuyZsyoPzMn571IP0zkN6ul3HEs/rUS2zZ3HIA3azq0yKLkkXz83ZOuGXGo3vw9mECmB+iQVvpUCMmojXZkIZoggUIRdccqPzwS3iZ1H/1jgsSjvFPHjjh4a+iSDZhUXm68B4uUeL9VxJ8PDDF88jZbrxRJsAx0zHAU=
Received: by 10.86.89.4 with SMTP id m4mr4273195fgb.12.1197729724471;
        Sat, 15 Dec 2007 06:42:04 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.240.142])
        by mx.google.com with ESMTPS id b17sm14288867fka.2007.12.15.06.42.02
        (version=SSLv3 cipher=OTHER);
        Sat, 15 Dec 2007 06:42:03 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200712151534.50951.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68388>

From: Petr Baudis <pasky@suse.cz>
Date: Sat, 8 Dec 2007 12:30:59 +0100
Subject: [PATCH] gitweb: Make config_to_multi return [] instead of [undef]

This is important for the list of clone urls, where if there are
no per-repository clone URL configured, the default base URLs
are never used for URL construction without this patch.

Add tests for different ways of setting project URLs, just in case.
Note that those tests in current form wouldn't detect breakage fixed
by this patch, as it only checks for errors and not for expected
output.

Signed-off-by: Petr Baudis <pasky@suse.cz>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Originally by Petr Baudis, changed to use defined($val). I have also
added parentheses for better readibility.

I have added tests _then_ I have realized that in current form they
cannot detect regression corrected by this patch. So if you want, you
can not apply changes to test (and remove paragraph about test from
commit message).

The fact that patch was not applied might be cause by the lack of Ack
from pasky.

 gitweb/gitweb.perl                     |    2 +-
 t/t9500-gitweb-standalone-no-errors.sh |   25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 24b3158..a746a85 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1511,7 +1511,7 @@ sub config_to_int {
 sub config_to_multi {
        my $val = shift;
 
-       return ref($val) ? $val : [ $val ];
+       return ref($val) ? $val : (defined($val) ? [ $val ] : []);
 }
 
 sub git_get_project_config {
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 35fff3d..2d3d4e8 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -558,6 +558,31 @@ test_expect_success \
 test_debug 'cat gitweb.log'
 
 # ----------------------------------------------------------------------
+# testing config_to_multi / cloneurl
+
+test_expect_success \
+       'URL: no project URLs, no base URL' \
+       'gitweb_run "p=.git;a=summary"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+       'URL: project URLs via gitweb.url' \
+       'git config --add gitweb.url git://example.com/git/trash.git &&
+        git config --add gitweb.url http://example.com/git/trash.git &&
+        gitweb_run "p=.git;a=summary"'
+test_debug 'cat gitweb.log'
+
+cat >.git/cloneurl <<\EOF
+git://example.com/git/trash.git
+http://example.com/git/trash.git
+EOF
+
+test_expect_success \
+       'URL: project URLs via cloneurl file' \
+       'gitweb_run "p=.git;a=summary"'
+test_debug 'cat gitweb.log'
+
+# ----------------------------------------------------------------------
 # gitweb config and repo config
 
 cat >>gitweb_config.perl <<EOF
-- 
1.5.3.7
