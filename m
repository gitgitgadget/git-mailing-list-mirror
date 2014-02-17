From: Andrew Keller <andrew@kellerfarm.com>
Subject: [PATCH] gitweb: Avoid overflowing page body frame with large images
Date: Mon, 17 Feb 2014 09:25:13 -0500
Message-ID: <C66B1A3C-7148-4514-B385-537E0BB6E187@kellerfarm.com>
References: <2452A253-A926-4A40-9F08-6E28EFF229F3@kellerfarm.com> <A4E05D52-1CED-46FC-B137-BCDFAD638E1D@kellerfarm.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Tony Finch <dot@dotat.at>,
	Krzesimir Nowak <krzesimir@endocode.com>,
	=?iso-8859-1?Q?J=FCrgen_Kreileder?= <jk@blackdown.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 17 15:25:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFP8P-0008LJ-8p
	for gcvg-git-2@plane.gmane.org; Mon, 17 Feb 2014 15:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbaBQOZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Feb 2014 09:25:18 -0500
Received: from atl4mhob03.myregisteredsite.com ([209.17.115.41]:45092 "EHLO
	atl4mhob03.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750958AbaBQOZR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Feb 2014 09:25:17 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.206])
	by atl4mhob03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s1HEPF8S020360
	for <git@vger.kernel.org>; Mon, 17 Feb 2014 09:25:15 -0500
Received: (qmail 20805 invoked by uid 0); 17 Feb 2014 14:25:14 -0000
X-TCPREMOTEIP: 69.41.14.217
X-Authenticated-UID: andrew@kellerfarm.com
Received: from unknown (HELO devnet.ces.cvnt.net) (andrew@kellerfarm.com@69.41.14.217)
  by 0 with ESMTPA; 17 Feb 2014 14:25:14 -0000
In-Reply-To: <A4E05D52-1CED-46FC-B137-BCDFAD638E1D@kellerfarm.com>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242260>

When displaying a blob in gitweb, if it's an image, specify constraints for
maximum display width and height to prevent the image from overflowing the
frame of the enclosing page_body div.

This change assumes that it is more desirable to see the whole image without
scrolling (new behavior) than it is to see every pixel without zooming
(previous behavior).

Signed-off-by: Andrew Keller <andrew@kellerfarm.com>
---

This is an updated copy of this patch.

Could I request a thumbs up, thumbs down, or thumbs sideways from those who develop gitweb?

Thanks,
Andrew Keller

 gitweb/gitweb.perl       |    2 +-
 gitweb/static/gitweb.css |    5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3bc0f0b..79057b7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7094,7 +7094,7 @@ sub git_blob {
 	git_print_page_path($file_name, "blob", $hash_base);
 	print "<div class=\"page_body\">\n";
 	if ($mimetype =~ m!^image/!) {
-		print qq!<img type="!.esc_attr($mimetype).qq!"!;
+		print qq!<img class="blob" type="!.esc_attr($mimetype).qq!"!;
 		if ($file_name) {
 			print qq! alt="!.esc_attr($file_name).qq!" title="!.esc_attr($file_name).qq!"!;
 		}
diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 3b4d833..3212601 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -32,6 +32,11 @@ img.avatar {
 	vertical-align: middle;
 }
 
+img.blob {
+	max-height: 100%;
+	max-width: 100%;
+}
+
 a.list img.avatar {
 	border-style: none;
 }
-- 
1.7.9.6 (Apple Git-31.1)
