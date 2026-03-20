Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D05B13B7AE
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 00:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773967595; cv=none; b=ulwbTUXQ/o+awzMDCcpbAaKRwsirLgU6aqFAOxYyC1sULezLTqwNW7jziWlZuqMdWsdEPHl2CgBtM4Ro7TZzagtrGWVGpLLUmjz3nSSsNmZReb/PPoX7yOPXWow4pr3I/OYgpyjWDpHFhqVIOoe3/alcQf2oiZsQEn8I8fZwBnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773967595; c=relaxed/simple;
	bh=NgcbtYnb0GL/oyh0Zqd9GDN+xk4FDLwEIESU2SL8978=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=amnXZ7UJGVTSB82uOQNzCd20J0llqoPAClIK1sylus1SDF3HZbiN2bi8B+FXMUC3P5MH/duOTDWhJsRalzDjlgemcd08le5nVSMr5gNe6HxB1b5aQphBJlBSt8M9TwpVVUBc2VR/CcTJxxERjj9JroTHy/qj+rnmOSpSDqAF308=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=jsfW0p2x; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="jsfW0p2x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773967586; x=1774572386; i=l.s.r@web.de;
	bh=fYusfGYWmjKgjEVO9sjQXmnF0j9uW64N2xbfMzBcr38=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jsfW0p2xd9Pe5+hJofQ+E3vx5CdoxH0zk0UKWCCHAv2qVaR5XgsDhUMHx5go5BY8
	 MvSN7CitGMBTYW//vKoD0v+UvBSGEI2ypBjE7zCisIebFVV42F1Oh8vmjDV8D8NnB
	 ueD5LX5awe15NbcPOOY8mUnKCzGf9bA7dmxgGMqDGmvHStPvKKGQG3rBGd9gq1Dmb
	 PR1OzCbEqWZcUK5243Kd4gBYmZQvBl+k24n/YRJyJPZzStBP6HbUBFxDdA46lgHsI
	 vzMTXrudmVy0tHCOYhWrXgYbHrCZF694t/lAWKju+hY/jRvIN5yi4l/0dZjHc4sEd
	 Y5WG+qXatdeZoeRwag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVJNT-1wC1MD1TWx-00HjAf; Fri, 20
 Mar 2026 01:46:26 +0100
