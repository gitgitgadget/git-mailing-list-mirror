Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930E02628D
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759679738; cv=none; b=tw+xROBtvZ6RUcH1PfktLyzYXntBUVYfdYliHOeLPOqAqvKOTOfbSlNmkqCloyvEEOadOl8O9zTzojkkbMkowbe2IdoEfT+CQT+XzfGhiHcUDRfulay9Cty8l48PM5T1FdvsESxlGg8BuRRgBhaANN70qsnukAv0BPqxwurLJoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759679738; c=relaxed/simple;
	bh=BS2Yq+8ySEXLZI1PzDFqihuraHXby891I/3+ZFzh+bw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Nm8eg/kNZ4Q0VX+28lU376YUnvtjeLMROlI6JO1aKWnaub9FjdiXr7kfN8h5D9xPC0ohyA6EHhqT2MPRy35OXsFkiHZ5xry5JqXBPVmAtnLzuNVsKLZ5oJpb2OxxuAIQ2AlguRQBTkEvNKBsziuInMwrW3y2f9Zc2XsznpLAgT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=BJoYTeL0; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="BJoYTeL0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759679734; x=1760284534; i=l.s.r@web.de;
	bh=owW8uEPVe2kayWNXHBUNidyyzRE2NVNmclCeke0Vuck=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BJoYTeL0Q14XFCAY6eolmjYJv4vlvI9dUc9vbsHoQDKqi6pVkmHXwTvHsOUUGoVy
	 J7F8uhPf/RY5JOn297xIfkSqF0YN7yMT/1o1lu2YfOuguWaDn2s1WKDdeGbRDyX2n
	 cPPveNLIQAlQUGemSvYITC+KUuV6iixii6h2798m7ityJSh8LqvA2mufAOAXIV/qE
	 PnysCVXfnhdJkidq5KldV6QYIO8vLEZnP+rktVcWdkFwh9zZk00h+SuSTH3UDLapF
	 Fr+i80SaECDJ/8IiZcoUDVNTNZ9yep4Y8btDN8XomJhMtj1aI5SJZ5yH4n+KmSjpt
	 GKe4OlNB6I6jfWAIuA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.16.132]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsaW1-1uGVSP2n4V-016aMo; Sun, 05
 Oct 2025 17:55:34 +0200
Message-ID: <3e1f51b4-b654-4fec-9774-8a76ee6f6cc3@web.de>
Date: Sun, 5 Oct 2025 17:55:34 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 3/5] add-patch: let options y, n, j, and e roll over to
 next undecided
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Cc: "Windl, Ulrich" <u.windl@ukr.de>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
 <17ef29a7-5214-4729-82eb-92a2af33e465@web.de>
