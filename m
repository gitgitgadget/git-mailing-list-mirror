Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73519C19F2A
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 10:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiHGKP3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Aug 2022 06:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbiHGKP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Aug 2022 06:15:27 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4497F62E1
        for <git@vger.kernel.org>; Sun,  7 Aug 2022 03:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1659867309;
        bh=6UCdbRQdxA350glfxGrCzfe96cTTuE2WTk1elucX2gA=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=hlOnA8l/ay8nibbPtd2/OhzCvyufycNyfrQxdYYFfND6eF/In319nGoB344I96oPf
         btgcRwdQXH3UvGJNTKuDKJqMXP6h9tU1F6T5KAg3tigYbOTG9bNEBtVee4rgyOAf5C
         CMaLwfJcZ2NckNCW8GQ8IsBPAloUwrqInD2Dl2e4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.35] ([79.203.16.122]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZB49-1nyRky2Rfd-00UoYf; Sun, 07
 Aug 2022 12:15:09 +0200
Message-ID: <b3310324-7969-f9fb-a2e0-46e881d37786@web.de>
Date:   Sun, 7 Aug 2022 12:15:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v2] pipe_command(): mark stdin descriptor as non-blocking
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
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
In-Reply-To: <6854c54c-12ff-f613-4cdc-18b3b1a55ef1@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+ho4eK8CL2qY2vdZ1ykxldEM0SI5zFVhKrHfrPosqzBrPALk6lv
 pW4bDHxohPrNHmIMxTJLGoW92SutCRec94bsGXyk06Os3qRPExXIfiJnWKLX8TlKpoFzVzg
 WbWpCXtsMb7MbBYSETm8gDlYF7gmX8xi0BU2EtbNhvScVDRzG18sG/sCvgmoZHljAccKK9l
 XQQGzhYz2QxoREKBXkZqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sbQSLSCpDJI=:diZ5cjmB00YMNGG6zBvP9h
 pM/Y1n7xbToYbDuNkgHhgVRLnyHXXF3ty/WJOegNyhWsuO6l09mvheZCzrKSpNrWDjiKtMobb
 ARlVOp7e7zU2RbGGsQn2lST+Km86o1EoZKeYYUH3jsHX3YcukbRrT0kAxSeu9t6gneXR8jkjD
 jS0k7eI05lTZwQoKZeeg1MSv1lKX5jpFyisH5Aqbxiwq6b59XZO+tHtYhX1RyO1ifbfsGA/8X
 OReCnXwSp9REmGRmh8LM1rB3NiFFUkKdMS5C1QPThobRD9YeD2pXwv3D39/JVy8a9hyQcxrkg
 ws36RxGTkw+IOis1/KWrwMW/fq1IAWE4x06m+UxJL4S2y0xyW4Ji6mS0H3bCWr8MFLYsK304V
 n0XAwtpDa3lIoT/FhjFZ62ltN3yvnNo0BWxR/k5QG4ldZ7ABdF2XgtnylDlETH7qR2Cdn1JY3
 tjpjdEQxgBWgt8LQOzYS4M3dc3CQpQAm+xRy10l6C2KI0mZOf2Qc/4XUCCumWPzXUxn1LHE30
 12pwA4J+oOlyN47B0ECAh+ecVompl7UOV8C2KMk1rOtZ7sWCYC9kpBqRdSHkZx5u10sPwFxWj
 rYqQjoXvAHEdVQrP93uKumlEorgsy7+vsoL/UV+sIb7jmT36GrUPbS1ihK/FHK4saJYYnYbnt
 n0c626BLiUb1bPx8WrD/0ukzvjHXzC2a5GbEkNtRU0d5QBOA6RccczlG5rPY573eSfgnEyK03
 70GGz+4v6LlV6HrBOGqxSISgZbiJ4s3pRXXBBd+ITU25lJJv9y0FScG7KwyxBhme20nRekF6Q
 QeUCi/RKTksBQVA7hElILuvahKtIzH1PDC4cGhbDPe7frhdQh1NioUbwamJ34Z4d+Z5wcRmWZ
 rPvzZPMew1/1G13iea2k5FKhrvl6mFulsMASyuTJl1UWvA0Y1+y4PtvPZbN5KnO5QvSDpVz25
 xP/rmU52I9GMpYy4p3Bglo+OwcSVlWO5QJq4ZITupOruJ5lbGhtEm73RtNYhwUli+a06UDn4l
 GTI5elNehtC/teJZ1rcY5SWQQDlzyxAfhtIH2watbL579shghgBRDW12dlIyVYCyIz3DmteRK
 vKKIn8A3G1CIUy+B9FfP0l+bHMbN0NJbiD8
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.08.2022 um 23:13 schrieb Ren=C3=A9 Scharfe:
> Am 05.08.2022 um 17:36 schrieb Jeff King:
>> On Wed, Aug 03, 2022 at 11:56:13PM +0200, Ren=C3=A9 Scharfe wrote:
>>
>>> Without that line the added test hangs for me on the Git for Windows
>>> SDK on Windows 11.
>>
>> Hmph. Interesting that it passes in CI, but not on your local setup.
>> I wonder why pipes would behave differently. Or perhaps there is even
>> some configuration different that means we are still running the perl
>> add--interactive there, though I kind of doubt it (and couldn't find
>> anything pointing there).
>>
>> Still, if it fails in at least one spot, it's something we need to deal
>> with. On the plus side, once we figure out how to fix it, the
>> hand-grenade of "enable_nonblock() does nothing on Windows" will not be
>> present anymore. ;)
>>
>>> With the patch below it fails and reports basically nothing:
>>> [...]
>>>    not ok 57 - handle very large filtered diff
>>>    #
>>>    #               git reset --hard &&
>>>    #               # The specific number here is not important, but it=
 must