Message-ID: <084f3b43-91ac-4553-8305-03944e97eaa6@web.de>
Date: Fri, 20 Mar 2026 01:46:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] use strvec_pushv() to add another strvec
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
References: <ad46f86f-2ac0-4802-8e63-d854d594932d@web.de>
Content-Language: en-US
Cc: Junio C Hamano <gitster@pobox.com>
In-Reply-To: <ad46f86f-2ac0-4802-8e63-d854d594932d@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B9AhGTkurqSr3uiGaSsj1yTSdFqR+rLULNwrtJ6hw0nlFPPdyzD
 uH6JbfmpozemqN7QGGjkwpqnNwdXUKL2ZdYfJzPjmTykz8lF/FX6IxEFWTkXwIUQmYcV0gL
 Jj2RuxoD4kDfySYOhiktdL4wM3rApVOTBc6L9WwCinq/C2vxOzl1F8rn8UMAEC3WF/Wcs7Y
 lcSnClTrCSoyDSygAWmfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zTGSBf0lABg=;3PU2WvAoNosDPAMmUOAOtxM3bXc
 fEqV1C5QaLDdEbmnUWKPfc+/5t/WGwmZs/pDIb9XMtE32vbjSQopTtFTh3G51pW8Gg/xcPcPR
 GpJqxwDoU7HEK7ub6PgKV4qN6pIxLJ8Q7ByE4ufnT8JLFq8dhY6RBcP30sWhHt8pFc0rZpvQK
 ctciGm6XPHzXCunNe9hXNcg20iYO1plSSZf+ARLWSYLXKKIDk8VD+1mCTeA/6CTiACOQKDtlV
 Qk2U5GLZ2Sf+YfNklhGKpeMYpuu268g2R/zyhqBjCGERaZuz4IkfGH1lEGbD61GC3r8CE76Pl
 JZPb8/QEM3yOTZDdsaHdIgtGedyP15Jxk+4eIkN4tE3HcLLfju57sY+wHenLxaO7u6/wrox+F
 21iBOcg8n+0pKCTG1HV/bL5lF/z5jSp3cOwIGzBQf7LVcUTzHwHLtQ3E1DkblB7UQx1Zu/A7/
 g+9F0Tua2Fa4UGSLB5M3RJOdw0lEb0zwB9O6GhWKdb7y/wS0d6xyXJCFbMzdwOE+EwOwEWOaS
 JEeKa3uvzqK5nnb8VmFx3LWXwxTIZFXxzD4+tMdY2c3xp4uCClIcW4NiQYudQdC7BzbROalmT
 gY7KEXxGZuyU23pMgQsD6uOwG0tVtDz33vyKAXAypxnMZ6i6ArFnm+dJ+yzNMs8IsvPpEZ0nr
 im8cwHVTm5AYX/psllHeyEIbUEtJH9PdFkR65C1wKN9sVgmD72zN1PuQP4+LfaagXbvAdcncH
 7+C8NfK3cqJDOVYwymPBaMno/gat0+Brzan8Jew10DqQU3UtQoIz7EGBX9ocarKPO156UnVQU
 9M2xYFtUFdjPfhYv+RbYkZsb4fdSSO/YXHHr4CkgmpNv0B4tHM0EbvNuffQ0CYCi8vETVgiQv
 zaYlwT4vez/lprpkqwIXd3DC6ZKkvQ+GA+/LP0OrjGuL/ogHHPyMpBMGhp34cQRjTLqOG8r5G
 kPnSu7wQFssb5KgJfGGDDJr9WrnqeoYu1kI1PNOguMubmlZjZnXtCH3FSNnq9Nskop+8sLcQk
 xQ+ei4htvx5C3nvEGYzZlS0bRTp0HHde6rs8suFJEbvcgkbSWCWcKcqorteoCTKdsP5htSux+
 diUl541kPuiWMRwBHrjrEa0YIiwAPYNSxzpIbW30tNcs0HR7P8FBUH0hXW+XKIDuHqQlYvY6Q
 R2VYEBnpeua/5HK7UPA9il8sMZ3JKQf47BrW05Ly2IWMKd8WhNLal1MEaBLvB8tqTxWbT7J8d
 65lxtVpMFU07WAQ2MPpprlVcDhRs6TMjw+rwuhQJZV6Lsb+kKzKsEUBT8ZRPKKzQgTwu/iKZY
 MCL6Qmo7VIu3fJM9HXMI2HREEn5rxe9JQtJvlOxzR/CmKaJQ2sQAJLxE0CnDUu6uEu5SGktnH
 73f/SvlSOBP8Vb1c0iPAc3flQWOW3jQaWhOMp19DG1CbgWMNP+6j/NhXPN3bCiRGnAeyhiYAe
 qcDOuRpTnE34QhfImcoYwxyoQIi8UExxQr4QlpOsHrmj02vxZm/IDQkNhJ/GZBOlbQovXtnl8
 EQRnXXoyoYSrqMgWGTtOaAjDbyril6Vh4NB8sD7e5dO53iwrMqtHPsJLnhrfZv109MKjJAAFy
 p54Wrauw2ctJG7f3jMPakYVZ4r3+h9FOM2I9+VogtJJ7kxiHEx8cTtr48/nidsIlwS5oWZLQ3
 nQIUgoTCMMNKlw2nXcVQvWoz5wZJVGiGtJlAyISqYYr3vSgqJYFGGYtQRdsrqV8cXeEj7posq
 M1O7jetPvzhLwAdS4f4Fa+dao+Q00PAgYeSpEmq2W4VOQ2vqn2CVGepKpANsI9D73eCxvEjmr
 lPnxcUqQWgsgyEXR0bJtN4gPryohAk8rQZHp8Oj2wR4QlTMoDjhMZ/uHUZX1/GgdlwEnMVNta
 Rhcyjw36xWhxREPUk6jNvSNGHH/XPIpw+xrT6Fj2dqrac4+P+2Z+5TIQSMPLYyHvtvF7llSgt
 xjbTn2RVy75xdAKaxf7XZx3lDNMgxVHBMjAfH9M0r//D+FHtvA7r98DN4uyavwHtmha+bmMO4
 Bm3fkSBc0KVQCwBOPcbR5S2NIr4XYgZQKNFDbnUjWzy7NXSlrAK8umSa0y2KQc2gqfnxNKWIt
 EfL7trlmrpvOKnzKUISQeK0GYsArv7t9G/cZAY06SgTRqtOLWj4KFtwc5XPVF+GjxO7k9eipU
 St1MITgTVFqp6/DlSqr/Up9Q2pMgUp8qQOsVV3vjA0Q3E13jJmq/sFf0DNC8uYb06V1tylKVN
 /Us77zmUPEb1Sq6+GqKHBniZIFl0sFRyrtysM4mIWH6E+mINW6zAkfCM2G/oUwI82ukePfN+2
 hipPpEl05vtrsu1ujgxvoWulPSyMHquqeyJ2MMZtTMmtrn7bJENBmTRCLb1iB/IpSxV31HbUv
 LGVaLqUk6TDWeS15ZvQ66KhprU5GgSWGLXFfFqdWIcktSCe+18IJlF3/EAn0kaw1U9yhOqu/B
 NTL3bEPpgPOQOk45h4DIxZ/xOCz9qin7qI2mDK/m0f06JGMFD6DTbW7RzhRMw/ZV6oi6m1VbZ
 s8jS6PtVvhpciEsy9rmXXo848hJoA7dfliUInxhExKBDurAk334rFA7NFXPxBm85ZlIBoKq02
 8nCNOlbrJ24UTkOQ12t4oPU42Vg2+pY6acHONHGpmyX35kz/ZgPNjAnD5Ps3yg2wo3u6m4nA3
 6vxhC/eST90f7jT7MysRhXWGq9Y39uKwkTDAykPLokvl6cjMuhg+HZbcUgRTXxCxcOounGDcs
 pPatkOU7cUclUCXoEvuU9pv1iyU13zqa48QS2oDcCIvZ9kBplimmzwLEqzSctrO/xIkvpRL/6
 ippXaM9X6PnQXJZKFUifFp0T2yxSQc+w+P3Wd6Sy72P6n3uTn61O5TNoPE9XCjWOOmn9Z673m
 peyjcW558lIYTwtfzDXq4k0bs2sXyrAc3t9lnYLPQ3kBS/9ZkaVmN99BB+F9cRjq7YW14XKrQ
 Pi5MpXTNv6VcjmBsDx4i6ya5hqRivIahhg6JvBSPrIkaCmtk+rjJp8PkyizN3ARln6K3CDiVV
 Tf1U+6KuMcnBYhinmu7CZkHBKnlbgK9qMln9i9c3GImgZnyjN/SDMhNWf87nKgI2SkbcgWjq0
 EaECyu+oqzy6uALXJIzZOauwsHUqtkeBpH29A/30zWvVV1BWpLT9PL/6A1OA1IKO+5lUVoKl7
 a+QMLG5znQsn3yAA82GzBSFhAAJbTdjIWQe5FrPtoHVwyQjbhDe5xvQx6frh497sIQgl047zb
 BVV8LSoYrvY6GOmrJKQycj+XNit99sVWw8HRVbjISE9KXkNqk9rzLFUa3+w4jjCKA8gsouTaS
 sYdi/f9FA/2CXKimPX68xB/BnJ3/XcwV6aFX8WbdLpcjdrymb6NLb0QyB8DTq/YqilY1Jypj0
 xF+8+DsHGlkEVIjdQc2DJjBbZB1Fd8kHWhOimrgUaGyTdHjO1mkdRiyaPd5A5pLvjYPzYyqLE
 Hk1vUZ0oUUDohY3IDSs4upWy9kBtKi0poL+DHJQoC5IiEUl5uZ4zibBHZ6WQ3eHjvvAUaBleX
 dnmXsgO5jzn5zI+yrjgi5sJngfqQ0oHrIyok6auT1VDSOU5k6/LzkqhQiVVVgt11vYt36fqaz
 Fb4fFEBJ/j90zSrqPwjfPj2U5hLCeE88RV9Nj452c36b6v2IceFeLdFTHkxKy8nVNSwuQPjiM
 4eXvZWaFvgGOpDblwDVlA+anDo/bVb4ktRBUpbHRc1r88qUy81SGXtM+1gFsBg3v5+IXbF9xn
 n3iTogxlElP+3Ly7up7w6MYuKJtJYQHGVzYYsZhnbT3Q1Y+L+XXx/McJJUVDEIicezFXy3ygA
 hzz1rGlhV8DKHh02u7TApHArOBji83QLstKPjWnaOKHhT+f2KHkdfkkAF4oeX00y6CSnqkpLk
 W89iwcSTsjaRbP3KZJHWLf92zyS19MjySaq4yGo3S2uyJNGwnYclYPCA5C6DbahmAKK/gwaQ2
 U96qPwWPQArbVzn5+X0u9WDp+A4NULhyP1mli1QO3jvLXBcfYQYEXt9fuErRnXmHnlNxH1XnQ
 i7+8skpTTd4QLkUAp2CpQGsDBUbnVv+re91/S/oJjEfrMRAGgBZUzNAkslefzdzf8ySXCPWmJ
 Yy8OWx27Kb1VY80yKfLLyTPhk107KAeK9Jmo80JcEywu2h8aFqwRr8Zlsb0gDm5mUTY55CaP1
 7gqfIFDyJYHt2whVj6uvzhECSkPwCE3nDhTLIdzETKYr3t3bV+pMuvQ9b6bSz5j/QBPeo9kI2
 B46F93Hr3SvnBJd6TjjQZDnAQcjX2wTuZqPxHyAHxFsrb7d9IfB7QmGQgtjnUZDaufynFVN+j
 TCILYc8o8oN594MhJRrc9DIc56X+5sR07v5vX1ZTM5rbuR8LuhkndxU2FiJvl4Pi4yRiVBGYj
 6xP0otm7/zHd89ODcm9wIUmtKJW8FmYcxoZzgwg5u0Ip3lZF5grdq1KyVTCQEowr75fif1Jw8
 fCkKTiLZK8lYmJq/o/gOa3vXWYirnHG5olWxByZfSaP8pg2wsN7BOiJqhez39QxEkqrDnF/Sd
 /1/gncFNbk+syqRO/CAMhQMPo46Lkfz7cnRh7YPZDUkFqtMnXfO/0kVWukHq8EMXFHDwtyYUq
 6lXC3gynYNzqltGs6e4iFcoLkB03vd7V+wmZ1uWPM8WBniI+FvUat/uMOZ7KTLsZhCUUjEhZW
 lgWUEid4eqK7EuNMIAITUqYM0dFVgP8REIsgUvcH7exyv4oW9DkL6dPXlCJ8Jp2UBhdNMxhH8
 CWRtgROSVopBDYVi0oCFzghv5cR221D8gY42jwoYThd25KfX26jr6Vm+1mpYxrt1ncvuJhDCD
 N+MUczFpOPpqKZd6OYvPCaRfGubIsvec1YpSx8g9V6wwbRAokHNY/2YG0EvmIYk7JOLAuSaY+
 JPA0mCLZHzOSe34HqGKNuxb+d3PgFYOpO6r0XyMXI5tXBN6/I/cQ8LcexuAts6OQQJhmypkEN
 Xh3bhQ4g9u0Vx3tsudAFpURz8yJeqSn51gTMlfqhh2TNSX+L43mmXzFxAmEPB2CkRQhEOJZPZ
 jjALhdEAqIAzTrVBomrK1rjBecXKL5s9PPziTiY9QCw+W9ruS4B0/k7FtlsrMMv/VfaFhy2aU
 AYP34zr+GoyC3MmPhFmyWPdXWUcq6vnfVjhx2p8GKcPHP9A/0WDNcC3A2RjNRpbCkO3PwGXvB
 bWTJNNTacWcZZjiDXPxfNqyE8eiSTJ9ni0ZN5ln6toZJ1Km18hhZYbJcS+kCIwoGaAidEhTAs
 XOtAE9PWNSytviCQEJSf

