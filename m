Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E61C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 17:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbiFOREg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 13:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiFOREe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 13:04:34 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EBC4BFCB
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 10:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655312652;
        bh=mXVTWZ9xjwXYTJa31Owk0xKwD3jj0x/tDsBDzIbgStE=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=RZDnnvqww5/wt1gG0NhKWlURuxWVoxfgI2bL4WerbRco/rPP0wHGHdEFHZsGRYqPD
         5rbGE8RbuwOKizmob7WnDHtAsrHqRTIl9xsEhKYgJtk4+J0FVMs9uXw9oYip9EcKB6
         tgpEfNioAWaH48vJ0q6AQWt0oUqFLhNopkULweC0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Meler-1nTqBC3b4H-00ahAE; Wed, 15
 Jun 2022 19:04:11 +0200
Message-ID: <71a9fb1b-55af-ecff-d672-197e6e557c81@web.de>
Date:   Wed, 15 Jun 2022 19:04:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: [PATCH v4 5/6] archive-tar: use OS_CODE 3 (Unix) for internal gzip
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <9df761c3-355a-ede9-7971-b32687fe9abb@web.de>
In-Reply-To: <9df761c3-355a-ede9-7971-b32687fe9abb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TWKe6DAHWwBkPppwYgIKab+EqqSpVdFMvXeve3lh3D9Y2/jSxho
 TzqyEAw4QGGkkqdL7d+HwcUKFjQi/pw/PDIA1ByUYeKEMrxPjKmy1S46HMiNA9R5HxW59Z+
 sZjrD1kASaCOsJOvMP5tuf2u1qMtDu2tWsG+yTDBkq+OhEfuSam8bE5MBqapb5cHomudMCa
 B+IRPu4ykT7tEhOOG2LHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vrb7N07gf8M=:BT/Xpzw3oKdbbXfqqpd1nu
 YK7p/A6z8XJ+rksgruIPxkTj3GiwPrRji0of4FYDs+5Q1pmsC3x2GNq59O81Y52sLRNU7MEZB
 gSAoTU+PXqdY5ALgB/PBAxyxOT2eLDbPIv6DzlyoEwh2b/SH6WKWa0WeDNtSAONZEcoGrBmZK
 e0nABtBzyYPYBmlDqBvwaT95nqvwZALrAwOP15SAVSz+DYZfJn7X1G3nmddu+bFCSGKPQpQsk
 6j+lZWSeDd2o1b/qlV0nDkyQb3GznWjQg4MfKMEMozOr533YbKj6QMXZE3WEhQf9a1oT0XQIe
 ZyCGrHpKUMJaqyTeIlBilTiQQVEkUe9TTZy4fxfn+tCwQlAUVNktkhezVaVQx7YEOyiQj5xCk
 rPBNecLUEAj1qWLUGjfkJgwvJmE3+S/Hv/ldUSqJj+eXhOBiMgcESZNmtQRZy3y8zMl2Ja/K7
 z0QloBB+HsmT24Ff+MCh0Wae3PlFPryMQTP165AxSV6xpGaup/7MW4LGwnSFtnSNfAgpfPNkk
 5IvA7Wv1Xn43BlspK2aA8Tw33StGV2Et3UtqLyHK8p8ijtZcZqs2kwuhFZ9dXSMaIuxWu2dH3
 NdU8o3oe/hYgVaZ6jR0CS3YvMYiEiF3PniX1cMEh1a0/P4Wv15S2w5zayhjea07fkZyV53hM3
 WetFbz0mBgfT9dHGIpRBUnU0birg/m+jifX+B6LNEoUcJDoA7cOZK7vTkXn6C2x50c8l7Alg+
 6QlpLHrgXr6zvhmtjClLx0WhWNsdHbL6npPU4uoBRpLPdu+x15p73DP5GCpJMgZk/1duNbSaL
 Rb2UOIAlTBXTLRi245SbzsHfFDV/L2Z5LHEsMn/VQ+4GYRnUMginU44cMHJ1cyyvPIQPSchqt
 kMobh1gcmtC7fl7iFSAmBZUZYNM8g/JMnWR0tXQkmpNF0w0rPrFSTGj889P8Tl8eBJp0mIkob
 1fJi8Qd3mBLS7zjSk//zzyIckoAouhdIF3/X4nkaJZiWWhdIqLLIgn4HEJjG0jwBYXPyWo6O4
 wo/gr6xz2f2u5pIhvrH/VdS7hs0Lwt3qE2i+DGpzuVZ6r4gJ8bDvl3aIjeRisHZ/dmFiCIN9a
 Vs/JdovjGutEIT7rKx9q7Qv8oVMKJn5OfuQ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gzip(1) encodes the OS it runs on in the 10th byte of its output. It
