From: Brian Downing <bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org>
Subject: [PATCH v2] compat: Add simplified merge sort implementation
 from glibc
Date: Tue, 5 Feb 2008 15:10:44 -0600
Message-ID: <20080205211044.GP26392@lavos.net>
Reply-To: bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Edgar Toernig <froese-Mmb7MZpHnFY@public.gmane.org>, Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, Johannes Schindelin <johannes.schindelin-Mmb7MZpHnFY@public.gmane.org>
To: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Feb 05 22:11:26 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ag-out-0910.google.com ([72.14.246.189])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMV4Y-0007Vm-94
	for gcvm-msysgit@m.gmane.org; Tue, 05 Feb 2008 22:11:18 +0100
Received: by ag-out-0910.google.com with SMTP id 32so4154255agc.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 05 Feb 2008 13:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:x-ironport-av:received:x-ironport-anti-spam-filtered:x-ironport-anti-spam-result:x-ironport-av:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=ziDsqMCTTY+qvz7ivA99slfhRgYa4AJeXnWMowMY6iE=;
        b=xWY3rA2MT8a9kF8b0twpkve7u+B1y2pNEBQx9aui33+QsB2MBmwRthT81GvyMLFNhXeNTd+7ZiEC4D9sxviHHpxjaqv4Ej5tAXtG1WMmCH+NGGKMqYZbsg99RVzqMG8J0/FqwRyTKCS6kRBZtHFB4aA4u8Mt6sB8Qpctr6a0Tl0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-ironport-av:x-ironport-anti-spam-filtered:x-ironport-anti-spam-result:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=WIpTKu3aEWB0lManDVHjybX2bMbvhdZ3pVC7OU1+osF0mHBCzyNN3pltbm4OB1MhU1xPlWgibdBh1i/SSgShA8ocmReCZ2SW97wu1Sdvv4Tih27tGzXVmd80RtpQoY7PRGvNGgR8z8d0djKfW4BWzHdZlWnNg+7Xr8V40a7ttOE=
Received: by 10.142.216.9 with SMTP id o9mr126023wfg.10.1202245845677;
        Tue, 05 Feb 2008 13:10:45 -0800 (PST)
Received: by 10.106.159.13 with SMTP id h13gr1630pre;
	Tue, 05 Feb 2008 13:10:45 -0800 (PST)
X-Sender: bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.124.20 with SMTP id b20mr2140385pyn.5.1202245845428; Tue, 05 Feb 2008 13:10:45 -0800 (PST)
Received: from mxsf06.insightbb.com (mxsf06.insightbb.com [74.128.0.76]) by mx.google.com with ESMTP id x46si3032793pyg.3.2008.02.05.13.10.45; Tue, 05 Feb 2008 13:10:45 -0800 (PST)
Received-SPF: neutral (google.com: 74.128.0.76 is neither permitted nor denied by best guess record for domain of bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org) client-ip=74.128.0.76;
Authentication-Results: mx.google.com; spf=neutral (google.com: 74.128.0.76 is neither permitted nor denied by best guess record for domain of bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org) smtp.mail=bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org
X-IronPort-AV: E=Sophos;i="4.25,309,1199682000";  d="scan'208";a="221700595"
Received: from unknown (HELO asav02.insightbb.com) ([172.31.249.124]) by mxsf06.insightbb.com with ESMTP; 05 Feb 2008 16:10:46 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FALRfqEdKhvkY/2dsb2JhbACBWKwZgXY
X-IronPort-AV: E=Sophos;i="4.25,309,1199682000";  d="scan'208";a="199059172"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24]) by asav02.insightbb.com with ESMTP; 05 Feb 2008 16:10:44 -0500
Received: by mail.lavos.net (Postfix, from userid 1000) id 87D51309F21; Tue,  5 Feb 2008 15:10:44 -0600 (CST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72699>


qsort in Windows 2000 (and various other C libraries) is a Quicksort
with the usual O(n^2) worst case.  Unfortunately, sorting Git trees
seems to get very close to that worst case quite often:

    $ /git/gitbad runstatus
    # On branch master
    qsort, nmemb = 30842
    done, 237838087 comparisons.

This patch adds a simplified version of the merge sort that is glibc's
qsort(3).  As a merge sort, this needs a temporary array equal in size
to the array that is to be sorted, but has a worst-case performance of
O(n log n).

The complexity that was removed is:

* Doing direct stores for word-size and -aligned data.
* Falling back to quicksort if the allocation required to perform the
  merge sort would likely push the machine into swap.

Even with these simplifications, this seems to outperform the Windows
qsort(3) implementation, even in Windows XP (where it is "fixed" and
doesn't trigger O(n^2) complexity on trees).

[jes: moved into compat/qsort.c, as per Johannes Sixt's suggestion]
[bcd: removed gcc-ism, thanks to Edgar Toernig.  renamed make variable
      per Junio's comment.]

Signed-off-by: Brian Downing <bdowning-oU/tDdhfGLReoWH0uzbU5w@public.gmane.org>
Signed-off-by: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin-Mmb7MZpHnFY@public.gmane.org>
---
    Here it is again.  Sorry about the mail screwup.

    -bcd

 Makefile          |    9 ++++++++
 compat/qsort.c    |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h |    6 +++++
 3 files changed, 75 insertions(+), 0 deletions(-)
 create mode 100644 compat/qsort.c

diff --git a/Makefile b/Makefile
index 92341c4..a0e5c0c 100644
--- a/Makefile
+++ b/Makefile
@@ -137,6 +137,11 @@ all::
 # Define THREADED_DELTA_SEARCH if you have pthreads and wish to exploit
 # parallel delta searching when packing objects.
 #
+# Define INTERNAL_QSORT to use Git's implementation of qsort(), which
+# is a simplified version of the merge sort used in glibc. This is
+# recommended if Git triggers O(n^2) complexity in your
+# implementation's qsort().
+#
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -722,6 +727,10 @@ ifdef NO_MEMMEM
 	COMPAT_CFLAGS += -DNO_MEMMEM
 	COMPAT_OBJS += compat/memmem.o
 endif
+ifdef INTERNAL_QSORT
+	COMPAT_CFLAGS += -DINTERNAL_QSORT
+	COMPAT_OBJS += compat/qsort.o
+endif
 
 ifdef THREADED_DELTA_SEARCH
 	BASIC_CFLAGS += -DTHREADED_DELTA_SEARCH
diff --git a/compat/qsort.c b/compat/qsort.c
new file mode 100644
index 0000000..8663889
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
+		char buf[1024];
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
index 4df90cb..0514604 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -426,4 +426,10 @@ static inline int strtol_i(char const *s, int base, int *result)
 	return 0;
 }
 
+#ifdef INTERNAL_QSORT
+void git_qsort(void *base, size_t nmemb, size_t size,
+	       int(*compar)(const void *, const void *));
+#define qsort git_qsort
+#endif
+
 #endif
-- 
1.5.4.rc3