Content-Language: en-US
In-Reply-To: <17ef29a7-5214-4729-82eb-92a2af33e465@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/3LwKJuof+3qg2nEGYVo4BkFb+GrgDy1/lZ0uMNmnDtHldQkl9C
 nU2vgkUEgC1j0+Q/KNprDHKQI2REKfey5O6NpP2eApFsDp/Wq/c3LeGRLWu8XVEXM7Q+Ubk
 4CZSqZx71Janehx35TmPlTsM2mn3VrP3rrMEG5Rrpmmq4AwcRWKIBQ/Ro1npQQLBkHlwVgM
 NMBw2xSFsJhjuvIT8VdmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:z0gL0xME9As=;9Xgg0I2PgC1zVTD/WNEkOPT9kH5
 5aNZI7otAcQGRGjSUzkD99GvxjY+ZS5nSzRa6aRfZyKvjAkzkaK1nXVakTesBWdVh4BG/SqzJ
 uoa8L5vN+ZGzQ/aHiLl93aZp90LnHTt83dHFEZ917g402/VO/AisQBk0TRpHfc9A4QKTKsUzJ
 dRCEjvJN4jpOfjR3h0zIoW7+b+SyeO4JJGtPn8ypMUw22ts5BeOJlSbYw8uI7lekuXxNDcMx/
 4eYFzYk33A9YAlyxMtLLA/Oha6ex2AXAhHuSC2obKLIK4PMQRwwcHQCENg6C4B+yl5QRokUPn
 hYmgYW5UWbWAz7uBiauwGWzMy8uPcIaoWK0gjnmhNqwmkE+6GIxGV9S5n2OU4FEHxfzA3zoCb
 CJUsc0TAxxOoP8UMbgWWMgq7iXOJpyfkxsATeK9+o8Y1IQZhfkIC7RAdKXzKr2GgkFQ73vry8
 Hcg8cQ0NFYsVzdgf4Q8Pn9CZJekCfSTHrudbkstJLeuT5GkCoEusXrTtZBsZOJDd+RTWH4dOL
 Nafv8nF+xliBTbtP1ITHPDs585zJNNfOrLukovsLKvaw67QVmQWResFdBxx2A2qi85tJBCanp
 zq2lvLpFVfoZsQj66jkU7f8ka8VnP49UKQhQbIWttCJAoOfo1KunPgNcj8+7lvvBnDiTFo9CN
 h59OZ1QxNEQBncqX2wuaFOHciDVsG9ysMs5hyreP5eymyNa3yg2ZpGNK6CTL0bmQIBHjkREIr
 hz01BhE1NrrIL3o7Y3iTlnAUMmR07dE/iuRSeMNFBo0zruKhKhbnzksZxGt7pT9+JsaUNLkg3
 /ILKfFJdoxexTSvNpSharWYCBM99T4pgUItt3CmEDYV4zd0EEswuR2z1EnSHg5tP+xUDG7Q4p
 DdLliw8tndkxUT25IUd55rNSao5lriTG1/IkS++1xMqUPZyynBFEdKtKmiSRcA+8yiniHS6rG
 iPEB6t1DiNfWp8KvxsJ1yYi84Q777Uf6qUSM5QDuXdRtuRPLdFho5IhOrByu9wOi1IlsKQk73
 LMR89rIvhibBUX0UTAgfu7d3169N5oP6J6e4ib4j69jHOnfFDZdU/8qelz2mM9snn2NvO+wej
 DbMe2xbu5If1GkCLl4mn7R6NgXS4I6WR0fa2cnl3CQxkVur4MD1IsznBsrglA6mZhFX+5wF8C
 DWPSdjg9oohz7R9E+KzMzraxWJ44XzUVdheuBuxoZWcmWV7Ns4G+xveaUECp7nlHlqITJGASw
 +zciVmvaez8X4WDwiCmdKTRPu6aJ+zPXmROvXYX1/wTetg8v/JODXmp788RWjspRDHKLB4w+G
 eVm6lTA2xhKCQjvepGYHrd892d0XVvleRxb8mmv37iK8k1+MdqUERZe/lsIa/fmUjId4v+R5j
 GFNrtbqTVGB+W4ZClIAgGEMRGuQhVi2U+Dc83cGL3M5XPUsmpvBnNBzLYNWFxRGIpBM1oXuEE
 gGkx0I1CikGbPiWEpOYgBT17MxpOqwiYrzfhZeb5JEDw6Oq/Cc2aLwGsLGtQz7fHLwDxAv+NM
 nNaWUXy/uxw4F7bO6Y9AM8Wr1l3t5n/E1u8AmiBdDLRmIkEBPUyJ3sNM4CZUVR2nU1Svhkr67
 zvgFYGViFz/4kAuTqpNPaS/PcyQXBWFDGlHfpOYTuFn0jwrcYKpl4228Czp8uYBH1VEd3w4Lc
 nE+Gg8AbMv3MlGkZOfSUfBBG7aSkQ8gSHwOZUAl5EmrYNMbbclHCLRJvzeF546jWYcCv2aqwl
 4GIPrMOUvUigLw/02LWi24UNDL94nJJtfRAqhNey1PymTiqtOSXqCNfc4LLWNUeWeFhau0cwG
 5mHVgKJglUIZ5YiYpjv34rV0yrI2QvIlZyiNuhLvdjUYnKXyxP4SemvnQT1ve8mOgTGTgDZbE
 3qNAPdhJ1esTwX5sYtqs+yVwISWCSEQgR6HDTpJ4e7KerIGcaTs4KThovLGC5Z9YzY4z23wOh
 LyVpNUWcoJwdWX3XTIwckG8LgCHH3a37Je7sq60mPhPqYkqOfbarSyl7AdYS8yf6fJbizdCLg
 XctpJpotETouB031YJa2ehXRtld9r4MapQ1361k023PnApGPwL2KYim1aRjjlUppVPE2XtrC6
 +Yd3y8bULHsmJ8sbp0fP0Sx8nFc/OQc5w+zV6zKtBH3ZJll+p0SOjC83Tzi8so4rM5Ny9pbYi
 SP5Mk0Zc2QHcyvA/KY55xssqBNjMPHf6dt1bL8f4EiCx4uy3OScuVDwreJAUkrLryHLn9BsfB
 Fa1keIWRSSNOQ7b5vgF/vt9O0JURTx0ZDqIfOevX4AttZGP5LFyv3IfMcN2asgooini0dxSmx
 U48s6l9APCRJE+b0F3hpiLJMLrgJ+OAJVw65eIQuSeKsb8WOko3Rcqq7eqYyoMT1CAob3ePVP
 +hVky61bKApOGhbsR0tJtDg84lpLF3HWy10cVKA20BqPZIdVT6m2jSPgW5MPyjF1o0FAJI/tQ
 ARo+tmE6mw7QMFAYhAfSiPAYNzGaQ3vbwUjZVmnhAi2iQDlnb88MUOPA1P2fcbbBfW8BRhqew
 2qHfcxddb1QneRlxNlIfSXt3HW5CbnwXRmXSaY+ZkLMOmmBi/LrRKq8KoLJTLdw7ABf4xYEPO
 VTYnMI/etoReM1bqQ9g+vvnp8D7b5KT8AxagzIFcEzTgFhmyycSQhpnTkK7Y0RXnq6tv3EQIc
 Ji5LMrBmJcVOa1nM9lPnbwu1u3zZvv3ZWh/UYGRE6thA7WA1K81FuBBl3UjgLUy/DXhUJ3lRj
 at+NuA56FBEN1xBDvRPWjkjESHUNo7v4mHZ6U3QDYQUabuMUxFBK4sUp7mSXTt6qPsYDIayM9
 K9VQbs9/8lP8MoPPJLjE4e33hV3i4hAQQBnToOXhH5r3jJz1KTvH64Er4eWxH7JQhn0n+9/p9
 W6zCmoJysTfLn7Le6eOe50fvBZBDDyHLaUBd7fHD4DF7SyKK1/Fu7ftUbadAPYZWpMf7JY2jj
 GQ4FuG7fDYzL9h7JPxuICt3WgGhb6M1VuC3xrUt1F4dczjIZPlD1e/SngD9bQuQvg7pTI0en4
 UlFwZXkGq/Hdy1cjSoBNzLBAeV7bmoe+KXFlBh18ZCjcZmftb6mDRKGbS5aL0CVNo2TFR+I/l
 de6SXGGgx5JQEk9qApwLJaXjfPso0Y8Xr7iadtRHfFZexM//gVFYrbks0Zfvk94XFLClUlO4r
 qQAAfnXOkZLydDnG0Qo+PUYTs1x5xz6IvA0rp62H0jaXkq93CfRZundn8PmSgeNeN7XRgAOau
 IqZCrLGXTrVyDRA77VObKnZW90dUT/pqzfBfMSiNg+9HPtLg6Hnp6UbEioVSmsfr3Oi+WIbCe
 l8CXA6QjIhtk5Lyzov71bZSQvjZGuOLNIFpf3DeLcqhrHyVTrrJkSmVOaGYxLBJL69T39pNYz
 7z6zOTi4cYHKZiW5v3h+2/VBFvk7OEcsUhLdp6J1Eo8Ai59a1bKMaml6V5OZNbK/tdJ+W1vCd
 HgFEw2Viq/99CiHhmgbuPM6YLKWlKa1AAYG9J4CRQpxfYckNscPZY/sleRH3ygiq6eKrU3+a7
 2qbvR0D7CyjUNezQCcwcgQmEhbtiRdB28zE1sVJEgWc37eGH7ARVp43ktvkqizkaHzz1+5epK
 CV35pgjX0b2ezYhYaLbx8ZYK+hRxNq1lRa9+fK82LfLY94HFyheKxdctTKBJjBRgjDwCg1dOo
 znK84chunSYeb/ofBRrZpAT48SYgm2qIQKkaFwfc7BIlcSb67p5bhC3/CKRVEU6x1IHObc9WR
 4YfmBIbioc8OO2YxlAqpZaiI1rGkb4tizcYKi+USZ4MLQ6PYQj3L0dWXZzz6Blsk4xDvHQRZH
 FZBGs1AdHYmGvM2mzwoUQMsIjVN6g84aXB8t8PzDYd/6r601xIdV6oO4mPs2OWtDwbVLkbyOF
 UbddgkNW5do5NFVuM3zbpfogmg6hI36tfyFqzzwI5kOheJUWYyTUkHKpFBKsMkkASLnEY2N4H
 Fg464J0pCLz4Ht5uzac6+T0rKmKvXNi9ntKREDpHuJBHPjioD5QOP4M084z56nOlD8MacgEIW
 E+MikDnUidH+UVw5Dv+D9lHJDwaOGHNOht6XS9MbVKLbwUN1PhG0wBAB9J+fDDsZWRtJY/suB
 Sx+3+dI6qxfxRPM4ABdCp9NF9MvOQ0S6uICTPVkaLiykLZe2DAQP5bxCmsjX+LcQxjRyzF2cK
 +tKnDjKazoETJByJ/AUVDVhUwBllVhThBfeD/PZwbkAnyxRaOObZCRpq4sMm4PAg51ybE3K0/
 vD54qzTIcThqWJIxaCM5GmJUrTEM+HI23l/rsYkF3gEwMKVqnPIQG2THSXqqnkSfmYyej9637
 +P3A5GxwxjYuF9iq+LzCQMYp7qXrfv22Z7BmOWjH3+MTF95hwjjLQihLctO6S6ODsBqPhDt3W
 E09WrsGgtvw8UsyWq4PtbQ5Y9+zMAppafQBIi5tvv2yXsgSZWNRLJKT2FqajXYQcTVkAROyW8
 TSRYal0ND6s5smwN/s2H+4edzMzwkX0jaRPJn32OorU/sM7ThN8JCUCzDM83voPNGM8qH0Mne
 Rj1xE83fSXvZfo+ARQNktHJkzunkXYFFlLTXhsrDLsqJ7v6tvZmQyeTk8TYDd7O5M+jVRukc7
 DGq0CWq/Z68A4FN0434mqmeQ0zjgk8vhFl/DWScFtxarZ7uO2q7dpTitCDuek/81NnqWttOUA
 oxdzEicZyU2sqsyJ6/IMQmekbULpAjW5E+xAdaXk6vVxuYjVxkfepAmGOlJQPG84TgfE6z6gq
 ARltQtS/oRcWhy2AGk54uSNQsPiR916oVaAV/pUea4usIAlh9R8dUrQ6XzRMaBHRvE/icJofx
 p7/LV+7FgLC9r6h5AVZrZeUFW6aWMSL3lrj7RVH+8rkl57DFX2l7QekJRzc8Gm+TIq8IJ7sps
 EJ39+KNfE8MNVwtGQJZOeo44VKhcj4pV1vEKX9x6yzIqPWvHZylAQycL5Bk4i3cy73xNZi5mB
 8BU0cLa29zTVFvcyXYodgHD+XiUQTDabnjodfCwkRseHcdIfbAKAZCIfRj/MkmFZmcy/yh9iA
 5RPdidm74sSd8EAI714Y3m364s=

