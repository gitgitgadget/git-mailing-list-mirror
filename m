From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 9/9] t1504: stop resolving symlinks in GIT_CEILING_DIRECTORIES
Date: Sat, 29 Sep 2012 08:16:02 +0200
Message-ID: <1348899362-4057-10-git-send-email-mhagger@alum.mit.edu>
References: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 08:16:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THqMC-0002Xr-Jf
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 08:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758788Ab2I2GQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 02:16:45 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:49027 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758599Ab2I2GQk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Sep 2012 02:16:40 -0400
X-AuditID: 1207440e-b7f036d0000008b5-8d-50669247fb06
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 92.D7.02229.74296605; Sat, 29 Sep 2012 02:16:39 -0400 (EDT)
Received: from michael.fritz.box (p57A246BE.dip.t-dialin.net [87.162.70.190])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8T6G746026219
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 29 Sep 2012 02:16:38 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsUixO6iqOs+KS3A4P8RKYuuK91MFg29V5gt
	jp6ysLi9Yj6zxfp3V5kdWD3+vv/A5LFz1l12j4uXlD0+b5ILYInitklKLCkLzkzP07dL4M5Y
	NO0aS8F67YopC96yNDB+Veti5OSQEDCR+LXmFzOELSZx4d56ti5GLg4hgcuMEvd/tbJCOGeZ
	JNa9eA9WxSagK7Gop5kJxBYRUJOY2HaIBaSIWWASo0TPhgfsIAlhgUCJhqP7wWwWAVWJvbOP
	AxVxcPAKuEg0XAiG2KYo8eP7GrCZnEDh3z3TWUFsIQFniUd777BOYORdwMiwilEuMac0Vzc3
	MTOnODVZtzg5MS8vtUjXWC83s0QvNaV0EyMkkPh2MLavlznEKMDBqMTDq3U8NUCINbGsuDL3
	EKMkB5OSKG/OxLQAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8GcVA5bwpiZVVqUX5MClpDhYl
	cV61Jep+QgLpiSWp2ampBalFMFkZDg4lCd4SkKGCRanpqRVpmTklCGkmDk4QwQWygQdoQw1I
	IW9xQWJucWY6RNEpRkUpcd5EkIQASCKjNA9uACzmXzGKA/0jzNsPUsUDTBdw3a+ABjMBDV66
	KQlkcEkiQkqqgTHtYWR0YZVNxSTRo1tNH7wwCL7+YhpH6lvG85oMFbcyhM9/ZFFPbj5qrxl0
	O/mRStUXAUPBT6kbam/NtVF9PsH/2I9cCVXWxU8T7Dawbpzrq9idX/TxXADb2zK2jaHvruur
	HPz5ZM2yx3mxDRVTt0uctnd+/e3SnlKz+5NUl35/U+rC/0nz61olluKMREMt5qLi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206640>

This test used to explicitly resolve symlinks in the paths derived
from TRASH_DIRECTORY that were written to GIT_CEILING_DIRECTORIES,
because the code handling GIT_CEILING_DIRECTORIES was confused by
symlinks.  This is no longer necessary.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1504-ceiling-dirs.sh | 67 ++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/t/t1504-ceiling-dirs.sh b/t/t1504-ceiling-dirs.sh
index cce87a5..a4a5202 100755
--- a/t/t1504-ceiling-dirs.sh
+++ b/t/t1504-ceiling-dirs.sh
@@ -14,8 +14,7 @@ test_fail() {
 	'
 }
 
-TRASH_ROOT="$PWD"
-ROOT_PARENT=$(dirname "$TRASH_ROOT")
+ROOT_PARENT=$(dirname "$TRASH_DIRECTORY")
 
 
 unset GIT_CEILING_DIRECTORIES
@@ -32,16 +31,16 @@ test_prefix ceil_at_parent ""
 GIT_CEILING_DIRECTORIES="$ROOT_PARENT/"
 test_prefix ceil_at_parent_slash ""
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY"
 test_prefix ceil_at_trash ""
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/"
 test_prefix ceil_at_trash_slash ""
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/sub"
 test_prefix ceil_at_sub ""
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub/"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/sub/"
 test_prefix ceil_at_sub_slash ""
 
 
@@ -56,55 +55,55 @@ export GIT_CEILING_DIRECTORIES
 GIT_CEILING_DIRECTORIES=""
 test_prefix subdir_ceil_empty "sub/dir/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY"
 test_fail subdir_ceil_at_trash
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/"
 test_fail subdir_ceil_at_trash_slash
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/sub"
 test_fail subdir_ceil_at_sub
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub/"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/sub/"
 test_fail subdir_ceil_at_sub_slash
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub/dir"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/sub/dir"
 test_prefix subdir_ceil_at_subdir "sub/dir/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub/dir/"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/sub/dir/"
 test_prefix subdir_ceil_at_subdir_slash "sub/dir/"
 
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/su"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/su"
 test_prefix subdir_ceil_at_su "sub/dir/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/su/"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/su/"
 test_prefix subdir_ceil_at_su_slash "sub/dir/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub/di"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/sub/di"
 test_prefix subdir_ceil_at_sub_di "sub/dir/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub/di"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/sub/di"
 test_prefix subdir_ceil_at_sub_di_slash "sub/dir/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/subdi"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/subdi"
 test_prefix subdir_ceil_at_subdi "sub/dir/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/subdi"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/subdi"
 test_prefix subdir_ceil_at_subdi_slash "sub/dir/"
 
 
-GIT_CEILING_DIRECTORIES="/foo:$TRASH_ROOT/sub"
+GIT_CEILING_DIRECTORIES="/foo:$TRASH_DIRECTORY/sub"
 test_fail second_of_two
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub:/bar"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/sub:/bar"
 test_fail first_of_two
 
-GIT_CEILING_DIRECTORIES="/foo:$TRASH_ROOT/sub:/bar"
+GIT_CEILING_DIRECTORIES="/foo:$TRASH_DIRECTORY/sub:/bar"
 test_fail second_of_three
 
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/sub"
 GIT_DIR=../../.git
 export GIT_DIR
 test_prefix git_dir_specified ""
@@ -123,41 +122,41 @@ export GIT_CEILING_DIRECTORIES
 GIT_CEILING_DIRECTORIES=""
 test_prefix sd_ceil_empty "s/d/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY"
 test_fail sd_ceil_at_trash
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/"
 test_fail sd_ceil_at_trash_slash
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/s"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/s"
 test_fail sd_ceil_at_s
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/s/"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/s/"
 test_fail sd_ceil_at_s_slash
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/s/d"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/s/d"
 test_prefix sd_ceil_at_sd "s/d/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/s/d/"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/s/d/"
 test_prefix sd_ceil_at_sd_slash "s/d/"
 
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/su"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/su"
 test_prefix sd_ceil_at_su "s/d/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/su/"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/su/"
 test_prefix sd_ceil_at_su_slash "s/d/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/s/di"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/s/di"
 test_prefix sd_ceil_at_s_di "s/d/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/s/di"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/s/di"
 test_prefix sd_ceil_at_s_di_slash "s/d/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sdi"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/sdi"
 test_prefix sd_ceil_at_sdi "s/d/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sdi"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/sdi"
 test_prefix sd_ceil_at_sdi_slash "s/d/"
 
 
-- 
1.7.11.3
