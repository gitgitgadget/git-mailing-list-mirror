From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Custom merge driver with no rename detection
Date: Sun, 14 Feb 2016 21:10:17 -0800
Message-ID: <xmqqpovyr22u.fsf@gitster.mtv.corp.google.com>
References: <CALMa68ovz=VZYkCcUDvEn1d7=xJDx__71caqsPXUFASZ1phfdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 06:10:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVBQc-0006If-8o
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 06:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbcBOFKX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 00:10:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63340 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751080AbcBOFKT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2016 00:10:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 33DFD44A6E;
	Mon, 15 Feb 2016 00:10:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zinCpdrUnOmU
	lLUGr0ttfK/7BdA=; b=MhxKbjWgK+R1QSgwRDDjGHPi+MJJlyKOrxenO8elCqlp
	/ZhBjeYoS/Y/2CJrRlgg9q5aPhnnzgGVTXWNJxh2u4rE9kD15C9oTINyU8xp23Gg
	8Z5LObCaoP6hIZhj5WAGtQyJioAPiDzGxLLT32nINNamJTHCOnfG8KpA08Ong8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=c9G64P
	9n2JP8n50zvhaFF9ZbQfKY8yDx1luLWXTKrCrkPMysCfd/24t2QT9pfGiqhQuyFI
	+NpnABUnSSdReAkLTcwHUtacLbeCDiC7as/QPlQTgfySzN/mUrmuF06VU8rvldKj
	u8jqUjzN0IoRHWeCXEUiuTrBu9HGRZmR62Cy0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2B68244A6C;
	Mon, 15 Feb 2016 00:10:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A349144A6B;
	Mon, 15 Feb 2016 00:10:18 -0500 (EST)
In-Reply-To: <CALMa68ovz=VZYkCcUDvEn1d7=xJDx__71caqsPXUFASZ1phfdw@mail.gmail.com>
	("Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis"'s message of "Sun, 14 Feb 2016
 17:51:10
	-0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 67F332EC-D3A2-11E5-B46C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286173>

=46elipe Gon=C3=A7alves Assis <felipeg.assis@gmail.com> writes:

> The usual workaround is using the resolve strategy, but apparently it
> ignores the custom merge driver.

Hmph.

Indeed, git-merge-file seems to call xdl_merge() directly, bypassing
the ll_merge(), which is understandable as the former predates the
latter.  That needs to be fixed, I think.
