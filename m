Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9E9E1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 14:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbcHOOKF (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 10:10:05 -0400
Received: from mout.gmx.net ([212.227.17.21]:58464 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752796AbcHOOIr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 10:08:47 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MRCCJ-1bld0n2kJj-00UWTV; Mon, 15 Aug 2016 16:08:42
 +0200
Date:	Mon, 15 Aug 2016 16:08:41 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t/Makefile: make sure that file names are truly
 platform-independent
Message-ID: <814aefbcf0f9380098e3f7a183399e11e24180dd.1471270061.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rjyxG2XLI9LTTA45xYxPu+rei1TRzD99jrBlNFQ/yq5700KWyxE
 WSbysq6dm9H+231zpYkSg/eAWaxGNFrm5R/U/bX+tdHQqFhYuK+S1NXB2AJi8GyJBWb11Dt
 bZF2PbF0UD0eN1Y1zBr1YA8MENvSUFWxHlD59v/FGbQMa/vTeC/fnmt0T8MvLuxzd8y/OMD
 X+m2er60F6hi9o/lJwV8w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:zDTLaeKji0o=:srqyxH80UhLCqNxeYrHar3
 lqjS+Hvz/6eFlXXynvNuO4ycdrWEZQ1Nf3SeXq3DiBV/JACeHxuLDK8ezspGjlJ/u/T7DgGpb
 GQ8YBVot+Wm5t1MZ30FhK3w6xN/Xdwpom+4Hui85PTuBXq7YsysEpuP8EocaIHQwYT1BWbl88
 jVI7lR72vWEAUY2FCRaFIqDPGeOaVI6RiP2EsQ4X9sDqmlXaunmyVK6hUcBUA+gbYUxrxzYKk
 QtXBfoZgDJLqz9B4SHNXW1nW/9RBAYZ+N0XP19rvflXErlmF/R3A0OKTIOguIrQ3eHSBMX6+R
 aq2cv+073tWBODHt+yTy0XiVdz0wljCvSMtH+jj+vLKmzWHYPj5W5Hd9CwvovQipmCqNwFIuj
 jeiYPDWe0uBwuZav3UiKx/Ub++T1Be0YGuq19WSmXW0uJoz5TEoVA79jDwymHNkXlJ7YLQuxR
 c+SujQQWN/5fXxrKKzuY1XP6Bf1GOh35uLm2LqP0lendiXO5NsWdYOm4NRBtv+xQH+7rvwvD+
 MwxCBdz51JFl9AfEnIkzo1X/kShY0VdIYIVDihm4ql+N2t24yiBjLTbY3xVoMa4uAi0U3JHrI
 NpTabzd9PFxuucoibSeWxw8q0GpOaIfM87CL2MXriy0TkiPSVs6KGdOSPBcVCyJbbuC0rEW2t
 JeMNQi7ZYBGTdVurr10GNlxQyVaw4Qzi/RbNDUuafS1dM8g7khkPq/Oa4xa9Vx09F1qlwZiYl
 Yfy3v6fsyppzcPC4Q8NkUxoQKTHIW5Jn24X1qKjjqsTecKFxgFHClY3susAcGA3TOb8y3vHWu
 y1HfIwm
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Some file names that are okay on ext4 and on HFS+ are illegal in
Windows. In order to stay truly platform-independent, Git's source code
must not contain such illegal file names, even if things just happen to
work on Linux.

One such file name was recently introduced into Git's `pu` branch:

t4013/diff.diff_--diff-line-prefix=-->_master_master^_sidt4013/diff.diff_--diff-line-prefix=-->_master_master^_sid

It is illegal because it contains the '>' character that is not part of
a valid filename on Windows.

To catch these issues early, let's introduce a new test-lint-* goal that
fails if such file names were detected and run it as part of a `make
test`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/test-lint-filenames-v1
Fetch-It-Via: git fetch https://github.com/dscho/git test-lint-filenames-v1

	This is the more complete fix I talked about.

 t/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/Makefile b/t/Makefile
index 18e2b28..3c0eb48 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -52,7 +52,8 @@ clean-except-prove-cache:
 clean: clean-except-prove-cache
 	$(RM) .prove
 
-test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax
+test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax \
+	test-lint-filenames
 
 test-lint-duplicates:
 	@dups=`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` && \
@@ -67,6 +68,11 @@ test-lint-executable:
 test-lint-shell-syntax:
 	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T) $(THELPERS)
 
+test-lint-filenames:
+	@illegal="$$(git ls-files | grep '["*:<>?\\|]')"; \
+		test -z "$$illegal" || { \
+		echo >&2 "illegal file name(s): " $$illegal; exit 1; }
+
 aggregate-results-and-cleanup: $(T)
 	$(MAKE) aggregate-results
 	$(MAKE) clean
-- 
2.9.2.691.g78954f3

base-commit: 5e18482599a6cfeb8d4e0ee5a98d30220cbdff72
