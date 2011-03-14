From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] make_absolute_path: Don't try to copy a string to
 itself
Date: Mon, 14 Mar 2011 15:58:53 -0700
Message-ID: <7vpqptb976.fsf@alter.siamese.dyndns.org>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
 <1300130318-11279-2-git-send-email-cmn@elego.de>
 <7v39mpcuv9.fsf@alter.siamese.dyndns.org>
 <1300140128.4320.39.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Mon Mar 14 23:59:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzGjG-0005ml-Ek
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 23:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300Ab1CNW7E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2011 18:59:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35755 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216Ab1CNW7D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Mar 2011 18:59:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1846A4042;
	Mon, 14 Mar 2011 19:00:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QSMkRh4ojQSn
	TMiL/N+rM4xFhao=; b=XW4kAMm32v3o0Weg3XWhDD1S2mMQACNq9WYqsdZIeBHX
	7erHD+J/QUNVvZz14md5+xlnvKFDHND5H1GJiqPj6hZ0BKIKllhaUg0KLj+hlUS9
	Rtx3fGELOppD3EmHQkLwVfFF6h/pQNJIovGob4M6oJgxJiR3/WWH1aDgOfwH4X0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JWLZyA
	lL34DQScnN7QE0zxMtPazM5ZheYKN89j942hQ/0VoNXhkx4CQgUX9QPAFv0T8jvR
	+J0XOMw/Xxe1UlfrCZKFBq6rUY+bh2O1Hso8W3h9/hVmlBMRtlgoDJUExav49AIV
	/ZSWqW1h0WsaqmrGSmbjiIK5XmVNaYsj+Elj0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EA415403E;
	Mon, 14 Mar 2011 19:00:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id ED45E4030; Mon, 14 Mar 2011
 19:00:24 -0400 (EDT)
In-Reply-To: <1300140128.4320.39.camel@bee.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Mon, 14 Mar 2011 23:02:07
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA784972-4E8E-11E0-AF1F-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169033>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

>> I don't think it is a bad idea per-se to avoid a copy from the same =
memory
>> location into the same memory location, but independent of the neces=
sity
>> of fixes at the low-level, shouldn't we fix the callers that do not =
check
>> if what they have is already absolute?
>
> If we'd like the semantics to be "whatever I had, I now know what the
> absolute path is" then we could make the check in the beginning of th=
e
> function, to centralise the check. If the semantics should be "I don'=
t
> have an absolute path, so I need to figure out what it is", then ther=
e
> should be a check before calling make_absolute_path() (the name sugge=
sts
> the second).

Good thinking, and I think the former semantics would be easier to use.

>  There is however the extra functionality the function offers, namely
> resolving links. It might be good to split it into two functions so e=
ach
> caller can specify what it wants.

Probably.
