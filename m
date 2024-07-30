Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5FC19E7E4
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722349139; cv=none; b=um9NkjfIfU6SNNxaSPx6muZqE1okq5mc21uRaTeQWhPRxE16nOf9XDpix8hS+e3AfAgY0sOvhw0XmA7grkzLnXjZTMmQ/PwROJ6K+P7YOJVBphhKVLBnIHY3AK+YqmnP9mCvKFuXHsh81Yemvh9f13Y7WetZ8NGNP7YxtXQq1Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722349139; c=relaxed/simple;
	bh=SbGxTuBPKGJQdCHiNjkA7LdfmpeXgRamp86wfIq7Un8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=D0wQ/MoNiI/FzTbCvbUu6/84R6KgZNzpDXhI1ndq+zSRuGUe1In+mQbe8p2KWQJudsbmLzC314ZhDEBWaFwDvFmdpyEjdlPOGvaJvnfOORkrrWEx1Aj8ANBaA6AUcgWU6JQjxs6PvMJMc11GmNLhGGQDvFX4a+MiK98Y3OUEHog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=WPCeJQbs; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="WPCeJQbs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722349134; x=1722953934; i=l.s.r@web.de;
	bh=AavDgItis9PZSyS3k4yxUBbJntMJGVSvgSJUvKYBG2o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WPCeJQbslGwrVkh5sjMvyoav32ycID0jFROLGKquGIS0bfioW/kgdzsO8aaDOn6A
	 4sjgYCbYuk+IEwkt9ueNFOmLfTmTUoA/eSxQa4h079xuCEx+A0wHLr5/V0khf2MNn
	 J2zz3lnzHfeS0EjsQguNwuhzw9mehfBFMPODVQMxmI+ObBK5lvv11CAlaUG47+NL5
	 Jyvaq8S8fwYT6liUAXzJhEw5wQA3bGwizc2wcpUQQPgYR2fsArGbTfFX3ZJCXA5uz
	 +vypvsW/OSN0TcfZu4SdQEMaod3II73Hmu9YFKGCgtbRyhBDFel4rDv+tkmbTm51L
	 R2zW5zHzzk8Zumwhmw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8T7K-1sdBPS3O3E-0046sy for
 <git@vger.kernel.org>; Tue, 30 Jul 2024 16:18:54 +0200
Message-ID: <8b90e0ec-251f-46b3-8777-96efd58e227b@web.de>
Date: Tue, 30 Jul 2024 16:18:54 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] grep: -W: skip trailing empty lines at EOF, too
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NIUUgymnWmgO+xJ0hkLx41nIbsxseD+14snKhp8rVx3Av3ZWxs3
 ajzpSz7dDtKjqs6T8U/cA1wn+OdlejqLFwJsFV82sfx4fKN6X2fND5DWkq1I9UPnzAcuQP8
 417zwOqdrjYxZhnqrSR2K/hDBwr8SHu9LlfuiFZS01361Cwd/UXXyUBKlc8rSP/1GagRvdp
 YDGYSqyUwmo1O4TFI8zKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Cs0qTI8yfwI=;7F5M7on9vRbfgCrCMIFcIkiz308
 HGOx1w1WznaN3hNEx18aerpUwf/3UvUvIGih8AHlmWHW0NifgMt6UH22IO59yMoAlSbypP41Z
 rLxQneAFi790A3vbJj7/x0RcH94BnKiulIMKm02oxWGzwy1gwumhnbQ5MekzuNz1hBcojqq1K
 Ih13Oz5D9r3N+QzfulW+sZJWjqGv6I6VvJgfcRMt1+Qjh0GmKJAup/9vNp98RC8pAx01P2goc
 E+jduwiVUEzurWGRAXX1c+OeD1LgJUnI/mGBX2VDgRNupEfihg6auLzXq/OKYK2sjEDjseWCO
 0SawS3dX42PtSyq1SldpBRmqwx76nQ9noxAYrZwtn58FVtHIpJjxXSlZNHYi6hm8CPOHx65bT
 VLbaB6uhu5vpCvI8GO4mJ7vlYrV3d9CnjYPTy+YFKYi+M/MdpjW8n76LGGeWeg0eGyM5CRZ01
 pcjz23uYsi39HpdjPrJrEU9mnJa+T2OH8kKWldlf8KZ7EVrZtSlebee+1IUr8W5SZRznavMKU
 ei7df0W7nYHiMo67sWuTm47/dgj9LFUSMFmINvRom6KLXZzAo7tWf0Qo7w7zXup+h3l/tYSHA
 ikhlZviDJg4RCfYGvzLhav+c1io9w8kFwSKUnFufX3QA0b8QviD8myn1X/o0Xg6R5jzldVIdQ
 EJ9Y8+fSQdGPczSofpP99Rd5Wgh8PpmLiM0tQrR+l898nfDOrDgsjjm37uDt8UrApGpzBKiqj
 1g6jfBITi1T54vFLJI9f4oT9/vlsuyuPVhguzljmbLGOeLbJgA3PNFw8epMEc29NzjwYx9TLP
 8H+a+1UerPp8XufpCkaT5qEg==

4aa2c4753d (grep: -W: don't extend context to trailing empty lines,
2016-05-28) stopped showing empty lines at the end of function context
when using -W.  Do the same for trailing empty lines at the end of
files, for consistency -- it doesn't matter whether a function section
is ended by the next function or the end of the file.

Test it by adding a trailing empty line to the file used by the test
"grep -W" and leave its expected output the same.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 grep.c          | 3 ++-
 t/t7810-grep.sh | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index ac34bfeafb..2f8b9553df 100644
=2D-- a/grep.c
+++ b/grep.c
@@ -1735,7 +1735,8 @@ static int grep_source_1(struct grep_opt *opt, struc=
t grep_source *gs, int colle
 				peek_eol =3D end_of_line(peek_bol, &peek_left);
 			}

-			if (match_funcname(opt, gs, peek_bol, peek_eol))
+			if (peek_bol >=3D gs->buf + gs->size ||
+			    match_funcname(opt, gs, peek_bol, peek_eol))
 				show_function =3D 0;
 		}
 		if (show_function ||
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 875dcfd98f..af2cf2f78a 100755
=2D-- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -31,6 +31,7 @@ int main(int argc, const char **argv)
 	return 0;
 	/* char ?? */
 }
+
 EOF

 test_expect_success setup '
=2D-
2.46.0