>>>    #               # be large enough that the output of "git diff --co=
lor"
>>>    #               # fills up the pipe buffer. 10,000 results in ~200k=
 of
>>>    #               # colored output.
>>>    #               test_seq 10000 >test &&
>>>    #               test_config interactive.diffFilter cat &&
>>>    #               printf y >y &&
>>>    #               force_color git add -p >output 2>&1 <y &&
>>>    #               git diff-files --exit-code -- test
>>>    #
>>>    1..57
>>>
>>> The file "output" contains "error: failed to run 'cat'".  This is
>>> add-patch.c::parse_diff() reporting that pipe_command() failed.  So
>>> that's not it, yet.  (I don't actually know what I'm doing here.)
>>
>> That implies that your call to enable_nonblock() succeeded, or
>> pipe_command() itself would have complained, too. Maybe instrument
>> it like this:
>>
>> diff --git a/run-command.c b/run-command.c
>> index 8ea609d4ae..27e79c928a 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -1473,11 +1473,17 @@ int pipe_command(struct child_process *cmd,
>>  	}
>>
>>  	if (pump_io(io, nr) < 0) {
>> +		error_errno("pumping io failed");
>>  		finish_command(cmd); /* throw away exit code */
>>  		return -1;
>>  	}
>>
>> -	return finish_command(cmd);
>> +	{
>> +		int ret =3D finish_command(cmd);
>> +		if (ret)
>> +			error("child returned failure %d", ret);
>> +		return ret;
>> +	}
>>  }
>>
>>  enum child_state {
>>
>> Normally we stay pretty quiet there and let the caller report any
>> problems, but it lacks enough context to make a more specific error
>> report.

Side note: The above patch gives better insight on error, but also
breaks t4205.105 (%(describe) vs git describe), t7400.16 (submodule add
to .gitignored path fails) and t7406.59 (submodule update --quiet passes
quietness to fetch with a shallow clone).

>
> This adds "error: pumping io failed: No space left on device" to output.
> Which kinda makes sense: With the pipe no longer blocking, there can be
> a moment when the buffer is full and writes have to be rejected.  This
> condition should be reported with EAGAIN, though.
>
> Adding "if (len < 0 && errno =3D=3D ENOSPC) continue;" after the xwrite(=
)
> call in pump_io_round() lets the test pass.
>
> Perhaps the translation from Windows error code to POSIX is wrong here?

So if we fix that with the patch below, t3701.57 still hangs, but this
time it goes through wrapper.c::handle_nonblock() again and again.
Replacing the "errno =3D EAGAIN" with a "return 0" to fake report a
successful write of nothing instead lets the test pass.

This seems to make sense -- looping in xwrite() won't help, as we need
to read from the other fd first, to allow the process on the other end
of the pipe to make some progress first, as otherwise the pipe buffer
will stay full in this scenario.  Shouldn't that be a problem on other
systems as well?

Ren=C3=A9

=2D--
 compat/mingw.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index b5502997e2..e34cceb151 100644
=2D-- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -702,6 +702,17 @@ ssize_t mingw_write(int fd, const void *buf, size_t l=
en)
 		else
 			errno =3D EINVAL;
 	}
+	if (result < 0 && errno =3D=3D ENOSPC) {
+		/* check if fd is a non-blocking pipe */
+		HANDLE h =3D (HANDLE) _get_osfhandle(fd);
+		DWORD m;
+		if (GetFileType(h) =3D=3D FILE_TYPE_PIPE &&
+		    GetNamedPipeHandleState(h, &m, NULL, NULL, NULL, NULL, 0) &&
+		    (m & PIPE_NOWAIT))
+			errno =3D EAGAIN;
+		else
+			errno =3D ENOSPC;
+	}

 	return result;
 }
=2D-
2.37.1.windows.1
