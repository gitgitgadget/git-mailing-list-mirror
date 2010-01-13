From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t7502: test commit.status, --status and --no-status
Date: Wed, 13 Jan 2010 00:58:07 -0800
Message-ID: <7veilupejk.fsf@alter.siamese.dyndns.org>
References: <7vocl1pwf5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "James P. Howard\, II" <jh@jameshoward.us>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 09:58:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUz3S-000899-NH
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 09:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917Ab0AMI6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 03:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343Ab0AMI6O
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 03:58:14 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33149 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838Ab0AMI6O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 03:58:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8895790A56;
	Wed, 13 Jan 2010 03:58:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=u4MvFBZxq0m71AULYIkUuGX7Dbs=; b=Ep58j91bbVZsD0F7CI5YK85
	eGYptT39FwUKPw3WPkfMfrTY9hVluBiNwuLhw3hqlYIU0ZxQqqhwfNUgXgsWtaq7
	ZNRUxkhC4VzbjRm406PyuzFLzlep5kkg1bxLtJUutO5WffoZH3FuahX5adUMRD8+
	uXtwn+2PZZIKICeCPbow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=UWS3GGSN8yfYqyLmoim9wz2SVj2LXj69yVdZ/Bs2gZ4t/b6Uw
	Z5D93JvHv/qQCZl7ALozjewGXWxFMdX52Hbz6bBXnVtBbF0CBhVWNHxyVh/mJlNl
	mmyG/UaP1zIDTSP25p3WzhnPS2KWDefB45fRFjnLZqrlE6W7jswlT4h/oc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6314290A55;
	Wed, 13 Jan 2010 03:58:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 771FB90A53; Wed, 13 Jan
 2010 03:58:08 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C6CE9514-0021-11DF-B5CF-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136793>

Make sure that the status information:

 - is shown as before without configuration nor command line option;

 - is shown if commit.status set to true without command line option,
   or --status is given;

 - is not shown if commit.status set to false without command line option,
   or --no-status is given.

Also make sure that the above does not affect the way lines taken from
the custom --template appear in the log message editor.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Junio C Hamano <gitster@pobox.com> writes:

 > What's cooking in git.git (Jan 2010, #03; Sun, 10)
 > --------------------------------------------------
 > ...
 > [Stalled]
 > * jh/commit-status (2009-12-07) 1 commit
 >  - [test?] Add commit.status, --status, and --no-status
 >
 > Needs tests.

 I think I have already given ample time for people to react, but ended up
 getting tired of waiting for tests to materialize and doing it myself, as
 I want to close merge window for 1.7.0-rc0 by the end of next week to
 have the final release early next month.

 t/t7502-commit.sh |  109 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 109 insertions(+), 0 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index fe94552..844fb43 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -267,4 +267,113 @@ test_expect_success 'A single-liner subject with a token plus colon is not a foo
 
 '
 
+cat >.git/FAKE_EDITOR <<EOF
+#!$SHELL_PATH
+mv "\$1" "\$1.orig"
+(
+	echo message
+	cat "\$1.orig"
+) >"\$1"
+EOF
+
+echo '## Custom template' >template
+
+clear_config () {
+	(
+		git config --unset-all "$1"
+		case $? in
+		0|5)	exit 0 ;;
+		*)	exit 1 ;;
+		esac
+	)
+}
+
+try_commit () {
+	git reset --hard &&
+	echo >>negative &&
+	GIT_EDITOR=.git/FAKE_EDITOR git commit -a $* $use_template &&
+	case "$use_template" in
+	'')
+		! grep "^## Custom template" .git/COMMIT_EDITMSG ;;
+	*)
+		grep "^## Custom template" .git/COMMIT_EDITMSG ;;
+	esac
+}
+
+try_commit_status_combo () {
+
+	test_expect_success 'commit' '
+		clear_config commit.status &&
+		try_commit "" &&
+		grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
+	'
+
+	test_expect_success 'commit' '
+		clear_config commit.status &&
+		try_commit "" &&
+		grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
+	'
+
+	test_expect_success 'commit --status' '
+		clear_config commit.status &&
+		try_commit --status &&
+		grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
+	'
+
+	test_expect_success 'commit --no-status' '
+		clear_config commit.status &&
+		try_commit --no-status
+		! grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
+	'
+
+	test_expect_success 'commit with commit.status = yes' '
+		clear_config commit.status &&
+		git config commit.status yes &&
+		try_commit "" &&
+		grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
+	'
+
+	test_expect_success 'commit with commit.status = no' '
+		clear_config commit.status &&
+		git config commit.status no &&
+		try_commit "" &&
+		! grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
+	'
+
+	test_expect_success 'commit --status with commit.status = yes' '
+		clear_config commit.status &&
+		git config commit.status yes &&
+		try_commit --status &&
+		grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
+	'
+
+	test_expect_success 'commit --no-status with commit.status = yes' '
+		clear_config commit.status &&
+		git config commit.status yes &&
+		try_commit --no-status &&
+		! grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
+	'
+
+	test_expect_success 'commit --status with commit.status = no' '
+		clear_config commit.status &&
+		git config commit.status no &&
+		try_commit --status &&
+		grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
+	'
+
+	test_expect_success 'commit --no-status with commit.status = no' '
+		clear_config commit.status &&
+		git config commit.status no &&
+		try_commit --no-status &&
+		! grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
+	'
+
+}
+
+try_commit_status_combo
+
+use_template="-t template"
+
+try_commit_status_combo
+
 test_done
-- 
1.6.6.292.ge84ea.dirty
