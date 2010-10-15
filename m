From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 15/15] daemon: opt-out on features that require posix
Date: Fri, 15 Oct 2010 14:16:57 -0700
Message-ID: <7vbp6vduly.fsf@alter.siamese.dyndns.org>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-16-git-send-email-kusmabite@gmail.com>
 <7vhbgphf25.fsf@alter.siamese.dyndns.org>
 <AANLkTi=N+4QokkiGmN+S17=7=QsgKWUXrsF0vZ_6Zt2H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	avarab@gmail.com, sunshine@sunshineco.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Oct 15 23:17:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6ref-0001s5-Rt
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 23:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642Ab0JOVRR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Oct 2010 17:17:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58588 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932336Ab0JOVRP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Oct 2010 17:17:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AD719DFBBD;
	Fri, 15 Oct 2010 17:17:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Tc9VoeJIxK4A
	9giM36g4+UAz9M8=; b=UUJXMe5ZbbNycCnSWl1dxAOU9gWlo1c3LwuibNXl8AXq
	h578Yu1GHntZaFKtliT0f91bXtTWN/DoKynxDzazgw9m/D+K/zQ/2isLXZFvewMq
	tzV3kUpypuQaffRUsK/DY6UgeKwseJ59iYT4XBkMaKmioDsHRZ2XwFPaL0cE/ek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hq8wcV
	0IlYKaLIG2SC51R6FwB1JumDYMww8eYQZ1Rib9h+ktZYWVakOtYW8ct5U/He4xCF
	m2R6XqXyG/HnnuPWkr0F8HHhuBdcDG+VQwhbtF5WHFCZqqycqIM5jp+YYYd943Vz
	OKaa4HmFF4vysdhH2diCmYnV3ZeRY73Cz2Fuk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A5BD1DFBBA;
	Fri, 15 Oct 2010 17:17:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 900D9DFBB8; Fri, 15 Oct
 2010 17:16:59 -0400 (EDT)
In-Reply-To: <AANLkTi=N+4QokkiGmN+S17=7=QsgKWUXrsF0vZ_6Zt2H@mail.gmail.com>
 (Erik Faye-Lund's message of "Thu\, 14 Oct 2010 13\:02\:10 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 904970C8-D8A1-11DF-9842-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159138>

Erik Faye-Lund <kusmabite@gmail.com> writes:

>>> -static int serve(struct string_list *listen_addr, int listen_port,=
 struct passwd *pass, gid_t gid)
>>> +#ifndef NO_POSIX_GOODIES
>>> +static struct passwd *pass;
>>> +static gid_t gid;
>>> +#endif
>>> +
>>> +static int serve(struct string_list *listen_addr, int listen_port)
>>> =C2=A0{
>>> =C2=A0 =C2=A0 =C2=A0 struct socketlist socklist =3D { NULL, 0, 0 };
>>>
>>
>> This is ugly. =C2=A0Why did you need to make the arguments file-scop=
e static?
>>
>
> To avoid having different signatures for the serve-function dependent
> on NO_POSIX_GOODIES.

Why does the signature even have to be different between the two to beg=
in
with?  I _think_ you have gid_t over there, although you might not have
"struct passwd", in which case you can just define an empty one that yo=
ur
alternate implementation is not going to use anyway.  This is especiall=
y
true if you are making the "drop-privileges" part a helper function, no=
?
