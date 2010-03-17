From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/16] tests: document format of conflicts from checkout -m
Date: Wed, 17 Mar 2010 07:09:39 -0500
Message-ID: <20100317120939.GH25641@progeny.tock>
References: <20100317113655.GA25470@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 13:09:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nrs3r-0008JW-TZ
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 13:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664Ab0CQMJP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 08:09:15 -0400
Received: from mail-pz0-f200.google.com ([209.85.222.200]:53754 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754644Ab0CQMJO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 08:09:14 -0400
Received: by pzk38 with SMTP id 38so682352pzk.33
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 05:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=2eCMeBDUIqIXIkX+zz+EyIY3sVK92nfK6nPXXDNMhUU=;
        b=ZDyJzRdUu4FDGgsRLzai7libH5nGcu4nq2MQ9CzEXCwBtVQj1Zdv+UZNuPROOLVMj4
         lzxuZHRYxVG2b+97BaYehUrfE7KJcvWKpgEOTUfYW97HWuTIpW36UbHS4wFiCjBL3+UG
         /PVSPqEbE8EVfeZhWGdnf2WWzMkv0O3HJuHH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=XyQDslG03Xi7N5KjuMDK59ruZJqGROgx1kCteANuVShJBWaPluvmxAp9kl+gsqGomU
         UmqRzV3ni376K+IXd8K5uDvXaLKkYVvz6aRbxkEohAEOYLmb3eBjxRR0oR+Dftx6Yv85
         S6pYal3SJZ/5M/uQe5p14ra4KlbJr4iMFt24c=
Received: by 10.140.83.22 with SMTP id g22mr573861rvb.49.1268827754421;
        Wed, 17 Mar 2010 05:09:14 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm6328036iwn.3.2010.03.17.05.09.13
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 05:09:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100317113655.GA25470@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142383>

We are about to change the format of the conflict hunks that =E2=80=98c=
heckout
--merge=E2=80=99 writes.  Add tests checking the current behavior first=
=2E

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Unchanged.

 t/t7201-co.sh |   65 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++---
 1 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 981ae8f..f3f0c4c 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -11,10 +11,12 @@ Test switching across them.
   ! [master] Initial A one, A two
    * [renamer] Renamer R one->uno, M two
     ! [side] Side M one, D two, A three
-  ---
-    + [side] Side M one, D two, A three
-   *  [renamer] Renamer R one->uno, M two
-  +*+ [master] Initial A one, A two
+     ! [simple] Simple D one, M two
+  ----
+     + [simple] Simple D one, M two
+    +  [side] Side M one, D two, A three
+   *   [renamer] Renamer R one->uno, M two
+  +*++ [master] Initial A one, A two
=20
 '
=20
@@ -52,6 +54,11 @@ test_expect_success setup '
 	git update-index --add --remove one two three &&
 	git commit -m "Side M one, D two, A three" &&
=20
+	git checkout -b simple master &&
+	rm -f one &&
+	fill a c e > two &&
+	git commit -a -m "Simple D one, M two" &&
+
 	git checkout master
 '
=20
@@ -166,6 +173,56 @@ test_expect_success 'checkout -m with merge confli=
ct' '
 	! test -s current
 '
=20
+test_expect_success 'format of merge conflict from checkout -m' '
+
+	git checkout -f master && git clean -f &&
+
+	fill b d > two &&
+	git checkout -m simple &&
+
+	git ls-files >current &&
+	fill same two two two >expect &&
+	test_cmp current expect &&
+
+	cat <<-EOF >expect &&
+	<<<<<<< simple
+	a
+	c
+	e
+	=3D=3D=3D=3D=3D=3D=3D
+	b
+	d
+	>>>>>>> local
+	EOF
+	test_cmp two expect
+'
+
+test_expect_success 'checkout --merge --conflict=3Ddiff3 <branch>' '
+
+	git checkout -f master && git reset --hard && git clean -f &&
+
+	fill b d > two &&
+	git checkout --merge --conflict=3Ddiff3 simple &&
+
+	cat <<-EOF >expect &&
+	<<<<<<< simple
+	a
+	c
+	e
+	|||||||
+	a
+	b
+	c
+	d
+	e
+	=3D=3D=3D=3D=3D=3D=3D
+	b
+	d
+	>>>>>>> local
+	EOF
+	test_cmp two expect
+'
+
 test_expect_success 'checkout to detach HEAD (with advice declined)' '
=20
 	git config advice.detachedHead false &&
--=20
1.7.0
