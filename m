From: Brian Downing <bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org>
Subject: [PATCH] compat: Add simplified merge sort implementation
 from glibc
Date: Sat, 2 Feb 2008 19:11:30 -0600
Message-ID: <20080203011130.GK26392@lavos.net>
Reply-To: bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Sun Feb 03 02:12:08 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLTOx-0000hG-Ki
	for gcvm-msysgit@m.gmane.org; Sun, 03 Feb 2008 02:12:08 +0100
Received: by yw-out-2122.google.com with SMTP id 4so3570590ywc.37
        for <gcvm-msysgit@m.gmane.org>; Sat, 02 Feb 2008 17:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:x-ironport-av:received:x-ironport-anti-spam-filtered:x-ironport-anti-spam-result:x-ironport-av:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=5hGpslDn1bhm1wD9qp7oaHQxB0ZnuKjC6i98vVfvXq0=;
        b=y3huPtHuUYpDUemei1WjN2qnvdxQ8FdSZ4N0aiUvvU3RMidmYXOKNmQO6UjdjRN73kQGz1W6iuLaVqXx4WPCGBRqVdKZWu12225ZUFoyYUA22ApsLg2b3XUA7dkp5dirWG1gLWmkA5K5+0kUq8UHFjQZaaXYnGUBNMRPMA4PKRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-ironport-av:x-ironport-anti-spam-filtered:x-ironport-anti-spam-result:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=HEwbGPrln8J6/wpTTrFDcg+D/2zK7QyQHZJnx0b55gunODnsjLhar5xwovK7+VxjrnXdNNadAmVnanVWgt+g+8nptQLf30vwaH5Nb4w06p3/MaL3V1uMvSS9vfzFhk3RDGnhy8IF3iU6T0dLsBCRSrtKzzguzXhkFkpkCkt3qhA=
Received: by 10.150.181.11 with SMTP id d11mr353018ybf.7.1202001092060;
        Sat, 02 Feb 2008 17:11:32 -0800 (PST)
Received: by 10.44.53.58 with SMTP id b58gr1587hsa;
	Sat, 02 Feb 2008 17:11:32 -0800 (PST)
X-Sender: bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.124.20 with SMTP id b20mr17705113pyn.5.1202001091506; Sat, 02 Feb 2008 17:11:31 -0800 (PST)
Received: from mxsf03.insightbb.com (mxsf03.insightbb.com [74.128.0.64]) by mx.google.com with ESMTP id x46si9748402pyg.3.2008.02.02.17.11.31; Sat, 02 Feb 2008 17:11:31 -0800 (PST)
Received-SPF: neutral (google.com: 74.128.0.64 is neither permitted nor denied by best guess record for domain of bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org) client-ip=74.128.0.64;
Authentication-Results: mx.google.com; spf=neutral (google.com: 74.128.0.64 is neither permitted nor denied by best guess record for domain of bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org) smtp.mail=bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org
X-IronPort-AV: E=Sophos;i="4.25,296,1199682000";  d="scan'208";a="195603707"
Received: from unknown (HELO asav01.insightbb.com) ([172.31.249.124]) by mxsf03.insightbb.com with ESMTP; 02 Feb 2008 20:11:31 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FADajpEdKhvkY/2dsb2JhbACBWKp+ggA
X-IronPort-AV: E=Sophos;i="4.25,296,1199682000";  d="scan'208";a="113529150"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24]) by asav01.insightbb.com with ESMTP; 02 Feb 2008 20:11:30 -0500
Received: by mail.lavos.net (Postfix, from userid 1000) id 94CCC309F21; Sat,  2 Feb 2008 19:11:30 -0600 (CST)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact msysgit-owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:msysgit-help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72311>


