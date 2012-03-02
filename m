From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH] mergetools: add support for DeltaWalker
Date: Fri, 2 Mar 2012 08:22:09 -0500
Message-ID: <CAFouethVURpXFDkm8N=riCQDaOYAXYg3VpwKRFaHMftNWr9=dw@mail.gmail.com>
References: <1330652872-916-1-git-send-email-tim.henigan@gmail.com>
	<7vpqcvk496.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, davvid@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 14:22:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3SR8-00056k-2m
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 14:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754342Ab2CBNWL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Mar 2012 08:22:11 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46427 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982Ab2CBNWJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2012 08:22:09 -0500
Received: by iagz16 with SMTP id z16so2281356iag.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 05:22:09 -0800 (PST)
Received-SPF: pass (google.com: domain of tim.henigan@gmail.com designates 10.50.186.161 as permitted sender) client-ip=10.50.186.161;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tim.henigan@gmail.com designates 10.50.186.161 as permitted sender) smtp.mail=tim.henigan@gmail.com; dkim=pass header.i=tim.henigan@gmail.com
Received: from mr.google.com ([10.50.186.161])
        by 10.50.186.161 with SMTP id fl1mr1661601igc.44.1330694529193 (num_hops = 1);
        Fri, 02 Mar 2012 05:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=TY/XRiDvYElk1HOMzac/IM0UsCAWqwwUecN3vYDIOYU=;
        b=Tfq1Ezs4A2TTbGDAhJFmNzHlFOg0QkOAM6GapS6EAtjTRX1sGU7Bv2cjqsXrnI+sH9
         6MuaRlDZL9fDHRDOw7DfHG24SIqpIPNZGHQTL0icvrNr54P0eJ8m+h9TSv2YWktFZcf3
         M9R3E+1OfnjDQ44rr9HROrXHeTvnjp25f97n2m0FEaPSYXWqenkBpISf1GvF3jg+gqY3
         ik0yTyRnucpIc5tc31RFKbareFRJVJq1ewmNXpQv/t5A8tfNsWJ72M0WDiPnchTit0i3
         X0zuo9Sc2el/Y6QhpaohfoJNSrrY9ODuvhxIB0cofRLPqQb+fDEfBYXLjGJt0tHGdjky
         fWMQ==
Received: by 10.50.186.161 with SMTP id fl1mr1378419igc.44.1330694529152; Fri,
 02 Mar 2012 05:22:09 -0800 (PST)
Received: by 10.42.218.65 with HTTP; Fri, 2 Mar 2012 05:22:09 -0800 (PST)
In-Reply-To: <7vpqcvk496.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192039>

On Thu, Mar 1, 2012 at 11:37 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Tim Henigan <tim.henigan@gmail.com> writes:
>
> I see that the earlier refactoring to make mergetool backend pluggabl=
e is
> starting to pay off rather nicely. =C2=A0It is not "since ..., requir=
es ...",
> but "thanks to ..., adding a random new tool is just a matter of drop=
ping
> a trivial shell snippet in the directory".

I will reword the commit message in v2.


> Perhaps doing the above like this might make it a bit less of an eye-=
sore.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if $base_present
> =C2=A0 =C2=A0 =C2=A0 =C2=A0then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"$merge_tool_p=
ath" "$LOCAL" "$REMOTE" "$BASE" -merged=3D"$PWD/$MERGED"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"$merge_tool_p=
ath" "$LOCAL" "$REMOTE" -merged=3D"$PWD/$MERGED"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi >/dev/null 2>&1

Will update in v2.


>> + =C2=A0 =C2=A0 =C2=A0 status=3D$?
>
> This is highly dubious. =C2=A0Looking at existing mergetools/*, I thi=
nk the
> caller expects merge_cmd to signal success or failure with $?, so you
> probably just want to drop this line; the caller will then get the $?
> that was set by the "$merge_tool_path" command.
>
> That is how your diff_cmd is communicating with its caller after all,=
 no?

It seems that only two of the existing scripts use this 'status=3D$?'
line (emerge and kdiff3).  I used the 'kdiff3' file as my starting
point without actually trying to understand why that line was present.
 Local testing shows that I don't need this line for DeltaWalker, so
it will be removed in v2.
