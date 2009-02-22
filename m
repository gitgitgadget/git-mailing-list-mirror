From: =?ISO-8859-1?Q?Marc=2DAndr=E9_Lureau?= <marcandre.lureau@gmail.com>
Subject: [PATCH/RFC 6/6] test: add simple sorted tag test
Date: Sun, 22 Feb 2009 20:06:41 +0200
Message-ID: <e29894ca0902221006k5743e19eqb18cf7b1eec84706@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 22 19:08:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbIkK-0003rP-Bt
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 19:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbZBVSGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 13:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbZBVSGn
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 13:06:43 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:6329 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbZBVSGm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 13:06:42 -0500
Received: by nf-out-0910.google.com with SMTP id d21so367282nfb.21
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 10:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=5tX4iPChX7EKw4W7J5iX2Og+1VtOj/wzh+UVuCfQO1o=;
        b=j1A2nVbTpY8f7EPk9l069yP60gHth3B6de1DWunVjX3r+iudRTTQq0f/cHtVKx3A9l
         FrJ8xR2gxz86Hxi10feJc44uqG3lGpxxASDZtjB5ez90EENsPE9Xqs6OYyPs5v9lIlsR
         6QQNkLL9ISOi+vZ4oG/2fBz4FNY+kVZvb53Cc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=B0eL9YHbLpPAohjg41jUc9JXdC5ubT445phX0qiq2aQpcitG7aGjavDINbi0tIfr+r
         emVhfsU0rmJQvZtg8JJOemy2HW+amOIdJhAGtakbCVcsXt52KLjFD96ng4vDepTPZCGG
         kThhJKyMnsi7kMPlrBvK6Yc51Aj89hDLVrmzQ=
Received: by 10.210.44.19 with SMTP id r19mr2711587ebr.60.1235326001736; Sun, 
	22 Feb 2009 10:06:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111033>

Signed-off-by: Marc-Andre Lureau <marcandre.lureau@gmail.com>
---
 t/t7004-tag.sh |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 69501e2..b8c07f5 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -174,6 +174,8 @@ test_expect_success 'listing all tags should print
them ordered' '
 	git tag t210 &&
 	git tag -l > actual &&
 	test_cmp expect actual &&
+	git tag -l -D > actual &&
+	test_cmp expect actual &&
 	git tag > actual &&
 	test_cmp expect actual
 '
@@ -579,6 +581,57 @@ test_expect_success \
 	test_cmp expect actual
 '

+# listing various tags sorted by date:
+test_tick
+
+time=$test_tick
+get_tag_header dated-tag-Z $commit commit $time >expect
+echo "A dated message +0" >>expect
+test_expect_success \
+	'creating an annotated tag with -m message should succeed' '
+	git tag -m "A dated message +0" dated-tag-Z &&
+	get_tag_msg dated-tag-Z >actual &&
+	test_cmp expect actual
+'
+
+time=$(($test_tick + 30000))
+GIT_COMMITTER_DATE="$time -0700"
+GIT_AUTHOR_DATE="$time -0700"
+export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
+
+get_tag_header dated-tag-W $commit commit $time >expect
+echo "A dated message +3" >>expect
+test_expect_success \
+	'creating an annotated tag with -m message should succeed' '
+	git tag -m "A dated message +3" dated-tag-W &&
+	get_tag_msg dated-tag-W >actual &&
+	test_cmp expect actual
+'
+
+time=$(($test_tick + 10000))
+GIT_COMMITTER_DATE="$time -0700"
+GIT_AUTHOR_DATE="$time -0700"
+export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
+
+get_tag_header dated-tag-Y $commit commit $time >expect
+echo "A dated message +1" >>expect
+test_expect_success \
+	'creating an annotated tag with -m message should succeed' '
+	git tag -m "A dated message +1" dated-tag-Y &&
+	get_tag_msg dated-tag-Y >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<EOF
+dated-tag-Z
+dated-tag-Y
+dated-tag-W
+EOF
+test_expect_success 'listing annotated tags by date' '
+	git tag -l -D "*dated*" > actual &&
+	test_cmp expect actual
+'
+
 # subsequent tests require gpg; check if it is available
 gpg --version >/dev/null
 if [ $? -eq 127 ]; then
-- 
1.6.2.rc1.28.g05ef4.dirty
