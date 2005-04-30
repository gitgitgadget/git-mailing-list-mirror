From: Andy Lutomirski <luto@myrealbox.com>
Subject: [PATCH] cg-add only checks if the first file exists
Date: Sat, 30 Apr 2005 09:39:02 -0700
Message-ID: <4273B4A6.10103@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 18:33:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRuuC-0008LO-1w
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 18:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVD3QjK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 12:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVD3QjK
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 12:39:10 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:9923 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261280AbVD3QjF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2005 12:39:05 -0400
Received: from [10.0.0.2] (luto.Stanford.EDU [128.12.71.50])
	(authenticated bits=0)
	by smtp-roam.Stanford.EDU (8.12.11/8.12.11) with ESMTP id j3UGd2g4020457
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 30 Apr 2005 09:39:02 -0700
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[apologies for possible dupe -- my mailer freaked out]

Doing:
cg-add foo bar
fails if foo doesn't exist but doesn't check for bar.  It also gives 
misleading reports to stdout.

I've fixed it at rsync://www.luto.us/cogito.git

Patch attached below as well.

--
Changed cg-add to check each added file for existence.

---
commit 9eb8efee632b6270a436d8088315856712bb5b32
tree cba76f974b1840640ccfa14b0118e1dc4a704876
parent 49612c471eebd26efe926a71752e254c1cdc382d
author Andy Lutomirski <luto@myrealbox.com> 1114878247 -0700
committer Andy Lutomirski <luto@myrealbox.com> 1114878247 -0700

Index: cg-add
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/cg-add  (mode:100755 
sha1:83f0b13f41599104d741ac91c7aa81497cd37d5f)
+++ cba76f974b1840640ccfa14b0118e1dc4a704876/cg-add  (mode:100755 
sha1:c84792450cec279f7b3eb1dec03b69ac07dbe9d9)
@@ -10,10 +10,12 @@

  [ "$1" ] || die "usage: cg-add FILE..."

-if [ -f "$1" ]; then
-       echo "Adding file $1"
-else
-       die "$1 does not exist"
-fi
+for i in "$@"; do
+       if [ -f "$i" ]; then
+              echo "Adding file $i"
+       else
+              die "$i does not exist"
+       fi
+done

  update-cache --add -- "$@"
