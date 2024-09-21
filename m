Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D660B61FCF
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726931406; cv=none; b=Zk/jcwyX2dkdCR/G5XBovwLrhrgPALBXb4qCMeSMRKIUyOV8IH+lPBKVwSvMuu8c/UgkgslmS5KwsR0Nkg3PSW3MDcX3sqyZLJ3HjCd8h4OkQTdP/a7rOeV9sFPpTsVMpwnGPknrYjUwdhMlygLdfgGoWN2slHRA8nlnvXb612A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726931406; c=relaxed/simple;
	bh=s55ZKqIZe1uJ9hh6vGWkERenYGzgdxwgoVrH66WxIY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jXu8LNNAbwitCFq32jOJsqWZW9JbMQaGA/a6Lh5o/3kbKwDtVMqStELc+RoftVp6GqEqgxcpstEBuswLmEDhaMiTsu0bdXUxhe3fMQzpeQ6iwwHqM1rOLnQark3KOcD5vl074OChiYyxWDI0vTVAQ17IHIHI9jt1EjOkxAISTMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=u1ckisoe; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="u1ckisoe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726931395; x=1727536195; i=l.s.r@web.de;
	bh=SuQ0KeZ/2FESaR+lT0BLtI5NGONjxF6AGKf6jgIvuuY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=u1ckisoepfarM1x00GchX8e50CMwB5y16K8607taCX7c0m1E8qsmGer5Ed9V9KYC
	 roY0ELLpVCKCXY7wmIeSacpQTR90Hg0eRFkm+yLfYmE/qXO6Xb49pEuJrmlMJTjQE
	 s/BODiUklq2SfGlwAWum8ES++ZVQ6Vsc/ftCdOYm1w4N+5S85biYQE4XBUcnMZbFZ
	 FK/dUWvUhPziQpdOy4yqlsnjdg6pNH4JvoRkxmZApRuEBLBJF2aggFdFUZvPVY7yg
	 0cRCpYCh5DWGPeDsMNBmP+ly/3eCXDwy2XAi+G1rcC+/eHkaFw7Hx/Mps2NU2TTAh
	 k90fX9/RMDMFtixG+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.18.174]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mc1ZN-1sF89s0A1f-00bgta; Sat, 21
 Sep 2024 17:09:55 +0200
Message-ID: <500a8e0a-9fbd-4b7b-b2f2-026a4293bc9f@web.de>
Date: Sat, 21 Sep 2024 17:09:54 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] diff: report modified binary files as changes in
 builtin_diff()
