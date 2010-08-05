From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v4 17/18] Add test cases for '--graph' of line level log
Date: Fri,  6 Aug 2010 00:11:56 +0800
Message-ID: <1281024717-7855-18-git-send-email-struggleyb.nku@gmail.com>
References: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Cc: trast@student.ethz.ch, Jens.Lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 18:14:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh35L-0001XF-3l
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 18:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760055Ab0HEQNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 12:13:41 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:65010 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759858Ab0HEQNj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 12:13:39 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so143837pwj.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 09:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=H5qk1QW4KvA+qPoTL+8VYq/1nHjytp65GpJKmJbjFOI=;
        b=hajfY0VH07o9Ss8IofGL/zYxGjp0UPap83HarulP1OYBdb0icOnXsysRKGeezMAiVy
         KOtwvteITeP/MJO0mO+UnyMf7+/JIBl8xA3GlZKi9EDnpSSalhu9qYr0kPLLT9VxOZdr
         q+zFZ9s03483CQPLLeq/orlwX0oBSoyRCboYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rtpwGl2hR3S3kvlAFtd1D74AZbpJeXPyMPlyqbONnm4OwfJO2/DRTR1rM3217b6QYX
         Inx9uC9bQWINGrEc6ceq8ViFI2z4CF+aaJ0tksyrhUAulmvTJoD2O4xEV8wPAT/Z55aG
         brcFrHZ0/Cm2/0/TGxPEIiBOnalMdpRfUMk9g=
Received: by 10.143.4.18 with SMTP id g18mr781835wfi.174.1281024819398;
        Thu, 05 Aug 2010 09:13:39 -0700 (PDT)
Received: from localhost.localdomain ([222.35.120.192])
        by mx.google.com with ESMTPS id w8sm343653wfd.19.2010.08.05.09.13.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 09:13:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.20.g388bbb
In-Reply-To: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152683>

t/t4301-log-line-single-history.sh:
  test the linear line of history with '--graph' option;

t/t4302-log-line-merge-history.sh:
  test the case that there are merges in the history with
  '--graph' option.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 t/t4301-log-line-single-history.sh |  277 ++++++++++++++++++++++++++++++++++++
 t/t4302-log-line-merge-history.sh  |   51 +++++++-
 2 files changed, 327 insertions(+), 1 deletions(-)

diff --git a/t/t4301-log-line-single-history.sh b/t/t4301-log-line-single-history.sh
index 9cf34f8..84bea11 100755
--- a/t/t4301-log-line-single-history.sh
+++ b/t/t4301-log-line-single-history.sh
@@ -339,4 +339,281 @@ test_expect_success \
 	 test_cmp current-linenum expected-linenum &&
 	 test_cmp current-always expected-always'
 
