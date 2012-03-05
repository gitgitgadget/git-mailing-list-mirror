From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] mergetools: add support for DeltaWalker
Date: Sun, 4 Mar 2012 18:10:30 -0800
Message-ID: <CAJDDKr6toChs8KpnAbjxeemBZT1AT1Uk9Ajk7DWBREuM6yFMzg@mail.gmail.com>
References: <1330694867-7601-1-git-send-email-tim.henigan@gmail.com>
	<7vaa3ybpat.fsf@alter.siamese.dyndns.org>
	<CAJDDKr4q7gmFeHuGM5hFruduHw-3mGa+CMU=U6X0jjXUsJLsvw@mail.gmail.com>
	<7vmx7x5ml0.fsf@alter.siamese.dyndns.org>
	<CAFouetjZ0kQMnAPdNey5kSEmq+fmQqq+fC51hcT+9k6T8c6uOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 03:10:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4NNl-0001NR-Ox
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 03:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647Ab2CECKc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 21:10:32 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:57934 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab2CECKb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Mar 2012 21:10:31 -0500
Received: by vcqp1 with SMTP id p1so2989934vcq.19
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 18:10:30 -0800 (PST)
Received-SPF: pass (google.com: domain of davvid@gmail.com designates 10.52.99.169 as permitted sender) client-ip=10.52.99.169;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of davvid@gmail.com designates 10.52.99.169 as permitted sender) smtp.mail=davvid@gmail.com; dkim=pass header.i=davvid@gmail.com
Received: from mr.google.com ([10.52.99.169])
        by 10.52.99.169 with SMTP id er9mr31370367vdb.126.1330913430854 (num_hops = 1);
        Sun, 04 Mar 2012 18:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=irIkEFk6BJMIelRxScXw+UujKyABcWQ6Q5rZz+lkpX0=;
        b=iLmOVtaQMhffBqxpxa5sNJgha8AFCDOyi0xnQw3735nsxlZ8PBlJZrNUk2GnqGV6MF
         plyR31Kiyw+g+a2JapJx8SDUgmtUrxFTOsDPF5wLEsUJpSenbfdn6fINiDA4DxGPCXz4
         ghX4Pqb6+zjZJoRfUshq1J79LWeWuP1JqUsp9hlAvLBbmBVnQmA7qoLHRcnCgWqFlBg4
         ovL/FZfAKdlsMFY2UMB5KSAW8NQq9xAt1LgY9U0NLxPNLzeAERxlImszWvzgaPbRgL50
         9g8qxi1pg3IMZS6FRuDgijqZUKj8T+EtYk/bZ26Tn0THnKrPOUapixtYC2s/Ie6i4wZu
         Ifqw==
Received: by 10.52.99.169 with SMTP id er9mr26953381vdb.126.1330913430805;
 Sun, 04 Mar 2012 18:10:30 -0800 (PST)
Received: by 10.220.230.200 with HTTP; Sun, 4 Mar 2012 18:10:30 -0800 (PST)
In-Reply-To: <CAFouetjZ0kQMnAPdNey5kSEmq+fmQqq+fC51hcT+9k6T8c6uOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192186>

On Sat, Mar 3, 2012 at 7:50 PM, Tim Henigan <tim.henigan@gmail.com> wro=
te:
> On Sat, Mar 3, 2012 at 5:47 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> David Aguilar <davvid@gmail.com> writes:
>>
>>>>> +merge_cmd () {
>>>>> + =C2=A0 =C2=A0 if $base_present
>>>>> + =C2=A0 =C2=A0 then
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "$merge_tool_path" "$=
LOCAL" "$REMOTE" "$BASE" -merged=3D"$PWD/$MERGED"
>>>>> + =C2=A0 =C2=A0 else
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "$merge_tool_path" "$=
LOCAL" "$REMOTE" -merged=3D"$PWD/$MERGED"
>>>>> + =C2=A0 =C2=A0 fi >/dev/null 2>&1
>>>>> +}
>>>
>>> Is the $PWD/ prefix strictly needed? =C2=A0The rest of the mergetoo=
ls use
>>> $MERGED as-is. =C2=A0Does it work without it?
>>
>> Hrm, I didn't notice it but they do look fishy. =C2=A0Thanks for goo=
d eyes.
>>
>> Tim?
>
> I ran a quick test using msysgit v1.7.9 on Win7 64-bit and found that
> it fails without '$PWD'.
>
> When '$PWD/' is removed from the '-merged' option, it results in a
> Java JRE crash and the conflict resolutions entered by the user are
> not written to the file.
>
> The JRE exception is 'EXCEPTION_ACCESS_VIOLATION (0xc0000005)'. =C2=A0=
I
> posted the full text of the exception to a public location, in case
> anyone is interested [1].
>
> The format of the '-merged' option was copied directly from the
> DeltaWalker manual. =C2=A0There was no explanation why '$PWD' is need=
ed.
>
> [1]: https://gist.github.com/1970590

Thanks, that makes a lot of sense.  It looks like they have a bug.  Do
they know about it?

My naive guess is that they are using some inotify-like thing and
subscribing to a directory (per the stack trace).  Since
dirname("relative") is "" they crash.

So this bug probably wouldn't be present when merging a file in a
sub-directory, or ../ relative path.  Is this the case?

Can you mention this in a comment so that someone doesn't copy/paste
it into another tool in the future?

If they fix it then we may want to consider only supporting the newer
version and remove the $PWD.  Does the OS X version have this bug too?

I didn't notice any other production shell scripts in git using $PWD.
There is one use of `pwd` in git-stash.sh and it's used in a few
tests, as is $PWD, but $(pwd) is the most prevalent overall.  I don't
know the reason $PWD is avoided in the git shell scripts (though
portability is often the reason).

Deltawalker is not currently available on any of the platforms where
this would be a concern, but we may still want to use $(pwd) for
consistency with the other commands.  Does that work instead?
--=20
David
