Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E69BC25B0D
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 05:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiHJFkE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 01:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiHJFkD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 01:40:03 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8B082F91
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 22:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1660109983;
        bh=TGhM6Vj1+R3NRLI2ch0SE6wXz8Zz82SLD4R0RIo89cQ=;
        h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:In-Reply-To;
        b=HXze6vm+sCBbJjaaYJTGXJ9Qkqo/eEzv82y8sHbyuneayBK2vUduTg4e87lzkhxHp
         htveUPTgD5YIyEzO9VVU3skzq4qzEbxVC8N+3FiCFh1UffUcBxvl5Q4bTnqC/xjn3x
         4oN/YDX9fPwvwLq/okLTv8UhHuZcrtgkzTkSpOcs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.35] ([79.203.28.61]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MkVwo-1nga8H0sFq-00m8T0; Wed, 10
 Aug 2022 07:39:43 +0200
Message-ID: <0e1b8066-3f67-cec6-675a-05d2cf54c119@web.de>
Date:   Wed, 10 Aug 2022 07:39:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v2] pipe_command(): mark stdin descriptor as non-blocking
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <YuikU//9OrdpKQcE@coredump.intra.peff.net>
 <YulFTSTbVaTwuQtt@coredump.intra.peff.net> <xmqq5yjahb8u.fsf@gitster.g>
 <YunxHOa2sJeEpJxd@coredump.intra.peff.net>
 <a9953278-b15f-fd76-17b0-e949c7937992@web.de>
 <YuquVEqEl6wxCLM7@coredump.intra.peff.net>
 <41477326-5493-4d3c-246d-8a28969fa73e@web.de>
 <Yu05GjncDaGRTgce@coredump.intra.peff.net>
 <6854c54c-12ff-f613-4cdc-18b3b1a55ef1@web.de>
 <b3310324-7969-f9fb-a2e0-46e881d37786@web.de>
 <Yu/5LU+ZhbVRnSdM@coredump.intra.peff.net>
Content-Language: en-US
In-Reply-To: <Yu/5LU+ZhbVRnSdM@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jm7bR04Np0m4U6HBDLipWaAJ2smKwVZATcBunWcocRVqyaHYIim
 HeNRPm6o5JdRoFibq6simIHNaQ45y2W6c2m4yjxYysTX/V/kmcZIKg9Ad7qQqpCUeZ+AUAx
 Xf2fsxHENPRyCh5/ffEzFNRbvyFKsydY/iO8W6XPrbw3g4H7iTV1vFqAFVsKZXC6uaNaHV9
 z700F6m+/ZldqqbcNGkXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8jEZXkNHIZw=:053edw+AgXtAZ6t0+2Gpgb
 YhE9g/rNOJU6fae4mxguEqBvYImbg2B1DQx+1NJuj/OvKuSsf+pggfP8/p/zVQGvtuDlqD1ft
 jHNAEoaEOEaw4k3h4ulsxn+WbAxXG/kJCAVIsi0ZTU4iohHoo3O/knRy/PtIa68X0hlRQQnkQ
 +49kBDu5SqmRqqxaNzlvvGuxF7XkGVmODgyVd6AZBKD+rKAT/J7L57QHwjGt7L7zLoJQymUsh
 nFlcnqff0Uuw2qbOOwEgTvI65LqzKXHOm6HPBFTySIXm2oRrKjWT5v1w9M0X8Fd2qcew+AC5J
 JCufxXGAbRMeN3zcIsl0dczPX7v1NjC15hnfYH6Cr5nEgiRCF0grrjxOkXbuJbUWekRgnR/5F
 2E07GNLEQJJJT5lfHiN6obLaiOsllV3AXxCYgjscwco4JUdnFJwa7YlsGq/H+OriajZKr9E0b
 h6iYnz058/WPxyAgX2x3NzFCzbHw4B3H3dR2oSCZlqAq0I0CHfnM5NzrRnzED8A6kFY3Kk09+
 N8/CLsstrBHrklNx09kQ0MCCLykMCMMebkVawOVeIpiAKNrg/DmUf4d0sz74WEmwyBywZb/C0
 YYs7ZWlk/ItsPGjbERakF4Zmy4JMIMxcHtqpgpSbpHihosxWyfwyAz9ADboq4QKcy8eObWg+u
 yPeAh9N7epI/o6MJIYd+dfp5stPHwWHWUFF6sahfNqYcO0ZfUzU3gyZuc0AjdLBPkK1eeQ4d6
 QeQvm6UV6iSD0Sg9ryewLaA9Lteg7Rll4JJwI9qLqudiEc9qZputGCr0T2jI9RwXD5AsFNeBr
 2wVQ9D69pL7xSYBIVZvLbVGBFHTDnisXIlIjxv2hys4kg04MCU5zYj2L6f4lW181HGJRUx0ul
 6AqicfKo+i5SBqNX/BJ7vFFHVOyTYXlOptZYRFDY6jaf9GyIyjt4YP+e60yNqTCU4bno/+RiC
 7rgTBJuwmkEbQdhiyhrbTEE5GKgstvfMlczNg9Jki2lH7Y/YF5RpzhDTDocthzAtoEEGqjofb
 6dQ35hb7wtXRUc/p2Z0FkDmKPL/1yurRf5wG/9jmV2v/0eBTE86TO1k+4tFUxxBJ4eeOEmX2n
 YoqL/qsY+QVLthVWUtzO19P1YXaazArEVBJ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.08.22 um 19:41 schrieb Jeff King:
