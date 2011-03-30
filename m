From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 2/2] Future Proofing: Pass around pointers to either
 functions or data
Date: Wed, 30 Mar 2011 12:41:43 -0700
Message-ID: <7vlizwmm4o.fsf@alter.siamese.dyndns.org>
References: <3c6b883f-8860-4da2-b328-d912019a4145-mfwitten@gmail.com>
 <522d5a8a-a674-40bd-91bf-b5b8f88e0f78-mfwitten@gmail.com>
 <AANLkTi=nxA0BrLruQ9zc_SajH2ghpZX14Ra7QOo9fMBx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 30 21:42:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q51HR-00030H-L3
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 21:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755355Ab1C3Tl4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Mar 2011 15:41:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65068 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754838Ab1C3Tlz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Mar 2011 15:41:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CA39B49E0;
	Wed, 30 Mar 2011 15:43:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zdTYMtoHP8X8
	V0iVmdnze1nYE4E=; b=Jf9K44HtCwd71lfb+IdQtBNFcpJNV+OSMWup3BHJeb8t
	RjwDoS6XvXXZL8gbfjv2McflA5ov8hN206QKQp6lh2olhHfElbPIBNfPTzt6+zqj
	qN5A6rgwRINf6c902CWUMYWxaQ+SgQq6FbenWp+lMMe8GE+6Qhj7/Zn/n4vOYsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Xrvx+1
	f2mhqWutkGsfUaf3FqUv/UUuJMdTPAAwfouL7x41R7cxf7YHd2UM7jA65U8kJZ1G
	adThD5uJy60QDwgcMKXe1nPhTelobwMWx7LImJWPx2g2LIhvTzEGsesfyZDGNjaH
	LqdYQJXAAOSE7KEEyN1RvjdLjzPuUIrhu9Hp4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 95FA649DB;
	Wed, 30 Mar 2011 15:43:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4D3CE49DA; Wed, 30 Mar 2011
 15:43:33 -0400 (EDT)
In-Reply-To: <AANLkTi=nxA0BrLruQ9zc_SajH2ghpZX14Ra7QOo9fMBx@mail.gmail.com>
 (Erik Faye-Lund's message of "Wed, 30 Mar 2011 12:09:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 01911BC8-5B06-11E0-978E-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170414>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Tue, Mar 29, 2011 at 5:28 PM, Michael Witten <mfwitten@gmail.com> =
wrote:
>> +#define ALT_ODB_FN_INFO_FUNC(variable, function) \
>> + =C2=A0 =C2=A0 =C2=A0 union alt_odb_fn_info variable =3D { \
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .func =3D (alt_od=
b_fn_cb)function \
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +#define ALT_ODB_FN_INFO_DATA(variable, data_) \
>> + =C2=A0 =C2=A0 =C2=A0 union alt_odb_fn_info variable =3D { \
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .data =3D data_ \
>> + =C2=A0 =C2=A0 =C2=A0 }
>
> We try to stay away from C99 features like this, as it doesn't work o=
n
> all compilers we target.

I had an impression that 1/2 is a good fix but 2/2 is going overboard w=
ith
a theoretical exercise without real gain.