To: Kohei Shibata <shiba200712@gmail.com>, git@vger.kernel.org
References: <CACpkL8WsNqhQ7SP27-XQwp1bzKjyUT6m2idFarZ2Z5rLVYg4pQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CACpkL8WsNqhQ7SP27-XQwp1bzKjyUT6m2idFarZ2Z5rLVYg4pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cF9p5FSFFLYWyPwyFAMLDk0Ulgrwi+zji7QN70NelZ/y6i2Hqqy
 sWrjau8PImiiJlNpi6cNt5cp61FRSxBtVhpWDviaJhtXh8WMb6bHxWiK8DMSdmZYBTdz6va
 oQCAhxeTeQVYeTP9LvMXfs4KqMS/DjMmB3QQstDrv9/Xk1clCsyDWyGfXLvEtKaf+nQLtsk
 ojmewO9IqvBMtyDKya86A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:51zQBWweLec=;EPZMw5ebzKsirduI+IoB0afDUqx
 0to9NpWCJeNXjj99z6j7ng2rRQrBkF/iGooAgQsV+RnHFLFhoOqbCeQlOwoiN0NzCx5gm/5ua
 YMzdBEnj++c30iVlbtwpa/qI2/YD/7NkU9BaAhq8OUnLnK98CLZYf/5QRUq8cFtuu6d3OpYlp
 CjetJMkGH4kOM/D9Htuvhc1RSxd5LLXeNjk0j3q2gDeFVol5X2JXYF40wPvNzk+W74Y3jUdI5
 Gf13my4nh/8u+sdw/M6o6lspoAt5vNcaHtwbUrf42GUjWkTittpksTo77IhjUGE6v40/1DzpU
 pnJCem5vvEDaayMzdgus9Gr8QatVfgP7wXLZyYzckEGrrqPdKB4pOApJC0ZbmdiKhjGROcp/t
 HZLdRwa8CCeyJwXwvgM5Abzo0k5rk8xxYDKg0j7+AUIMeDkQ2vM3k3qqRdYKNlkZc1CaMNAD7
 DsZlqmHAHkt2YdN55t52qMueYixB++fHanbSfaLCJF7EozB8xAhN3EPL3Xe9X7ftVt+p3ArWk
 2eEtXS4F8EK4AuxC3ZA+WWCyGo9b1oETrxhUw32Adyk4/TdGuxkEykR98DC5NQyH8/Y4PqpN9
 9ZsLUTyMojBv0qGCm5AdtNESfMDfrgeTvonNar4RxciYpCXMDUvoddT4hQDPBYFClPZdQCaw6
 cTD++VqdqG181IPZhHow9Xvu3Mwws3dazZA56ZJ4BssKujdUQr0XUjracxIMsx6/CZyZgLq8R
 sqwo7GGqmMkIcI+uPZaMFpV7ybq4qEhyEmAVtsbbtLx2LLLEixunOFHQkyl2cxhdp2Nh0Gjov
 dc98HJH4lqnRCYo9Bbf/5M0w==

The diff machinery has two ways to detect changes to set the exit code:
Just comparing hashes and comparing blob contents.  The latter is needed
if certain changes have to be ignored, e.g. with --ignore-space-change
or --ignore-matching-lines.  It's enabled by the diff_options flag
diff_from_contents.

The code for handling binary files added by 1aaf69e669 (diff: shortcut
for diff'ing two binary SHA-1 objects, 2014-08-16) always uses a quick
hash-only comparison, even if the slow way is taken.  We need it to
report a hash difference as a change for the purpose of setting the
exit code, though, but it never did.  Fix that.

d7b97b7185 (diff: let external diffs report that changes are
uninteresting, 2024-06-09) set diff_from_contents if external diff
programs are allowed.  This is the default e.g. for git diff, and so
that change exposed the inconsistency much more widely.

Reported-by: Kohei Shibata <shiba200712@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Thank you for the report!

 diff.c                 | 1 +
 t/t4017-diff-retval.sh | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/diff.c b/diff.c
index 3be927b073..84a6bb0868 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -3675,6 +3675,7 @@ static void builtin_diff(const char *name_a,
 			emit_diff_symbol(o, DIFF_SYMBOL_BINARY_FILES,
 					 sb.buf, sb.len, 0);
 			strbuf_release(&sb);
+			o->found_changes =3D 1;
 			goto free_ab_and_return;
 		}
 		if (fill_mmfile(o->repo, &mf1, one) < 0 ||
diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
index d644310e22..1cea73ef5a 100755
=2D-- a/t/t4017-diff-retval.sh
+++ b/t/t4017-diff-retval.sh
@@ -145,6 +145,14 @@ test_expect_success 'option errors are not confused b=
y --exit-code' '

 for option in --exit-code --quiet
 do
+	test_expect_success "git diff $option returns 1 for changed binary file"=
 "
+		test_when_finished 'rm -f .gitattributes' &&
+		git reset --hard &&
+		echo a binary >.gitattributes &&
+		echo 2 >>a &&
+		test_expect_code 1 git diff $option
+	"
+
 	test_expect_success "git diff $option returns 1 for copied file" "
 		git reset --hard &&
 		cp a copy &&
=2D-
2.46.0
