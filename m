From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 6/9] difftool: replace system call with Git::command_noisy
Date: Sat, 17 Mar 2012 20:54:14 +0100
Message-ID: <CALxABCaGOhsTdRRtbVDbS37FHZ32yf4URGw34P-nq-RFm5sSYA@mail.gmail.com>
References: <1331949557-15146-1-git-send-email-tim.henigan@gmail.com>
 <CAJDDKr4+0iWoZhxo6kMVa0YUtDzmrH=XTZnDqQdbnM6TJ41UDg@mail.gmail.com>
 <CALxABCYiOpQavW3qz+Xx-qjadaF3sAQ3DHAAwzRRBDXm6MAnOw@mail.gmail.com> <CAFouethChs_2ZhYDjOqRTSoDMZ60DeMkS1A=Ke4G5G_pKPKrYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 20:55:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8zib-0006jF-Pt
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 20:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508Ab2CQTyg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Mar 2012 15:54:36 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:36221 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752087Ab2CQTyg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 15:54:36 -0400
Received: by lahj13 with SMTP id j13so3959329lah.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 12:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Dg1zCwy6uKZ+a4YBehgdPtzwIMBZr+3y0YKfEBT6Cjo=;
        b=ZgbIKcUgPcL4PhIdpDPMEuArZ540/E92rjX5kSz9zJfdC6A96I1bL7+85HqKr+ndF4
         JaPi2DxAKK8eHus/fmfzQWibt+N024dFeQ8ID79cZVpN61u7YCuCIcNc0ijbX3KUuY2n
         mLC3tNroL3BERaklamwfxtLB8e41FZI+d7zOtGqOOzrOEs5N/FfigVg+60nolIEl42Uc
         Uyo0rqNDNKb7FpJUEcD6YLxyLOICMHuzPrVXi1byrsTLh78n6Oqy/D8xAJ58VBBf56Ic
         3GKuFzVF21TH+mHzMQx9UX9yi9EldLORG69oLIHdsGaobN9PlL5lsA0jptYeai7q2LKn
         F8ug==
Received: by 10.152.115.38 with SMTP id jl6mr5269658lab.24.1332014074276; Sat,
 17 Mar 2012 12:54:34 -0700 (PDT)
Received: by 10.152.146.65 with HTTP; Sat, 17 Mar 2012 12:54:14 -0700 (PDT)
In-Reply-To: <CAFouethChs_2ZhYDjOqRTSoDMZ60DeMkS1A=Ke4G5G_pKPKrYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193348>

On Sat, Mar 17, 2012 at 15:48, Tim Henigan <tim.henigan@gmail.com> wrot=
e:
> On Sat, Mar 17, 2012 at 6:50 AM, Alex Riesen <raa.lkml@gmail.com> wro=
te:
>> On Sat, Mar 17, 2012 at 03:48, David Aguilar <davvid@gmail.com> wrot=
e:
>>> Is this no longer a concern? =C2=A0Does Git.pm need a similar porta=
bility
>>> caveat, or =C2=A0does it avoid the problem altogether since it uses=
 fork()
>>> + exec() + waitpid()? =C2=A0(if this is true then it implies that t=
his
>>> change is fine).
>
> I need to spend more time testing this. =C2=A0On Windows, I have test=
ed
> with msysgit but not cygwin. =C2=A0Was ActiveState Perl used with cyg=
win
> git?

Yes, it is even stated in the commentary.

As far as I know, there is only one installation where a cygwin-compile=
d
Git is used with the ActiveState Perl (mine. I believe we would have
heard if there were others - it is an extremely annoying combination).

>> It _might_ work. Cygwin kind of has fork(2), it even works (kind of:
>> it is a *very* expensive thing to do). There are also other ifs and
>> whens, but it is worth a test. It's a nice clean up to have.
>
> Even it fork(2) is expensive, in this case it seems reasonable. Given
> the time needed to spawn the diff tool, the fork(2) time seems
> negligible.

Not Cygwin's fork. They really do a deep copy of parent process.

But actually, I misunderstood. The Perl used was of ActiveState origin.
So the code in question is not affected by Cygwin at all.
I have no idea how usable fork(2) of ActiveState Perl is.

Even if it is bad, I won't be really affected, I very seldom use the
difftool, and I believe I never used it on that particular system.

I try test the patch in the next days. I'll tell if something is
completely broken.