The options y, n, and e mark the current hunk as decided.  If there's
another undecided hunk towards the bottom of the hunk array they go
there.  If there isn't, but there is another undecided hunk towards the
top then they go to the very first hunk, no matter if it has already
been decided on.

The option j does basically the same move.  Technically it is not
allowed if there's no undecided hunk towards the bottom, but the
variable "permitted" is never reset, so this permission is retained
from the very first hunk.  That may a bug, but this behavior is at
least consistent with y, n, and e and arguably more useful than
refusing to move.

Improve the roll-over behavior of these four options by moving to the
first undecided hunk instead of hunk 1, consistent with what they do
when not rolling over.

Reported-by: Windl, Ulrich <u.windl@ukr.de>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-add.adoc |  2 +-
 add-patch.c                | 11 +++++++++--
 t/t3701-add-interactive.sh | 22 ++++++++++++++++++++++
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 5c05a3a7f9..596cdeff93 100644
=2D-- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -342,7 +342,7 @@ patch::
        d - do not stage this hunk or any of the later hunks in the file
        g - select a hunk to go to
        / - search for a hunk matching the given regex
-       j - go to the next undecided hunk
+       j - go to the next undecided hunk, roll over at the bottom
        J - go to the next hunk, roll over at the bottom
        k - go to the previous undecided hunk
        K - go to the previous hunk