Add and apply a semantic patch that simplifies the code by letting
strvec_pushv() append the items of a second strvec instead of pushing
them one by one.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes since v1:
- Semantic patch.
- New conversion in builtin/rebase.c.

 builtin/rebase.c                |  3 +--
 contrib/coccinelle/strvec.cocci | 46 +++++++++++++++++++++++++++++++++
 fetch-pack.c                    |  8 ++----
 git.c                           |  3 +--
 submodule.c                     |  4 +--
 5 files changed, 51 insertions(+), 13 deletions(-)
 create mode 100644 contrib/coccinelle/strvec.cocci

diff --git a/builtin/rebase.c b/builtin/rebase.c
index a1c7d78196..fa4f5d9306 100644
=2D-- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -182,8 +182,7 @@ static struct replay_opts get_replay_opts(const struct=
 rebase_options *opts)
=20
 	replay.signoff =3D opts->signoff;
=20
-	for (size_t i =3D 0; i < opts->trailer_args.nr; i++)
-		strvec_push(&replay.trailer_args, opts->trailer_args.v[i]);
+	strvec_pushv(&replay.trailer_args, opts->trailer_args.v);
=20
 	replay.allow_ff =3D !(opts->flags & REBASE_FORCE);
 	if (opts->allow_rerere_autoupdate)
