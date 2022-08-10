Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F184C25B0C
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 05:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiHJFkF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 01:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiHJFkD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 01:40:03 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF20382F90
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 22:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1660109989;
        bh=Hz02X3dRop4idY5wKmFhNKPLBEowqIrt6gYHv/jC6CQ=;
        h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:In-Reply-To;
        b=DcAFa2E+18zlOn6IQ2Pzq/Uru1spfP8q/LvOWlyNb2W+fihA3A55fRsc2hZ0asW7f
         5JDasqJBFj0gcRvCtFq67HkgpxgUOhDGrirjXUhkCjXgcN9HZqqwp57uek4KGx3V90
         6eZacC/UtE3dCSNO8K7BwbUno6A/uvw5X428GxyY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.35] ([79.203.28.61]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYLig-1nqHwt0Lbe-00VdiC; Wed, 10
 Aug 2022 07:39:49 +0200
Message-ID: <72d007c5-9429-1612-24d7-af5db906dd63@web.de>
Date:   Wed, 10 Aug 2022 07:39:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] mingw: handle writes to non-blocking pipe
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
X-Provags-ID: V03:K1:pgC29J1Lk6RW5mDulXYtTJjh0BnlymGiFhul+QrYucxHV3TUrjx
 Svvddpl2hmk4luS3Q7cctlwQcGA9RrYcTcXACS85KCzYjUHqogjKhINiYm6O2vQID9hdIP8
 WZgCR+Ybd0oZgL6JIkAAxO7Y7U0PALaN8NiWasZ51C+H3KtA+jbhdlWLK50UEA+6Cv7jSr3
 vGbjB4WOk40Aa7gsb88yg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sRNaoMr6UHc=:SFAOw+qFP8+dm+uavLoPr4
 /bZpmopHaD6epKZP+7LhTr2UUvdxvFcQDY3SrEYLLEZkjISh27xOvrRd26dz47QwgF+izs72S
 4OBBjX0HDZb5+N5mCarxeNDfAuiTEl7gTdxyTYHuLGMK5hRuIm17GgdTDXEpaIdeb2xhqJ1/+
 BltBiHUfqElXcsgPQjhJVzwqS769VEAIQZCTq0JK35McfTuDWq/xRIeyQzqi3lJdRE+Iyt5Bb
 HZXaorjffN96eOwEx+4k8YGkRp/bD0Q2x27N61PjWmwx91I3Sx9Cy7y1iTkDlO612Mp1WPQLr
 kwhLwDN0NHLXOj3TqU80zsHBp5tSDG2ZEx3vnRwXJns/V9ActLGhlPkfG1zBNWdFXZjfOlTZn
 KlQ7bpQiOT6PiGbm1gnIq48RUj3ZBDFssL+MstkCUSMI16ckJLo24WqXwBu4piWxvtX6LwLcv
 3L+TA9WBIVF3AfAYRGhmFkSOclqC9+R+CKtWGMvHgfgL/kD1btqyIubtXfsifoeBqBTOkidS1
 Oar7AhY7qO7Nn0cLUXlr1uHjnfsk4hAoTL7xQK4+8EEfB54WO2TUYy1Qlm8VFbwi5zf6fwh+K
 mFccd5MJSRzB1+EsFTINj5M/3xGGR00tk83x55AxxPjYbUeHKA5BKmc1WfGaI1gf+5lSXZ3VV
 4/GCf0CpKYpblOLMvMFjBGvdMeWALjTKpOMLB/JFdnP6h/tk2st4rCmap/u2+/TxvOaUpqDMN
 FOFZx+ycaBRjW14j5mvbkG0Imwct7alcvgmtcWKod+F+x2ieOLbUlClIig8i1Mrq7MKsZxyZH
 q98vfvS9T3kbE1uFI2TcrGqQFw7AY+MJmIGcXf9s61RI5sZI3kgKgxvw578ngmNtmnjrCBirV
 hFA9Rlb2WmJoBQVO/ZtTAuGpaZ2wjzV3/hih/4cGFL1BH4ErjbPWllmGAtjIuQhVhRbGsxoPA
 1IPaFo8rA1ub3gCzuOqjajM3r6H1mjHaXrf6aHWd6LMW5Aqy+MddbK+TPlHyPySkf1/64q7BA
 FqRu5u9ndfczco3YgXW2fCzs1rDnBTfj8+slntWfFHz+0wQci7IaUJj4vnoeCvdRXsV1aK+Fd
 GCY2tbXvDA1yB3kQMR7zDdBADnzAnhyfmR3
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

write() on Windows reports ENOSPC when writing to a non-blocking pipe
whose buffer is full and rejects writes bigger than the buffer outright.
Change the error code to EAGAIN and try a buffer-sized partial write to
comply with POSIX and the expections of our Git-internal callers.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 compat/mingw.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index b5502997e2..c6f244c0fe 100644
=2D-- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -689,6 +689,8 @@ int mingw_fflush(FILE *stream)
 	return ret;
 }

+#define PIPE_BUFFER_SIZE (8192)
+
 #undef write
 ssize_t mingw_write(int fd, const void *buf, size_t len)
 {
@@ -702,6 +704,21 @@ ssize_t mingw_write(int fd, const void *buf, size_t l=
en)
 		else
 			errno =3D EINVAL;
 	}
+	if (result < 0 && errno =3D=3D ENOSPC) {
+		/* check if fd is a non-blocking pipe */
+		HANDLE h =3D (HANDLE) _get_osfhandle(fd);
+		DWORD s;
+		if (GetFileType(h) =3D=3D FILE_TYPE_PIPE &&
+		    GetNamedPipeHandleState(h, &s, NULL, NULL, NULL, NULL, 0) &&
+		    (s & PIPE_NOWAIT)) {
+			DWORD obuflen;
+			if (!GetNamedPipeInfo(h, NULL, &obuflen, NULL, NULL))
+				obuflen =3D PIPE_BUFFER_SIZE;
+			if (len > obuflen)
+				return mingw_write(fd, buf, obuflen);
+			errno =3D EAGAIN;
+		}
+	}

 	return result;
 }
@@ -1079,7 +1096,7 @@ int pipe(int filedes[2])
 	HANDLE h[2];

 	/* this creates non-inheritable handles */
-	if (!CreatePipe(&h[0], &h[1], NULL, 8192)) {
+	if (!CreatePipe(&h[0], &h[1], NULL, PIPE_BUFFER_SIZE)) {
 		errno =3D err_win_to_posix(GetLastError());
 		return -1;
 	}
=2D-
2.37.1.windows.1
