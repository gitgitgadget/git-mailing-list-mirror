From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/10] tests: document format of conflicts from checkout -m
Date: Mon, 15 Mar 2010 03:00:58 -0500
Message-ID: <20100315080058.GG8824@progeny.tock>
References: <20100305215253.364.63583.reportbug@localhost>
 <20100305221950.GB5083@progeny.tock>
 <20100315074748.GA28827@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 09:01:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr5EV-0001ha-Kf
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 09:01:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759749Ab0COIA5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 04:00:57 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36227 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759723Ab0COIA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 04:00:56 -0400
Received: by gyg8 with SMTP id 8so1360726gyg.19
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 01:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=scgl98Tnw7jkSLRiunkkdLlefwky4Czk6tFYb+qYqY8=;
        b=tJB1tunGIpsuNbt0+LksjEEL6yKp1lXS+kidHzhQ0Ff1nXwb95Rk6LJzduUDLX82YY
         GTPAKqwy009cb0fXRvA6qSadSA/YTrb22Pxr8BS0pC+bHWO2AvwNYixdNmWKU83mfA5f
         o6L2pNUOpSrJlSLLjYTZTcbh6aKLP672Gcx4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ohuQ10p03SsFOfhAMcnK41lxpjLZSRaco73teLpjG3vaucyenGbRd0I8q0Ii6yAlgx
         /n43ecjBbwI2gXeH9+1bRY0OCVGANHQ+KYA7YFmOw9W58B+FEBcyZiDIg9VZsXWqdYkF
         SpvjvRCdwf3o2m5ye6iREaBNhIA/v4LSBa4P4=
Received: by 10.101.131.27 with SMTP id i27mr863724ann.230.1268640055801;
        Mon, 15 Mar 2010 01:00:55 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm4042171iwn.8.2010.03.15.01.00.55
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Mar 2010 01:00:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100315074748.GA28827@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142182>

We are about to change the format of the conflict hunks that =E2=80=98c=
heckout
--merge=E2=80=99 writes.  Add tests checking the current behavior first=
=2E

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7201-co.sh |   65 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++---
 1 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index ebfa5ca..970a460 100755
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
