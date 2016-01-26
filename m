From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 11/19] tests: turn off git-daemon tests if FIFOs are not
 available
Date: Tue, 26 Jan 2016 15:35:09 +0100 (CET)
Message-ID: <0717fe3c7788ae2441cdf2e8ca8aeda708e8d300.1453818790.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 15:35:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO4iR-0004mL-Cv
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 15:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966310AbcAZOfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 09:35:19 -0500
Received: from mout.gmx.net ([212.227.15.15]:63882 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966201AbcAZOfN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 09:35:13 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M2cYX-1a51vH2XcT-00sNXi; Tue, 26 Jan 2016 15:35:10
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453818789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:IrWFd+1hiq9G2AHjc89XHoaXa0Eves1+szlqiZW3wIEVDNmgjh9
 2dn+Nbp5Un/sZCwNJp615IxcC9TA54GeXgddQ02UTu797eTc6HxA1ZF/xIFl/rgTI5OaxlK
 B9mzloWq0N5ZZD0/Tq5Ui7SM1mSoOuh45rBuX7u5sl4m+w+B93fI3+s9MVwHpUg3YjMDADn
 y9nR0MbT5ZAasNcN+YuxA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qXBeNFngaxo=:GhFOpfDJiPeT0841a8fcOc
 S1lKr2fb/upXavcVxwGX2csjSTeOQ/+jk+zRr0xGo+fCiwzY34jU+zromuNUy7CNmffDIHdg0
 /eO24VfI8wQDXEywESRmIwYzjczyDHw7Nnv/B8OrBTf+dFRi560PatPv/TfkphH5snNNvNHvx
 +cvCZ/5zT4B4jbnT/dvHjaQjcFHC0trgR8K3/Tg9v3TXC88Ccs6Rli7TOWfKWHvNSCp+5SPoz
 URPrQBS/+lNlGcs5UjFnWTg0oskd5gv2cwXrPhF3IZIQanNPyreZFkrUZUHu2kntjgvqcWJmW
 ztKGNZqXpOu+538osyaASgvAzWsSjezHq27+H7OJ6YRVKQzy2wlQNfpOeaTUwoqsFiGAYVtts
 sBJdrloWJrIr7EG2lalpC3IGO0M74Lrs1XO/9IVpMaFWz9HSmd7AeUbH32ABC+jNyBylmaowU
 NTcBhcbg9wOx7LNjBJnfQZsNkiYbbRjEDLe+aO7o4Vc5mn40qbjbUAhzBGSLVHCN7uq4HTagw
 OAbHUizDaAmQMH7UAY31YCl4R2mlYIkTv076AHm4fcU0fJgyPdaTvUrETC6wNlhvSAqqTt6qG
 N3ozMK/KodDHjfZCy8Voh/pAD8DkARwDpYN+x3axUHpoVVHg55R9WFDBeBZfFoag/Wgm6wcfl
 8w71+flzJhQ8qW3Di1JWmHPbR/HK1wlhhzRAx+Og665Wk3WzXECzD9/H+VtaGodBMgsAzMyv4
 6NLZA3/HSjjhX30QNn06chodxMDZW9BAGZMdijspSE2zgPkBZzlop42GCVpwsRYKHgfRQM5n 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284824>

The Git daemon tests create a FIFO first thing and will hang if said
FIFO is not available.

This is a problem with Git for Windows, where `mkfifo` is an MSYS2
program that leverages MSYS2's POSIX emulation layer, but
`git-daemon.exe` is a MINGW program that has not the first clue about
that POSIX emulation layer and therefore blinks twice when it sees
MSYS2's emulated FIFOs and then just stares into space.

This lets t5570-git-daemon.sh and t5811-proto-disable-git.sh pass.

Signed-off-by: Stepan Kasal <kasal@ucw.cz>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/lib-git-daemon.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index bc4b341..9b1271c 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -23,6 +23,11 @@ then
 	test_done
 fi
 
+if ! test_have_prereq PIPE
+then
+	test_skip_or_die $GIT_TEST_GIT_DAEMON "file system does not support FIFOs"
+fi
+
 LIB_GIT_DAEMON_PORT=${LIB_GIT_DAEMON_PORT-${this_test#t}}
 
 GIT_DAEMON_PID=
-- 
2.7.0.windows.1.7.g55a05c8
