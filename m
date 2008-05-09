From: drafnel@gmail.com
Subject: [PATCH 5/5] git-tag: call verify_tag_buffer to validate the generated tag object
Date: Thu,  8 May 2008 21:19:49 -0500
Message-ID: <859967.1210299539642.JavaMail.teamon@b301.teamon.com>
References: <1210299589-10448-1-git-send-email-drafnel@example.com>
 <1210299589-10448-2-git-send-email-drafnel@example.com>
 <1210299589-10448-3-git-send-email-drafnel@example.com>
 <1210299589-10448-4-git-send-email-drafnel@example.com>
 <1210299589-10448-5-git-send-email-drafnel@example.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 04:34:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuIQo-00053E-Pi
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 04:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430AbYEICdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 22:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755341AbYEICdM
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 22:33:12 -0400
Received: from mailproxy01.teamon.com ([64.85.68.137]:18864 "EHLO
	b301.teamon.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755167AbYEICdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 22:33:09 -0400
X-Greylist: delayed 866 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 May 2008 22:33:07 EDT
Received: from b301.teamon.com (localhost [127.0.0.1])
	by b301.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id m492IxG10627;
	Fri, 9 May 2008 02:18:59 GMT
X-Mailer: git-send-email 1.5.5.67.g9a49
In-Reply-To: <1210299589-10448-5-git-send-email-drafnel@example.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81589>

From: Brandon Casey <drafnel@gmail.com>

This will ensure that both git-tag and git-mktag "produce valid tags,
with the same definition of validity."

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 builtin-tag.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 85ec2f3..0f79d47 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -508,6 +508,8 @@ static void create_tag(const unsigned char *object, const char *tag,
 
 	if (sign && do_sign(buf) < 0)
 		die("unable to sign the tag");
+	if (verify_tag_buffer(buf->buf, buf->len) < 0)
+		die("invalid tag object");
 	if (write_sha1_file(buf->buf, buf->len, tag_type, result) < 0)
 		die("unable to write tag file");
 }
-- 
1.5.5.67.g9a49
