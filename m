Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32CBC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA8ED61A51
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352906AbhJAJTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:19:46 -0400
Received: from mout.web.de ([212.227.17.12]:47769 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhJAJTp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633079878;
        bh=dyfeIr0gJmT8o2FBrINxKDbVaWlpxgBDcl19/sy7n58=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=bxbXL6ewBttjkyh7GqxC1DuxCgrQBSqoOb7JzZqTj26OrjWjGUIwVZ5GYIPSwJsdq
         Aaypt5qtmxUKuk6rc4rlSSOsZ/Z4Tfa9Xh9O5btXsgJHre4+mgvA4TKDPRdhIfvPqf
         CvpMaMreRaB1GEDNvV9Lc9mGJavD08GOdgvyjnrk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MMW2M-1mSNb61cIo-008K6p; Fri, 01 Oct 2021 11:17:58 +0200
Subject: [PATCH 6/9] test-mergesort: add unriffle_skewed mode
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
Message-ID: <8763ebde-772c-500c-20fc-cbde43dcefeb@web.de>
Date:   Fri, 1 Oct 2021 11:17:57 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <943b1e01-465e-5def-a766-0adf667690de@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ynsosH7KRiHwh5inIskZCv2dj64iZpdBvxPt3d7F1pUDsIE9zuq
 vBDM184zV9LIQqTRNV2gV3rMiYUXSp+bOp3R6H1s8nMgmZ+xWtEV44LPbYMZdip9iAPF/V7
 FQBgjk3rN4zIWRezhlqQNXiHel8oHaMsG85wdWOjlMFn91pweogrrlXY0JF+sOvq0W7lZ8s
 yNsPhjn8F9ydMzrsGv7BQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nO48ipw3mPQ=:Qz0bZi/lEVMkfHWkD5aQOx
 h41tWXyxHpKUR3YsZ8I83MHONtzcvKUhv0mbGCno2oSp3o+g2VnV3Hhuh1eywMWMpTtACgQpf
 uR0CI4UWvZZPyedLrTWzVTAbkRUA9VDhhtqa+aFrmKhp1KemvZOTxaWbNvPKPMwGr4Nh8WsGl
 FOsUzIpI4px6rkLV2OmX3huObAKwKNfrUt3Vaq4q4RDiC2CexuqVFXC9CYYd2BioYJ4JE98kR
 HLKcO9J7p/8hPfqNbs0vePckZBV++t7CBenj4sSHeN9JZKzOyOn3WOyJFqp2L4cMPCUI3cvbZ
 5B5Xr4gvqwNPLW5EqTA54te4FN/LwVUfgRy8TzXccU4PpJp7CR1iymXB0LwOJe0s5kwc+EQgo
 pz44oVBRUurZJ30PP0iqdNUJ+EwkZy6amOrv1abaKZD168HstyHtB1oDnd5IqWPCiENtyQCZl
 3FPT/f1DhwhPFqVAjLXEs+mLFtQ5Kxi2J1+WcROKFxx20QiiNCiVOX3TNCrwOwVo0Jc9BsPPF
 GbRaM0cnHTQCCA7FGlKGKozecjw83oqXtF36qER68cKxQPmJWsE09Br4w+WS0pi/LS270fkNE
 vK5O4CTKNAook/JvuhTrAt3BbDdEO5GUOtTFYLWo/FvMuxWo5LTbn8KSNkyqtDj7d4DRyVd7/
 uDzhPRpJUKmygounaHGDHYdfsj9ejSZqQPXEyplbFH4kl8oxaIHbj2nmAJJDy6MbiSKK0kdQN
 OI0bTbG+hqj7Da7Npi0oFCS4xGf0cROBd2Te7BYhundHuDRPvS8j9QH4nBa0UbSzw5UVbYg70
 zvjZXouiNzKYMg/NeJEot8CPDHYKxA26Tl3GGr5njdrO06vUJ40JoaQBRz5cu91RKlm1Y5PkP
 6yrdb00NI95wYJmacZjI+HrYpcbEo9CI/0ZCp20LKvNMBEITVogpPNHI/8+dsDrHAwBZgCbfQ
 7vD8UkNpdvaPARIgfquy4OHld5M7eh94UjJ6cES4+LI0F5k6xTDaijly3m25rYpQleJ7zKWLF
 56jFwkVpdXspfQKlErrPNB/v/U4dG3kLnzUwMyhLwcwRH9RlOElqTgfVZMCyGDUB98RHmRiV4
 rQF0cN4OAgZ0jg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a mode that turns a sorted list into adversarial input for a
bottom-up mergesort implementation that doubles the length of sorted
sublists at each level -- like our llist_mergesort().

While unriffle mode splits the list in half at each recursion step,
unriffle_skewed splits it into 2^l items and the rest, with 2^l being
the highest power of two smaller than the number of items and thus
2^l >=3D rest.  The rest is unriffled with the tail of the first half to
require a merge to compare the maximum number of elements.

It complements the unriffle mode, which targets balanced merges.  If
the number of elements is a power of two then both actually produce the
same result, as 2^l =3D=3D rest =3D=3D n/2 at each recursion step in that =
case.

Here are the results:

   $ t/helper/test-tool mergesort test | awk '
      $7 > max[$3] {max[$3] =3D $7; line[$3] =3D $0}
      END {for (n in line) print line[n]}
   '

distribut mode                    n        m get_next set_next  compare ve=
rdict
sawtooth  unriffle_skewed       100      128     1184      700      589 OK
sawtooth  unriffle_skewed      1023     1024    16373    10230     9207 OK
sawtooth  unriffle             1024     1024    16384    10240     9217 OK
sawtooth  unriffle_skewed      1025     2048    18454    11275    10241 OK

The sawtooth distribution with m>=3Dn produces a sorted list and
unriffle_skewed mode turns it into adversarial input for unbalanced
merges, which it wins in all cases except for n=3D1024 -- the resulting
list is the same, but unriffle is tested before unriffle_skewed, so its
result is selected by the AWK script.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/helper/test-mergesort.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index d71ef568f3..43ec74e2d3 100644
=2D-- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -178,6 +178,33 @@ static void mode_unriffle(int *arr, int n)
 	free(tmp);
 }

+static unsigned int prev_pow2(unsigned int n)
+{
+	unsigned int pow2 =3D 1;
+	while (pow2 * 2 < n)
+		pow2 *=3D 2;
+	return pow2;
+}
+
+static void unriffle_recursively_skewed(int *arr, int n, int *tmp)
+{
+	if (n > 1) {
+		int pow2 =3D prev_pow2(n);
+		int rest =3D n - pow2;
+		unriffle(arr + pow2 - rest, rest * 2, tmp);
+		unriffle_recursively_skewed(arr, pow2, tmp);
+		unriffle_recursively_skewed(arr + pow2, rest, tmp);
+	}
+}
+
+static void mode_unriffle_skewed(int *arr, int n)
+{
+	int *tmp;
+	ALLOC_ARRAY(tmp, n);
+	unriffle_recursively_skewed(arr, n, tmp);
+	free(tmp);
+}
+
 #define MODE(name) { #name, mode_##name }

 static struct mode {
@@ -191,6 +218,7 @@ static struct mode {
 	MODE(sort),
 	MODE(dither),
 	MODE(unriffle),
+	MODE(unriffle_skewed),
 };

 static const struct mode *get_mode_by_name(const char *name)
=2D-
2.33.0
