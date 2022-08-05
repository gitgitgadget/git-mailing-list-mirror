Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF48C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 21:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241135AbiHEVN6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 17:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241330AbiHEVNy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 17:13:54 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF9765561
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 14:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1659734009;
        bh=OVYh09PdSggnYUVvNdBSOHX/Uvuowc1G8V42qz+IT2s=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fEq/N4ryQW3jl38zzBddhYs/ptunnm/m7WKIS7+INM2ETGmrf80ctMy68yUMByqXd
         nahuwrFriKaC5FmGvb6wDNBz8oI0v+23vninEcU5LkG7uqnmLKeOX1zLwaLBZ6Ql/L
         oYhyyQ32k0IFuYFWlwOAfRC84Hi6ST1P0QN/bEhA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.35] ([91.47.154.211]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBS6v-1o8Hih3gJ5-00D2wO; Fri, 05
 Aug 2022 23:13:28 +0200
Message-ID: <6854c54c-12ff-f613-4cdc-18b3b1a55ef1@web.de>
Date:   Fri, 5 Aug 2022 23:13:28 +0200
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
X-Provags-ID: V03:K1:LtlPUvXzeLAIFHNDy42+cx2lEmsxFvHwEx6CREIiH8VXny+KxOU
 m8JChtCJILBel9uUNmZ0iycyMN9vtMe197xYXYYDLAtvHPy3ssBn4x068NJr8/zF5lvvwLG
 IIQftImQpV3WPCZ1J/fOLms18y0SC6cb3L+PNj5WwHALMM9vqPF3BoRsxKQA7i/I/7gDSbX
 O//OZR2IWrAZFt30zm4PQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cYYwF/gAcmM=:iXAyLi6aBVC5m2dWeGgo+c
 059boNoawAOf+kd0Uptu3SgvWhKlfS8ZjaK7N5xQ7UgT/NOVNMkQfWqD6kfB1CVLQW+ugmS3n
 xSUvQvU1heVTo4FN2g+ERi6bwSshtO5e+pymNGErlhf8wHoXZeiN0LlFrvK1mQUFLL26M/QGq
 wnPDmfG/uc6NyGxcky863TlvLCPbgiSmb7iM/tuUKjHg2hOl8D1b8mr8aF7mLACCsSg3U3p62
 iq5ju8sdCfWSCum5hFger5sl5Q7twXwy+zQY3KyXnjCy/Ei/Wsw3f7m/XkbevO3jRqy5ceC69
 4wW4y3vB5RhGUQtYnUasZikR7YeI/RuIw1vqe/nq8sewfFwLzbOxFxSo8XdzJZOFZrk71r4Hb
 reG9MBOm05NkkCal1i5YpIKcU4F3pT42x3iZyLYFuQhOKNV6s3mn45EfbFepDgeGzmHUGwfmI
 J5fN/+zXBElfthT0WGyr9n/VzqLS8z6vPmsifMhd7fz3goAwCl3LlJUsnIsc2OlDmpAJUgua5
 /y6YKLvcf4psaC5WYVTP3JH1uIFF2xl1G4/2fzw6cGo4EmBS6o1NOUwMMWE84EWtERgWc7v4J
 qIvxjbtwChvf2wG85zFpv/tLNQMXWNUt9WB81hvDfycA2AKR9q1rluVzFiBmG3IyUQdF9K5Iv
 x6jjlyn++pHZNWY8VACevP7Dqqfelj2kazaY8jUiPdtBDX1KK4ltpl8PxWcLIL8dc/SK4UxZY
 Xhw/+0ySIXpVUtU3t5km7a+fsNJdllsuh39hMbqgp+8DzCVlK39qKeBPjcfXMKp44kVJupKo6
 p3M3RSrgVelGYZcrJdc8InUs6/ixx+kA3t9WG8VSc/Wl5d2bICy0b1qjeZxTv75gh4sl0jlLC
 a6KPOpyE7jiw6/muNqov9xIB8ENNa/OrXkwJbK0QGpDdpLuhqKdgZmtvmE+erVAIvy9fvmwtP
 NffxQ6VogUQtSxC+jo/8unLreRaa1z8GH9FaeISzvmw9Q92wmMhVowUgSHlC5RZ5F+Hi9uQI/
 KmmiWtp4MioxQ/5chlKNilvDLLDEtdGfdiiAzHroZYP6L4LKQUH4B0vSJ0zDrPSttC0hdJOxY
 4G9TnMTyU5MvZEJhiE3XWuVTjLhcGyZeddi
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.08.2022 um 17:36 schrieb Jeff King:
> On Wed, Aug 03, 2022 at 11:56:13PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Without that line the added test hangs for me on the Git for Windows
>> SDK on Windows 11.
>
> Hmph. Interesting that it passes in CI, but not on your local setup.
> I wonder why pipes would behave differently. Or perhaps there is even
> some configuration different that means we are still running the perl
> add--interactive there, though I kind of doubt it (and couldn't find
> anything pointing there).
>
> Still, if it fails in at least one spot, it's something we need to deal
> with. On the plus side, once we figure out how to fix it, the
> hand-grenade of "enable_nonblock() does nothing on Windows" will not be
> present anymore. ;)
>
>> With the patch below it fails and reports basically nothing:
>> [...]
>>    not ok 57 - handle very large filtered diff
>>    #
>>    #               git reset --hard &&
>>    #               # The specific number here is not important, but it =
must
>>    #               # be large enough that the output of "git diff --col=
or"
>>    #               # fills up the pipe buffer. 10,000 results in ~200k =
of
>>    #               # colored output.
>>    #               test_seq 10000 >test &&
>>    #               test_config interactive.diffFilter cat &&
>>    #               printf y >y &&
>>    #               force_color git add -p >output 2>&1 <y &&
>>    #               git diff-files --exit-code -- test
>>    #
>>    1..57
>>
>> The file "output" contains "error: failed to run 'cat'".  This is
>> add-patch.c::parse_diff() reporting that pipe_command() failed.  So
>> that's not it, yet.  (I don't actually know what I'm doing here.)
>
> That implies that your call to enable_nonblock() succeeded, or
> pipe_command() itself would have complained, too. Maybe instrument
> it like this:
>
> diff --git a/run-command.c b/run-command.c
> index 8ea609d4ae..27e79c928a 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1473,11 +1473,17 @@ int pipe_command(struct child_process *cmd,
>  	}
>
>  	if (pump_io(io, nr) < 0) {
> +		error_errno("pumping io failed");
>  		finish_command(cmd); /* throw away exit code */
>  		return -1;
>  	}
>
> -	return finish_command(cmd);
> +	{
> +		int ret =3D finish_command(cmd);
> +		if (ret)
> +			error("child returned failure %d", ret);
> +		return ret;
> +	}
>  }
>
>  enum child_state {
>
> Normally we stay pretty quiet there and let the caller report any
> problems, but it lacks enough context to make a more specific error
> report.

This adds "error: pumping io failed: No space left on device" to output.
Which kinda makes sense: With the pipe no longer blocking, there can be
a moment when the buffer is full and writes have to be rejected.  This
condition should be reported with EAGAIN, though.

Adding "if (len < 0 && errno =3D=3D ENOSPC) continue;" after the xwrite()
call in pump_io_round() lets the test pass.

Perhaps the translation from Windows error code to POSIX is wrong here?

>
>>  int enable_nonblock(int fd)
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

Right, and the "Named" part should be explained: As [1] says: "[...] you
can often pass a handle to an anonymous pipe to a function that requires
a handle to a named pipe.".

And perhaps that's not the right thing to do after all, as [2] says:
"Note that nonblocking mode is supported for compatibility with
Microsoft LAN Manager version 2.0 and should not be used to achieve
asynchronous input and output (I/O) [...]".

[1] https://docs.microsoft.com/en-us/windows/win32/ipc/anonymous-pipe-oper=
ations
[2] https://docs.microsoft.com/en-us/windows/win32/api/namedpipeapi/nf-nam=
edpipeapi-setnamedpipehandlestate

>
> Thanks for poking at this.
>
> -Peff
