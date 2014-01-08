From: Ryan Biesemeyer <ryan@yaauie.com>
Subject: Re: [PATCH] merge: make merge state available to prepare-commit-msg hook
Date: Wed, 8 Jan 2014 19:02:57 +0000
Message-ID: <DA9E6645-82DC-4714-845F-423726F96A40@yaauie.com>
References: <6B177FFA-1797-45FE-9EF1-2C9E6EE8A234@yaauie.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_FF049652-538A-4EBA-8C5F-C1894FAB0FAB"; protocol="application/pgp-signature"; micalg=pgp-sha512
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
To: Ryan Biesemeyer <ryan@yaauie.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 20:03:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0yPE-0001Qn-PX
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 20:03:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbaAHTDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 14:03:04 -0500
Received: from mail-qa0-f41.google.com ([209.85.216.41]:56216 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbaAHTDD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 14:03:03 -0500
Received: by mail-qa0-f41.google.com with SMTP id w5so2146611qac.14
        for <git@vger.kernel.org>; Wed, 08 Jan 2014 11:03:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:message-id:references:to;
        bh=c7gGj24ZWO8lC7R9krEo2JbfLx0aVdttsfDbLHsV3II=;
        b=ZTC87LVPl1SDT9AL/OzQsvmRspGOmAE94bCRNUG9i9zSkpZ7snZZ2gap3Rhv4cUmI3
         d9e/QMgMRYMWMTCZz+Jnb0SCTY2mEQsusJeYef5nfr0LaVn0RbTQpfJ85vyVt5xdvNjw
         I2L5tdxDxmaBhSOuqDZMXBEVpJO/nnMItP1UDdtyJPIVUzsL9Cw5iDmU/pb2blND8QIs
         H6t0MhAuiMI6tkZsd8vRFKLLDZhAsMfYsv0ugjnod6xpJFPinT8+khmpxryV4JL5iXPl
         dCKMOQ8RX83f8u29kEIBy0/TdD/Zf9aEWmQ33XgV7Ss1WQyo63+LbgSGk3/dMcoXjjsl
         AkmA==
X-Gm-Message-State: ALoCoQlRtMl4OQVinXMsCiyCpTIkfSmwtPQMxiUss/Du3C1O81L2ET9nVjmCDNV/F6C5LYWroH57
X-Received: by 10.49.1.106 with SMTP id 10mr216297447qel.55.1389207781914;
        Wed, 08 Jan 2014 11:03:01 -0800 (PST)
Received: from [10.40.8.139] ([69.164.175.238])
        by mx.google.com with ESMTPSA id w7sm2347877qaj.23.2014.01.08.11.02.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 08 Jan 2014 11:03:00 -0800 (PST)
In-Reply-To: <6B177FFA-1797-45FE-9EF1-2C9E6EE8A234@yaauie.com>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240222>


--Apple-Mail=_FF049652-538A-4EBA-8C5F-C1894FAB0FAB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

=46rom 9b431e5206652cf62ebb09dad4607989976e7748 Mon Sep 17 00:00:00 2001
From: Ryan Biesemeyer <ryan@yaauie.com>
Date: Wed, 8 Jan 2014 00:46:41 +0000
Subject: [PATCH 1/2] merge: make prepare_to_commit responsible for
 write_merge_state

When merging, make the prepare-commit-msg hook have access to the merge
state in order to make decisions about the commit message it is =
preparing.

Since `abort_commit` is *only* called after `write_merge_state`, and a
successful commit *always* calls `drop_save` to clear the saved state, =
this
change effectively ensures that the merge state is also available to the
prepare-commit-msg hook and while the message is being edited.

Signed-off-by: Ryan Biesemeyer <ryan@yaauie.com>
---
 builtin/merge.c                    |  3 ++-
 t/t7505-prepare-commit-msg-hook.sh | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 4941a6c..b7bfc9c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -802,7 +802,6 @@ static void abort_commit(struct commit_list =
*remoteheads, const char *err_msg)
 		error("%s", err_msg);
 	fprintf(stderr,
 		_("Not committing merge; use 'git commit' to complete =
the merge.\n"));
-	write_merge_state(remoteheads);
 	exit(1);
 }
=20
@@ -816,6 +815,8 @@ N_("Please enter a commit message to explain why =
this merge is necessary,\n"
 static void prepare_to_commit(struct commit_list *remoteheads)
 {
 	struct strbuf msg =3D STRBUF_INIT;
+
+	write_merge_state(remoteheads);
 	strbuf_addbuf(&msg, &merge_msg);
 	strbuf_addch(&msg, '\n');
 	if (0 < option_edit)
diff --git a/t/t7505-prepare-commit-msg-hook.sh =
b/t/t7505-prepare-commit-msg-hook.sh
index 3573751..89cdfe8 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -181,5 +181,27 @@ test_expect_success 'with failing hook (merge)' '
 	test_must_fail git merge other
=20
 '
+git merge --abort # cleanup, since the merge failed.
+
+test_expect_success 'should have MERGE_HEAD (merge)' '
+
+	git checkout -B other HEAD@{1} &&
+	echo "more" >> file &&
+	git add file &&
+	rm -f "$HOOK" &&
+	git commit -m other &&
+	git checkout - &&
+	write_script "$HOOK" <<-EOF
+	if [ -s "$(git rev-parse --git-dir)/MERGE_HEAD" ]; then
+		exit 0
+	else
+		exit 1
+	fi
+	EOF
+	git merge other &&
+	test "`git log -1 --pretty=3Dformat:%s`" =3D "Merge branch =
'"'"'other'"'"'" &&
+	test ! -s "$(git rev-parse --git-dir)/MERGE_HEAD"
+
+# '
=20
 test_done
--=20
1.8.5


--Apple-Mail=_FF049652-538A-4EBA-8C5F-C1894FAB0FAB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJSzaDhAAoJENsKO4td9bkLUdsP/j75NVIAGC2SGCCiWk+OcrBi
rRx1PyfCILrddqiPWD0bPKfYAJeOerDpUsn+O+6ZSTZFGD7CiPhrb2wNmtgShh9Z
9p8yl0Ux1GkU3/6PmaG3xkmvzYwTbN3n4/wL8u8ZxyMaBfzFd5UEBGl0zJzUh4bB
grxBtCOU/ixbZaIX6E+IbjkRykLVO0v7qM5+GkoMYkfSmvnCeUMNlSbIHYzjVCy4
pC3yG82axf1aIH4kh8Bt45ZA/aPKgG+6J01EDNdm9wrw4Otr8Ud+eovrNA5CHbos
qD5u240MmfV844xr8iQdkKK5XFPrghkZPvewlydy+2JgxKk7d2RylRBph29kTss/
ZFqC8k4/wh6SZvrn02hjFNAluQu9keaLJt/vAm+nVJPPu1KFoYca6nIhgPO4IW6T
OZm85xUyfwGhA10kf48zG5Rsubdebk6UmsOWPwjLeHH0oLLM37kqqwVWtOqU33Zj
3u1SG9RVw2f8oKXvpQkP5nzDIySYn3/g3qmutg9JNZDtd1Ze0DxKBcr0Ec7f7tbs
CtYzLFnCcMBweOHzRTRIduB/Gg0pvnMP/TwlF8IOIAbGjYlxve9mO5W+wLkCV7W+
yd4PGPrzSskuR21l3d/CaGA9CAKuhS9vGYedjJSBmwZ28CHrAp1F7U7Q956VCuMs
FDWibKURV3q+rvRSHfQp
=54rl
-----END PGP SIGNATURE-----

--Apple-Mail=_FF049652-538A-4EBA-8C5F-C1894FAB0FAB--
