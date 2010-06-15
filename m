From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] textconv: support for blame
Date: Tue, 15 Jun 2010 08:00:06 -0700
Message-ID: <7vfx0o8hop.fsf@alter.siamese.dyndns.org>
References: <1275921713-3277-1-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275924218-20154-1-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275924218-20154-2-git-send-email-axel.bonnet@ensimag.imag.fr>
 <7vfx0p9wlm.fsf@alter.siamese.dyndns.org>
 <0091febb4a3832a6680a0fbc2209f841@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: clement.poulain@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Tue Jun 15 17:00:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOXcm-0007GW-QK
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 17:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757993Ab0FOPAR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 11:00:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43724 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481Ab0FOPAQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jun 2010 11:00:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B13ABA403;
	Tue, 15 Jun 2010 11:00:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nX8105Sm2Iff
	TwlcdOZwvHD9tyI=; b=F3Elco5uC6yzkWLLhjdLTwdoSrWZZtvyXOTyd/Sqbm0r
	Q/Ww5gOGxmopky3VvEdM5yob7GvOn4wYaIp5GPAgyDYspVgOtQTzhxeIRSOSa/xc
	4uvkaLGQhFSnXYfRCvjg50sxt3csn6zK95eFyRmVF3P6xyEEuzh0C5CzBqTPPnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bQU1Tn
	pgQh3PdubSXCwTbBdWp+Pus9v0RhfPRwQDGBntwZp4Me/zIw1u1Q74GIrNJ5o6nk
	eh+yCFBn0exc55GIosoDYkTd4fU6yjAxuJBNvyxo8a4zE/3Vxwl8j/QBuzCJQwLe
	kdeIUIkcL2S4XRoYioFjP3B0MUNDX+5W7vJSc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EB07BA402;
	Tue, 15 Jun 2010 11:00:11 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E3A8BA3FE; Tue, 15 Jun
 2010 11:00:08 -0400 (EDT)
In-Reply-To: <0091febb4a3832a6680a0fbc2209f841@ensimag.fr> (=?utf-8?Q?=22C?=
 =?utf-8?Q?l=C3=A9ment?= Poulain"'s message of "Tue\, 15 Jun 2010 11\:29\:57
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B2168222-788E-11DF-8198-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149188>

Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr> writes:

> On Mon, 14 Jun 2010 13:40:21 -0700, Junio C Hamano <gitster@pobox.com=
>
> wrote:
>> Axel Bonnet <axel.bonnet@ensimag.imag.fr> writes:
>>=20
>>> @@ -86,16 +87,49 @@ struct origin {
>>> ...
>>> +static void fill_origin_blob(struct diff_options *opt,
>>> +			     struct origin *o, mmfile_t *file)
>>>  {
>>>  	if (!o->file.ptr) {
>>>  		enum object_type type;
>>>  		num_read_blob++;
>>> -		file->ptr =3D read_sha1_file(o->blob_sha1, &type,
>>> -					   (unsigned long *)(&(file->size)));
>>> +
>>> +		if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
>>> +		    textconv_object(o->path, o->blob_sha1, &file->ptr,
>>> +				    (size_t *) &file->size))
>>=20
>> This cast is not correct, as there is no guarantee that your size_t =
and
>> typeof(mmfile_t.size) are compatible.  Depending on the gcc version,=
 you
>> would get "dereferencing type-punned pointer will break strict-alias=
ing
>> rules" error.
>>=20
>> The same issue exists in Cl=C3=A9ment's patch to builtin/cat-file.c.
>
> We did this way because we found a similar cast in prep_temp_blob(),
> diff.c:
>
> 	if (convert_to_working_tree(path,
> 			(const char *)blob, (size_t)size, &buf)) {
>
> where size is an unsigned long.

That is a completely different kind of cast that is sane.  The function
takes a _value_ of type size_t.

Your cast is "This function wants to store a value to a _memory locatio=
n_
that is supposed to hold a value of type size_t, and I know &(file->siz=
e)
is not such a location (it is to hold a value of type 'unsigned long');
please pretend that these two distinct pointers are compatible", which =
is
a big no-no.
