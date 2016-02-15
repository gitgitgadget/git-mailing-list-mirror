From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Custom merge driver with no rename detection
Date: Mon, 15 Feb 2016 01:57:43 -0800
Message-ID: <xmqqlh6mqors.fsf@gitster.mtv.corp.google.com>
References: <CALMa68ovz=VZYkCcUDvEn1d7=xJDx__71caqsPXUFASZ1phfdw@mail.gmail.com>
	<xmqqpovyr22u.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1602150854520.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis <felipeg.assis@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 15 10:57:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVFui-0007rx-Nh
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 10:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbcBOJ5s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 04:57:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56248 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752500AbcBOJ5q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2016 04:57:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5B87F3E869;
	Mon, 15 Feb 2016 04:57:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tdBIVI9xf7s1
	FiNubps3R03YxfU=; b=Jn6Hnm8B3BxW5twd8ltr6WKMGYtvHW9wdWLhUYaR5gPC
	Of8sfz1f6TxP/GK7f+kS0B8jEc/Al3HsJRBfJ6VgfCs5pyp2u9wRJh53prX1XVyt
	5X0plAC/GZCCyLuEVE/r7Q1cXnmUE+W8sS7BnRA7kTtHrJHf3O8oxVfO3yGVJbM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=d2X7V9
	jJhg5ERnE5nYWC7GFUd7AlefjJcu3Jgk/+pNRDBnieBfVoCYOk9upzQ3b6XRh/kg
	65sx69gAkdL4PTrD+xRPeKPR2FDWG4eQmxypIHryF2mVts7/kHmqWXtjrz2SHPHe
	CCYvvGRLUjbrMak316yktYnvJp8PlnPAto4l8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 520F63E868;
	Mon, 15 Feb 2016 04:57:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C8DE13E867;
	Mon, 15 Feb 2016 04:57:44 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1602150854520.2964@virtualbox> (Johannes
	Schindelin's message of "Mon, 15 Feb 2016 09:06:53 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8F755AB6-D3CA-11E5-BFFB-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286192>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 14 Feb 2016, Junio C Hamano wrote:
>
>> Felipe Gon=C3=A7alves Assis <felipeg.assis@gmail.com> writes:
>>=20
>> > The usual workaround is using the resolve strategy, but apparently=
 it
>> > ignores the custom merge driver.
>>=20
>> Hmph.
>>=20
>> Indeed, git-merge-file seems to call xdl_merge() directly, bypassing
>> the ll_merge(), which is understandable as the former predates the
>> latter.  That needs to be fixed, I think.
>
> I think this is by design. (Because I designed it.)
>
> The original idea of git-merge-file was to serve as a drop-in replace=
ment
> for GNU/BSD merge when you want to avoid to be subject to the vagarie=
s of
> the GNU vs BSD implementations.

We did use to use "merge" from the RCS suite originally, and we did
want to use our own, but the primary reason we added our own was so
that it can be enhanced in sync with the remainder of Git in a
consistent way.

If the rest of Git can be told via the attribute system to make use
of a three-way merge driver, it should have learnt the trick to be
kept up with the rest of the system.  I see the current state of the
program merely be staying a bit behind; I do not think it was part
of the grand design to forbidd it forever from learning new optional
tricks.
