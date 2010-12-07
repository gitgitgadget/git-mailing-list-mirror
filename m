From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cmd_cherry in builtin/log.c?
Date: Tue, 07 Dec 2010 12:30:29 -0800
Message-ID: <7vaakhpbq2.fsf@alter.siamese.dyndns.org>
References: <AANLkTikXmc-3BBkxy-D8GNLAMXUOPghp78GpStZ-_wBW@mail.gmail.com>
 <20101207173923.GA21483@burratino> <4CFE83A2.8070004@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Dec 07 21:30:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ4BT-000455-Dy
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 21:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754352Ab0LGUam convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 15:30:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45437 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891Ab0LGUal convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 15:30:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 882B53A05;
	Tue,  7 Dec 2010 15:31:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Uvgh4bW/r+iH
	ZPjDP8mzXPTLeDM=; b=x1VFiV47M/DB5bJ1BiPTdBPawd3XM5q7LH8Ut19LftP5
	uffjQI6PGHRCE4/SlrcnJQzBYUWYjIa2Loxg9oMWAYtckcPs7RD69/jJbuOPSGLr
	vUiZDaBFgbFdb64OL3DEdhqrkeGjaneSxu3VLZOfJ+6W+YNtAobPR3xWKwKrzTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=l2znxF
	3mQlOEg5eOuaKAHGLWvm9NrbM+aqQNmdBb2e3Ve6PQ13OnW7fk1Kcr4KC2sv6DyB
	fBGhl9M8LOcoiDJ9VUFzX9A9IGWSLfr7OlHzHblLQiMtQPw7xWm+ka2EdZQAVkaQ
	ogfiIhmP0iet+LzyZqQAf53vLZvvN4wAlrOXw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4453B39FF;
	Tue,  7 Dec 2010 15:30:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D0EF939F6; Tue,  7 Dec 2010
 15:30:53 -0500 (EST)
In-Reply-To: <4CFE83A2.8070004@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Tue\, 07 Dec 2010 19\:57\:38 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E6AD2310-0240-11E0-B0BA-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163125>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 07.12.2010 18:39, schrieb Jonathan Nieder:
>> while the core of the builtin version is
>>=20
>> 	get_patch_ids(&revs, &patch_id_opts, prefix);
>>=20
>> The latter function is static, introduced by v1.4.1~12^2~5
>> (format-patch: introduce "--ignore-if-in-upstream", 2006-06-25).
>>=20
>> So the answer is that "git cherry" is considered a variant on
>> "git log" (like format-patch, show, and whatchanged) and that it use=
s
>> "git log" internals.
>
> That's right.  get_patch_ids() could be moved into patch-ids.c now an=
d
> then cmd_cherry() could get its own file in builtin/, though.

Right, but the key word is "could".  Is it hurting _anything_ to have i=
t
in the current place?  I doubt it.
