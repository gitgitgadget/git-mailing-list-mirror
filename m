Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33012C19F2A
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 10:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiHGKPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Aug 2022 06:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbiHGKPc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Aug 2022 06:15:32 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70816431
        for <git@vger.kernel.org>; Sun,  7 Aug 2022 03:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1659867297;
        bh=YunoSIjK/ETFOdBB2S++5eW75ptOxOrNtjkvMARUfGc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=agxALR51VHL7TkFvW0/db8Xt4DR3fOdoNQfVdmYxr4Rrg8C16D/P9tMQrdz93AGW0
         /72JCYgnnvXCVnoicvbrFaoraaNfB7VtsQ1oOqhFKDdMwzDAYa08+X8wWeT7t3fDl1
         Jv+Z6w/Qa3xLWNKduD7eAIFtxYubQYJH6TXXUkPg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.35] ([79.203.16.122]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHmq2-1oEbh90NSI-00FHY4; Sun, 07
 Aug 2022 12:14:57 +0200
Message-ID: <362560ca-1e37-bab3-e508-4d5bf5429e66@web.de>
Date:   Sun, 7 Aug 2022 12:14:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
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
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Yu05GjncDaGRTgce@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bt5nPTe+EtrFjo8+AOHnAG3nLVjyCJHX/EuTLbhKktYfkCN3TSK
 djQwpEgEMNhLxW4mq0qj4YKZS1R4+LJyzG5KLzwG2ssl1MZiIpCCydwH3LVAaz8n/dKL6e5
 zNTY2S8u10E6pz6LxDWGn/ZLRX8WJQQhvUNnD1TMDCDEJDIuYLlauViIhKNsPcHbsiTJaOt
 PI/p3l82abL3mBGcm1i5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MilDSKnSRhU=:AAzrpAYDM/Kyc5eCtGku0c
 WwDXVD6CIWZoGkJWtO8GIIMOcznZX//N8qT95zRrWVXY4hBScbAa6y9rIo5YwpfvOApiE0cAX
 aL8iRWLshgaPVaBmRARNu5IvxSnjJeq8Lg4L3EzEpesBW6Ik8TyvuoPpxi3DDyBLp9kc/3B16
 ka95wgUxP4AUJG4vAjFqWtxdRS952HyeL96yz73rPrrzC8qKHzOzZJf67YmWhTv7HlJTPNIbe
 KHbX71FP+6UksdbnNPA82JBMufej3Ne/uevJRl5mHzB50tFxZ+yv2nrpByNQQI4mZi8EyKkDu
 HxJvEFSQJjDTp3J3H3GraU6UQnh7Nu0+UgAGbFhCCUpjuZZ9WuzCK9fRJf0+kKjO6RqvO/Pfr
 nlMZMI8g17FcTJQ9ael7NHMpHR8WMxfK+6+dIyMoApGPjiS56xukl6o/Puqt57z7GLdSgNVNo
 /TcVKWdet2XGoVdyrlROeWCXTH+81xRwW/3PHYfrQ2ndA3gFrah/zgmhrPXod0qWl8iQpZrYg
 spoxWTC6vjsUn7dJfEd+KrWvtxsEvRijt6ekUtvS+nRB8BMXgOjnjA6sd5QL8faxVL8SN33i/
 Uw7oUoXTxuqTExG2sRGGOppGPJ5VZFjRRjt1BDh646acZt27fR+BdcffKO0DwyLXNOqNoNE0+
 4q/wEy0k2lZTEk5FK0oXW0bcRovlGTOd6wDks/Kn/j72seHAlqofXvNLImlfCjfkzpP79rTx1
 RrVsmARhZx8sK+vvY+ksO/N+cDpi0gcPePh4t8YJdShvg4oYseY3KpAE/u/fM+fyzL/nyjZK/
 agSalTH06SFLtQd6Z/nRcXodbei0i2yyoo8UNVWQ2F1R6m+kzWGa4vLlmCEojAgAOlbpAYwZv
 FfEO3onQpPJbQzsmuRV8BmxPMPkak95sR7Q4jHvt1NXAoHOZn0kxBjh4khNlWbHz3+ryJTYA7
 Gzf7FqTecrf8YTAWwY1zXiTEoQkFUSHp1S62iL99GRHynLldazIvmhnetBVig/MY1PVGX05z5
 p3aqJF7l5orA1KEUWzRF4KJvz48AXp8EJVKnIJOEP4y4Ughmi1ugm9VNUbogSe9I7GAt3KmGT
 DqNlwyPuVdmlUas0tn4zANulCcATk1UQfI2
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.08.2022 um 17:36 schrieb Jeff King:
> On Wed, Aug 03, 2022 at 11:56:13PM +0200, Ren=C3=A9 Scharfe wrote:
> >>  int enable_nonblock(int fd)
>>  {
>> +	DWORD mode;
>> +	HANDLE handle =3D winansi_get_osfhandle(fd);
>> +	if (!handle)
>> +		return -1;
>> +	if (!GetNamedPipeHandleState(handle, &mode, NULL, NULL, NULL, NULL, 0=
))
>> +		return -1;
>> +	if (mode & PIPE_NOWAIT)
>> +		return 0;
>> +	mode |=3D PIPE_NOWAIT;
>> +	if (!SetNamedPipeHandleState(handle, &mode, NULL, NULL))
>> +		return -1;
>>  	return 0;
>>  }
>
> This looks plausibly correct to me. ;) We might want to change the name
> of the compat layer to enable_pipe_nonblock(), since one assumes from
> the function names this only works for pipes.

Or how about this?  Squashable.  Needs testing.

=2D-- >8 ---
Subject: [PATCH] nonblock: support Windows

Implement enable_nonblock() using the Windows API.  Supports only named
and anonymous pipes for now, which suffices for the current caller.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 compat/nonblock.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/compat/nonblock.c b/compat/nonblock.c
index 897c099010..78923cd2c3 100644
=2D-- a/compat/nonblock.c
+++ b/compat/nonblock.c
@@ -14,9 +14,40 @@ int enable_nonblock(int fd)

 #else

+#ifdef GIT_WINDOWS_NATIVE
+
+#include "win32.h"
+
+int enable_nonblock(int fd)
+{
+	HANDLE h =3D (HANDLE)_get_osfhandle(fd);
+	DWORD mode;
+	DWORD type =3D GetFileType(h);
+	if (type =3D=3D FILE_TYPE_UNKNOWN && GetLastError() !=3D NO_ERROR) {
+		errno =3D EBADF;
+		return -1;
+	}
+	if (type !=3D FILE_TYPE_PIPE)
+		BUG("unsupported file type: %lu", type);
+	if (!GetNamedPipeHandleState(h, &mode, NULL, NULL, NULL, NULL, 0)) {
+		errno =3D err_win_to_posix(GetLastError());
+		return -1;
+	}
+	mode |=3D PIPE_NOWAIT;
+	if (!SetNamedPipeHandleState(h, &mode, NULL, NULL)) {
+		errno =3D err_win_to_posix(GetLastError());
+		return -1;
+	}
+	return 0;
+}
+
+#else
+
 int enable_nonblock(int fd)
 {
 	return 0;
 }

 #endif
+
+#endif
=2D-
2.37.1.windows.1
