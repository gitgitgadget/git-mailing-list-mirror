From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] diff: disable diff.bwoutputonly warning
Date: Sat, 28 Nov 2009 23:26:18 -0800
Message-ID: <7vaay5dc6d.fsf_-_@alter.siamese.dyndns.org>
References: <7vfx7yfetb.fsf@alter.siamese.dyndns.org>
 <7vmy25dc9h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 29 08:26:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEeAt-0000kg-F0
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 08:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbZK2H0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 02:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753523AbZK2H0Q
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 02:26:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53608 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbZK2H0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 02:26:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8F67BA23D1;
	Sun, 29 Nov 2009 02:26:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VVkrtv8k6KLmxLH3sKztO0S5xd0=; b=clXiv1
	ZV9ddMs45ZAS3c1ca8QTUVSZH1Fb1wecUi/0Zb8lUCBfcDwoJW+oyHJ7skDrSJgG
	EJhEoCWnvunn8KfE3w0BcKmuo7tm1eNgIiN23qubkjCZVGGgRoq2SKHZaktvP2eN
	P6Yk2iZ5gBEKx/b53RwzTZRPOUee6dZmVzGYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VREqMpIQTDMmsd8qWLwaikvNALgD+i7U
	TsWK6NpZE82dCFE2suXB6eyBrU0cmEQgqBe0SWYP+AjFBqvE29i9Ux08VOQu95B5
	VFQvBa2A5961IhAR4iX28jWnun9SU/l2j4yQuyGYqliaQ4jxvVGQBv/ERVtOyMGi
	oseDXeWS788=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7DFFAA23D0;
	Sun, 29 Nov 2009 02:26:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B9088A23CF; Sun, 29 Nov 2009
 02:26:19 -0500 (EST)
In-Reply-To: <7vmy25dc9h.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat\, 28 Nov 2009 23\:24\:26 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7E0FB84E-DCB8-11DE-8338-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133999>

After 1.7.0 (or whatever version) ships and everybody expects the new
semantics from "diff", we can squelch the warning.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                     |   11 -----------
 t/t4015-diff-whitespace.sh |    4 ++--
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
index df67f18..ba1f482 100644
--- a/diff.c
+++ b/diff.c
@@ -30,7 +30,6 @@ static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 static int diff_b_w_output_only;
-static int diff_b_w_output_only_given;
 
 static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
@@ -136,7 +135,6 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp(var, "diff.bwoutputonly")) {
-		diff_b_w_output_only_given = 1;
 		diff_b_w_output_only = git_config_bool(var, value);
 		return 0;
 	}
@@ -2523,11 +2521,6 @@ void diff_setup(struct diff_options *options)
 	}
 }
 
-static const char *bw_option_warning =
-	"ignore-whitespace options will stop showing diff headers in later\n"
-	"versions of git; set diff.bwoutputonly to true to keep the old\n"
-	"behaviour, or set.bwoutputonly to false to squelch this message.\n";
-
 int diff_setup_done(struct diff_options *options)
 {
 	int count = 0;
@@ -2553,10 +2546,6 @@ int diff_setup_done(struct diff_options *options)
 	bw_options = (DIFF_XDL_TST(options, IGNORE_WHITESPACE) ||
 		      DIFF_XDL_TST(options, IGNORE_WHITESPACE_CHANGE) ||
 		      DIFF_XDL_TST(options, IGNORE_WHITESPACE_AT_EOL));
-	if (!diff_b_w_output_only_given && bw_options && bw_option_warning) {
-		warning("%s", bw_option_warning);
-		bw_option_warning = NULL;
-	}
 	if (!diff_b_w_output_only && bw_options)
 		DIFF_OPT_SET(options, DIFF_FROM_CONTENTS);
 	else
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 8ca81e8..0964ea2 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -433,10 +433,10 @@ test_expect_success 'no warning without diff.bwoutputonly' '
 	! grep "stop showing" errors
 '
 
-test_expect_success 'warning without diff.bwoutputonly' '
+test_expect_success 'no warning anymore' '
 	git config --unset diff.bwoutputonly
 	git diff -b 2>errors &&
-	grep "stop showing" errors
+	! grep "stop showing" errors
 '
 
 test_expect_success 'combined diff with autocrlf conversion' '
-- 
1.6.6.rc0.61.g41d5b.dirty
