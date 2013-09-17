From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH] contacts: allow execution from other directories
Date: Tue, 17 Sep 2013 14:50:46 +0200
Message-ID: <1379422246-12818-1-git-send-email-t.gummerer@gmail.com>
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 17 14:50:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLuk6-0007Nk-Gt
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 14:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478Ab3IQMuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 08:50:54 -0400
Received: from mail-bk0-f47.google.com ([209.85.214.47]:50766 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975Ab3IQMux (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 08:50:53 -0400
Received: by mail-bk0-f47.google.com with SMTP id mx12so2113557bkb.6
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 05:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ZptV4vE7CXLn/MtQyEzWwpPzNaA+aAxUKQ7m0kG1Hu0=;
        b=t53qMQeGLbwmzSCQlJ+odUT28LE+itqzfzI8xa3gk3+4BSNXxuHgY1Cou2E8b0cBdM
         k9gse6EsWzUVR8h3239mZ2JZjZtFJblFv8qiMySDnbAHT+aeKQNBv3W81bj23mvijBk5
         PT8YlQh8/AOvWHcYGfDuJKSN08MbmoN0gnhMQl+YlhVSo/PK8gJaPHifJ/Qo818JmJ6c
         qbHkPPxOEKzVKilpNC/+jatnC6iWV5JU6Ufsu+ulFDUhZjKZbFtW1FByCCIaDS2f6lk2
         5qsvogn7iDrd1MZtKrJuda2nfmpUpE7JTSGvcZltZM9cMKwCcu7Q7hQ/6IhOQbZEhwn3
         3dpw==
X-Received: by 10.204.121.201 with SMTP id i9mr29701980bkr.13.1379422252636;
        Tue, 17 Sep 2013 05:50:52 -0700 (PDT)
Received: from localhost ([2001:5c0:1400:a::44f])
        by mx.google.com with ESMTPSA id z6sm10004601bkn.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 17 Sep 2013 05:50:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.535.g7b94f8e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234877>

Currently git-contacts only works if it is executed from the top level
of the git repository.  Enable the execution in sub directories of that
repository.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

I have no experience in perl, so there may be nicer implementations.  It works when tested manually.

 contrib/contacts/git-contacts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index fb6429b..32f03fc 100755
--- a/contrib/contacts/git-contacts
+++ b/contrib/contacts/git-contacts
@@ -61,6 +61,9 @@ sub import_commits {
 sub get_blame {
 	my ($commits, $source, $from, $ranges) = @_;
 	return unless @$ranges;
+	my $git_dir = `git rev-parse --show-toplevel`;
+	chomp($git_dir);
+	$source = $git_dir . '/' . $source;
 	open my $f, '-|',
 		qw(git blame --porcelain -C),
 		map({"-L$_->[0],+$_->[1]"} @$ranges),
-- 
1.8.4.535.g7b94f8e.dirty
