From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH v2] mergetools: add support for DeltaWalker
Date: Sat, 3 Mar 2012 22:50:55 -0500
Message-ID: <CAFouetjZ0kQMnAPdNey5kSEmq+fmQqq+fC51hcT+9k6T8c6uOw@mail.gmail.com>
References: <1330694867-7601-1-git-send-email-tim.henigan@gmail.com>
	<7vaa3ybpat.fsf@alter.siamese.dyndns.org>
	<CAJDDKr4q7gmFeHuGM5hFruduHw-3mGa+CMU=U6X0jjXUsJLsvw@mail.gmail.com>
	<7vmx7x5ml0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 04 04:51:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S42Tr-0003qj-0X
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 04:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754328Ab2CDDvU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Mar 2012 22:51:20 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55581 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754317Ab2CDDu4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Mar 2012 22:50:56 -0500
Received: by iagz16 with SMTP id z16so4074927iag.19
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 19:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=bnU7F0EuJAiHukT8m5ew+406IGhg/SivDUrX5RDQetE=;
        b=BVcvs3DvBX9xIIe6Qg0F//9HYCXlctoTwY8Gh14zS2p1RdE99swNueMjyL0ZPMInCs
         r+XLaiPR+FH7ATMlvhJXJ0Urrrn01UcEp0punZX4xgiGg7gUzwQoqZsImzrZjU8oSA4Y
         uo2XssK5wtYEZO5vU2r7YIpj+sMoG2y6Y5aSSI4xrnhuKBhMdXPjRqQUyTnfFsAcgy57
         jhNSQIvSnAjlencToTU9YHbRzS3yo05QXlr5gYrR0YaaTLPTJybt4k2wPNRppB/jR9Dj
         86p3kbJ1dlwXmKUaKVZV+o8Yqt+y07jgBt3vIH1u71YKITdLxYYL0wsaxLvq6TtfNUbP
         zM9Q==
Received: by 10.50.153.166 with SMTP id vh6mr2535797igb.44.1330833055984; Sat,
 03 Mar 2012 19:50:55 -0800 (PST)
Received: by 10.42.218.65 with HTTP; Sat, 3 Mar 2012 19:50:55 -0800 (PST)
In-Reply-To: <7vmx7x5ml0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192144>

On Sat, Mar 3, 2012 at 5:47 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> David Aguilar <davvid@gmail.com> writes:
>
>>>> +merge_cmd () {
>>>> + =C2=A0 =C2=A0 if $base_present
>>>> + =C2=A0 =C2=A0 then
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "$merge_tool_path" "$L=
OCAL" "$REMOTE" "$BASE" -merged=3D"$PWD/$MERGED"
>>>> + =C2=A0 =C2=A0 else
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "$merge_tool_path" "$L=
OCAL" "$REMOTE" -merged=3D"$PWD/$MERGED"
>>>> + =C2=A0 =C2=A0 fi >/dev/null 2>&1
>>>> +}
>>
>> Is the $PWD/ prefix strictly needed? =C2=A0The rest of the mergetool=
s use
>> $MERGED as-is. =C2=A0Does it work without it?
>
> Hrm, I didn't notice it but they do look fishy. =C2=A0Thanks for good=
 eyes.
>
> Tim?

I ran a quick test using msysgit v1.7.9 on Win7 64-bit and found that
it fails without '$PWD'.

When '$PWD/' is removed from the '-merged' option, it results in a
Java JRE crash and the conflict resolutions entered by the user are
not written to the file.

The JRE exception is 'EXCEPTION_ACCESS_VIOLATION (0xc0000005)'.  I
posted the full text of the exception to a public location, in case
anyone is interested [1].

The format of the '-merged' option was copied directly from the
DeltaWalker manual.  There was no explanation why '$PWD' is needed.

[1]: https://gist.github.com/1970590
