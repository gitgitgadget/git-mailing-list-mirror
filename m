Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A10A01F453
	for <e@80x24.org>; Sat, 27 Apr 2019 09:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfD0J7p (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Apr 2019 05:59:45 -0400
Received: from mout.web.de ([217.72.192.78]:36095 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfD0J7p (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Apr 2019 05:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1556359172;
        bh=SzlykpiLQURHi7nZlpD9w25Itkf6T4FX1nuaGetRHN0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MY7BgQmi+oO4aZwcu0xR1yaXEpzK8Wdct9UHWdFUtzpKRVuxd5aBG03UBF9o7Lo2g
         U2GZvF2DXmq1Zq1f2kcejALMLId3mr5J+09ocDIPlSKMkUUZi1ZhQ3d0+3DKV3NSl1
         BWDq3mgB8Dlq0RaXZJ4yYfoy7iDojS9SjT2bwfmw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.17.75]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LecNe-1h05s21dD4-00qPZ0; Sat, 27
 Apr 2019 11:59:32 +0200
Subject: Re: [PATCH 2/2] archive: avoid spawning `gzip`
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
References: <pull.145.git.gitgitgadget@gmail.com>
 <44d5371ae6808ec40e8f52c3dc258a85c878b27e.1555110278.git.gitgitgadget@gmail.com>
 <20190413015102.GC2040@sigill.intra.peff.net>
 <8ef2164c-1d44-33bf-ea8a-49fa0b5c8abf@web.de>
 <20190415213556.GB28128@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1904261047560.45@tvgsbejvaqbjf.bet>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f6f32bc0-109c-e0eb-f7d2-9e46647f260c@web.de>
Date:   Sat, 27 Apr 2019 11:59:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1904261047560.45@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4RWNzpngIJfpGzgTZVjBo+tbjYjQ6nItEq3LDIZ8+kkdU5efBwl
 IPvg7tdKQvooFeDBRp70gb0fpA5pPufdvaef6+K2XLq7XXjwYS6feE0ied5gE7YyvbOw9Cv
 h497eMuekPTusuEu6kU3zX8U2FlaehmF3PmGPFL3VKqDYq1ppvK8pxGBiWIyVAmz3J66g6g
 TFAjTEDvPAefpeAyzhKsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9QRfX3NBZ/o=:5vlCPOEjmJ1NXtX5t1YE/V
 +QQo3ei/7v9ObWnDtunUPeOks0FVeOBwShQPTTdgR6dCLoK5tnVvN4sP0pkI/VkdXXpXPtLxx
 MJSzdQ4m3f3Sq0Sn0LCmYi1uspMeaK02UXevqLJG420m/aAF3E+qfT/snTtwuNBy7mqmJf8Lr
 LpF6mTejAHehj413qtMm0uz8o19QOx76bhZoKX4DOohn59sJWZy6SBjYaCuoLzxxNHGUoAUDf
 Kczksk4f/9I8YKXcmbqynMI2GBE/wK/JvCNbUn5NLjAmVDbw9jH0HVqg1IYSIa6wTZtTpjQv7
 EQMsHQmdKFxOqPoDv8DXUi6OKiTuluyX22nqYUjN53ELUlfgD8GPpfN7Ur58fyXJuxCp93bc7
 EBU7FGvqjcCiT38XWa66COUIUQ55spKEBE1vUu2qoGtZs6IfU+fod+sq3HNqDvT0py+vgKExX
 RQyELBEpA2bhcnfC86k2Bf+X+TtH54ksPNu5b1Q0n0IqIJhEubhlnMV3S/DD1L7UJGPhOM0ua
 wa5S3rdSlRJ+zIPdSbu73VqnSV7y27laVOD6Y/dCuQ144ZTHiE5N7l8CGVp0eipdf7X5F8b3D
 xbtGfuE7QQ/lAN9k+MYRjBVq3NwhfiBrQau+lcsSB7FWiw7tnCfwsrF3BIcqflNeT0dt0b1WJ
 YA9E4ogl/bmJTHFonBZntzCmLD8Yc4ZIXa/qfuNE0q2cRMpthGGoH6N7WZAnkSLh6Z/RQ353U
 oGCvJshNNhL3S/U7wKWe3ro8EQNkrGtX6x6DUJFsL3nDSER9i+47HnZrezgaE7DQ83N0sKShl
 CiSWeZbmfIhxv6P5Xn4L7pAp7MWTNu4MPV4kCm6rK2VUUydCD8MI0s0cWqaWqQxzINqcXMCkZ
 kL8LnqBHT3wZDfy3pkJDuZHNZJuzr9h8FeVsPfUmj2Cvs5v8cc1i7oFPWGTJtH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.04.19 um 16:51 schrieb Johannes Schindelin:> Hi Peff,
>
> On Mon, 15 Apr 2019, Jeff King wrote:
>
>> On Sun, Apr 14, 2019 at 12:01:10AM +0200, Ren=C3=A9 Scharfe wrote:
>>
>>>>> As we already link to the zlib library, we can perform the compressi=
on
>>>>> without even requiring gzip on the host machine.
>>>>
>>>> Very cool. It's nice to drop a dependency, and this should be a bit m=
ore
>>>> efficient, too.
>>>
>>> Getting rid of dependencies is good, and using zlib is the obvious way=
 to
>>> generate .tgz files. Last time I tried something like that, a separate=
 gzip
>>> process was faster, though -- at least on Linux [1].  How does this on=
e
>>> fare?
>>
>> I'd expect a separate gzip to be faster in wall-clock time for a
>> multi-core machine, but overall consume more CPU. I'm slightly surprise=
d
>> that your timings show that it actually wins on total CPU, too.

My initial expectation back then was that moving data between processes
is costly and that compressing in-process would improve the overall
performance.  Your expectation is more in line with what I then actually
saw.  The difference in total CPU time wasn't that big, perhaps just
noise.

> If performance is really a concern, you'll be much better off using `pig=
z`
> than `gzip`.

Performance is always a concern, but on the other hand I didn't see any
complaints about slow archiving so far.

>> Here are best-of-five times for "git archive --format=3Dtar.gz HEAD" on
>> linux.git (the machine is a quad-core):
>>
>>    [before, separate gzip]
>>    real	0m21.501s
>>    user	0m26.148s
>>    sys	0m0.619s
>>
>>    [after, internal gzwrite]
>>    real	0m25.156s
>>    user	0m25.059s
>>    sys	0m0.096s
>>
>> which does show what I expect (longer overall, but less total CPU).

I get similar numbers with hyperfine:

Benchmark #1: git archive --format=3Dtar.gz HEAD >/dev/null
  Time (mean =C2=B1 =CF=83):     16.683 s =C2=B1  0.451 s    [User: 20.230=
 s, System: 0.375 s]
  Range (min =E2=80=A6 max):   16.308 s =E2=80=A6 17.852 s    10 runs

Benchmark #2: ~/src/git/git-archive --format=3Dtar.gz HEAD >/dev/null
  Time (mean =C2=B1 =CF=83):     19.898 s =C2=B1  0.228 s    [User: 19.825=
 s, System: 0.073 s]
  Range (min =E2=80=A6 max):   19.627 s =E2=80=A6 20.355 s    10 runs

Benchmark #3: git archive --format=3Dzip HEAD >/dev/null
  Time (mean =C2=B1 =CF=83):     16.449 s =C2=B1  0.075 s    [User: 16.340=
 s, System: 0.109 s]
  Range (min =E2=80=A6 max):   16.326 s =E2=80=A6 16.611 s    10 runs

#1 is git v2.21.0, #2 is with the two patches applied, #3 is v2.21.0
again, but with zip output, just to put things into perspective.

>> Which one you prefer depends on your situation, of course. A user on a
>> workstation with multiple cores probably cares most about end-to-end
>> latency and using all of their available horsepower. A server hosting
>> repositories and receiving many unrelated requests probably cares more
>> about total CPU (though the differences there are small enough that it
>> may not even be worth having a config knob to un-parallelize it).
>
> I am a bit sad that this is so noticeable. Nevertheless, I think that
> dropping the dependency is worth it, in particular given that `gzip` is
> not exactly fast to begin with (you really should switch to `pigz` or to=
 a
> faster compression if you are interested in speed).

We could import pigz verbatim, it's just 11K LOCs total. :)

>>> Doing compression in its own thread may be a good idea.
>>
>> Yeah. It might even make the patch simpler, since I'd expect it to be
>> implemented with start_async() and a descriptor, making it look just
>> like a gzip pipe to the caller. :)
>
> Sadly, it does not really look like it is simpler.

I have to agree -- at least I was unable to pull off the stdout
plumbing trick.  Is there a way?  But it doesn't look too bad, and
the performance is closer to using the real gzip:

Benchmark #1: ~/src/git/git-archive --format=3Dtar.gz HEAD >/dev/null
  Time (mean =C2=B1 =CF=83):     17.300 s =C2=B1  0.198 s    [User: 20.825=
 s, System: 0.356 s]
  Range (min =E2=80=A6 max):   17.042 s =E2=80=A6 17.638 s    10 runs

This is with the following patch:

=2D--
 archive-tar.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 3e53aac1e6..c889b84c2c 100644
=2D-- a/archive-tar.c
+++ b/archive-tar.c
@@ -38,11 +38,13 @@ static int write_tar_filter_archive(const struct archi=
ver *ar,
 #define USTAR_MAX_MTIME 077777777777ULL
 #endif

+static int out_fd =3D 1;
+
 /* writes out the whole block, but only if it is full */
 static void write_if_needed(void)
 {
 	if (offset =3D=3D BLOCKSIZE) {
-		write_or_die(1, block, BLOCKSIZE);
+		write_or_die(out_fd, block, BLOCKSIZE);
 		offset =3D 0;
 	}
 }
@@ -66,7 +68,7 @@ static void do_write_blocked(const void *data, unsigned =
long size)
 		write_if_needed();
 	}
 	while (size >=3D BLOCKSIZE) {
-		write_or_die(1, buf, BLOCKSIZE);
+		write_or_die(out_fd, buf, BLOCKSIZE);
 		size -=3D BLOCKSIZE;
 		buf +=3D BLOCKSIZE;
 	}
@@ -101,10 +103,10 @@ static void write_trailer(void)
 {
 	int tail =3D BLOCKSIZE - offset;
 	memset(block + offset, 0, tail);
-	write_or_die(1, block, BLOCKSIZE);
+	write_or_die(out_fd, block, BLOCKSIZE);
 	if (tail < 2 * RECORDSIZE) {
 		memset(block, 0, offset);
-		write_or_die(1, block, BLOCKSIZE);
+		write_or_die(out_fd, block, BLOCKSIZE);
 	}
 }

@@ -434,6 +436,56 @@ static int write_tar_archive(const struct archiver *a=
r,
 	return err;
 }

+static int internal_gzip(int in, int out, void *data)
+{
+	int *levelp =3D data;
+	gzFile gzip =3D gzdopen(1, "wb");
+	if (!gzip)
+		die(_("gzdopen failed"));
+	if (gzsetparams(gzip, *levelp, Z_DEFAULT_STRATEGY) !=3D Z_OK)
+		die(_("unable to set compression level"));
+
+	for (;;) {
+		char buf[BLOCKSIZE];
+		ssize_t read =3D xread(in, buf, sizeof(buf));
+		if (read < 0)
+			die_errno(_("read failed"));
+		if (read =3D=3D 0)
+			break;
+		if (gzwrite(gzip, buf, read) !=3D read)
+			die(_("gzwrite failed"));
+	}
+
+	if (gzclose(gzip) !=3D Z_OK)
+		die(_("gzclose failed"));
+	close(in);
+	return 0;
+}
+
+static int write_tar_gzip_archive(const struct archiver *ar,
+				  struct archiver_args *args)
+{
+	struct async filter;
+	int r;
+
+	memset(&filter, 0, sizeof(filter));
+	filter.proc =3D internal_gzip;
+	filter.data =3D &args->compression_level;
+	filter.in =3D -1;
+
+	if (start_async(&filter))
+		die(_("unable to fork off internal gzip"));
+	out_fd =3D filter.in;
+
+	r =3D write_tar_archive(ar, args);
+
+	close(out_fd);
+	if (finish_async(&filter))
+		die(_("error in internal gzip"));
+
+	return r;
+}
+
 static int write_tar_filter_archive(const struct archiver *ar,
 				    struct archiver_args *args)
 {
@@ -445,6 +497,9 @@ static int write_tar_filter_archive(const struct archi=
ver *ar,
 	if (!ar->data)
 		BUG("tar-filter archiver called with no filter defined");

+	if (!strcmp(ar->data, "gzip -cn"))
+		return write_tar_gzip_archive(ar, args);
+
 	strbuf_addstr(&cmd, ar->data);
 	if (args->compression_level >=3D 0)
 		strbuf_addf(&cmd, " -%d", args->compression_level);
=2D-
2.21.0
