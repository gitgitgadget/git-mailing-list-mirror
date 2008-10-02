From: "Imre Deak" <imre.deak@gmail.com>
Subject: git apply: git diff header lacks filename information for git diff --no-index patch
Date: Thu, 2 Oct 2008 21:27:36 +0300
Message-ID: <500f3d130810021127j570bb540p901f6a73f58a6cb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 20:29:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlSuy-00019h-VB
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 20:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136AbYJBS1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 14:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753175AbYJBS1i
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 14:27:38 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:55663 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096AbYJBS1h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 14:27:37 -0400
Received: by yw-out-2324.google.com with SMTP id 9so202658ywe.1
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 11:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=nGUiLHTOlLO9JU3b2kOnfNvcAvW2XG5zfjnXTdfVj88=;
        b=HVkOr2RD6VsVEXKe1k7+fBwV5QXnJW77492DBUb5vrZ27D86WO8LSb6rRUxCmnVqR7
         pWluPRiFlyILNEHLyhBjXykxkhI8rwVjx/jTq22mMYCs0tEUk45/+eKpVPIGQ9142709
         sLDRuIJ0rGbY40n/PjE4SDCIM71GmB3y7AMQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=iTQ0MdVnKnzrm4s95F0Ze4tkFNQ9hT0nXjpx7bZ+jnDtUO5pTQ8ffxMaUQ5EiWUifZ
         QWnCsyqIuVhxwVLAVId3qbOgY1TovbKWFVlWpK+M3eL+HMSNEilnHN/JdMl+xTdB+80d
         VNn77W8Z5iX3R2TKx2Mq2mElb0kpiYXxhTLn4=
Received: by 10.151.40.3 with SMTP id s3mr160936ybj.240.1222972056071;
        Thu, 02 Oct 2008 11:27:36 -0700 (PDT)
Received: by 10.150.123.11 with HTTP; Thu, 2 Oct 2008 11:27:36 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97364>

Hi,

I have the following problem:

$ echo -e '\x0' > a
$ git diff --no-index --binary /dev/null a > patch
$ rm a
$ git apply patch
fatal: git diff header lacks filename information (line 4)
$ cat patch
diff --git a/dev/null b/a
new file mode 100644
index 0000000000000000000000000000000000000000..1f2a4f5ef3df7f7456d91c961da36fc58904f2f1
GIT binary patch
literal 2
JcmZSJ0ssIE01E&B

literal 0
HcmV?d00001

The same works for text based patches:

$ echo 1 > a
$ git diff --no-index /dev/null a > patch
$ rm a
$ git apply patch
$ ls
a
$ cat patch
diff --git a/dev/null b/a
new file mode 100644
index 0000000..d00491f
--- /dev/null
+++ b/a
@@ -0,0 +1 @@
+1

The binary patch lacks ---/+++ lines but still provides the name info
on the diff --git line which I think should suffice for git apply.

--Imre