diff --git a/add-patch.c b/add-patch.c
index bef2ba7a25..da75618dcb 100644
=2D-- a/add-patch.c
+++ b/add-patch.c
@@ -1397,7 +1397,7 @@ static size_t display_hunks(struct add_p_state *s,
 }
=20
 static const char help_patch_remainder[] =3D
-N_("j - go to the next undecided hunk\n"
+N_("j - go to the next undecided hunk, roll over at the bottom\n"
    "J - go to the next hunk, roll over at the bottom\n"
    "k - go to the previous undecided hunk\n"
    "K - go to the previous hunk\n"
@@ -1408,6 +1408,11 @@ N_("j - go to the next undecided hunk\n"
    "p - print the current hunk, 'P' to use the pager\n"
    "? - print help\n");
=20
+static size_t inc_mod(size_t a, size_t m)
+{
+	return a < m - 1 ? a + 1 : 0;
+}
+
 static int patch_update_file(struct add_p_state *s,
 			     struct file_diff *file_diff)
 {
@@ -1451,7 +1456,9 @@ static int patch_update_file(struct add_p_state *s,
 					break;
 				}
=20
-			for (i =3D hunk_index + 1; i < file_diff->hunk_nr; i++)
+			for (i =3D inc_mod(hunk_index, file_diff->hunk_nr);
+			     i !=3D hunk_index;
+			     i =3D inc_mod(i, file_diff->hunk_nr))
 				if (file_diff->hunk[i].use =3D=3D UNDECIDED_HUNK) {
 					undecided_next =3D i;
 					break;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index d5d2e120ab..8086d3da71 100755
=2D-- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1364,4 +1364,26 @@ test_expect_success 'option J rolls over' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'options y, n, j, e roll over to next undecided (1)' =
'
+	test_write_lines a b c d e f g h i j k l m n o p q >file &&
+	git add file &&
+	test_write_lines X b c d e f g h X j k l m n o p X >file &&
+	test_set_editor : &&
+	test_write_lines g3 y g3 n g3 j g3 e q | git add -p >out &&
+	test_write_lines 1  3 1  3 1  3 1  3 1 >expect &&
+	sed -n -e "s-/.*--" -e "s/^(//p" <out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'options y, n, j, e roll over to next undecided (2)' =
'
+	test_write_lines a b c d e f g h i j k l m n o p q >file &&
+	git add file &&
+	test_write_lines X b c d e f g h X j k l m n o p X >file &&
+	test_set_editor : &&
+	test_write_lines y g3 y g3 n g3 j g3 e q | git add -p >out &&
+	test_write_lines 1 2  3 2  3 2  3 2  3 2 >expect &&
+	sed -n -e "s-/.*--" -e "s/^(//p" <out >actual &&
+	test_cmp expect actual
+'
+
 test_done
=2D-=20
2.51.0
