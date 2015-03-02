From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] git: make was_alias and done_help non-static
Date: Mon,  2 Mar 2015 18:02:37 +0600
Message-ID: <1425297757-16431-1-git-send-email-kuleshovmail@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 02 13:02:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSP3k-0006x9-UW
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 13:02:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbbCBMCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 07:02:48 -0500
Received: from mail-la0-f43.google.com ([209.85.215.43]:36256 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbbCBMCr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 07:02:47 -0500
Received: by labgq15 with SMTP id gq15so29849670lab.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2015 04:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=VTXe37HttYXap8O0sRzt6tUOVCPtEp5lnL3pLXhBSvA=;
        b=B+rwrKw5TD/vhJUgemPsyELlT+l/G3N5f5wI656SggUkmzjpfxFuj6CxDq2Qine8pd
         AxJw7OJC3eJTqbNsZD4sMb88fmJ863bCEA9Kjsx0xqr02609Hl5c9+EUlgL0hRipxMR3
         OYRWnNr9kyeu+8QvvR7x9Vr8CXzdiYHqlOEFvL7F8ssJ4GIV2w1RypNxJh441r522jM5
         Oix5qgu38TnrqZ3btKam9k1oyOHMcyjONaA+YnE28Xg2jl3R5DdcQ1N1lYYnme1oLF2C
         Zjp69ydVhFRwXDl48+RvsoH7YbNYvCgHwQ3ma85GCWT+ERn86p4492zi/47/079OOA3K
         1GeQ==
X-Received: by 10.112.114.164 with SMTP id jh4mr23936650lbb.21.1425297764957;
        Mon, 02 Mar 2015 04:02:44 -0800 (PST)
Received: from localhost.localdomain ([147.30.48.224])
        by mx.google.com with ESMTPSA id gz5sm1760716lac.26.2015.03.02.04.02.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Mar 2015 04:02:44 -0800 (PST)
X-Mailer: git-send-email 2.3.1.422.ge618558
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264590>

'was_alias' variable does not need to store it's value on each
iteration in the loop, anyway this variable changes it's value with run_argv.

'done_help' variable does not need to be static variable too if we'll move it
out the loop.

So these variables do not need to be static.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
---
 git.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/git.c b/git.c
index 1780233..96723b8 100644
--- a/git.c
+++ b/git.c
@@ -619,6 +619,7 @@ int main(int argc, char **av)
 {
 	const char **argv = (const char **) av;
 	const char *cmd;
+	int done_help, was_alias;
 
 	startup_info = &git_startup_info;
 
@@ -681,8 +682,6 @@ int main(int argc, char **av)
 	setup_path();
 
 	while (1) {
-		static int done_help = 0;
-		static int was_alias = 0;
 		was_alias = run_argv(&argc, &argv);
 		if (errno != ENOENT)
 			break;
-- 
2.3.1.422.ge618558
