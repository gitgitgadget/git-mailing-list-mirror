Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7707CC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 565A1610C8
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhJAJSj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:18:39 -0400
Received: from mout.web.de ([217.72.192.78]:60293 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230000AbhJAJSi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633079810;
        bh=Ub489NJCdHYRn3myJlbvJbDD+oZboHmWvm7inzCe/fQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=L8q1TogSYRcXNp7VAXLo6mnRSNc01RlNAvQ/E0Ewg19H72zT0rwAx4pemdWOet6Nu
         9NJKrT6vDqNyIpveperJSxS0F1wGyYlwLPc5fv2FWJVSVagaTp+7hjClxZveh4RK/A
         8MQ1xYVdv6PcioMEOxvYzitra46BhZI6kkWnitqc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MGzXS-1ma6Hw2F4E-00Dn3j; Fri, 01 Oct 2021 11:16:50 +0200
Subject: [PATCH 5/9] test-mergesort: add unriffle mode
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
Message-ID: <fbeacc0e-d870-2aef-3177-9b661ffc6768@web.de>
Date:   Fri, 1 Oct 2021 11:16:49 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <943b1e01-465e-5def-a766-0adf667690de@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d8AJLR5iau+yiItNsMbCN408COKsWJ55H2u0Yw6ec43+J/yt74J
 c/oq8rVBhaLJ+ebuL8mYuZX0f28N5Xxup8M0cT1wAYULAAENMy+MoviG/7D0/oL22q/U99Y
 PctWNKV+IiWYz6ZJjrkGUYVoVLVgSumLwrsTEG2TaTNQxkA3npOOq9WErXxZLQiTRa6+l8a
 a7H+ZMhZLEHWXJ+KCWUBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QOpB3DYJFTo=:ZsPJxDtiubsYgCjzhA6e0b
 lm/mnZOrY6QiSCms4azrtDbZmhuaDaXJyNHndAf55RbplgjFNi+87l4XLbA8fvg2dNIdmlW2o
 Q1JB2+fvLWFHwMmq2yKt3Pr08NvdWG8kUn4/1U+H9IBCB7dsVJP5kPqKoV/d9wcZ9SNV/IRDj
 6DbIm8k0Q9e57kB0Bqun6IU23bwaxNvcJs8NQhYRD3i289Dy0loi32PO2Lt4D/zYS4V/cS2qk
 J8j6/0s/rWV1NPMwFww/PqgdSeH52wL3HhnEuWGFmsI18I82AVh2xu4OqD9aGTebftFFFJOqD
 1CUNno8lWPacoD76nUKjcDbizbbO4ugQ1+Zh8a6a+Oz34UE8sP6OgnaEd78erbC+Tt5u/8aki
 pE693IiZZQWRXFNFpGSWoKkAE7If+Q/b3/Y5ITsRuGmpro1eMyiC2uBS/A4IJHbUj9FYyYpCe
 dPYNkq7PLrWWN9zbby5ea6g4b8Fol+pyXUj2o2mwsoAoyAqj6qt0mJg7XfasQk7PrtvEJvQYv
 Z8/WFkH65emwOuFVih5YO7aMkJjmx4ELF3TKPCJ4dyrQEbUjVrgqmow76//2Ah0bZ9dKYb+KU
 SdY6l8Wiuxx9zWoEFBLQJ1LM5vHWg7mBzvo/UvnMpfIXOEAnxQuvhB9XHUMV/0vG1cwj5W5uO
 N733Hb6ob6PrXi7AzsjFsexgO4uvQFq0YKOlUjQjT60VevSUWMfI6/YGnQN8SnTt1wtS2FS8A
 NH8xuahOOTyVwvXCP/OG0TA4yAgauZmZBn1Z+9xlXOgKWknUwlRZbdkHBnBvMbWtSALw+xwUe
 vqYS+i+GUllFCEyiAyMhb/G3vWsFBok/zcFbzSUlUttQCX79h2ShKh3FmiFChlbcVAs478/tG
 gR6WYvS2lBu0Kn2vqD3/AGH94NWqUpJ3BYql3GRCZzq+4zf4poIFzGzRdWYO1Jr4te5K9oP/u
 U1z2oJWknu2s81KGNxP+UfFRLOQqJAMZLNzfjSQ+2I/Qt2U+y2fIIUevmFQvVB1e9yFglBPNm
 dOkksUqslN3H8OpUU14JU2CJVtxaev/q5QSBTeLBm0t5iBN+PWE7x9/mK7lUTcNBnSJEkjg9V
 ovp4RfbEX2LuJM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a mode that turns sorted items into adversarial input for mergesort.
Do that by running mergesort in reverse and rearranging the items in
such a way that each merge needs the maximum number of operations to
undo it.

To riffle is a card shuffling technique and involves splitting a deck
into two and then to interleave them.  A perfect riffle takes one card
from each half in turn.  That's similar to the most expensive merge,
which has to take one item from each sublist in turn, which requires the
maximum number of comparisons (n-1).

So unriffle does that in reverse, i.e. it generates the first sublist
out of the items at even indexes and the second sublist out of the items
at odd indexes, without changing their order in any other way.  Done
recursively until we reach the trivial sublist length of one, this
twists the list into an order that requires the maximum effort for
mergesort to untangle.

As a baseline, here are the rand distributions with the highest number
of comparisons from "test-tool mergesort test":

   $ t/helper/test-tool mergesort test | awk '
      NR > 1 && $1 !=3D "rand" {next}
      $7 > max[$3] {max[$3] =3D $7; line[$3] =3D $0}
      END {for (n in line) print line[n]}
   '

distribut mode                    n        m get_next set_next  compare ve=
rdict
rand      copy                  100       32     1184      700      569 OK
rand      reverse_1st_half     1023      256    16373    10230     8976 OK
rand      reverse_1st_half     1024      512    16384    10240     8993 OK
rand      dither               1025       64    18454    11275     9970 OK

And here are the most expensive ones overall:

   $ t/helper/test-tool mergesort test | awk '
      $7 > max[$3] {max[$3] =3D $7; line[$3] =3D $0}
      END {for (n in line) print line[n]}
   '

distribut mode                    n        m get_next set_next  compare ve=
rdict
stagger   reverse               100       64     1184      700      580 OK
sawtooth  unriffle             1023     1024    16373    10230     9179 OK
sawtooth  unriffle             1024     1024    16384    10240     9217 OK
stagger   unriffle             1025     2048    18454    11275    10241 OK

The sawtooth distribution with m>=3Dn generates a sorted list.  The
unriffle mode is designed to turn that into adversarial input for
mergesort, and that checks out for n=3D1023 and n=3D1024, where it produce=
s
the list that requires the most comparisons.

Item counts that are not powers of two have other winners, and that's
because unriffle recursively splits lists into equal-sized halves, while
llist_mergesort() splits them into the biggest power of two smaller than
n and the rest, e.g. for n=3D1025 it sorts the first 1024 separately and
finally merges them to the last item.

So unriffle mode works as designed for the intended use case, but to
consistently generate adversarial input for unbalanced merges we need
something else.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/helper/test-mergesort.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index 27ba252d4a..d71ef568f3 100644
=2D-- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -150,6 +150,34 @@ static void mode_dither(int *arr, int n)
 		arr[i] +=3D i % 5;
 }

+static void unriffle(int *arr, int n, int *tmp)
+{
+	int i, j;
+	COPY_ARRAY(tmp, arr, n);
+	for (i =3D j =3D 0; i < n; i +=3D 2)
+		arr[j++] =3D tmp[i];
+	for (i =3D 1; i < n; i +=3D 2)
+		arr[j++] =3D tmp[i];
+}
+
+static void unriffle_recursively(int *arr, int n, int *tmp)
+{
+	if (n > 1) {
+		int half =3D n / 2;
+		unriffle(arr, n, tmp);
+		unriffle_recursively(arr, half, tmp);
+		unriffle_recursively(arr + half, n - half, tmp);
+	}
+}
+
+static void mode_unriffle(int *arr, int n)
+{
+	int *tmp;
+	ALLOC_ARRAY(tmp, n);
+	unriffle_recursively(arr, n, tmp);
+	free(tmp);
+}
+
 #define MODE(name) { #name, mode_##name }

 static struct mode {
@@ -162,6 +190,7 @@ static struct mode {
 	MODE(reverse_2nd_half),
 	MODE(sort),
 	MODE(dither),
+	MODE(unriffle),
 };

 static const struct mode *get_mode_by_name(const char *name)
=2D-
2.33.0
