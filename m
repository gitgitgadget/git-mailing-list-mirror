From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] http.c: Use timeout suggested by curl instead of
 fixed 50ms timeout
Date: Fri, 04 Nov 2011 11:02:30 -0700
Message-ID: <7v62izdavd.fsf@alter.siamese.dyndns.org>
References: <1320265288-12647-1-git-send-email-mika.fischer@zoopnet.de>
 <1320416367-28843-1-git-send-email-mika.fischer@zoopnet.de>
 <1320416367-28843-3-git-send-email-mika.fischer@zoopnet.de>
 <7vehxndd4q.fsf@alter.siamese.dyndns.org>
 <CAOs=hRKxc9SdE_HTnfs+WdnxZEY6yF9MBV_K1FX2=7B7xtj7-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, daniel@haxx.se, peff@peff.net
To: Mika Fischer <mika.fischer@zoopnet.de>
X-From: git-owner@vger.kernel.org Fri Nov 04 19:02:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMO6A-0006b6-NI
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 19:02:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756081Ab1KDSCe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Nov 2011 14:02:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50595 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755187Ab1KDSCe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Nov 2011 14:02:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BCCB6D0C;
	Fri,  4 Nov 2011 14:02:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Msk+XEMYlCT0
	W2oMPFZMHNF4Flc=; b=CQiVOlmbaXZeAQHyh+aAuhBBoIoiHcflEMGHW93laS/r
	dOMv1/S7zkiAZmNEQXx2JWgGRJxIUKi2QUTuOIlafa3qoKOTXuf9U91OYqwyMiYL
	LToe/sqTstcK4OE19/yZM0yUdshvBcLOI77inD1e0JwfOfcJoagnmE9GPoj9XPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KUhUzY
	5trXDMJc5qHJp1/LRW+E0caQZ7a1w3yJvuqlf1Q3dvtT14VsXoC8gOMBzAXnk/v8
	gidQgbKKyttvrvb17BPd3uc1Ic16UVdmnOxuvcepN9JdGSna0bcr7Wqtk6FTqVX5
	bGOL39PrjyCOev2QEPvGKt1VEeeiWe61ggfKo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDAA16D0A;
	Fri,  4 Nov 2011 14:02:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 587BA6D03; Fri,  4 Nov 2011
 14:02:32 -0400 (EDT)
In-Reply-To: <CAOs=hRKxc9SdE_HTnfs+WdnxZEY6yF9MBV_K1FX2=7B7xtj7-w@mail.gmail.com> (Mika
 Fischer's message of "Fri, 4 Nov 2011 18:47:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2AEA7B30-070F-11E1-BC2F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184794>

Mika Fischer <mika.fischer@zoopnet.de> writes:

>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (slot->in_=
use && !data_received) {
>> =C2=A0#if LIBCURL_VERSION_NUM >=3D 0x070f04
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 long curl_timeout;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0curl_multi_timeout(curlm, &curl_timeout);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (curl_timeout =3D=3D 0) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;
>
> Ah yes, that's good. I would have done it this way in C++, but I
> wasn't sure whether C99 is OK for git.

I do not see anything C99 here.
