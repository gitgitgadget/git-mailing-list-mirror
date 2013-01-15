From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] tests: turn on test-lint-shell-syntax by default
Date: Tue, 15 Jan 2013 21:12:46 +0100
Message-ID: <50F5B83E.9060800@web.de>
References: <201301120650.46479.tboegi@web.de> <7vvcb37xfe.fsf@alter.siamese.dyndns.org> <50F28BB5.9080607@web.de> <20130113173207.GC5973@elie.Belkin> <7v4nikiu81.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaA==?= =?UTF-8?B?YXVzZW4=?= 
	<tboegi@web.de>, git@vger.kernel.org, kraai@ftbfs.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 21:13:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvCsz-0005TN-77
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 21:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817Ab3AOUNI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2013 15:13:08 -0500
Received: from mout.web.de ([212.227.17.12]:53898 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863Ab3AOUNH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 15:13:07 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0Lx7Ab-1St0ac1Ytd-01743y; Tue, 15 Jan 2013 21:12:47
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7v4nikiu81.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:5/yn4JojvclPchTA68I8A07ixjyGPDIDYKb/ha6O0l+
 2DTt/+w3FJ1ihna/nqc99k9ejL3VU4c06Mh7v06/ZMs+jZji9U
 KeSDd0vHRIdkrIgISqYj0J3t43yrriICo89JBeg9wj9TfSTfw1
 w7K3mLavzHM/rYNrtcMP5QFpKJVoTzlpKEgIsN/srTJUTuNWCX
 98BZiC2R48MkQGqdtcqMw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213670>

On 13.01.13 23:38, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>=20
>> Hi,
>>
>> Torsten B=C3=B6gershausen wrote:
>>
>>> -	/^\s*[^#]\s*which\s/ and err 'which is not portable (please use t=
ype)';
>>> +	/^\s*[^#]\s*which\s+[-a-zA-Z0-9]+$/ and err 'which is not portabl=
e (please use type)';
>>
>> Hmm.  Neither the old version nor the new one matches what seem to
>> be typical uses of 'which', based on a quick code search:
>>
>> 	if which sl >/dev/null 2>&1
>> 	then
>> 		sl -l
>> 		...
>> 	fi
>>
>> or
>>
>> 	if test -x "$(which sl 2>/dev/null)"
>> 	then
>> 		sl -l
>> 		...
>> 	fi
>=20
> Yes, these two misuses are what we want it to trigger on, so the
> test is very easy to trigger and produce a false positive, but does
> not trigger on what we really want to catch.
>=20
> That does not sound like a good benefit/cost ratio to me.
>=20
Thanks for comments, I think writing a regexp for which is difficult.
What do we think about something like this for fishing for which:

--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -644,6 +644,10 @@ yes () {
                :
        done
 }
+which () {
+       echo >&2 "which is not portable (please use type)"
+       exit 1
+}


This will happen in runtime, which might be good enough ?


@Matt:
>The "[^#]" appears to ensure that there's at least one character
>before the which and that it's not a pound sign.  Why is this done?
This is simply wrong.
