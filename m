From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] thin-pack capability for send-pack/receive-pack
Date: Wed, 06 Nov 2013 14:25:50 -0800
Message-ID: <xmqqvc056uc1.fsf@gitster.dls.corp.google.com>
References: <1383750263-32495-1-git-send-email-cmn@elego.de>
	<xmqqbo1x8e60.fsf@gitster.dls.corp.google.com>
	<1383774082.2850.10.camel@centaur.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Nov 06 23:26:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeBY2-00089d-Do
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 23:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766Ab3KFWZ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Nov 2013 17:25:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58528 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709Ab3KFWZ5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Nov 2013 17:25:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBDC3503D8;
	Wed,  6 Nov 2013 17:25:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5Yj787+YrNPF
	h/uQXlF/7IOCQao=; b=Xv7QeCQ97vjBa1VaOe5HIlUt3Y9/KMZWuysXPdQVXGxr
	YMVSu4TAsq1F2CaZ/74vG/TqNdLhDZS7qTZ5zTcBjyplB/984/btCqwkJSQcY2bi
	9y/Lz1EZ7LOlb5dlRzTRX+JcTrxX0twE88rW6ZS6oHH31xm6/k2l7OS2h0t7RTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ILNawz
	3btvyrq0ZeztEi7B/HEJLsBCmsa1i6E/ZFZZJTJNLQl16DliEEuwsBxA1fgEi3ex
	isfNbtkDsUwMkdfpiMaY6BOiq3+UN+7h8PH0nanwqh7Tfa4bmXA0JDUQUyXK8CQO
	C+bMugmH4UcMPZZBVSerpICnGvniWl+JMPJ8w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCAE5503D6;
	Wed,  6 Nov 2013 17:25:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CCC5503D4;
	Wed,  6 Nov 2013 17:25:55 -0500 (EST)
In-Reply-To: <1383774082.2850.10.camel@centaur.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?=
	Nieto"'s message of "Wed, 06 Nov 2013 22:41:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 67705934-4732-11E3-A689-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237375>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> On Wed, 2013-11-06 at 12:32 -0800, Junio C Hamano wrote:
>> I'll queue these for now, but I doubt the wisdom of this series,
>> given that the ship has already sailed long time ago.
>>=20
>> Currently, no third-party implementation of a receiving end can
>> accept thin push, because "thin push" is not a capability that needs
>> to be checked by the current clients.  People will have to wait
>> until the clients with 2/2 patch are widely deployed before starting
>> to use such a receiving end that is incapable of "thin push".
>>=20
>> Wouldn't the world be a better place if instead they used that time
>> waiting to help such a third-party receiving end to implement "thin
>> push" support?
>>=20
>
> Support in the code isn't always enough. The particular case that
> brought this on is one where the index-pack implementation can deal w=
ith
> thin packs just fine.
>
> This particular service takes the pack which the client sent and does
> post-processing on it to store it elsewhere. During the receive-pack
> equivalent, there is no git object db that it can query for the missi=
ng
> base objects. I realise this is pretty a unusual situation.

OK, I agree that it sounds quite niche-y, but it still is sensible.
If a receiving end does not want to (this includes "it is incapable
of doing so", but does not have to be limited to) complete a thin
pack, the series will give it such an option in the longer term.

Thanks.
