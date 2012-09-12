From: Peter Jones <pjones@redhat.com>
Subject: Re: [PATCH] Handle "git show" output correctly.
Date: Wed, 12 Sep 2012 14:00:23 -0400
Organization: Red Hat, Inc.
Message-ID: <1347472823.12986.3.camel@eddie.install.bos.redhat.com>
References: <1347463571-16831-1-git-send-email-pjones@redhat.com>
	 <vpqpq5rz1ua.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-qiGqjCliycktW0JLd64I"
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 12 20:00:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBrEq-0006So-Ta
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 20:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758837Ab2ILSA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 14:00:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15109 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752763Ab2ILSA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 14:00:28 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q8CI0Qof006028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 12 Sep 2012 14:00:26 -0400
Received: from [10.3.112.24] (ovpn-112-24.phx2.redhat.com [10.3.112.24])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q8CI0NVd003564;
	Wed, 12 Sep 2012 14:00:24 -0400
In-Reply-To: <vpqpq5rz1ua.fsf@bauges.imag.fr>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205316>


--=-qiGqjCliycktW0JLd64I
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-09-12 at 17:40 +0200, Matthieu Moy wrote:
> 
> How does this react to multi-line subject, e.g
> 
> This should be the
> subject line.
> 
> And this is the body.
> 
> ?
> 
> git format-patch will merge the lines in a single Subject: header, and
> your version seems to take only the first line.
> 
> A test showing this would be welcome. 

An updated patch to fix this will be my next mail.  It's not as succinct
as it once was, but such is life.

The two attached commits to this message can be used as a test case.
Basically, do (in any repo)

git am 0001* 0002*
git show > foo.patch
git reset HEAD^ --hard
git am foo.patch
git show # check the output here
git format-patch -1
# check 0001-bar-bar-bar-this-is-a-very-very-long-line-I-am-tired.patch
# here.

It winds up merging the subject lines before the rest of git-am does - I
couldn't get it to work if I preserved the newline; for some reason I
always get a second newline and that's /more/ wrong.

-- 
  Peter

--=-qiGqjCliycktW0JLd64I
Content-Disposition: attachment;
	filename*0=0001-this-is-an-example-with-a-very-long-subject-line-whi.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-this-is-an-example-with-a-very-long-subject-line-whi.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From f7521f88731f9fc696dcd8e32de58cc9d98ed892 Mon Sep 17 00:00:00 2001
From: Peter Jones <pjones@redhat.com>
Date: Wed, 12 Sep 2012 13:17:11 -0400
Subject: [PATCH 1/2] this is an example with a very long subject line which
 is completely unreasonable and nevertheless a thing.

It also has other stuff here.
---
 foo | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 foo

diff --git a/foo b/foo
new file mode 100644
index 0000000..fa5ef85
--- /dev/null
+++ b/foo
@@ -0,0 +1 @@
+    za za za
-- 
1.7.11.4


--=-qiGqjCliycktW0JLd64I
Content-Disposition: attachment;
	filename*0=0002-bar-bar-bar-this-is-a-very-very-long-line-I-am-tired.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0002-bar-bar-bar-this-is-a-very-very-long-line-I-am-tired.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From bc471f2b89ada6e6ddf35b5ec2538242b5639836 Mon Sep 17 00:00:00 2001
From: Peter Jones <pjones@redhat.com>
Date: Wed, 12 Sep 2012 13:39:56 -0400
Subject: [PATCH 2/2] bar bar bar this is a very very long line I am tired of
 this game and it is quite annoying.

this is really annoying.  I hate perl.
    zonk.

yes.
    no.
---
 foo | 1 +
 1 file changed, 1 insertion(+)

diff --git a/foo b/foo
index fa5ef85..3b572f4 100644
--- a/foo
+++ b/foo
@@ -1 +1,2 @@
     za za za
+    bar bar bar
-- 
1.7.11.4


--=-qiGqjCliycktW0JLd64I--
