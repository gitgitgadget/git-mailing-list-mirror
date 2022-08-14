Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049ACC25B06
	for <git@archiver.kernel.org>; Sun, 14 Aug 2022 15:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241348AbiHNP52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 11:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242194AbiHNPyE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 11:54:04 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBAB32EC2
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 08:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1660491429;
        bh=rTQcjmUwd0bnmQIHqpn2J0btO/pkAd3nmuMV96aQQPs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=NwnfdKWi9LK6kqXDladwXEXii+HSC9Lhy2LJCH9PxttXW6Vd/aiyN1AxUyyLfGDTz
         8L4pCKwRNC2jfk4+QLSXk+snDfftEpS3dqtrA36Ikds93DiFt2yPMpI5Mmf974BP+/
         YBQ5GdFU/Tt3+/xHpz78gHFbtsN79ffwUHAeClhI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.34] ([91.47.147.35]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTOha-1nvrS52cG4-00TyyY; Sun, 14
 Aug 2022 17:37:09 +0200
Message-ID: <c7c6524c-4f02-10f6-1a58-738cef5aecf2@web.de>
Date:   Sun, 14 Aug 2022 17:37:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] mingw: handle writes to non-blocking pipe
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <41477326-5493-4d3c-246d-8a28969fa73e@web.de>
 <Yu05GjncDaGRTgce@coredump.intra.peff.net>
 <6854c54c-12ff-f613-4cdc-18b3b1a55ef1@web.de>
 <b3310324-7969-f9fb-a2e0-46e881d37786@web.de>
 <Yu/5LU+ZhbVRnSdM@coredump.intra.peff.net>
 <72d007c5-9429-1612-24d7-af5db906dd63@web.de>
 <YvQO4ZYI8/fAk0Gj@coredump.intra.peff.net>
 <77244ffe-41c1-65bd-8984-8ed6909ffe07@web.de>
 <YvTCIVN2VBir7WEP@coredump.intra.peff.net>
 <976ac297-28ec-0a38-c4e1-eb7b94d0eb8c@web.de>
 <YvVIYyA8Js0WDAMc@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <YvVIYyA8Js0WDAMc@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ig2YRA/WGRpxEhgpZ+Ly1flR3oizOmFjiuOy6DREETuR9732xfQ
 P6CtBefHTFo1g8OvaWgzc1HUQCb93TY+fXxTK+O3/nxW4BWrOC5k3ykhXczcBM/j76mAGcj
 cINu2taX+gaFP7dBvJ1EgLgT1YVf78FuB1R5j6l6VOYY69DIf4D5a5aDlVVjv+jbnovRt2j
 xBnU1Ku47HnTSbtX/dCCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KVeiUdXJo28=:bbmdNWFsjX20/eNK+aSQ6Q
 HawE3siVhihee2RNknFpY+rypdteve/Vs7JxrMyT1llA4Xxp4Xr9PBhBEG6nlqCDxFr+5KgZB
 2jhgTRG03F7/L7sBgcuoU6/QRNE7U6ArRfrCw9dwamFBV5xXWLfME2fybV9LyTYCdiFOhFD/9
 9F3g1svNp8tlkkG54qzgUnpeV2T7RMGjEXum+1ySUO77uEitH07DkYiATpB+KBP2JcyrFe9Jo
 DvaGKw9pIZOpAfRtY9ty9JYOtxj18rPNVcziLwuoKHbV8Jvn9jHKe/9udg++6cf9qr59KItIA
 76kxjvdeqXqPVuVVzYNc3irSbCydOwAG3CKcKy8N+nowfaUF1b7eY/GhWKihFIOEZj0EafOyb
 eydXB7ZhRkWXUUXTDT6l1B0F/PN9SYNMd2MMnQIcSniOF1V0hc79xwISoxDKb6Xy84Gf8CL97
 YYPQW8z8zY8mBkc0Z1irwUgR3SMzvPKzpVnAOKg1MvNr0qFAM2EkqJOw3nNJcV6of5uhr9iC1
 cJ3UcfMTjQr3V1vqtf9cPlU/F70yfBRF1kUCuK5/vvTi1B27n+gYK6hBe+8lIiMh1XsZK7uoP
 ed2S7trM6DjVLlqGNs+2837pW5+R1WkyHm7qRpMT004y+pFN479fd6dp3mwzC5O4TBPGm+9SE
 rupE/kej+0ylLOXu16Cl62CIX4CCF5y/k8hIQ09HtLeqWfDIoW4RGQoOvDe0YTtTZS3ldt+ai
 7zf1inglz54RK7tbLABDr8rbYAkm0TnX4Ligckw3gbMLijResXo1wlfWhiKPxh7n4IFhme0Lv
 uio1cotpYceFyAvvk0xdGHXWGTRgTtGokHMpO24TmMN6mdeEl3+5V7HW+7Rm5YqyEgyHcE0hc
 IBn/Zl1TXcib1Xb2N4tZ8QTh7sVFUa1wY/j1VHgH1kMc3KQfn/3t/qglmN/2Pj7Yr8Q6zZ5o6
 AEnyOUNeMFUZT8Rx6D1Fpi/VjZFCn2SB/Sf6HJioNzBgCSSntSCriNp/nmDWs8lCZqM0iWRWI
 X7ACSJeWbRvSYLu4NA1v4pZFZDwBOP+aJm6qQbt+YLMdZmJ/blWYt5YiKfJUK3IPODx0oofLQ
 yinWYU7L6BJbEvig+lbNh33ndtAxitgxeVm
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.08.2022 um 20:20 schrieb Jeff King:
> On Thu, Aug 11, 2022 at 07:35:33PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> OK, but we can't just split anything up as we like: POSIX wants us to
>> keep writes up to PIPE_BUF atomic.  When I read that name I mistakenly
>> thought it was the size of the pipe buffer, but it's a different value.
>> The minimum value according to POSIX is 512 bytes; on Linux it's 4KB.
>>
>> And Windows doesn't seem to define it.  Bash's ulimit -p returns 8,
>> which is in units of 512 bytes, so it's 4KB like on Linux.  But that's
>> apparently not respected by Windows' write.
>>
>> I just realized that we can interprete the situation slightly
>> differently.  Windows has effectively PIPE_BUF =3D 2^32, which means al=
l
>> writes are atomic.  I don't see POSIX specifying a maximum allowed
>> value, so this must be allowed.  Which means you cannot rely on write
>> performing partial writes.  Makes sense?
>
> Hmm, I'm not sure. POSIX does allow writing a single byte if that's all
> the space there is, but only if the original _request_ was for more than
> PIPE_BUF. Which I guess matches what you're saying.
>
> If the original request is smaller than PIPE_BUF, it does seem to say
> that EAGAIN is the correct output. But it also says:
>
>   There is no exception regarding partial writes when O_NONBLOCK is set.
>   With the exception of writing to an empty pipe, this volume of
>   POSIX.1-2017 does not specify exactly when a partial write is
>   performed since that would require specifying internal details of the
>   implementation. Every application should be prepared to handle partial
>   writes when O_NONBLOCK is set and the requested amount is greater than
>   {PIPE_BUF}, just as every application should be prepared to handle
>   partial writes on other kinds of file descriptors.
>
>   The intent of forcing writing at least one byte if any can be written
>   is to assure that each write makes progress if there is any room in
>   the pipe. If the pipe is empty, {PIPE_BUF} bytes must be written; if
>   not, at least some progress must have been made.
>
> So they are clearly aware of the "we need to make forward progress"
> problem. But how are you supposed to do that if you only have less than
> PIPE_BUF bytes left to write? And likewise, even if it is technically
> legal, having a PIPE_BUF of 2^32 seems like a quality-of-implementation
> issue.
>
> And that doesn't really match what poll() is saying. The response from
> poll() told us we could write without blocking, which implies at least
> PIPE_BUF bytes available. But clearly it isn't available, since the
> write fails (with EAGAIN, but that is equivalent to blocking in POSIX's
> view here).

