From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/7] grep: --count over binary
Date: Thu, 13 May 2010 22:37:10 +0200
Message-ID: <4BEC62F6.9050602@lsrfire.ath.cx>
References: <4BEC6211.2000309@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Phil Lawrence <prlawrence@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 13 22:37:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCf9l-0006mS-Af
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 22:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759452Ab0EMUhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 16:37:15 -0400
Received: from india601.server4you.de ([85.25.151.105]:53373 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756577Ab0EMUhO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 16:37:14 -0400
Received: from [10.0.1.100] (p57B7E766.dip.t-dialin.net [87.183.231.102])
	by india601.server4you.de (Postfix) with ESMTPSA id DE6A52F806A;
	Thu, 13 May 2010 22:37:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BEC6211.2000309@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147024>

The intent of showing the message "Binary file xyz matches" for
binary files is to avoid annoying users by potentially messing up
their terminals by printing control characters.  In --count mode,
this precaution isn't necessary.

Display counts of matches if -c/--count was specified, even if -a
was not given.  GNU grep does the same.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c                 |    2 +-
 t/t7008-grep-binary.sh |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/grep.c b/grep.c
index 2a8e879..4b6c02e 100644
--- a/grep.c
+++ b/grep.c
@@ -802,7 +802,7 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 
 	switch (opt->binary) {
 	case GREP_BINARY_DEFAULT:
-		if (buffer_is_binary(buf, size))
+		if (!opt->count && buffer_is_binary(buf, size))
 			binary_match_only = 1;
 		break;
 	case GREP_BINARY_NOMATCH:
diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index f9fd5e6..5449dd9 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -27,4 +27,10 @@ test_expect_success 'git grep -I ina a' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git grep -c ina a' '
+	echo a:1 >expect &&
+	git grep -c ina a >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.1