qsort in Windows 2000 (and possibly other older Windows' C libraries)
is a Quicksort with the usual O(n^2) worst case.  Unfortunately, sorting
Git trees seems to get very close to that worst case quite often:

    $ /git/gitbad runstatus
    # On branch master
    qsort, nmemb = 30842
    done, 237838087 comparisons.

This patch adds a simplified version of the merge sort that is glibc's
qsort(3).  As a merge sort, this needs a temporary array equal in size
to the array that is to be sorted.

The complexity that was removed is:

* Doing direct stores for word-size and -aligned data.
* Falling back to quicksort if the allocation required to perform the
  merge sort would likely push the machine into swap.

Even with these simplifications, this seems to outperform the Windows
qsort(3) implementation, even in Windows XP (where it is "fixed" and
doesn't trigger O(n^2) complexity on trees).

[jes: moved into compat/qsort.c, as per Johannes Sixt's suggestion]

Signed-off-by: Brian Downing <bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org>
Signed-off-by: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin-Mmb7MZpHnFY@public.gmane.org>
---
   Junio,

   This is for consideration for mainline Git now that 1.5.4 is out.  It
   is used to avoid an awful qsort implementation on Windows 2000, and I
   believe there was some discussion about other Unixes (AIX, etc) that
   have a similar problem.

   -bcd

 Makefile          |    7 ++++++
 compat/qsort.c    |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h |    6 +++++
 3 files changed, 73 insertions(+), 0 deletions(-)
 create mode 100644 compat/qsort.c

diff --git a/Makefile b/Makefile
index 92341c4..1698bc4 100644
--- a/Makefile
+++ b/Makefile
@@ -137,6 +137,9 @@ all::
 # Define THREADED_DELTA_SEARCH if you have pthreads and wish to exploit
 # parallel delta searching when packing objects.
 #
+# Define NEEDS_QUICK_QSORT if your qsort() implementation has O(n^2)
+# worst case complexity.
+#
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -722,6 +725,10 @@ ifdef NO_MEMMEM
 	COMPAT_CFLAGS += -DNO_MEMMEM
 	COMPAT_OBJS += compat/memmem.o
 endif
+ifdef NEEDS_QUICK_QSORT
+	COMPAT_CFLAGS += -DNEEDS_QUICK_QSORT
+	COMPAT_OBJS += compat/qsort.o
+endif
 
 ifdef THREADED_DELTA_SEARCH
 	BASIC_CFLAGS += -DTHREADED_DELTA_SEARCH
diff --git a/compat/qsort.c b/compat/qsort.c
new file mode 100644
index 0000000..734866e
--- /dev/null
+++ b/compat/qsort.c
@@ -0,0 +1,60 @@
+#include "../git-compat-util.h"
+
+/* This merge sort implementation is simplified from glibc's. */
+static void msort_with_tmp(void *b, size_t n, size_t s,
+			   int (*cmp)(const void *, const void *),
+			   char *t)
+{
+	char *tmp;
+	char *b1, *b2;
+	size_t n1, n2;
+
+	if (n <= 1)
+		return;
+
+	n1 = n / 2;
+	n2 = n - n1;
+	b1 = b;
+	b2 = (char *)b + (n1 * s);
+
+	msort_with_tmp(b1, n1, s, cmp, t);
+	msort_with_tmp(b2, n2, s, cmp, t);
+
+	tmp = t;
+
+	while (n1 > 0 && n2 > 0) {
+		if (cmp(b1, b2) <= 0) {
+			memcpy(tmp, b1, s);
+			tmp += s;
+			b1 += s;
+			--n1;
+		} else {
+			memcpy(tmp, b2, s);
+			tmp += s;
+			b2 += s;
+			--n2;
+		}
+	}
+	if (n1 > 0)
+		memcpy(tmp, b1, n1 * s);
+	memcpy(b, t, (n - n2) * s);
+}
+
+void git_qsort(void *b, size_t n, size_t s,
+	       int (*cmp)(const void *, const void *))
+{
+	const size_t size = n * s;
+
+	if (size < 1024) {
+		char buf[size]; /* gcc-ism */
+
+		/* The temporary array is small, so put it on
+		   the stack.  */
+		msort_with_tmp(b, n, s, cmp, buf);
+	} else {
+		/* It's somewhat large, so malloc it.  */
+		char *tmp = malloc(size);
+		msort_with_tmp(b, n, s, cmp, tmp);
+		free(tmp);
+	}
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index 4df90cb..e848a73 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -426,4 +426,10 @@ static inline int strtol_i(char const *s, int base, int *result)
 	return 0;
 }
 
+#ifdef NEEDS_QUICK_QSORT
+void git_qsort(void *base, size_t nmemb, size_t size,
+	       int(*compar)(const void *, const void *));
+#define qsort git_qsort
+#endif
+
 #endif
-- 
1.5.4.rc3
