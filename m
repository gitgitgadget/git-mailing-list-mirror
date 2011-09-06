From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] Makefile: abort on shells that do not support ${parameter%word} expansion
Date: Tue,  6 Sep 2011 14:09:43 -0500
Message-ID: <rPnr5AVZRRnklxb_Yaj0gopXRTVCT-tq7iVG-1NoXjOrHWsyuLop-co4qtQjezJ98BaKc0R71r8fMcBOijq9oCOgfBF6ticVk17DwDQzV91bcC719fGSUPDsf40AuoRfgjURcxREkMk@cipher.nrlssc.navy.mil>
References: <7vbouzxy7g.fsf@alter.siamese.dyndns.org>
Cc: Naohiro Aota <naota@elisp.net>, git@vger.kernel.org,
	tarmigan+git@gmail.com, David Barr <davidbarr@google.com>,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 21:10:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R112M-0007B9-S7
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 21:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463Ab1IFTKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 15:10:15 -0400
Received: from mail4.nrlssc.navy.mil ([128.160.11.9]:45549 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754331Ab1IFTKO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 15:10:14 -0400
Received: by mail3.nrlssc.navy.mil id p86J9xxT010334; Tue, 6 Sep 2011 14:09:59 -0500
In-Reply-To: <7vbouzxy7g.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 06 Sep 2011 19:09:55.0281 (UTC) FILETIME=[900B2410:01CC6CC8]
X-Virus-Scanned: clamav-milter 0.97.2 at mail4
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180822>

From: Brandon Casey <drafnel@gmail.com>

Add an entry to the please_set_SHELL_PATH_to_a_more_modern_shell target
which tests whether the shell supports ${parameter%word} expansion.  I
assume this one test is enough to indicate whether the shell supports the
entire family of prefix and suffix removal syntax:

   ${parameter%word}
   ${parameter%%word}
   ${parameter#word}
   ${parameter##word}

FreeBSD, for one, has a /bin/sh that, apparently, supports $() notation but
not the above prefix/suffix removal notation.
---

On 09/05/2011 02:09 AM, Junio C Hamano wrote:
> Naohiro Aota <naota@elisp.net> writes:
> 
>> Variable expansions like "${foo#bar}" or "${foo%bar}" doesn't work on
>> shells like FreeBSD sh and they made the test to fail.
> 
> Sorry, I do appreciate the effort, but a patch like this takes us in the
> wrong direction.
> 
> While we do not allow blatant bashisms like ${parameter:offset:length}
> (substring expansion), ${parameter/pattern/string} (pattern substitution),
> "local" variables, "function" noiseword, and shell arrays in our shell
> scripts, the two kinds of substitution you quoted above are purely POSIX,
> and our coding guideline does allow them to be used in the scripts.

Perhaps we should add a test for this shell feature.

-Brandon

 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 8d6d451..46d9c5d 100644
--- a/Makefile
+++ b/Makefile
@@ -1738,6 +1738,7 @@ endif
 
 please_set_SHELL_PATH_to_a_more_modern_shell:
 	@$$(:)
+	@foo=bar_suffix && test bar = "$${foo%_*}"
 
 shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
 
-- 
1.7.6.1
