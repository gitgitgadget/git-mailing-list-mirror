From: Zheng Liu <gnehzuil.liu@gmail.com>
Subject: [GUILT] add FreeBSD support
Date: Fri,  9 Aug 2013 20:32:28 +0800
Message-ID: <1376051548-3126-1-git-send-email-wenqing.lz@taobao.com>
Cc: git@vger.kernel.org, Zheng Liu <gnehzuil.liu@gmail.com>
To: jeffpc@josefsipek.net
X-From: git-owner@vger.kernel.org Fri Aug 09 14:32:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7lrf-0002mU-J1
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 14:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755818Ab3HIMcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 08:32:15 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:45183 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787Ab3HIMcP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 08:32:15 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so493777pdj.16
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 05:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8DlMIpUT73B3j1iBDttKTFRh2As5q0rRZLc+e2OfD9Y=;
        b=vyt5K4CkcREKQJODOu9LEKmFhHWKRglVIQzi3lBYztFFCU9SJWJ3bFFlTto+RrluG5
         qwQ5QxVqf9nRY0VdyuNTt18rvAnlJjG+nL8MQioE7gbtXQAKLLGoTi/WkZFcrRDP9zNs
         /UhBjvQh2ZrUb35+xtckQ08bhJ65NtTdZ7snv0Hce09KynnQOiMq3OVXWfJ3UJd8marN
         xcCXJ9P/i1kzj3TOvYdB9vddfAvXe6ARUh2RGg0d3F0X3CBl0ff9UZgwxyejnrrlnv5p
         HZNqYSRoiOqzLHz0Wl2wY3+MOcWx6bkspDbGXlCsH85Fkxzv3cVQL6DpBQD4Hvppcnq9
         D7Ig==
X-Received: by 10.66.4.71 with SMTP id i7mr422335pai.82.1376051534466;
        Fri, 09 Aug 2013 05:32:14 -0700 (PDT)
Received: from lz-devel.taobao.ali.com ([182.92.247.2])
        by mx.google.com with ESMTPSA id z14sm19954292pbt.0.2013.08.09.05.32.12
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 05:32:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231974>

From: Zheng Liu <gnehzuil.liu@gmail.com>

Currently guilt doesn't support FreeBSD platform.  This commit tries to
add this support.  The file called 'os.FreeBSD' is copied from os.Darwin
due to these two platforms have almost the same command tools.

Signed-off-by: Zheng Liu <gnehzuil.liu@gmail.com>
---
Hi all,

After applied this patch, the regression test 010 and 060 will fail because
of the output format.  After fixing these issues, all the regression tests
will pass.

P.S. I don't subscribe git@ mailing list.  So please put my email address
in Cc list.  Thanks!

Regards,
						- Zheng

 os.FreeBSD | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 os.FreeBSD

diff --git a/os.FreeBSD b/os.FreeBSD
new file mode 100644
index 0000000..3f23121
--- /dev/null
+++ b/os.FreeBSD
@@ -0,0 +1,70 @@
+# usage: touch_date <unix ts> <file>
+touch_date()
+{
+	touch -t `date -r $1 +%Y%m%d%H%M.%S` "$2"
+}
+
+# usage: last_modified <file>
+last_modified()
+{
+	stat -f "%m" "$1"
+}
+
+# usage: format_last_modified <file>
+format_last_modified()
+{
+	stat -f "%Sm" -t "%Y-%m-%d %H:%M:%S %z" "$1"
+}
+
+# usage: head_n [count]
+head_n()
+{
+	if [ "$1" -gt 0 ]; then
+		head -n "$1"
+	fi
+}
+
+# usage: sha1 [file]
+sha1()
+{
+	if [ $# = 1 ]
+	then
+		openssl dgst -sha1 "$1" | sed "s,SHA1.\(.*\).= \(.*\),\2  \1,"
+	else
+		openssl dgst -sha1 | sed 's,\(.*= \)*\(.*\),\2  -,'
+	fi
+}
+
+# usage: cp_a <src> <dst>
+cp_a()
+{
+	cp -pR "$1" "$2"
+}
+
+# usage: _tac
+_tac()
+{
+	sed -e '1!G;h;$!d'
+}
+
+_seq()
+{
+	(
+		if [ $# -eq 1 ]
+		then
+			/usr/bin/jot $1
+		elif [ $# -eq 2 ]
+		then
+			n1=$((${2} - ${1} + 1))
+			n2=$1
+			/usr/bin/jot $n1 $n2
+		elif [ $# -eq 3 ]
+		then
+			num1=$1
+			incr=$2
+			num2=$3
+			/usr/bin/awk -v n1=$num1 -v n2=$num2 -v add=$incr 'BEGIN{ for(i=n1; i<=n2; i+=add) print i;}' | /usr/bin/sed -E '/e/s/^.+e.+$/0/'
+		fi
+	)
+	return 0
+}
-- 
1.8.3.4