+# Rerun all log with graph
+test_expect_success \
+    'Show the line level log of path0 with --graph' \
+    'git log --pretty=format:%s%n%b --graph -L /func/,/^}/ path0 > current-path0-graph'
+
+test_expect_success \
+    'Show the line level log of path1 with --graph' \
+    'git log --pretty=format:%s%n%b --graph -L /output/,/^}/ path1 > current-path1-graph'
+
+test_expect_success \
+    'Show the line level log of two files with --graph' \
+    'git log --pretty=format:%s%n%b --graph -L /func/,/^}/ path0 --graph -L /output/,/^}/ path1 > current-pathall-graph'
+
+test_expect_success \
+    'Test the line number argument with --graph' \
+    'git log --pretty=format:%s%n%b --graph -L 1,2 path0 > current-linenum-graph'
+
+test_expect_success \
+	'Test the --full-line-diff option with --graph option' \
+	'git log --pretty=format:%s%n%b --full-line-diff --graph -L 1,2 path0 > current-always-graph'
+
+cat > expected-path0-graph <<\EOF
+* Final change of path0
+| 
+| diff --git a/path0 b/path0
+| index 44db133..1518c15 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,6 +1,5 @@
+|  void func(){
+|  	int a = 10;
+|  	int b = 11;
+| -	int c;
+| -	c = 10 * (a + b);
+| +	printf("%d", a - b);
+|  }
+|  
+* Change the 5th line of path0
+| 
+| diff --git a/path0 b/path0
+| index 9ef1692..44db133 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,6 +1,6 @@
+|  void func(){
+|  	int a = 10;
+|  	int b = 11;
+|  	int c;
+| -	c = a + b;
+| +	c = 10 * (a + b);
+|  }
+|  
+* Change 2,3 lines of path0 and path1
+| 
+| diff --git a/path0 b/path0
+| index aabffdf..9ef1692 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,6 +1,6 @@
+|  void func(){
+| -	int a = 0;
+| -	int b = 1;
+| +	int a = 10;
+| +	int b = 11;
+|  	int c;
+|  	c = a + b;
+|  }
+|  
+* Base commit
+  
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..aabffdf
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +1,6 @@
+  +void func(){
+  +	int a = 0;
+  +	int b = 1;
+  +	int c;
+  +	c = a + b;
+  +}
+EOF
+
+cat > expected-path1-graph <<\EOF
+* Change 2,3 lines of path0 and path1
+| 
+| diff --git a/path1 b/path1
+| index 997d841..1d711b5 100644
+| --- a/path1
+| +++ b/path1
+| @@ -1,3 +1,4 @@
+|  void output(){
+| -	printf("hello world");
+| +	const char *str = "hello world!";
+| +	printf("%s", str);
+|  }
+|  
+* Base commit
+  
+  diff --git a/path1 b/path1
+  new file mode 100644
+  index 0000000..997d841
+  --- /dev/null
+  +++ b/path1
+  @@ -0,0 +1,3 @@
+  +void output(){
+  +	printf("hello world");
+  +}
+EOF
+
+cat > expected-pathall-graph <<\EOF
+* Final change of path0
+| 
+| diff --git a/path0 b/path0
+| index 44db133..1518c15 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,6 +1,5 @@
+|  void func(){
+|  	int a = 10;
+|  	int b = 11;
+| -	int c;
+| -	c = 10 * (a + b);
+| +	printf("%d", a - b);
+|  }
+|  
+* Change the 5th line of path0
+| 
+| diff --git a/path0 b/path0
+| index 9ef1692..44db133 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,6 +1,6 @@
+|  void func(){
+|  	int a = 10;
+|  	int b = 11;
+|  	int c;
+| -	c = a + b;
+| +	c = 10 * (a + b);
+|  }
+|  
+* Change 2,3 lines of path0 and path1
+| 
+| diff --git a/path0 b/path0
+| index aabffdf..9ef1692 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,6 +1,6 @@
+|  void func(){
+| -	int a = 0;
+| -	int b = 1;
+| +	int a = 10;
+| +	int b = 11;
+|  	int c;
+|  	c = a + b;
+|  }
+| diff --git a/path1 b/path1
+| index 997d841..1d711b5 100644
+| --- a/path1
+| +++ b/path1
+| @@ -1,3 +1,4 @@
+|  void output(){
+| -	printf("hello world");
+| +	const char *str = "hello world!";
+| +	printf("%s", str);
+|  }
+|  
+* Base commit
+  
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..aabffdf
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +1,6 @@
+  +void func(){
+  +	int a = 0;
+  +	int b = 1;
+  +	int c;
+  +	c = a + b;
+  +}
+  diff --git a/path1 b/path1
+  new file mode 100644
+  index 0000000..997d841
+  --- /dev/null
+  +++ b/path1
+  @@ -0,0 +1,3 @@
+  +void output(){
+  +	printf("hello world");
+  +}
+EOF
+
+cat > expected-linenum-graph <<\EOF
+* Change 2,3 lines of path0 and path1
+| 
+| diff --git a/path0 b/path0
+| index aabffdf..9ef1692 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,2 +1,2 @@
+|  void func(){
+| -	int a = 0;
+| +	int a = 10;
+|  
+* Base commit
+  
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..aabffdf
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +1,2 @@
+  +void func(){
+  +	int a = 0;
+EOF
+
+cat > expected-always-graph <<\EOF
+* Final change of path0
+| 
+| diff --git a/path0 b/path0
+| index 44db133..1518c15 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,2 +1,2 @@
+|  void func(){
+|  	int a = 10;
+|  
+* Change the 5th line of path0
+| 
+| diff --git a/path0 b/path0
+| index 9ef1692..44db133 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,2 +1,2 @@
+|  void func(){
+|  	int a = 10;
+|  
+* Change 2,3 lines of path0 and path1
+| 
+| diff --git a/path0 b/path0
+| index aabffdf..9ef1692 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,2 +1,2 @@
+|  void func(){
+| -	int a = 0;
+| +	int a = 10;
+|  
+* Base commit
+  
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..aabffdf
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +1,2 @@
+  +void func(){
+  +	int a = 0;
+EOF
+
+test_expect_success \
+    'validate the path0 output.' \
+    'test_cmp current-path0-graph expected-path0-graph'
+test_expect_success \
+	'validate the path1 output.' \
+	'test_cmp current-path1-graph expected-path1-graph'
+test_expect_success \
+	'validate the all path output.' \
+	'test_cmp current-pathall-graph expected-pathall-graph'
+test_expect_success \
+	'validate graph output' \
+	'test_cmp current-linenum-graph expected-linenum-graph'
+test_expect_success \
+	'validate --full-line-diff output' \
+	'test_cmp current-always-graph expected-always-graph'
+
 test_done
diff --git a/t/t4302-log-line-merge-history.sh b/t/t4302-log-line-merge-history.sh
index 02e7439..1536cc4 100755
--- a/t/t4302-log-line-merge-history.sh
+++ b/t/t4302-log-line-merge-history.sh
@@ -66,7 +66,6 @@ Merge two branches
 
 nontrivial merge found
 path0
-
 @@ 2,1 @@
  	printf("hello earth and moon");
 
@@ -107,8 +106,58 @@ index 0000000..f628dea
 +	printf("hello");
 +}
 EOF
+
+cat > expected-graph <<\EOF
+*   Merge two branches
+|\  
+| | 
+| | nontrivial merge found
+| | path0
+| | @@ 2,1 @@
+| |  	printf("hello earth and moon");
+| | 
+| |   
+| * Change path0 in master
+| | 
+| | diff --git a/path0 b/path0
+| | index f628dea..bef7fa3 100644
+| | --- a/path0
+| | +++ b/path0
+| | @@ -2,1 +2,1 @@
+| | -	printf("hello");
+| | +	printf("hello earth");
+| |   
+* | Change path0 in feature
+|/  
+|   
+|   diff --git a/path0 b/path0
+|   index f628dea..a940ef6 100644
+|   --- a/path0
+|   +++ b/path0
+|   @@ -2,1 +2,1 @@
+|   -	printf("hello");
+|   +	print("hello moon");
+|  
+* Base commit
+  
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..f628dea
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +2,1 @@
+  +	printf("hello");
+EOF
+
+test_expect_success \
+    'Show the line log of the 2 line of path0 with graph' \
+    'git log --pretty=format:%s%n%b --graph -L 2,+1 path0 > current-graph'
+
 test_expect_success \
     'validate the output.' \
     'test_cmp current expected'
+test_expect_success \
+    'validate the graph output.' \
+    'test_cmp current-graph expected-graph'
 
 test_done
-- 
1.7.2.20.g388bbb
