Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A550C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 22:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiHJWfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 18:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbiHJWfP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 18:35:15 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE608E56
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 15:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1660170895;
        bh=nh5sH5585iR87LgUmaey4eWfb60rG39KcG7msjG+0qI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=QV4qnjKgYX2YdB7/qEX6zMJd8Z2WwbsZIR/PfVIZcwMutyfSZpoaPWO1DhQaDAIYc
         ugPkuuDUc8JQWZ6fzlbsUu/Rg+s5EKbp08OcfS11tV8Xq0fjEB6tULK1X8Vg+eXLnI
         HoHcoxnTIKkbEod55lLoh0lzBfcPmGPUqAE1i9qk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.34] ([79.203.28.61]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYtx4-1nr7uA3Ss4-00V5xL; Thu, 11
 Aug 2022 00:34:54 +0200
Message-ID: <77244ffe-41c1-65bd-8984-8ed6909ffe07@web.de>
Date:   Thu, 11 Aug 2022 00:34:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] mingw: handle writes to non-blocking pipe
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <xmqq5yjahb8u.fsf@gitster.g>
 <YunxHOa2sJeEpJxd@coredump.intra.peff.net>
 <a9953278-b15f-fd76-17b0-e949c7937992@web.de>
 <YuquVEqEl6wxCLM7@coredump.intra.peff.net>
 <41477326-5493-4d3c-246d-8a28969fa73e@web.de>
 <Yu05GjncDaGRTgce@coredump.intra.peff.net>
 <6854c54c-12ff-f613-4cdc-18b3b1a55ef1@web.de>
 <b3310324-7969-f9fb-a2e0-46e881d37786@web.de>
 <Yu/5LU+ZhbVRnSdM@coredump.intra.peff.net>
 <72d007c5-9429-1612-24d7-af5db906dd63@web.de>
 <YvQO4ZYI8/fAk0Gj@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <YvQO4ZYI8/fAk0Gj@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6+HWT7xS0qREV0fgDmEmHOSYCmo3w2/AtKgL+TsApWc/IGAo1Kf
 di3J3Rm0CwcDSdxWkRFDoxso4EeFX91MDw+JrxUIxDebbDC2Z6NMRlkrU2Z2Mg0TfQLpCJQ
 kvde3MXuYLfO//z7KeEj5IMV0oUCyHNBAyZ4eslCX+QF1/NeRuBpcpcnXLNJD8IcDvqGFGL
 NLeGy4v0xfQ0iRmB3noWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+dfcOu72VKA=:ppF9CGSyU95PUsrw1JjX2e
 rBUdyPhD6iykDIt28BI+p7oD9unPkUBqWzI7Ev7nVRK5wYoXVahd0JQytmksbgEQBYzksI6/J
 8oEEAnzjPQDWYsyeZLaG/j03bD0K0vWu2unHR9/oiKA/8zcuwPVnW7uGPOG+kfbK8TLtV1wVf
 rHC2I9gPXHiDKd9v4i0bQbmmjmXgZCWR0vpFZR/K+iqV2dqQaiwricyZSYOeIzaofx5JIKNcZ
 ytcMyJl3JUkBscONcpMayKmXHXv+C4rETYsKVqsqPtSmm0eYzbM9sGYl7Q/BktzfxBN27naFn
 g/Rr35F2MN5+kuL88mrvl1wATql4z4gLuGlKE0Lya/lnw4u/FLL17rk+eb1OgOJK9d/Tn2Fu5
 zRoUWBeg8AmoGG/C0lwPLxLGhwLXBm3/6doLAcT1v0zR8qlR5g6TErermA1w6WkFueaDVtvHo
 SEjMoCFLWzJ0gwIjzvvGQjZiMIzt/l6NtcRbyBcezWc9nj+tL5Tz4XvPV6dJox19eBPrZ0UMQ
 8g63SqTpe8d7Q+v4j4cMKRKXKr1Z7b0TZ3BrLYAzxkJxufzlovCmSTcVtnu+7gbuAACQziYvt
 Z1FiXKtz6p0A4ZZohIFf9BwMKu9bQ3R7u9SgD6dHSxi70UgI8k7ENEXjJmjCTy4wAzcHRrWVw
 jVqUmwKITaQGPWEQtToZzofR/zqDlC7F/QXzzIH/YvKQHpQvmpvTAGdvBozaVsilYPEpRcwHP
 PD5rPVqiiAuyBisnmc7tpEVMTp8b0eSwZ96fr371l+fMIVO228cmnG2yPfqXUJHyEgZI7NpXB
 S8TH2gd85WHnZwVIY5WLo19Sc2DcuHXUxLWr4X7erz/tBdPPXc0i823eFKrCjHWNh60iQwkJC
 4MWRXqyiAg4bzUcxCdxu/goVhcIQB93tMNa/8QLzSYGCaPR6LuggJeGg+e0G0xyabZwo5XQvW
 i8ZeU8B61gPvuU8M9LoE5FEb52SN5eypzaou1TG29VA7BP6jcLijkZ6DIWr/rgIPTFFYKfK8e
 v588dTfC2A+RYPDkf81BwI0YukFWvg/yiFILFxkSPaJAgrnxi+P0JOyHF+qDsy89SESClBFkc
 rd5dYrLb1ai05wlnjrsxrfPI1L3eZiezmt6
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.08.2022 um 22:02 schrieb Jeff King:
> On Wed, Aug 10, 2022 at 07:39:40AM +0200, Ren=C3=A9 Scharfe wrote:
>
>> write() on Windows reports ENOSPC when writing to a non-blocking pipe
>> whose buffer is full and rejects writes bigger than the buffer outright=
.
>> Change the error code to EAGAIN and try a buffer-sized partial write to
>> comply with POSIX and the expections of our Git-internal callers.
>
> Bearing in mind that I have no qualifications for reviewing
> Windows-specific patches, this seems like the right thing to be doing
> from the behavior you saw.
>
> One question:
>
>> +	if (result < 0 && errno =3D=3D ENOSPC) {
>> +		/* check if fd is a non-blocking pipe */
>> +		HANDLE h =3D (HANDLE) _get_osfhandle(fd);
>> +		DWORD s;
>> +		if (GetFileType(h) =3D=3D FILE_TYPE_PIPE &&
>> +		    GetNamedPipeHandleState(h, &s, NULL, NULL, NULL, NULL, 0) &&
>> +		    (s & PIPE_NOWAIT)) {
>> +			DWORD obuflen;
>> +			if (!GetNamedPipeInfo(h, NULL, &obuflen, NULL, NULL))
>> +				obuflen =3D PIPE_BUFFER_SIZE;
>> +			if (len > obuflen)
>> +				return mingw_write(fd, buf, obuflen);
>> +			errno =3D EAGAIN;
>> +		}
>
> OK, so we call GetNamedPipeInfo() to find the size of the pipe buffer.
> It's unclear to me from Microsoft's docs if that is the _total_ size, or
> if it's the remaining available size. Hopefully the latter, since none
> of this works otherwise. ;)
>
> But two corner cases:
>
>   - If we fail to get the size, we guess that it's the maximum. Is this
>     dangerous? I'm not sure why the call would fail, but if for some
>     reason it did fail and we can't make forward progress, would we
>     enter an infinite recursion of mingw_write()? Would it be safer to
>     bail with EAGAIN in such a case (through granted, that probably just
>     puts us into an infinite loop in xwrite())?

AFAIU it's the total size, not the available space.  I think I confused
it with PIPE_BUF, which we should use instead.

Alternatively we could retry with ever smaller sizes, down to one byte,
to avoid EAGAIN as much as possible.  Sounds costly, though.

>
>   - According to the docs:
>
>       If the buffer size is zero, the buffer is allocated as needed.
>
>     If we see this case, we'd then call mingw_write() with 0 bytes,
>     which I imagine also makes no forward progress (though maybe we
>     eventually return a successful 0-byte write?).

Ah, yes, forgot that case.

Ren=C3=A9