diff --git a/contrib/coccinelle/strvec.cocci b/contrib/coccinelle/strvec.c=
occi
new file mode 100644
index 0000000000..64edb09f1c
=2D-- /dev/null
+++ b/contrib/coccinelle/strvec.cocci
@@ -0,0 +1,46 @@
+@@
+type T;
+identifier i;
+expression dst;
+struct strvec *src_ptr;
+struct strvec src_arr;
+@@
+(
+- for (T i =3D 0; i < src_ptr->nr; i++) { strvec_push(dst, src_ptr->v[i])=
; }
++ strvec_pushv(dst, src_ptr->v);
+|
+- for (T i =3D 0; i < src_arr.nr; i++) { strvec_push(dst, src_arr.v[i]); =
}
++ strvec_pushv(dst, src_arr.v);
+)
+
+@ separate_loop_index @
+type T;
+identifier i;
+expression dst;
+struct strvec *src_ptr;
+struct strvec src_arr;
+@@
+  T i;
+  ...
+(
+- for (i =3D 0; i < src_ptr->nr; i++) { strvec_push(dst, src_ptr->v[i]); =
}
++ strvec_pushv(dst, src_ptr->v);
+|
+- for (i =3D 0; i < src_arr.nr; i++) { strvec_push(dst, src_arr.v[i]); }
++ strvec_pushv(dst, src_arr.v);
+)
+
+@ unused_loop_index extends separate_loop_index @
+@@
+  {
+  ...
+- T i;
+  ... when !=3D i
+  }
+
+@ depends on unused_loop_index @
+@@
+  if (...)
+- {
+  strvec_pushv(...);
+- }
diff --git a/fetch-pack.c b/fetch-pack.c
index 6ecd468ef7..a32224ed02 100644
=2D-- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1024,12 +1024,8 @@ static int get_pack(struct fetch_pack_args *args,
 				     fsck_msg_types.buf);
 	}
