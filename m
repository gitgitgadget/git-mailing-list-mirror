From: Jakub Narebski <jnareb@gmail.com>
Subject: [gsoc2012 wiki PATCH] "Use JavaScript library / framework in gitweb" project
Date: Thu,  8 Mar 2012 22:18:13 +0100
Message-ID: <1331241493-17188-1-git-send-email-jnareb@gmail.com>
References: <20120302091114.GA3984@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 22:18:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5kjH-0006va-63
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 22:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756164Ab2CHVS1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 16:18:27 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64607 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755917Ab2CHVSX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 16:18:23 -0500
Received: by wgbdr13 with SMTP id dr13so931671wgb.1
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 13:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=oeRMJxDRv1E1FbI1v+AXq0ljqbqVUiygD+OaGMSsZkI=;
        b=sSlFSzFDkpgLmzCi8QQy3kdXVSyuFDZeCIe28X0h9/fkQm0NTenKhqdu/DnZouJCuZ
         te9Sb1hrMHr4gr2AAoTt6keBAXJeahpr/HnjW3+BRRxIq8EV8UQ4NhqJp7hE3IQhqrzV
         MsGBFwp0epKnAnRvYyazcVvrXtYpDEmR0mdmhCusO1gmBqM3jPkaPOXysRV2JmBX6i5x
         n7CX5ela4P7XIeJ0/8QW5fLEu/vgEvrGxcMJI2ge5asICAKIFdM8bf5c5dVBpnoC5Hi0
         GnIX1dUVddgowLzOkINJKk8CVBPiXRb8nfoqB/XCjd/ebVPkOwL9YDZsi310fWhSPqoH
         IfhA==
Received: by 10.180.96.8 with SMTP id do8mr38213360wib.21.1331241502048;
        Thu, 08 Mar 2012 13:18:22 -0800 (PST)
Received: from localhost.localdomain (abwp68.neoplus.adsl.tpnet.pl. [83.8.239.68])
        by mx.google.com with ESMTPS id t20sm14264799wiv.0.2012.03.08.13.18.19
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 13:18:21 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <20120302091114.GA3984@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192651>

---
Inspied by problems with timezone changing JavaScript that Ramsay
Jones had.

 SoC-2012-Ideas.md |   54 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/SoC-2012-Ideas.md b/SoC-2012-Ideas.md
index 6f543f6..8c3b266 100644
--- a/SoC-2012-Ideas.md
+++ b/SoC-2012-Ideas.md
@@ -264,6 +264,60 @@ Programming language: Perl
 Proposed by: Jakub Nar=C4=99bski =20
 Possible mentor(s): Jakub Nar=C4=99bski (?)
=20
+Use JavaScript library / framework in gitweb
+--------------------------------------------
+
+Gitweb (git web interface) includes some *optional* client-side
+scripting using JavaScript.  This includes checking if JavaScript is
+available and remembering this information so gitweb can choose
+JavaScript-only version of a view (javascript-detection), selecting
+common timezone to use when showing dates (adjust-timezone), and
+AJAX-y incremental blame view (blame_incremental).
+
+Currently all this is done using hand-written JavaScript.  This means
+that gitweb scripting includes handling cookies, formatting output,
+processing dates, and smoothing out incompatibilities between browsers
+(like e.g. XmlHttpRequest creation).
+
+This is redoing work which JavaScript libraries, such as jQuery,
+MooTools or YUI already did.  Moreover, if we want to add new features
+(e.g. table sorted using JavaScript), or improve existing ones, we
+would have to re-implement existing JavaScript code.  Also our
+hand-crafted code is not as well tested as widely used JavaScript
+libraries.
+
+The goal of this project is to move gitweb client side scripting to
+use some JavaScript library / JavaScript framework.
+
+The project would consist of the following steps:
+
+ * Add support for configuring and loading external JavaScript library
+   to `gitweb/gitweb.perl` and `gitweb/Makefile`.  It would be nice
+   (though not necessary) to be able to use local version of library,
+   and have such feature well documented.
+
+ * Remove gitweb's JavaScript mini-library in `gitweb/static/js/lib`
+   and replace it part by part by appropriate JavaScript library
+   functions (methods).
+
+ * Replace DOM selectors by library version, if applicable.
+
+ * Optional: emulate 'onprogress' in XmlHttpRequest using native
+   JavaScript library mechanism (creating a class, or whatever).
+
+ * Optional: better deferring of repainting in incremental blame.
+
+Note that we require that client-side scripting in gitweb follow
+[progressive enhancement] strategy; gitweb should work correctly,
+perhaps with reduced functionality, even if JavaScript is turned off,
+or external JavaScript library cannot be loaded.
+
+[progressive enhancement]: http://en.wikipedia.org/wiki/Progressive_en=
hancement
+
+Programming language: JavaScript =20
+Proposed by: Jakub Nar=C4=99bski =20
+Possible mentor(s): Jakub Nar=C4=99bski
+
 Finishing network support for libgit2
 -------------------------------------
=20
--=20
1.7.9
