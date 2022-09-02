Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D41ECAAD2
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 04:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiIBEVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 00:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiIBEVo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 00:21:44 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314BF6F563
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 21:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1662092498;
        bh=4Uig4r45GIp09ued0mtOlJCZDqd4y3iCuk6ixYMqbRk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=k5BikU6kP/7LoZrf0YtlQlKOCePXrIMM6ypEkfuDLUhMdzFOIhnpJ4v4hpjDSZzSh
         oTHUdSqQPcY1v29PDeF7PaN+1BtuftaKCuIHfWYUJ2p3wGYj+OoTroZYEgzr/S7lOq
         3WgFu2Qy7hn3uiTkji33yclOg9aM/VjEejV35vLc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([62.20.115.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9LIO-1pQFB02s0i-01598d; Fri, 02
 Sep 2022 06:21:38 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, alexander.s.m@gmail.com,
        Johannes.Schindelin@gmx.de
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 1/2] diff.c: When appropriate, use utf8_strwidth(), part1
Date:   Fri,  2 Sep 2022 06:21:33 +0200
Message-Id: <20220902042133.13883-1-tboegi@web.de>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4+etA3E4OFjA94mvSx3IfXOnycLnV79mYMbFuz33jEvt9vtHK76
 RwRuRsMBBxqvqKK0f4AAd50D1v6Xtdqi+g1yUJ7oxpyTqUFp4rUtTFi8hhSGMi2XMZfEheD
 D07vSTsGPZMv90H8Pv3JB8oMCuzWQkkoMr3veah4FuU9QKVIg80c5UfcA3lfLR5fIP6z9i/
 5RiGkA3mWZ26sNcGSmI3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6uK+Ty3g9fo=:Ilnr/ACdhGTbS1jtfehP/K
 O1YkV2l5CanxqgA0mFAUm/4aMRfwDTzaJXAtY2ymXtBZYfKSM4aw5KPUqJiYL34WSqoaOIhri
 LwKadu0a0s8mNqXYPGw+xAn3T2AAKO05FaBllqYVoIjeU4e9SlUIWLjRvgGUc47XL+pff/nXh
 0Ui11E2hk1w8FA/3tLU+bJqY5trxsKueSRdufcb2MzY/YzpvKUJte6ohTGozgARQj9+NbEL2d
 tRr9T2elVf7+WNbhiE1p+Aq+nhxSNEeUEM4V9Zdgzjo/qssFiaqg/rDQMXGjNS9jVb9mXKUIS
 iaEUzUhrbY9f2lGlz2QDzerYIhjNMscZMwv+5MGY5SUphGj71Uo+teBliQ5BOw/CBN+f4T43K
 N96r4wbPDxblgMY63LGb877tjGxTxwzMCLnpz0WvvdUtkahKRLkyoIv5PE83BQN3yvzAmDX7x
 J0b+yBP0hvYu34eo4NjyGqZoPvwfyIAhseEEBTBwZy8SpEtlcYgzAvfYWiLQfufL6ru9/QvQf
 iQ74MVvrGRL/PX78uCmSGN+X/WIwCCUEJlSenxYja2Iu2hOhfNVeH0l8LhSHEbv3r33mheFBa
 jqIwZ4G4kvUUaWgMPu3AR8VaD0HqGZH+DZyhdzycRz0dnWw6fMUdJmKOE2qlA89CJ/Q7/NUpW
 GZcfXr3T85BjXg2HvfAOogB33POZafncgMh+vHv/xzOD+eLqA/e+fWV9VjBUepDZ58DRlkOAs
 2FXOIXSP+jlu/pt8mvRLsIDCGWSpoSrHjJPEW/XbTJOGJy44NkYQP7Me4hEXT2nnGfQ5jNLUm
 WCEx1dA//n3GZ4cgH3wTbixSxLUeL8NZCp1IzSo4JuLSfHq0Trut81KnnQGf0jCK0Z+EnzstP
 6jiKyzG454E1Ipvw2SHQV/LSbrmdT+l09tR7cN+Nr8CwTFksHaIrl48Jcob3Imemdjv2ainXS
 zfvN8T00vglURdJxEVAX3zWwnbMSxUYgy61/a9J3tGd9RcpfeY9ufB1lzH1bTnjpG27HqXNkA
 gAIccoCywSO8n/yCefOXYRBmIK46oIi4BaDFWVOUOnWuSoF8I2CDJP7PCgIVVGz/+GrPbe/1e
 Gxdu5RllVIJTIGunIMdWNhCZQ8vlmYTpS601ImLK0NFGpn5IqzK6G96lcAR7n9ZljVCme2ps4
 pWtkk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten B=C3=B6gershausen <tboegi@web.de>

When unicode filenames (encoded in UTF-8) are used, the visible width
on the screen is not the same as strlen(filename).

For example, `git log --stat` may produce an output like this:

[snip the header]

 Arger.txt  | 1 +
 =C3=84rger.txt | 1 +
 2 files changed, 2 insertions(+)

A side note: the original report was about cyrillic filenames.
After some investigations it turned out that
a) This is not a problem with "ambiguous characters" in unicode
b) The same problem exists for all unicode code points (so we
  can use Latin based Umlauts for demonstrations below)

The '=C3=84' takes the same space on the screen as the 'A'.
But needs one more byte in memory, so the the `git log --stat` output
for "Arger.txt" (!) gets mis-aligned:
The maximum length is derived from "=C3=84rger.txt", 10 bytes in memory,
9 positions on the screen. That is why "Arger.txt" gets one extra ' '
for aligment, it needs 9 bytes in memory.
If there was a file "=C3=96", it would be correctly aligned by chance,
but "=C3=96h=C3=B6" would not.

The solution is of course, to use utf8_strwidth() instead of strlen()
when dealing with the width on screen.

Side note 1:
Needed changes for this fix are split into 2 commits:
This commit only changes strlen() into utf8_strwidth() in diff.c:
The next commit will add tests and further needed changes.

Side note 2:
Junio C Hamano suspects that there is probably more work to be done,
in a separate commit:
Code in diff.c::pprint_rename() that "abbreviates" overly long pathnames
and "transforms" renames lines like
"a/b/c -> a/B/c" into the shorter
"a/{b->B}/c" form, and IIRC this is all byte based.

Reported-by: Alexander Meshcheryakov <alexander.s.m@gmail.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 974626a621..b5df464de5 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -2620,7 +2620,7 @@ static void show_stats(struct diffstat_t *data, stru=
ct diff_options *options)
 			continue;
 		}
 		fill_print_name(file);
-		len =3D strlen(file->print_name);
+		len =3D utf8_strwidth(file->print_name);
 		if (max_len < len)
 			max_len =3D len;

@@ -2743,7 +2743,7 @@ static void show_stats(struct diffstat_t *data, stru=
ct diff_options *options)
 		 * "scale" the filename
 		 */
 		len =3D name_width;
-		name_len =3D strlen(name);
+		name_len =3D utf8_strwidth(name);
 		if (name_width < name_len) {
 			char *slash;
 			prefix =3D "...";
=2D-
2.34.0

