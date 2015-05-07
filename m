From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/12] t5520: implement tests for no merge candidates cases
Date: Thu, 07 May 2015 08:56:39 -0700
Message-ID: <xmqq4mnos7ns.fsf@gitster.dls.corp.google.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-2-git-send-email-pyokagan@gmail.com>
	<554B2AEB.3020608@web.de>
	<xmqqh9roscty.fsf@gitster.dls.corp.google.com>
	<CACRoPnSCvitGfVKyqV7PJd_TzLJEs8U_mjYhaRy3KOFrWjBEwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 17:56:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqOAN-0005Zq-Tx
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 17:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbbEGP4o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 May 2015 11:56:44 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50966 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751638AbbEGP4l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2015 11:56:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AAE14DE80;
	Thu,  7 May 2015 11:56:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0tUPc9amn/oV
	6GWlxB9VdiSGyso=; b=Y4uNI9QJ93V2i1JhdKlNHsMee4BdTId+ilKp9+dU+ES9
	FW+iBYXv0aOVzq8W+RWOFZju1Qmo2fHLojAL4lUQUHeXFBiYZ3oIQuP46IEE7XfB
	Lg2C3I8ms1Ppb2D3SYeHf98exUzpGVpxsV+qhRaMeLK1ylTQEWm4PJlStkH8aFs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rSG19L
	O4BPCQ0hX3I4yRAT3gxvY5hNFnWQwoMpCW7L035/R8sxamj23EYNRxcVE0YL3pL6
	Durc7P19jhc0QjrguWmHFmgdnBY6znHPFgMvJ0irAGAd32mTNSd2AhY2HLkl48qv
	d/9piGKTeSEJznS/g8Nsjj276+hLOlIwz/mcM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 01D7B4DE7F;
	Thu,  7 May 2015 11:56:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72D8F4DE7E;
	Thu,  7 May 2015 11:56:40 -0400 (EDT)
In-Reply-To: <CACRoPnSCvitGfVKyqV7PJd_TzLJEs8U_mjYhaRy3KOFrWjBEwA@mail.gmail.com>
	(Paul Tan's message of "Thu, 7 May 2015 22:47:02 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A66CDE5C-F4D1-11E4-B1B0-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268536>

Paul Tan <pyokagan@gmail.com> writes:

> Hi Junio,
>
> On Thu, May 7, 2015 at 10:04 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>>
>>> In other words:
>>> test $(cat file) =3D file &&
>>
>> Is there a guarantee that file has a single word?  Can it be empty?
>> Can it contain "foo bar\n"?
>
> It can, but it should not ;-). But yes, this will need to be quoted a=
s
> well to be safe. Whoops.

Yup.  I see that existing test (this script is ancient, isn't it?)
has the same issue of using backticks and not quoting sufficiently.

Perhaps we would want a clean-up-and-modernise step before this
patch to reduce patch noise.

Thanks.
