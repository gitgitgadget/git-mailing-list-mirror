From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3] gitweb: ref markers link to named shortlogs
Date: Fri, 22 Aug 2008 10:03:51 +0200
Message-ID: <1219392231-9568-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <200808212332.07095.jnareb@gmail.com>
Cc: Petr Baudis <pasky@ucw.cz>, Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 10:04:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWRdQ-00009h-Vz
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 10:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbYHVIDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 04:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbYHVIDg
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 04:03:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:32471 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbYHVIDd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 04:03:33 -0400
Received: by ug-out-1314.google.com with SMTP id c2so72810ugf.37
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 01:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=LUkayyxYXJVyqCNz0dyKlvSqK/oNES5OZtr4Uxmbgbc=;
        b=ph8lCSKpWYHDLVUGKG3rZCiLeydNe9kkYTrosQkvIGe5rOCwl2pZRs9vdsVpeNxi+B
         /qSjUGg6fH3Lk/bkKpg+0MI4g3mu1/CWNE6RzaRbWSMjI8ukV6BLfl4osPv8ApEdo47f
         VexNlmWgjA/2Ic23i4vn3KL3tx76BklZrGsa8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BKYlPt6Wjv3v9jvSizPu9u9h3Qp2eYVre5qcFXCjeALhDCI57VSmtJm6FQmPdBW1U/
         nOkMgmA6nwPiavMf4G++FE0BU1iitn/EgJtnM+3dOrkcf1/yn0whclRYL1Mk5+cn1S2+
         Hb/CuIhPbu4Zo7UXWVsR3CqKNJV4a62tA90+Y=
Received: by 10.67.119.8 with SMTP id w8mr2260980ugm.20.1219392211129;
        Fri, 22 Aug 2008 01:03:31 -0700 (PDT)
Received: from localhost ( [78.13.49.52])
        by mx.google.com with ESMTPS id j27sm1376580ugc.7.2008.08.22.01.03.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Aug 2008 01:03:30 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <200808212332.07095.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93270>

This patch turns ref markers into links to appropriate views for the ref
name, using the full ref name as hash. Appropriate changes are made in
the CSS to prevent ref markers to be annoyingly blue and underlined,
unless hovered on.

For all git ref types it's assumed that the preferred view is named like
the ref type itself. If the corresponding action is not defined,
shortlog is used.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---

Following Jakub Narebski's suggestions, an underlined :hover is
added for the ref marker css, and we use $type instead of
$git_type, sparing ourselves a bunch of git calls.

An additional change wrt the previous version is that the full ref
name is used (to link to the correct object when e.g. a head and a
tag by the same name exist).

 gitweb/gitweb.css  |    9 +++++++++
 gitweb/gitweb.perl |    3 ++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index aa0eeca..fadce1b 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -481,6 +481,15 @@ span.refs span {
 	border-color: #ffccff #ff00ee #ff00ee #ffccff;
 }
 
+span.refs span a {
+	text-decoration: none;
+	color: inherit;
+}
+
+span.refs span a:hover {
+	text-decoration: underline;
+}
+
 span.refs span.ref {
 	background-color: #aaaaff;
 	border-color: #ccccff #0033cc #0033cc #ccccff;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 90cd99b..77b2442 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1107,7 +1107,8 @@ sub format_ref_marker {
 			}
 
 			$markers .= " <span class=\"$type\" title=\"$ref\">" .
-			            esc_html($name) . "</span>";
+				$cgi->a({-href => href(action=> $actions{$type} || "shortlog", hash=>$ref)}, $name) .
+				"</span>";
 		}
 	}
 
-- 
1.5.6.3
