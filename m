From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 1/5 v2] t7607: use test-lib functions and check MERGE_HEAD
Date: Sun, 10 Oct 2010 10:35:43 +0200
Message-ID: <20101010083543.GA12186@localhost>
References: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
 <1286632380-7002-2-git-send-email-drizzd@aon.at>
 <20101010063527.GC23100@burratino>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 10:36:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4rOW-0006Zo-EX
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 10:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011Ab0JJIfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 04:35:39 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47821 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab0JJIfi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 04:35:38 -0400
Received: by bwz15 with SMTP id 15so1120826bwz.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 01:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=tTnoWbfFj3Ded3sALTlvYadYDgvrr6YC8ej7k+urpjs=;
        b=DQ0wsdN0CnxC3VqP/GUVPCk0kLaaJS0Ks439M9Ht4qOBqiAl1zW+Yz6snIMqdsuVoH
         aDTylyoVg+/8nozVcM2WLHC9c9850o5NWQRv4J/2zd1AdVQLNIyIXayC7peKFyp9inrv
         tPlHqeuD7dnLzr7HlWSV3XadYb2vRmWlduack=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=EhXlY0WFRzGYBnidKhlHar4d83BVZhHBKzn+Xm/qKzsZHDEeEaPVos2Za/vWmUo+F3
         G6p1nP3b6z7bfbhTJMQ3luDok0TIKXM8m7up38HfZhf6Fhr1ozPQzuDBoJKebOf8nEAl
         +xTqYoP0NkIKpIKLSwKDNzv6SW6qTIkSaS71E=
Received: by 10.204.115.3 with SMTP id g3mr4009748bkq.141.1286699735032;
        Sun, 10 Oct 2010 01:35:35 -0700 (PDT)
Received: from darc.lan (p549A35A6.dip.t-dialin.net [84.154.53.166])
        by mx.google.com with ESMTPS id q19sm1368658bkb.4.2010.10.10.01.35.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 01:35:34 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1P4rNf-0003Tp-MB; Sun, 10 Oct 2010 10:35:43 +0200
Content-Disposition: inline
In-Reply-To: <20101010063527.GC23100@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158651>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Use the test_commit and test_path_is_missing
functions from the test library.

Also make sure that a merge which fails due to
pre-merge checks aborts properly and does not
leave MERGE_HEAD behind.

The "will not overwrite removed file" test is an
exception to this. It notices the untracked file
at a stage where the merge is already well under
way. Therefore we cannot abort the merge without
major restructuring. See the following thread for
more details.

http://mid.gmane.org/7vskopwxej.fsf@gitster.siamese.dyndns.org

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Sun, Oct 10, 2010 at 01:35:27AM -0500, Jonathan Nieder wrote:
>=20
> The main change (checking that MERGE_HEAD is not present
> for a merge that fails due to pre-merge checks) seems good.

Thanks. This new version incorporates all of your suggestions.

Clemens

 t/t7607-merge-overwrite.sh |   38 +++++++++++++++-----------------------
 1 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index d82349a..b8fab54 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -7,48 +7,38 @@ Do not overwrite changes.'
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
-	echo c0 > c0.c &&
-	git add c0.c &&
-	git commit -m c0 &&
-	git tag c0 &&
-	echo c1 > c1.c &&
-	git add c1.c &&
-	git commit -m c1 &&
-	git tag c1 &&
+	test_commit c0 c0.c &&
+	test_commit c1 c1.c &&
+	test_commit c1a c1.c "c1 a" &&
 	git reset --hard c0 &&
-	echo c2 > c2.c &&
-	git add c2.c &&
-	git commit -m c2 &&
-	git tag c2 &&
-	git reset --hard c1 &&
-	echo "c1 a" > c1.c &&
-	git add c1.c &&
-	git commit -m "c1 a" &&
-	git tag c1a &&
+	test_commit c2 c2.c &&
 	echo "VERY IMPORTANT CHANGES" > important
 '
=20
 test_expect_success 'will not overwrite untracked file' '
 	git reset --hard c1 &&
-	cat important > c2.c &&
+	cp important c2.c &&
 	test_must_fail git merge c2 &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test_cmp important c2.c
 '
=20
 test_expect_success 'will not overwrite new file' '
 	git reset --hard c1 &&
-	cat important > c2.c &&
+	cp important c2.c &&
 	git add c2.c &&
 	test_must_fail git merge c2 &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test_cmp important c2.c
 '
=20
 test_expect_success 'will not overwrite staged changes' '
 	git reset --hard c1 &&
-	cat important > c2.c &&
+	cp important c2.c &&
 	git add c2.c &&
 	rm c2.c &&
 	test_must_fail git merge c2 &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	git checkout c2.c &&
 	test_cmp important c2.c
 '
@@ -57,7 +47,7 @@ test_expect_success 'will not overwrite removed file' '
 	git reset --hard c1 &&
 	git rm c1.c &&
 	git commit -m "rm c1.c" &&
-	cat important > c1.c &&
+	cp important c1.c &&
 	test_must_fail git merge c1a &&
 	test_cmp important c1.c
 '
@@ -66,9 +56,10 @@ test_expect_success 'will not overwrite re-added file' '
 	git reset --hard c1 &&
 	git rm c1.c &&
 	git commit -m "rm c1.c" &&
-	cat important > c1.c &&
+	cp important c1.c &&
 	git add c1.c &&
 	test_must_fail git merge c1a &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test_cmp important c1.c
 '
=20
@@ -76,10 +67,11 @@ test_expect_success 'will not overwrite removed file wi=
th staged changes' '
 	git reset --hard c1 &&
 	git rm c1.c &&
 	git commit -m "rm c1.c" &&
-	cat important > c1.c &&
+	cp important c1.c &&
 	git add c1.c &&
 	rm c1.c &&
 	test_must_fail git merge c1a &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	git checkout c1.c &&
 	test_cmp important c1.c
 '
--=20
1.7.1.571.gba4d01


--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMsXrfAAoJELKdZexG8uqM/BwH/Ai2w+DFW4L9D1SivLoxDL8/
Z3YDRrx5oJa35ZhbBwInGJx7xwXG3Pn/mx0avGwoRwQe9cRufp6AO5hHUq3U1LNv
ZaP4RdlScMqeuKUu8mrbjJs4kumL/sjZ59MRnBZzX1Ovdq/GbKhJqidYTvmHQc6e
0sngXx9Jf1WlS7m1sDztYPRJ3z2lF0js+BNHLIVOi6CgSbBJYdQzeLrvO/BVX9V0
P2F0bGZLWTqqOSLMav5jcYFAgIv8mRqxjre+1IviFuGTuu5hX7yTx++qAiV8CK0f
Fpe0HNQlYahbytd9qlOoqsbV5fuXkOoFqYHKmT6461u31QHaYPyBwsSWgjkF9IE=
=3pEL
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
