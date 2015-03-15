From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] git prompt: Use toplevel to find untracked files.
Date: Sun, 15 Mar 2015 12:49:04 +0100
Message-ID: <1426420144-10584-1-git-send-email-szeder@ira.uka.de>
References: <xmqqmw3hzakn.fsf@gitster.dls.corp.google.com>
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Cody A Taylor <cody.taylor@maternityneighborhood.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 12:49:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YX72y-0002NW-Uy
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 12:49:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbbCOLt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 07:49:29 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:42316 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752202AbbCOLtZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Mar 2015 07:49:25 -0400
Received: from x590c5c95.dyn.telefonica.de ([89.12.92.149] helo=localhost)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1YX72m-0005Cs-QA; Sun, 15 Mar 2015 12:49:22 +0100
X-Mailer: git-send-email 1.9.5.msysgit.0
In-Reply-To: <xmqqmw3hzakn.fsf@gitster.dls.corp.google.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1426420162.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265490>

Hi,

Quoting Junio C Hamano <gitster@pobox.com>:

> Cody A Taylor <cody.taylor@maternityneighborhood.com> writes:
>> The __git_ps1() prompt function would not show an untracked
>> state when the current working directory was not a parent of
>> the untracked file.
>
> Good find, and nicely explained.

Somehow I had a hard time making sense out of "when the current working
directory was not a parent of the untracked file".  Perhaps "when the
untracked files are outside of the current working directory" would be
easier to grok?

> I wonder if we can add a test
> or two to t9903-bash-prompt.sh?

This test fails without the patch in question and succeeds with it.

-- 8< --

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 51ecd3e..3d1a95f 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -397,6 +397,16 @@ test_expect_success 'prompt - untracked files status indicator - untracked files
 	test_cmp expected "$actual"
 '
 
+test_expect_success 'prompt - untracked files status indicator - untracked files outside cwd' '
+	printf " (master %%)" >expected &&
+	(
+		cd ignored_dir &&
+		GIT_PS1_SHOWUNTRACKEDFILES=y &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
 test_expect_success 'prompt - untracked files status indicator - shell variable unset with config disabled' '
 	printf " (master)" >expected &&
 	test_config bash.showUntrackedFiles false &&