Turns out that's not the case on Windows: 94f4d01932 (mingw: workaround
for hangs when sending STDIN, 2020-02-17) changed the compatibility
implementation to 'Make `poll()` always reply "writable" for write end
of the pipe.'.

An updated version of the test helper confirms it (patch below) by
reporting on Windows:

chunk size: 1 bytes
 EAGAIN after 8192 bytes
chunk size: 500 bytes
 EAGAIN after 8000 bytes
chunk size: 1000 bytes
 EAGAIN after 8000 bytes
chunk size: 1024 bytes
 EAGAIN after 8192 bytes
chunk size: 100000 bytes
 partial write of 8192 bytes after 0 bytes
 EAGAIN after 8192 bytes

On Debian I get this instead:

chunk size: 1 bytes
 POLLOUT gone after 61441 bytes
 EAGAIN after 65536 bytes
chunk size: 500 bytes
 POLLOUT gone after 60500 bytes
 EAGAIN after 64000 bytes
chunk size: 1000 bytes
 POLLOUT gone after 61000 bytes
 EAGAIN after 64000 bytes
chunk size: 1024 bytes
 POLLOUT gone after 62464 bytes
 EAGAIN after 65536 bytes
chunk size: 100000 bytes
 partial write of 65536 bytes after 0 bytes
 POLLOUT gone after 65536 bytes
 EAGAIN after 65536 bytes

