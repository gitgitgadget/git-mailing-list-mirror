From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 4/6] t0060: Add tests for prefix_path when path begins with work tree
Date: Tue, 04 Feb 2014 12:07:23 -0800
Message-ID: <xmqqmwi68ww4.fsf@gitster.dls.corp.google.com>
References: <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
	<1391523920-26946-1-git-send-email-martinerikwerner@gmail.com>
	<1391523920-26946-5-git-send-email-martinerikwerner@gmail.com>
	<52F146E1.4000604@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Erik Werner <martinerikwerner@gmail.com>,
	git@vger.kernel.org, richih@debian.org, pclouds@gmail.com,
	dak@gnu.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 04 21:16:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAmQ5-0001qe-3D
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 21:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbaBDUQZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Feb 2014 15:16:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63756 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932400AbaBDUQX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Feb 2014 15:16:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEF6A69FB4;
	Tue,  4 Feb 2014 15:16:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=G3aHPE/OFdIm
	vP1PFVAVSy2h9XQ=; b=MmY38EspZhgjbvRBsyrqp6RkE6GuAbaotwNIIuGSz7xp
	WQTDjJRKaud48eBcaUN6xrjbnMHuHnszaudqmwwvuRZ7ZKveCVVMj3KCq7CP5sW3
	mFEBCH4xVcdP5azFP9/d7qs8u5b06eG1G+PrUZCulDrLMdzwfdLRiVgNML9+Kts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lEeYmj
	TlORGRU5loa1rGvveXCu6C1bQhLE/YKmR/CVtUtUg4jMGq0lUnU7ovnWyTtYwPsn
	EPftp6rCLKeje/JmyOk0Wq2FlTMjj/exECki40Urs9iEahpy3Xv4WnGNZQ2tJgJj
	4NmK5CPX46jOp7Al5XfOwr2fRCYZvQEINxUr4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8312969FB3;
	Tue,  4 Feb 2014 15:16:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6D9D69C28;
	Tue,  4 Feb 2014 15:07:25 -0500 (EST)
In-Reply-To: <52F146E1.4000604@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Tue, 04 Feb 2014 21:00:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F74B0658-8DD7-11E3-BF23-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241547>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2014-02-04 15.25, Martin Erik Werner wrote:
>
>>  t/t0060-path-utils.sh | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>=20
>> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
>> index b8e92e1..c0a14f6 100755
>> --- a/t/t0060-path-utils.sh
>> +++ b/t/t0060-path-utils.sh
>> @@ -201,6 +201,16 @@ test_expect_success 'prefix_path works with onl=
y absolute path to work tree' '
>>  	test_cmp expected actual
>>  '
>> =20
>> +test_expect_success 'prefix_path rejects absolute path to dir with =
same beginning as work tree' '
>> +	test_must_fail test-path-utils prefix_path prefix "$(pwd)a"
>> +'
>> +
>> +test_expect_success 'prefix_path works with absolute path to a syml=
ink to work tree having  same beginning as work tree' '
>> +	git init repo &&
>> +	ln -s repo repolink &&
>> +	test "a" =3D "$(cd repo && test-path-utils prefix_path prefix "$(p=
wd)/../repolink/a")"
>> +'
> I think we need SYMLINKS here.

Yes.
