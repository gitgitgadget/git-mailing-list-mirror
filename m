From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] archive-zip: add --text parameter
Date: Thu, 05 Mar 2015 16:27:40 +0100
Message-ID: <54F875EC.2020600@web.de>
References: <12g5ss8uqwflv.dlg@nililand.de> <54F77573.80109@web.de> <xmqq7fuw5guc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: luatex@nililand.de, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 16:28:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTXh6-0005UX-8i
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 16:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932872AbbCEP2H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2015 10:28:07 -0500
Received: from mout.web.de ([212.227.15.4]:61208 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932834AbbCEP2F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 10:28:05 -0500
Received: from [192.168.178.27] ([79.250.191.206]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MS1tK-1Y1Owl3h3S-00TAyr; Thu, 05 Mar 2015 16:27:53
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqq7fuw5guc.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:us8xlWQfX5hg0jTc1dRKNAVXH3WtSOGtkHLhf25YP0B+bhqutRj
 jU0YWZI2qA0b3uyjikmMrfXARmdEX1ksxY4m4ICYHSdUrQYk7PLw1Q+iIjRvr5mFT+t/mOz
 TU5a1BnBckDk8XHP8t5k1ksnKLe0ywIhb9BZ791cTNulYKSEJGlJytVxMHOpK3wZ50wqWYB
 teZ1eYhRKavDKQMREaHIw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264842>

Am 05.03.2015 um 03:16 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> No sign-off, yet, because I'm not sure we really need another option=
=2E
>> E.g. --text=3Dall doesn't seem to be actually useful, but it was eas=
y to
>> implement.  Info-ZIP's zip always creates archives like --text=3Daut=
o
>> does, so perhaps we should make that our default behavior as well?
>
> My knee-jerk reaction is "yeah, why not? what are the downsides,
> other than the result will not be bit-for-bit identical to the
> output from older Git".  I am sure I am missing something as I do
> not regularly use this format.

AFAICS there won't be any other downsides.  And archive stability is=20
harder to achieve for ZIP anyway because it depends on compression leve=
l=20
and (more fundamentally) on libz version.

>> @@ -256,6 +264,8 @@ static int write_zip_entry(struct archiver_args =
*args,
>>   				return error("cannot read %s",
>>   					     sha1_to_hex(sha1));
>>   			crc =3D crc32(crc, buffer, size);
>> +			if (is_binary < 0)
>> +				is_binary =3D buffer_is_binary(buffer, size);
>
> In this codepath, do you have the path of the thing the buffer
> contents came from?  I am wondering if consulting the attributes
> system is a better idea. Anything that is explicitly marked as
> "binary" or "-diff" is definitely binary, and anything that is not
> marked as "binary" is text to us for all practical purposes, no?

Yes, attributes can help, especially to allow users to correct wrong=20
guesses of the heuristic.  Offering automatic detection of binary files=
=20
by default like git diff and git grep is still a good idea, I think.=20
buffer_is_binary() doesn't add a lot of overhead since it only looks at=
=20
the first few bytes of the buffer.

Ren=C3=A9