> On Sun, Aug 07, 2022 at 12:15:06PM +0200, Ren=C3=A9 Scharfe wrote:
>
>>> This adds "error: pumping io failed: No space left on device" to outpu=
t.
>>> Which kinda makes sense: With the pipe no longer blocking, there can b=
e
>>> a moment when the buffer is full and writes have to be rejected.  This
>>> condition should be reported with EAGAIN, though.
>>>
>>> Adding "if (len < 0 && errno =3D=3D ENOSPC) continue;" after the xwrit=
e()
>>> call in pump_io_round() lets the test pass.
>>>
>>> Perhaps the translation from Windows error code to POSIX is wrong here=
?
>>
>> So if we fix that with the patch below, t3701.57 still hangs, but this
>> time it goes through wrapper.c::handle_nonblock() again and again.
>> Replacing the "errno =3D EAGAIN" with a "return 0" to fake report a
>> successful write of nothing instead lets the test pass.
>>
>> This seems to make sense -- looping in xwrite() won't help, as we need
>> to read from the other fd first, to allow the process on the other end
>> of the pipe to make some progress first, as otherwise the pipe buffer
>> will stay full in this scenario.  Shouldn't that be a problem on other
>> systems as well?
>
> It doesn't happen on Linux; I suspect there's something funny either
> about partial writes, or about poll() on Windows. What's supposed to
> happen is:
>
>   1. pump_io() calls poll(), which tells us the descriptor is ready to
>      write
>
>   2. we call xwrite(), and our actual write() call returns a partial
>      write (i.e., reports "ret" bytes < "len" we passed in)
>
>   3. we return back to pump_io() do another round of poll(). If the
>      other side consumed some bytes from the pipe, then we may get
>      triggered to do another (possibly partial) write. If it didn't, and
>      we'd get EAGAIN writing, then poll shouldn't trigger at all!
>
> So it's weird that you'd see EAGAIN in this instance. Either the
> underlying write() is refusing to do a partial write (and just returning
> an error with EAGAIN in the first place), or the poll emulation is wrong
> (telling us the descriptor is ready for writing when it isn't).

You're right, Windows' write needs two corrections.  The helper below
reports what happens when we feed a pipe with writes of different sizes.
On Debian on WSL 2 (Windows Subsystem for Linux) it says:

   chunk size: 1 bytes
   65536 total bytes written, then got EAGAIN
   chunk size: 1000 bytes
   64000 total bytes written, then got EAGAIN
   chunk size: 1024 bytes
   65536 total bytes written, then got EAGAIN
   chunk size: 100000 bytes
   0 total bytes written, then got a partial write of 65536 bytes
   65536 total bytes written, then got EAGAIN

On Windows directly I get:

   chunk size: 1 bytes
   8192 total bytes written, then got ENOSPC
   chunk size: 1000 bytes
   8000 total bytes written, then got ENOSPC
   chunk size: 1024 bytes
   8192 total bytes written, then got ENOSPC
   chunk size: 100000 bytes
   0 total bytes written, then got ENOSPC

https://pubs.opengroup.org/onlinepubs/9699919799/functions/write.html
documents what we should get: Writes smaller than the buffer should
be atomic, bigger writes bigger should be broken up, and the error code
for a full buffer should be EAGAIN.  I.e. the first example is right.
So mingw_write() needs to translate ENOSPC to EAGAIN and break up huge
writes instead of giving up outright.

> Can you instrument pump_io_round() (or use some strace equivalent, if
> there is one) to see if we do a successful partial write first (which
> implies poll() is wrong in telling us we can write more for the second
> round), or if the very first write() is failing (which implies write()
> is wrong for returning EAGAIN when it could do a partial write).

The two corrections mentioned above together with the enable_nonblock()
implementation for Windows (and the removal of "false") suffice to let
t3701 pass when started directly, but it still hangs when running the
whole test suite using prove.

I don't have time to investigate right now, but I still don't
understand how xwrite() can possibly work against a non-blocking pipe.
It loops on EAGAIN, which is bad if the only way forward is to read
from a different fd to allow the other process to drain the pipe
buffer so that xwrite() can write again.  I suspect pump_io_round()
must not use xwrite() and should instead handle EAGAIN by skipping to
the next fd.

Ren=C3=A9

=2D--
 Makefile                 |  1 +
 t/helper/test-nonblock.c | 51 ++++++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c     |  1 +
 t/helper/test-tool.h     |  1 +
 4 files changed, 54 insertions(+)
 create mode 100644 t/helper/test-nonblock.c

diff --git a/Makefile b/Makefile
index d9c00cc05d..0bc028ca00 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -751,6 +751,7 @@ TEST_BUILTINS_OBJS +=3D test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS +=3D test-match-trees.o
 TEST_BUILTINS_OBJS +=3D test-mergesort.o
 TEST_BUILTINS_OBJS +=3D test-mktemp.o
+TEST_BUILTINS_OBJS +=3D test-nonblock.o
 TEST_BUILTINS_OBJS +=3D test-oid-array.o
 TEST_BUILTINS_OBJS +=3D test-oidmap.o
 TEST_BUILTINS_OBJS +=3D test-oidtree.o
diff --git a/t/helper/test-nonblock.c b/t/helper/test-nonblock.c
new file mode 100644
index 0000000000..c9288ea6ac
=2D-- /dev/null
+++ b/t/helper/test-nonblock.c
@@ -0,0 +1,51 @@
+#include "test-tool.h"
+#include "compat/nonblock.h"
+
+static void fill_pipe(size_t write_len)
+{
+	void *buf =3D xcalloc(1, write_len);
+	int fds[2];
+	size_t total_written =3D 0;
+	int last =3D 0;
+
+	if (pipe(fds))
+		die("pipe failed");
+	if (enable_nonblock(fds[1]))
+		die("enable_nonblock failed");
+
+	printf("chunk size: %"PRIuMAX" bytes\n", write_len);
+	for (;;) {
+		ssize_t written =3D write(fds[1], buf, write_len);
+		if (written !=3D write_len)
+			printf("%"PRIuMAX" total bytes written, then got ",
+			       (uintmax_t)total_written);
+		if (written < 0) {
+			switch (errno) {
+			case EAGAIN: printf("EAGAIN\n"); break;
+			case ENOSPC: printf("ENOSPC\n"); break;
+			default: printf("errno %d\n", errno);
+			}
+			break;
+		} else if (written !=3D write_len)
+			printf("a partial write of %"PRIuMAX" bytes\n",
+			       (uintmax_t)written);
+		if (last)
+			break;
+		if (written > 0)
+			total_written +=3D written;
+		last =3D !written;
+	};
+
+	close(fds[1]);
+	close(fds[0]);
+	free(buf);
+}
+
+int cmd__nonblock(int argc, const char **argv)
+{
+	fill_pipe(1);
+	fill_pipe(1000);
+	fill_pipe(1024);
+	fill_pipe(100000);
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 318fdbab0c..562d7a9161 100644
=2D-- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -45,6 +45,7 @@ static struct test_cmd cmds[] =3D {
 	{ "match-trees", cmd__match_trees },
 	{ "mergesort", cmd__mergesort },
 	{ "mktemp", cmd__mktemp },
+	{ "nonblock", cmd__nonblock },
 	{ "oid-array", cmd__oid_array },
 	{ "oidmap", cmd__oidmap },
 	{ "oidtree", cmd__oidtree },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index bb79927163..d9006a5298 100644
=2D-- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -36,6 +36,7 @@ int cmd__lazy_init_name_hash(int argc, const char **argv=
);
 int cmd__match_trees(int argc, const char **argv);
 int cmd__mergesort(int argc, const char **argv);
 int cmd__mktemp(int argc, const char **argv);
+int cmd__nonblock(int argc, const char **argv);
 int cmd__oidmap(int argc, const char **argv);
 int cmd__oidtree(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
=2D-
2.37.1
