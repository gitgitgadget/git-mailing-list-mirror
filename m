From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/18] Offer a function to demote fsck errors to warnings
Date: Mon, 22 Dec 2014 14:40:40 -0800
Message-ID: <xmqqy4pz71g7.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<2a0c4cd4c5d3aaceff8a6ffa49d2f3597d26086d.1418055173.git.johannes.schindelin@gmx.de>
	<xmqqoarbidv7.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222232270.21312@s15462909.onlinehome-server.info>
	<xmqqfvc78hwq.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222330080.21312@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 22 23:40:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3Beh-00010r-LA
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 23:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbaLVWkn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Dec 2014 17:40:43 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751110AbaLVWkn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Dec 2014 17:40:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DACB29D23;
	Mon, 22 Dec 2014 17:40:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+OxvCBbI+9rQ
	5ZwygkE6cz4iDpo=; b=BqQn+6Jf4cFNVqhfmTMky54y76bz6GfN0Fg5EpbGAPG8
	lOczsRfu5kMDbTinAIeaL1bYMmLvBC067XxG1TwDzm4kAh3Yzq1cFzmaJIJkxqTc
	rhothBXDg6FOQaB/4KT0e3uTKrwHZEj1XtMof1y+hotAVEmbTmhGHw3c51/kUS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PAmVam
	ZP/LkRCmKipXnZtyq07SdPHQbGhbwzvHfozRkeg07CKFhW9SzjogV1mP7DYXrvKD
	4YrWW+vjk0tpEwM4467nKFG6NTOQyHhwLJsJC2HRovjJLHemMecoh2iXNf6Dwngd
	gyg1C/2MvsYdy3zX94m1mU0xbsjaRnrvTG3rI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 84E2E29D22;
	Mon, 22 Dec 2014 17:40:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 09A2C29D21;
	Mon, 22 Dec 2014 17:40:41 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1412222330080.21312@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Mon, 22 Dec 2014 23:32:44 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8F4FDBD6-8A2B-11E4-B6BA-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261689>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 22 Dec 2014, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>=20
>> >> In other words, at some point wouldn't we be better off with
>> >> something like this
>> >>=20
>> >> 	struct {
>> >>         	enum id;
>> >>                 const char *id_string;
>> >>                 enum error_level { FSCK_PASS, FSCK_WARN, FSCK_ERR=
OR };
>> >> 	} possible_fsck_errors[];
>> >
>> > I considered that, and Michael Haggerty also suggested that in a p=
rivate
>> > mail. However, I find that there is a clear hierarchy in the defau=
lt
>> > messages: fatal errors, errors, warnings and infos.
>>=20
>> I am glad I am not alone ;-)
>> ...
> Oh, but please understand that this hierarchy only applies to the def=
ault
> settings. All of these settings can be overridden individually =E2=80=
=93 and the
> first override will initialize a full array with the default settings=
=2E

But that means that the runtime needs to switch between two code
with and without override, no?

> 	if (options->strict_mode)
> 		return options->strict_mode[msg_id];

In other words, I think this is misleading and unnecessary
optimization for the "full array" allocation.  A code that uses an
array of a struct like the above that Michael and I independently
suggested would initialize once with or without an override and then
at the runtime there is no "if the array is there use it"
conditional.

I do not know why Michael suggested the same thing, but the reason
why I prefer that arrangement is because I think it would be easier
to read and maintain.

Thanks.
