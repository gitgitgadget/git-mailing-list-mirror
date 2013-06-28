From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] CYGWIN: Use a TCP socket for pipe()
Date: Thu, 27 Jun 2013 22:46:55 -0400
Message-ID: <51CCF91F.7080501@gmail.com>
References: <201306271831.13865.tboegi@web.de> <7vvc4zsbbs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	ramsay@ramsay1.demon.co.uk, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 04:47:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsOiX-0004D1-VM
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 04:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358Ab3F1CrA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Jun 2013 22:47:00 -0400
Received: from mail-qe0-f45.google.com ([209.85.128.45]:47871 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135Ab3F1Cq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 22:46:59 -0400
Received: by mail-qe0-f45.google.com with SMTP id w7so502167qeb.32
        for <git@vger.kernel.org>; Thu, 27 Jun 2013 19:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=XyRDKT0GtkBYy09dxJ2ePw9g36Rot1a3hyWuYMM8XRY=;
        b=tDRwlDt9Ri/h12hY5L376TES/3/lnXFy69QxAN/8SUhkIijNJ/cPySzA5wC/yZe/jS
         fbqSc/hC4fbP+HgcK58Nak4iHXTXPz5Mowy/VnztcxvCVEJsm9p9J7dk9vx9CSF9aeVe
         MAm8/q19+ChZBKt3sKBskj//1nX6Wdn3I1WwD0L8JPSj8uwYhBM/bNXlDbiRbEua3Ago
         huvTLmFeWtq5MZ5yrSQl5Nm3N0BaDaciKtAT1XY8CghnSf21e28vAlSsOtCPa4+rMyjP
         zHnl5ysetyuL+0LWOk2mMxmEoQybkVqra2q0gOVngFtwLopatnD+vf+jEtutIs83MeEQ
         w+Uw==
X-Received: by 10.49.28.200 with SMTP id d8mr14643474qeh.26.1372387618331;
        Thu, 27 Jun 2013 19:46:58 -0700 (PDT)
Received: from mark-laptop.lan (pool-173-79-104-160.washdc.fios.verizon.net. [173.79.104.160])
        by mx.google.com with ESMTPSA id l2sm7996810qez.2.2013.06.27.19.46.56
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 27 Jun 2013 19:46:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
In-Reply-To: <7vvc4zsbbs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229174>

On 06/27/2013 01:38 PM, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> Work around issues that git hangs when doing fetch or pull under
>> various protocols under CYGWIN.
>>
>> Replace pipe() with a socket connection using a TCP/IP.
>> Introduce a new function socket_pipe() in compat/socket_pipe.c
> Sounds like sweeping the real problem, whatever it is, under rug.
> Is it that we are assuming a pipe buffer that is sufficiently large
> and expecting a write that we deem to be small enough not to block,
> causing a deadlock on a platform with very small pipe buffer, or
> something?
>

There were issues in early v1.7 Cygwin release for overlapping I/O such=
=20
that the pipe was sometimes terminated early resulting in data loss. If=
=20
the pipe implementation in Cygwin is still a problem a good test case=20
sent to the Cygwin developers would be the right approach rather than a=
=20
one-off patch in git to try to work around a current platform bug.

Note - I do not see random hangs with the stat/lstat hack removed,=20
rather the sole test suite hang I see is repeatable in t0008.sh. So, if=
=20
the patch remains, we may be able to run this remaining hang to ground.

Mark
