From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 02/10] Stop starting pager recursively
Date: Tue, 28 Feb 2012 11:10:27 -0800
Message-ID: <7vipiqzsd8.fsf@alter.siamese.dyndns.org>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-3-git-send-email-pclouds@gmail.com>
 <7v4nua25cz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 28 20:10:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2SRX-0000Ai-Cm
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 20:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256Ab2B1TKa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 14:10:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53079 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966048Ab2B1TKa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2012 14:10:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 807FB7E70;
	Tue, 28 Feb 2012 14:10:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=llYW9z1pAeqo
	0CaG3NdDHP+gSD4=; b=RnrdskU/sLr+jNR9I76sV+LovoP/VsMQrhesSg5cNJ9e
	nVJTWRSLzzlVZq4y2ma300JGnvnRBG+iU4FQ4fW92Sq41ZA0qNzSSA59E8/afRNh
	wGbZogScrygKuzD+4kSJxO1oaxCwsWijP41/Gs0CPUyKDtElwANGP8u/uc10TS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RA7vXy
	3HCbnjKnZkGaLnKzErOJEVOR0mx4+0roNn/zc4v5b/Q67u20BEgas2jISgNwaGHG
	fQqrEbOjdcs6qLzbKwIkgJ5GPfyTSKD088rti3Lb8JmeOMzb935wean6JR2dwDyx
	OTlZLocZSe4Aql+LTN+jKgMAUphdahuy5Gbps=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 765747E6E;
	Tue, 28 Feb 2012 14:10:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB0DC7E6D; Tue, 28 Feb 2012
 14:10:28 -0500 (EST)
In-Reply-To: <7v4nua25cz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 28 Feb 2012 10:13:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E099592A-623F-11E1-863C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191765>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> git-column can be used as a pager for other git commands, something
>> like this:
>>
>>     GIT_PAGER=3D"git -p column --mode=3D'dense color'" git -p branch
>>
>> The problem with this is that "git -p column" also has $GIT_PAGER
>> set so the pager runs itself again as a pager, then again and again.
>>
>> Stop this.
>
> A natural question that may come after reading only the above is if "=
git
> column" is the only one that has this problem.  In other words, is th=
e
> undesirable behaviour you observed caused by a bug in setup_pager() t=
hat
> needs to be fixed, or should it be fixed in "git column"?

Put another way, if there is another git command X that can be used as =
a
filter to the output of a git command Y, do you suffer from the same is=
sue
to when you abuse the GIT_PAGER mechanism to pipe the output from Y to =
X?
That is a sure sign that the pager mechanism needs improvement (obvious=
ly,
an alternative answer could be "don't do that then", though).

=46or example, shortlog is designed to be X for Y=3Dlog, i.e.

	$ git log v1.0.0.. | git shortlog

is a perfectly valid way to use the command.  I could imagine that this
patch may improve the situation if you abuse GIT_PAGER mechanism to
implement the above pipeline, i.e.

	$ GIT_PAGER=3D"git -p shortlog" git log v1.0.0..

Although I never tried it.
