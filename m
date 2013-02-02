From: Marc Khouzam <marc.khouzam@ericsson.com>
Subject: [PATCH] Handle path completion and colon for tcsh script
Date: Sat, 2 Feb 2013 19:43:25 +0000
Message-ID: <E59706EF8DB1D147B15BECA3322E4BDC09AA38@eusaamb103.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "manlio.perillo@gmail.com" <manlio.perillo@gmail.com>,
	"gitster@pobox.com" <gitster@pobox.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 02 20:44:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1j0U-0004Vt-84
	for gcvg-git-2@plane.gmane.org; Sat, 02 Feb 2013 20:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758076Ab3BBTna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2013 14:43:30 -0500
Received: from usevmg21.ericsson.net ([198.24.6.65]:65123 "EHLO
	usevmg21.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758072Ab3BBTn2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Feb 2013 14:43:28 -0500
X-AuditID: c6180641-b7f926d000000e79-4b-510d6c5e8582
Received: from EUSAAHC008.ericsson.se (Unknown_Domain [147.117.188.96])
	by usevmg21.ericsson.net (Symantec Mail Security) with SMTP id B4.FF.03705.F5C6D015; Sat,  2 Feb 2013 20:43:27 +0100 (CET)
Received: from EUSAAMB103.ericsson.se ([147.117.188.120]) by
 EUSAAHC008.ericsson.se ([147.117.188.96]) with mapi id 14.02.0318.004; Sat, 2
 Feb 2013 14:43:26 -0500
Thread-Topic: [PATCH] Handle path completion and colon for tcsh script
Thread-Index: Ac4BfS+gNnq/8K09SGSiydPZlwP+xg==
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.117.188.135]
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsUyuXRPgm58Dm+gwaKdohZdV7qZLBp6rzBb
	XPzTxe7A7LFz1l12j4uXlD0+b5ILYI7isklJzcksSy3St0vgyjjdPpmx4Bl/xenpTawNjE28
	XYycHBICJhJHF15khLDFJC7cW8/WxcjFISRwhFHi8o4JLCAJIYFljBKnn5SC2GwCehI3ft5i
	72Lk4BAR0JfouyAKEmYWSJH4+e0vK0hYWMBR4vkucZCwiICbxIFz89kgbD2J9mkXmUBsFgEV
	iZ5jc8HW8gp4S3QuWMYOYjMKyErsPnudCWKkuMS++buZIU4TkFiy5zyULSrx8vE/VghbWeL7
	nEcsEPU6Egt2f2KDsLUlli18zQwxX1Di5MwnLBMYRWYhGTsLScssJC2zkLQsYGRZxchRWpxa
	lptuZLiJERgBxyTYHHcwLvhkeYhRmoNFSZw31PVCgJBAemJJanZqakFqUXxRaU5q8SFGJg5O
	qQbGnWe62Y/83/Fv5aWLFqvNDz37denpjWDDRWVKLNGLzv4NtVHZYMB+NFflzo+0XZXG29Mi
	f0Zm7Yg9zjOz2e/F2rfVftPl6i91/TlcHSkzr2lllapcd5Ts+aUZ4n7yDp5tq67Jlk3r5y23
	OvExm2vppMNpPHENFd3f1+V+vJ+fllq4pPAei4ugEktxRqKhFnNRcSIAwtBpKU4CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215291>

Recent enhancements to git-completion.bash provide
intelligent path completion for git commands.  Such
completions do not add the '/' at the end of directories
for recent versions of bash.  However, the '/' is needed
by tcsh, so we must tell the bash script to append it
by using a compatibility method available for older
bash versions.

Also, tcsh does not handle the colon as a completion
separator so we remove it from the list of separators.

Signed-off-by: Marc Khouzam <marc.khouzam@ericsson.com>
---
Hi,

Here is the update for tcsh completion which is needed to handle
the cool new path completion feature just pushed to 'next'.

Also, Manlio reported that tcsh completion was broken when using
the colon, and this patch fixes the issue.

I haven't quite figured out the process to indicate which branch
a patch is meant for.  Do I just mention it in the email?  Or are all 
patches meant for the 'pu' branch?  In this case, 'pu' or 'next'
would be appropriate.

Thanks!

Marc

 contrib/completion/git-completion.tcsh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/contrib/completion/git-completion.tcsh b/contrib/completion/git-completion.tcsh
index 3e3889f..eaacaf0 100644
--- a/contrib/completion/git-completion.tcsh
+++ b/contrib/completion/git-completion.tcsh
@@ -52,6 +52,18 @@ cat << EOF > ${__git_tcsh_completion_script}
 
 source ${__git_tcsh_completion_original_script}
 
+# Remove the colon as a completion separator because tcsh cannot handle it
+COMP_WORDBREAKS=\${COMP_WORDBREAKS//:}
+
+# For file completion, tcsh needs the '/' to be appended to directories.
+# By default, the bash script does not do that.
+# We can achieve this by using the below compatibility
+# method of the git-completion.bash script.
+__git_index_file_list_filter ()
+{
+	__git_index_file_list_filter_compat
+}
+
 # Set COMP_WORDS in a way that can be handled by the bash script.
 COMP_WORDS=(\$2)
 
-- 
1.8.1.367.g8e14972.dirty
