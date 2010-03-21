From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/14] tests: document format of conflicts from checkout -m
Date: Sat, 20 Mar 2010 19:27:17 -0500
Message-ID: <20100321002717.GB23681@progeny.tock>
References: <7vr5ne908y.fsf@alter.siamese.dyndns.org>
 <20100321002535.GA23681@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 01:26:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt8zo-0005Og-OZ
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 01:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921Ab0CUA0U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 20:26:20 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:57656 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906Ab0CUA0T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 20:26:19 -0400
Received: by ywh2 with SMTP id 2so1213907ywh.33
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 17:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=j+c7+5RkxPHvXVOsLa+o4/kLYD7TzWQM27BJOt4iWQc=;
        b=tQb4eyzRJo0ee8IoYRmpOC3QRAPZyDO2dM8jbHXpF/ScZUuHDNQZQoFJLV06BBHeAs
         3uq6DGa9uSgBC2vyb1sPqb1M/RxTeJf2avjPsN7ZCRD9zSDqjF9+R7jsAHRaYFUrNM0J
         0wsjn+ybz1/qEnOpQSaRyYkq5cDnqNQz2o0fc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Hyd7do9M/o4YugCXSSS6zQFSv31durMfp48BelRPZTz1v4yEgZVKTmL0HfepSjoyaS
         jD2ntnqwB+OSCQN5ofqPbAC8oojQy6sfkGIsbBAKFa4D4d/jPfrBU1CJHuC/IOBfmeXb
         mBoFIc76eolWe6teymXAbzEoT6VKCcaOJK4H4=
Received: by 10.101.176.6 with SMTP id d6mr1912606anp.155.1269131178160;
        Sat, 20 Mar 2010 17:26:18 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm2741513iwn.6.2010.03.20.17.26.17
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 17:26:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100321002535.GA23681@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142769>

We are about to change the format of the conflict hunks that =E2=80=98c=
heckout
--merge=E2=80=99 writes.  Add tests checking the current behavior first=
=2E

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Unchanged from
<http://thread.gmane.org/gmane.comp.version-control.git/142374/focus=3D=
142383>.

 t/t7201-co.sh |   65 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++---
 1 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index d20ed61..01175f7 100755
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
1.7.0.2
