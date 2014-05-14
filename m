From: Michael Wagner <accounts@mwagner.org>
Subject: [PATCH/RFC] Gitweb: Convert UTF-8 encoded file names
Date: Wed, 14 May 2014 20:41:45 +0200
Message-ID: <20140514184145.GA25699@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 20:48:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkeEE-0008RB-6G
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 20:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbaENSsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 14:48:30 -0400
Received: from caelum.uberspace.de ([95.143.172.212]:33154 "EHLO
	caelum.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbaENSs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 14:48:29 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 May 2014 14:48:29 EDT
Received: (qmail 18380 invoked from network); 14 May 2014 18:41:47 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by caelum.uberspace.de with SMTP; 14 May 2014 18:41:47 -0000
Content-Disposition: inline; filename="28222-Gitweb-Convert-UTF-8-encoded-file-names.patch"
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248935>

Perl has an internal encoding used to store text strings. Currently, trying to
view files with UTF-8 encoded names results in an error (either "404 - Cannot
find file" [blob_plain] or "XML Parsing Error" [blob]). Converting these UTF-8
encoded file names into Perl's internal format resolves these errors.

Signed-off-by: Michael Wagner <accounts@mwagner.org>
---
 gitweb/gitweb.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a9f57d6..6046977 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1056,7 +1056,7 @@ sub evaluate_and_validate_params {
 		}
 	}
 
-	our $file_name = $input_params{'file_name'};
+	our $file_name = decode("utf-8", $input_params{'file_name'});
 	if (defined $file_name) {
 		if (!is_valid_pathname($file_name)) {
 			die_error(400, "Invalid file parameter");
-- 
1.9.0
