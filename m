Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0833AC19F2B
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 21:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbiHCV4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 17:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbiHCV4d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 17:56:33 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA5C1EED8
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 14:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1659563774;
        bh=zNwaFW5z7GfTLqD7Ch+LZUlWsMNWKGNM87JJu1pr49U=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=M/AZuDJWfX8ifw06y69eNMmhf9ZYxVY66ld51MDTXbkJmpMe3VLawAoxjDGM6iTu9
         1gncY6uz3su28uS1oswrWGse92PXszaJc0oxrehYqIgey9aMMbNAHhzz3QwZxZf9Qo
         ZW/ytj073BjG5TU9YduwAhwm2DcgWI+rO78jz8mU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.35] ([91.47.148.139]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2gkl-1oHyEb248V-003xzH; Wed, 03
 Aug 2022 23:56:14 +0200
Message-ID: <41477326-5493-4d3c-246d-8a28969fa73e@web.de>
Date:   Wed, 3 Aug 2022 23:56:13 +0200
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
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <YuquVEqEl6wxCLM7@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:96JmwZ5LGgfShi9Hg803WlRKWIHQs73Ckh6l0uBydRY6CWHET9Y
 ZLizU2sAJO5BmBgAkTgsjFQ+841SGBm6mzSdWiBAi0ZoB+RcLhM2b70Vv2Sk6n7ylbkGNTw
 JPEv7J04WjFpH9hQ0tYbvxW2yrtWlfTu6RbFV1xsNGfhvnLmxM+b7VQKWGjydPMRml0EGJs
 T8PjRyff+rK+nUTpW4sjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/sCOf+VhXyw=:8hGiAovfjMBRB2zxlGbo8O
 0FEyLyApSNGqv4Cs0444fN4J9P5yFKVQOkkD0sl6XMqT9tqpjnh7uOAUgYcyQGAN7Z/64xrGi
 nTVF57BN62UtEcpjo9eaU/G4EzOl+BRZbLtpkcxeGJiYIx88UHNPb/5P7cpdChnKRbCrDk+wC
 1MFdE7pEGw2COp7ZFn4UipPHveao2XEGeqi9/lTqsVLkzuc/NxNrvlR1jQMGSEfgGtu96xNPY
 iMhFqU0O4O72BD3AKE/oAVQqs/QpRbIGRMyqgY3SaofjuzlZaK6VnppuFO3RybmXiKc35478a
 heZlqZzU1O/2KtjCzpgrVt7J7LtYbRRFK/2zspB6Delvalvho471Mi7UHbzZ8Rt9HhOa+/nIx
 oM77Cjpy0ALAdyQ+2OU4m4IROM/HymmlesRohXmqmBNAZOly4FoyM3L92itqKltzTfOtTC7Nl
 uh4I0ltEAFDPigCQLNA3tkVN0aaS3dymfXvUv/xgbTFJF8K5os2C18vzEhtIk35deDZNlnUH6
 FCI61v797E6VeTHnpeOqwj71OuUr+y8gUGH/agHJ7lagw1Q8j9S8VivWa7KPtFlerPq5L8MXJ
 y2gFhWSJDmI8Ms9FzvZ4hb6yd8AbK6LTSnEim7tJycWEMG91QtnV/Q7fy1ePkB9E8jrJSdEkH
 A4e2vI22qMdns6qOEVc3EWOXehBYsrG3+sq4cTlAhGYBALoa3cPQFX2NCauKO6CFCOYRIVv5v
 aTY/QZLnNYBBd2mPh94dm4kuvtDwtDybBr9Fge0eb4DLl0azvYWx44lIygpRxsqZvFPsqU6hD
 aA0p60BNtr6zCG25i2k/QpehGmFgdLWFmKzdAFXGDXuB+/LZaGqQdWgIjbMP7pAhWoKE4sb+f
 kx3ZckvvYh7b8ekQ6eQH86auWTfTiaPiDXw7x3rXM/ozm5E4TVCcz6QzMJ6oVzjmZ6hGGLOWQ
 llHH5VxPb+Q1tUSPhqvpmqeR37X/KD2u5nT4BATfPvHs5hlOET+9y4q1h89WCVGbjFSf2kExQ
 7PBtlQkMUVl8vzJPNUdnwP5ZSLC4P+vqyPWpfA5ony7pjlfe81SDRLR4Q4WqGPLcGFhbUXTu/
 ciAzFwFC7JUaPqmdL7lqaXqfaZf1nggBGZz
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.08.2022 um 19:20 schrieb Jeff King:
> On Wed, Aug 03, 2022 at 06:45:23PM +0200, Ren=C3=A9 Scharfe wrote:
>
>>> +test_expect_success 'handle very large filtered diff' '
>>> +	git reset --hard &&
>>> +	# The specific number here is not important, but it must
>>> +	# be large enough that the output of "git diff --color"
>>> +	# fills up the pipe buffer. 10,000 results in ~200k of
>>> +	# colored output.
>>> +	test_seq 10000 >test &&
>>> +	false &&
>>
>> Isn't this test going to end here, reporting failure before it even get=
s
>> to the interesting part?
>
> Urgh, whoops. That was from some last-minute tweaking of the comment.
> There was also a line:
>
>   git diff --color | wc -c
>
> before it so I could measure how big the output was for a few values.
>
> It snuck into the emailed patch, but the actual test runs (including the
> Windows CI) didn't include that (since obviously they'd have failed the
> test).

Without that line the added test hangs for me on the Git for Windows
SDK on Windows 11.

With the patch below it fails and reports basically nothing:

   expecting success of 3701.57 'handle very large filtered diff':
           git reset --hard &&
           # The specific number here is not important, but it must
           # be large enough that the output of "git diff --color"
           # fills up the pipe buffer. 10,000 results in ~200k of
           # colored output.
           test_seq 10000 >test &&
           test_config interactive.diffFilter cat &&
           printf y >y &&
           force_color git add -p >output 2>&1 <y &&
           git diff-files --exit-code -- test

   HEAD is now at 095e8c6 main
   not ok 57 - handle very large filtered diff
   #
   #               git reset --hard &&
   #               # The specific number here is not important, but it mus=
t
   #               # be large enough that the output of "git diff --color"
   #               # fills up the pipe buffer. 10,000 results in ~200k of
   #               # colored output.
   #               test_seq 10000 >test &&
   #               test_config interactive.diffFilter cat &&
   #               printf y >y &&
   #               force_color git add -p >output 2>&1 <y &&
   #               git diff-files --exit-code -- test
   #
   1..57

The file "output" contains "error: failed to run 'cat'".  This is
add-patch.c::parse_diff() reporting that pipe_command() failed.  So
that's not it, yet.  (I don't actually know what I'm doing here.)

=2D--
 compat/nonblock.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/compat/nonblock.c b/compat/nonblock.c
index 897c099010..030cf92af2 100644
=2D-- a/compat/nonblock.c
+++ b/compat/nonblock.c
@@ -14,8 +14,21 @@ int enable_nonblock(int fd)

 #else

+#include "win32.h"
+
 int enable_nonblock(int fd)
 {
+	DWORD mode;
+	HANDLE handle =3D winansi_get_osfhandle(fd);
+	if (!handle)
+		return -1;
+	if (!GetNamedPipeHandleState(handle, &mode, NULL, NULL, NULL, NULL, 0))
+		return -1;
+	if (mode & PIPE_NOWAIT)
+		return 0;
+	mode |=3D PIPE_NOWAIT;
+	if (!SetNamedPipeHandleState(handle, &mode, NULL, NULL))
+		return -1;
 	return 0;
 }

=2D-
2.37.1.windows.1