uses the following OS_CODE values according to its tailor.h [1]:

        0 - MS-DOS
        3 - UNIX
        5 - Atari ST
        6 - OS/2
       10 - TOPS-20
       11 - Windows NT

The gzip.exe that comes with Git for Windows uses OS_CODE 3 for some
reason, so this value is used on practically all supported platforms
when generating tgz archives using gzip(1).

Zlib uses a bigger set of values according to its zutil.h [2], aligned
with section 4.4.2 of the ZIP specification, APPNOTE.txt [3]:

         0 - MS-DOS
         1 - Amiga
         3 - UNIX
         4 - VM/CMS
         5 - Atari ST
         6 - OS/2
         7 - Macintosh
         8 - Z-System
        10 - Windows NT
        11 - MVS (OS/390 - Z/OS)
        13 - Acorn Risc
        16 - BeOS
        18 - OS/400
        19 - OS X (Darwin)

Thus the internal gzip implementation in archive-tar.c sets different
OS_CODE header values on major platforms Windows and macOS.  Git for
Windows uses its own zlib-based variant since v2.20.1 by default and
thus embeds OS_CODE 10 in tgz archives.

The tar archive for a commit is generated consistently on all systems
(by the same Git version).  The OS_CODE in the gzip header does not
influence extraction.  Avoid leaking OS information and make tgz
archives constistent and reproducable (with the same Git and libz
versions) by using OS_CODE 3 everywhere.

At least on macOS 12.4 this produces the same output as gzip(1) for the
examples I tried:

   # before
   $ git -c tar.tgz.command=3D'git archive gzip' archive --format=3Dtgz v2=
.36.0 | shasum
   3abbffb40b7c63cf9b7d91afc682f11682f80759  -

   # with this patch
   $ git -c tar.tgz.command=3D'git archive gzip' archive --format=3Dtgz v2=
.36.0 | shasum
   dc6dc6ba9636d522799085d0d77ab6a110bcc141  -

   $ git archive --format=3Dtar v2.36.0 | gzip -cn | shasum
   dc6dc6ba9636d522799085d0d77ab6a110bcc141  -

[1] https://git.savannah.gnu.org/cgit/gzip.git/tree/tailor.h
[2] https://github.com/madler/zlib/blob/master/zutil.h
[3] https://pkware.cachefly.net/webdocs/casestudies/APPNOTE.TXT

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 archive-tar.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/archive-tar.c b/archive-tar.c
index 53d0ef685c..efba78118b 100644
=2D-- a/archive-tar.c
+++ b/archive-tar.c
@@ -463,6 +463,9 @@ static const char internal_gzip_command[] =3D "git arc=
hive gzip";
 static int write_tar_filter_archive(const struct archiver *ar,
 				    struct archiver_args *args)
 {
+#if ZLIB_VERNUM >=3D 0x1221
+	struct gz_header_s gzhead =3D { .os =3D 3 }; /* Unix, for reproducibilit=
y */
+#endif
 	struct strbuf cmd =3D STRBUF_INIT;
 	struct child_process filter =3D CHILD_PROCESS_INIT;
 	int r;
@@ -473,6 +476,10 @@ static int write_tar_filter_archive(const struct arch=
iver *ar,
 	if (!strcmp(ar->filter_command, internal_gzip_command)) {
 		write_block =3D tgz_write_block;
 		git_deflate_init_gzip(&gzstream, args->compression_level);
+#if ZLIB_VERNUM >=3D 0x1221
+		if (deflateSetHeader(&gzstream.z, &gzhead) !=3D Z_OK)
+			BUG("deflateSetHeader() called too late");
+#endif
 		gzstream.next_out =3D outbuf;
 		gzstream.avail_out =3D sizeof(outbuf);

=2D-
2.36.1
