From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Surprising interaction of "binary" and "eol" gitattributes
Date: Tue, 10 Mar 2015 13:01:44 -0700
Message-ID: <xmqq385c1v13.fsf@gitster.dls.corp.google.com>
References: <54F88684.3020905@alum.mit.edu>
	<xmqqwq2v14iv.fsf@gitster.dls.corp.google.com>
	<54F9422D.2020800@web.de> <54F9E907.4040703@alum.mit.edu>
	<54FA1C7B.3040906@web.de> <54FF450F.7040506@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 10 21:01:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVQLh-0000Wu-5p
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 21:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbbCJUBs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2015 16:01:48 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59742 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751563AbbCJUBr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2015 16:01:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B6A73F11B;
	Tue, 10 Mar 2015 16:01:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mUwGYBrGpiZN
	n+/HCkZzJWZM4fU=; b=rWveX7jX8zjcQ1AoxIah5j8ooMjCoxwu8mx5/Tx+NnbB
	CtvvdsI1lskMhl2hUCrzMWh+vskV7qA9FVpoTlM0GjUJG8k8jApxkuLq8sX3Pxji
	LoliRmL3oxmRdutAqJUTHEJmxCDzgsn5RxjqFsTuYOJL/iesQcJ0etGBkWOGuHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vQFtz9
	/MGXZijHL5eOQydF3/ZnWRpNgXM17qDDqYAEMP5Okh7nkMenqACLos79aR73wD0D
	219zAkyc9mPp5VKJieJr93mXGuu1Oe2ka+RsLTs1bdr6wJ94VFcKe1HOzH8hE9nc
	4WQWzuHpzuL2ofQ1utSp/zD8SRLbKFbGp+/H8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 818563F11A;
	Tue, 10 Mar 2015 16:01:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E893C3F117;
	Tue, 10 Mar 2015 16:01:45 -0400 (EDT)
In-Reply-To: <54FF450F.7040506@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 10 Mar 2015 20:25:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4794CA96-C760-11E4-8A5A-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265259>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 03/06/2015 10:30 PM, Torsten B=C3=B6gershausen wrote:
>>=20
>>> Oops, I misunderstood an internal bug report. In seems that it is t=
he
>>> following scenario that is incorrect:
>>>
>>>     *.png text=3Dauto eol=3Dcrlf
>> Hm, I don't know if we support this combination at all.
>
> The user can specify this combination in a .gitattributes file and we
> have to react to it *some way*.
>
> Theoretically we could document that
> this combination is undefined and/or emit an error if we see this
> combination, but we don't do so.
>
>> The current logic supports auto-detection of text/binary,
>> * text=3Dauto
>> (the files will get the line ending from core.eol or core.autocrlf)
>>=20
>> or the  the setting of a line ending:
>> *.sh eol=3Dlf
>> *.bat eol=3Dcrlf
>>=20
>>=20
>> Is there a special use-case, which needs the combination of both ?
>
> I'm still trying to infer the spirit of the current behavior, so cave=
ats
> here.
>
> This comes from a real-life scenario where a user, somewhere early in
> .gitattributes, had
>
>     * text
>     * eol=3Dcrlf
>
> and then later (this could be in a subdirectory) tried to carve out
> exceptions to this rule by using
>
>     *.png binary
>     * text=3Dauto
>
> Intuitively it *feels* like either of the later lines should suppress
> EOL translation in PNG files (assuming the PNG file has a NUL byte in
> the first 8k, which this one did).

The way I read the description of "eol" was that that was a more
specific way to do what used to be done with "text" (meaning "OK,
that may be a text file, but how exactly is the end-of-line
handled?"), so I would say if the above behaved the same way as

    *.png eol=3Dcrlf text

that would be the least surprising to me.  But perhaps that is only
because I know which one came first and which one came later for
what purpose.

But ...

> It seems to me that setting "text=3Dauto" should mean that Git uses i=
ts
> heuristic to guess whether a particular file is text or not, and then
> treats the file as if it had "text" or "-text" set. If the latter, th=
en
> EOL translation should be suppressed.

=2E.. I think this makes even more sense. I do not think the code is
set up to do so.  To be honest, eol_attr thing introduced in
fd6cce9e (Add per-repository eol normalization, 2010-05-19) always
confuses me whenever I follow this codepath.

> It also seems to me that "binary" should imply "-eol".

I thought that "eol" attribute is not even looked at when you say
"binary"; that is what I recall finding out when I dug into this
earlier in the thread.

http://thread.gmane.org/gmane.comp.version-control.git/264850/focus=3D2=
64872
