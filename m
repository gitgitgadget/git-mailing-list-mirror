Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8F6C25B0C
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 17:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbiHKRgJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 13:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbiHKRgB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 13:36:01 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3646D9C4
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 10:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1660239344;
        bh=E0n7/bjb3xFqfm1A/FNIK9yUkzNRAT669yNcGfcIf0w=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=P9vpBQ41X0iyG+sdc5iSZPLnQ7W3/EZ5+eJjCH+6OkCI/ScZbXX4PrQ4sO5jZTjSR
         +tAuX4h14B9E5rftCIXsWs3dbxU/gueXr6p6fcSalkbz59+NesBCXXwRS+YuVG1RNY
         5At21FW+cP+FiN1rY2LDmFz6vYg6FE/cMezTrbUM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.35] ([79.203.28.61]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSZI5-1nxkFK3wdd-00SoQd; Thu, 11
 Aug 2022 19:35:43 +0200
Message-ID: <976ac297-28ec-0a38-c4e1-eb7b94d0eb8c@web.de>
Date:   Thu, 11 Aug 2022 19:35:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] mingw: handle writes to non-blocking pipe
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <a9953278-b15f-fd76-17b0-e949c7937992@web.de>
 <YuquVEqEl6wxCLM7@coredump.intra.peff.net>
 <41477326-5493-4d3c-246d-8a28969fa73e@web.de>
 <Yu05GjncDaGRTgce@coredump.intra.peff.net>
 <6854c54c-12ff-f613-4cdc-18b3b1a55ef1@web.de>
 <b3310324-7969-f9fb-a2e0-46e881d37786@web.de>
 <Yu/5LU+ZhbVRnSdM@coredump.intra.peff.net>
 <72d007c5-9429-1612-24d7-af5db906dd63@web.de>
 <YvQO4ZYI8/fAk0Gj@coredump.intra.peff.net>
 <77244ffe-41c1-65bd-8984-8ed6909ffe07@web.de>
 <YvTCIVN2VBir7WEP@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <YvTCIVN2VBir7WEP@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iuJuj1OST+dRtyiNFwnbQfnU9F8IbTqE6uQT2zVYjZqzm1+R0zL
 OPDWE8LMjCAU95JqQkMC3VC8sFuxljeq/t1xWsPl3AP+ItOo6fZDr8Grb+euejK9V+I0IX9
 G5j/3wlIZfSqKtwUd0w9QheEZf18RgBZCBlel1jNP+SlULIB6y4tvbpKhQRmrved9qaQcy1
 jFZrR94rbUczR40O3+MiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:frqn9uZeBIo=:abF8eQNdxPkFuIu2oGOqy5
 Cdqvh/a/1L4T2yoMfSnACx1VCVdFHhj9ixRL1C5njlmzevB6AX5aFcASMt6xyGomXg/KsBq4g
 X5nwKgZDGcCA3vHynN7qdqRz6czfmXZ9wOG6ABInTTLgH2a2yY3SyDQ8wfy4cdPGiviKh7EtD
 ltrARaTSy5HpSRuWAL/lJXu13AxBEe/neRC5G2koS/YRZ0O/8DU8RJ1SWbT8FGGK61kOrkt6q
 87bnwOpMWiQQbkMdSl4Ls0r0k0XywTEiXtXspQbBksVbJ8UX3klCL7I8Fu9PgeviMCZjsV+B0
 Z//21Wf4L0W1hnYczr0yhncSb/wUHsnFvVU3L+OpEOWgHv+O4zJhsF7S7C4Ms2MJ1FMUwvw6c
 O/1vLBCOAMWubB3n2WI4Czu8AQjdc4ycBTG8Klg3ftfZXZve1YUzYU6HzYKxxgl/0cogBnC2h
 gsfmLxM9RGlNkSsYlC4WxwkK7UvNYOs0rIYZrSY9ZidfPJDmmcVI+w2Kf9VMJFxPkID1QQSch
 cQWyDCYYKblRbZo4XeOX8r3Hi8Mx0VonhC0nalvNc2JJEKNCRq38GTd7EcS24X8bDzaQRqfF9
 kIxsv1nw49dEFPxFp1y2p/wNczb8tPOUStDxbwK1HXGpLzoaY6CNn5ZGFO+pvcmtdRRcmYJpr
 ZFuuUlz3r/qqnxj5Y3i2PA1ZxIp/clbto+Ka/9nw9gOWsOxis9QwewfKORsaACKfXzyjjqol6
 2TU6xeuHQb4/LJz5Vhi9hj6bC3jmVNL1QcBhbU9T4UMsMeOLivdB2rjr2Qe3c6lYTLB7pgQZU
 XMf+M2+oeXZ+WAQtuEKMuA44LsiTkuH+vhmyobOdIDQCSmfvaNDh2K5TRNA8wjfMh3Tr6yPsH
 Oi/pOjEliPJ//pToptZ6vD7/FbyG7Um06+POvSVR3B+A9zlsM4lWdKGiUfSkQ5B5gNRHtt1jJ
 6XoriR6Q7IKoKCY44rcFsrDMS3qIgRwL9BQ4AIQRuEHPenQ+AL3bUyb4lKvUfqFOGdAL91u8L
 bW9Uc5GeD7knIONmIN/gF+Z312aY/897QRZJP//dtXdLo/I7/nqseRN6kU67OV8MeIH6sDo2K
 kCRYfMcWjY4rJqm29SLUVD5cW9ha8Qu427d
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.08.2022 um 10:47 schrieb Jeff King:
> On Thu, Aug 11, 2022 at 12:34:46AM +0200, Ren=C3=A9 Scharfe wrote:
>
>>> OK, so we call GetNamedPipeInfo() to find the size of the pipe buffer.
>>> It's unclear to me from Microsoft's docs if that is the _total_ size, =
or
>>> if it's the remaining available size. Hopefully the latter, since none
>>> of this works otherwise. ;)
>>>
>>> But two corner cases:
>>>
>>>   - If we fail to get the size, we guess that it's the maximum. Is thi=
s
>>>     dangerous? I'm not sure why the call would fail, but if for some
>>>     reason it did fail and we can't make forward progress, would we
>>>     enter an infinite recursion of mingw_write()? Would it be safer to
>>>     bail with EAGAIN in such a case (through granted, that probably ju=
st
>>>     puts us into an infinite loop in xwrite())?
>>
>> AFAIU it's the total size, not the available space.  I think I confused
>> it with PIPE_BUF, which we should use instead.
>
> Hmm. If it's giving us the total size, that seems like it may fail in a
> case like this:
>
>   - we write a smaller amount to the pipe, say 7168 bytes. That leaves
>     1024 bytes in the buffer. The reader reads nothing yet.
>
>   - now we try to write another 4096 bytes. That's too big, so we get
>     ENOSPC. But when we ask for the pipe size, it tells us 8192. So we
>     _don't_ try to do a partial write of the remaining size, and return
>     EAGAIN. But now we've made no forward progress (i.e., even though
>     poll() said we could write, we don't, and we end up in the xwrite
>     loop).
>
> So we really do want to try to get a partial write. Even a single byte
> means we are making forward progress.
>
>> Alternatively we could retry with ever smaller sizes, down to one byte,
>> to avoid EAGAIN as much as possible.  Sounds costly, though.
>
> It's definitely not optimal, but it may not be too bad. If we cut the
> size in half each time, then at worst we make log2(N) extra write
> attempts, and we end up with a partial write within 50% of the optimal
> size.

OK, but we can't just split anything up as we like: POSIX wants us to
keep writes up to PIPE_BUF atomic.  When I read that name I mistakenly
thought it was the size of the pipe buffer, but it's a different value.
The minimum value according to POSIX is 512 bytes; on Linux it's 4KB.

And Windows doesn't seem to define it.  Bash's ulimit -p returns 8,
which is in units of 512 bytes, so it's 4KB like on Linux.  But that's
apparently not respected by Windows' write.

I just realized that we can interprete the situation slightly
differently.  Windows has effectively PIPE_BUF =3D 2^32, which means all
writes are atomic.  I don't see POSIX specifying a maximum allowed
value, so this must be allowed.  Which means you cannot rely on write
performing partial writes.  Makes sense?

If we accept that, then we need a special write function for
non-blocking pipes that chops the data into small enough chunks.

Another oddity: t3701 with yesterday's patch finishes fine with -i, but
hangs without it (not just when running it via prove).  O_o

Ren=C3=A9