So on Windows the POLLOUT bit is indeed never unset.

> Lawyering aside, I think it would be OK to move forward with cutting up
> writes at least to a size of 512 bytes. Git runs on lots of platforms,
> and none of the code can make an assumption that PIPE_BUF is larger than
> that. I.e., we are reducing atomicity provided by Windows, but that's
> OK.
>
> I don't think that solves our problem fully, though. We might need to
> write 5 bytes, and telling mingw_write() to do so means it's supposed to
> abide by PIPE_BUF conventions. But again, we are in control of the
> calling code here. I don't think there's any reason that we care about
> PIPE_BUF atomicity. Certainly we don't get those atomicity guarantees on
> the socket side, which is where much of our writing happens, and our
> code is prepared to handle partial writes of any size. So we could just
> ignore that guarantee here.
>
>> If we accept that, then we need a special write function for
>> non-blocking pipes that chops the data into small enough chunks.
>
> I'm not sure what "small enough" we can rely on, though. Really it is
> the interplay between poll() and write() that we care about here. We
> would like to know at what point poll() will tell us it's OK to write().
> But we don't know what the OS thinks of that.

Based on the output above I think Linux' poll() won't consider a pipe
writable that has less than PIPE_BUF (4096) available bytes.

> Or maybe we do, since I think poll() is our own compat layer. But it
> just seems to be based on select(). We do seem to use PeekNamedPipe()
> there to look on the reading side, but I don't know if there's an
> equivalent for writing.

This has been elusive so far (see 94f4d01932).

Perhaps we should take the advice about PIPE_NOWAIT in the docs serious
and use overlapping (asynchronous) writes on Windows instead.  This
would mean reimplementing the whole pipe_command() with Windows API
commands, I imagine.

>> Another oddity: t3701 with yesterday's patch finishes fine with -i, but
>> hangs without it (not just when running it via prove).  O_o
>
> Yes, definitely strange. I'd expect weirdness with "-v", for example,
> because of terminal stuff, but "-i" should have no impact on the running
> environment.
It's especially grating because test runs also take very looong.

Avoiding xwrite() in pump_io_round() on top lets the test suite
finish successfully.

Ren=C3=A9


=2D--
 Makefile                 |  1 +
 t/helper/test-nonblock.c | 73 ++++++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c     |  1 +
 t/helper/test-tool.h     |  1 +
 4 files changed, 76 insertions(+)
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
index 0000000000..c9350ce894
=2D-- /dev/null
+++ b/t/helper/test-nonblock.c
@@ -0,0 +1,73 @@
+#include "test-tool.h"
+#include "compat/nonblock.h"
+
+static void fill_pipe(size_t write_len)
+{
+	void *buf =3D xcalloc(1, write_len);
+	int fds[2];
+	size_t total_written =3D 0;
+	int last =3D 0;
+	struct pollfd pfd;
+	int writable =3D 1;
+
+	if (pipe(fds))
+		die_errno("pipe failed");
+	if (enable_nonblock(fds[1]))
+		die_errno("enable_nonblock failed");
+	pfd.fd =3D fds[1];
+	pfd.events =3D POLLOUT;
+
+	printf("chunk size: %"PRIuMAX" bytes\n", write_len);
+	for (;;) {
+		ssize_t written;
+		if (poll(&pfd, 1, 0) < 0) {
+			if (errno =3D=3D EINTR)
+				continue;
+			die_errno("poll failed");
+		}
+		if (writable && !(pfd.revents & POLLOUT)) {
+			writable =3D 0;
+			printf(" POLLOUT gone after %"PRIuMAX" bytes\n",
+			       total_written);
+		}
+		written =3D write(fds[1], buf, write_len);
+		if (written < 0) {
+			switch (errno) {
+			case EAGAIN:
+				printf(" EAGAIN after %"PRIuMAX" bytes\n",
+				       total_written);
+				break;
+			case ENOSPC:
+				printf(" ENOSPC after %"PRIuMAX" bytes\n",
+				       total_written);
+				break;
+			default:
+				printf(" errno %d after %"PRIuMAX" bytes\n",
+				       errno, total_written);
+			}
+			break;
+		} else if (written !=3D write_len)
+			printf(" partial write of %"PRIuMAX" bytes"
+			       " after %"PRIuMAX" bytes\n",
+			       (uintmax_t)written, total_written);
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
+	fill_pipe(500);
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
2.37.1.windows.1
