From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] diff: flip the diff.bwoutputonly default to false
Date: Sat, 28 Nov 2009 23:25:54 -0800
Message-ID: <7veinhdc71.fsf_-_@alter.siamese.dyndns.org>
References: <7vfx7yfetb.fsf@alter.siamese.dyndns.org>
 <7vmy25dc9h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 29 08:26:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEeAW-0000co-N7
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 08:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428AbZK2HZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 02:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753328AbZK2HZx
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 02:25:53 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33740 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbZK2HZw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 02:25:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 57588835A6;
	Sun, 29 Nov 2009 02:25:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iDWcg5vlRViif3pczacJBhadDbI=; b=EjmSM8
	Tr4uAIpVY1ulRTefbTIyRWZ99An9ViJkwMDQWmEcg2mkvroGlmCgH+SutDuhHuU+
	HxainnwQOkROaCQoX+AFaPm4Ng+5tnk8m3cntc7DhA7tayODGQM/i1wPaHeS+6Uo
	3AHw4PGeQ2njMR3bNhwKeUxRC4q+rI/fJwO+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w6n7ZJwNL85wX2l3eb+dqV9SCgkrsTdh
	K4DISgCmgdiWdm+O5lRKMaUcuXB6bwuaOgwlAIayy1zv775sxZ/0zN/b9+3vRszl
	vS/h11ksJGVOCbr0tNGnVrrQMoQnr6xy6ZNvxpnYbzf8OjibdMgEmoJ6PrgV6Omk
	YZuYtJgNNZs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 87247835A5;
	Sun, 29 Nov 2009 02:25:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C832E835A4; Sun, 29 Nov
 2009 02:25:55 -0500 (EST)
In-Reply-To: <7vmy25dc9h.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat\, 28 Nov 2009 23\:24\:26 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6FC432B0-DCB8-11DE-B9C5-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133998>

This finally corrects the broken "ignore whitespace options only
affect patch output and never affects status nor header output",
as we have been planning for 1.7.0

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                       |    2 +-
 t/t4015-diff-whitespace.sh   |    5 +++--
 t/t4040-whitespace-status.sh |    2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index fb93a22..df67f18 100644
--- a/diff.c
+++ b/diff.c
@@ -29,7 +29,7 @@ static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
-static int diff_b_w_output_only = 1;
+static int diff_b_w_output_only;
 static int diff_b_w_output_only_given;
 
 static char diff_colors[][COLOR_MAXLEN] = {
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 310421b..8ca81e8 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -114,6 +114,7 @@ index d99af23..8b32fb5 100644
 EOF
 test_w_b "bwoutputonly=true"
 
+>expect
 git config --unset diff.bwoutputonly
 test_w_b "bwoutputonly unset"
 
@@ -398,7 +399,7 @@ test_expect_success 'checkdiff allows new blank lines' '
 	git diff --check
 '
 
-test_expect_success 'whitespace-only changes shown' '
+test_expect_success 'whitespace-only changes hidden' '
 	git config --unset diff.bwoutputonly
 	git reset --hard &&
 	echo >x "hello world" &&
@@ -406,7 +407,7 @@ test_expect_success 'whitespace-only changes shown' '
 	git commit -m "hello 1" &&
 	echo >x "hello  world" &&
 	git diff -b >actual &&
-	test 2 = $(wc -l <actual)
+	! test -s actual
 '
 
 test_expect_success 'whitespace-only changes shown with diff.bwoutputonly' '
diff --git a/t/t4040-whitespace-status.sh b/t/t4040-whitespace-status.sh
index 95a93f7..57db3cc 100755
--- a/t/t4040-whitespace-status.sh
+++ b/t/t4040-whitespace-status.sh
@@ -72,6 +72,6 @@ git config diff.bwoutputonly false
 test_once "bwoutputonly=false" ""
 
 git config --unset diff.bwoutputonly
-test_once "bwoutputonly unset" "test_must_fail"
+test_once "bwoutputonly unset" ""
 
 test_done
-- 
1.6.6.rc0.61.g41d5b.dirty