=20
-	if (index_pack_args) {
-		int i;
-
-		for (i =3D 0; i < cmd.args.nr; i++)
-			strvec_push(index_pack_args, cmd.args.v[i]);
-	}
+	if (index_pack_args)
+		strvec_pushv(index_pack_args, cmd.args.v);
=20
 	sigchain_push(SIGPIPE, SIG_IGN);
=20
diff --git a/git.c b/git.c
index 2b212e6675..5a40eab8a2 100644
=2D-- a/git.c
+++ b/git.c
@@ -877,8 +877,7 @@ static int run_argv(struct strvec *args)
 			commit_pager_choice();
=20
 			strvec_push(&cmd.args, "git");
-			for (size_t i =3D 0; i < args->nr; i++)
-				strvec_push(&cmd.args, args->v[i]);
+			strvec_pushv(&cmd.args, args->v);
=20
 			trace_argv_printf(cmd.args.v, "trace: exec:");
=20
diff --git a/submodule.c b/submodule.c
index cd879a5cfe..4c8c674aa4 100644
=2D-- a/submodule.c
+++ b/submodule.c
@@ -1815,7 +1815,6 @@ int fetch_submodules(struct repository *r,
 		     int default_option,
 		     int quiet, int max_parallel_jobs)
 {
-	int i;
 	struct submodule_parallel_fetch spf =3D SPF_INIT;
 	const struct run_process_parallel_opts opts =3D {
 		.tr2_category =3D "submodule",
@@ -1842,8 +1841,7 @@ int fetch_submodules(struct repository *r,
 		die(_("index file corrupt"));
=20
 	strvec_push(&spf.args, "fetch");
-	for (i =3D 0; i < options->nr; i++)
-		strvec_push(&spf.args, options->v[i]);
+	strvec_pushv(&spf.args, options->v);
 	strvec_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
=20
=2D-=20
2.53.0
