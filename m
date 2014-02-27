From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 17/25] setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
Date: Thu, 27 Feb 2014 09:48:19 -0800
Message-ID: <xmqq38j41m70.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-18-git-send-email-pclouds@gmail.com>
	<xmqqios11k0v.fsf@gitster.dls.corp.google.com>
	<CACsJy8CQTV65KnzhQ8PrgrEUAJA+LPD=-5=g9J_gtNoLOPApAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 18:48:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ54b-0003Fm-7S
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 18:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbaB0Rsc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Feb 2014 12:48:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41217 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753286AbaB0RsZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 12:48:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E306D6F858;
	Thu, 27 Feb 2014 12:48:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hhj5CcntGoXN
	TwxIiLkse4Lb+FA=; b=U/xa7JvQryW32OZxH1Bmc4gHL1eotj8ENtnylORkUW5P
	XyshQHuo7HCBPEBDzEWZvvg3QSvjen/+iec/tUC8IfSKvyN1oEQ7wKcvIFfzw/jl
	YID9uN97gFS827phBMrEMLcAiQNK59+mzwSsIyfFVwea/5nEc59Y34torklL3kQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=E7ESl9
	06kzempCs3bMzG+u2lsYNLmjCLj0RjgptS1ayty/FG15JlAQb7yuWuUOY52j5sn9
	3f9AxE2+RjvvaErQgUyDcn3DQJoSvwQ4cc5+QgW8ntDgF8nTmaF9UmLLPJX7qSj4
	rnMG8GaUsqK50MojhmEqHEezMbSsVAzRd67Oc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6D046F857;
	Thu, 27 Feb 2014 12:48:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0243B6F854;
	Thu, 27 Feb 2014 12:48:23 -0500 (EST)
In-Reply-To: <CACsJy8CQTV65KnzhQ8PrgrEUAJA+LPD=-5=g9J_gtNoLOPApAg@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 27 Feb 2014 09:43:56 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5ABA8900-9FD7-11E3-A020-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242833>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Feb 27, 2014 at 7:22 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>> ---
>>
>> It is a good thing to do to read config from the real repository we
>> are borrowing from when we have .git/commondir, but it makes me
>> wonder if we should signal some kind of error if we find .git/config
>> in such a borrowing repository---which will be silently ignored.
>>
>> My gut feeling is that such a check may be necessary, but may not
>> belong to this function.
>
> Just checking. Once we do this, what about .git/refs/.. that is also
> ignored in such a repo?

It was just that I became aware of the issue while reading this
patch to check-repository-format which is only about config, but
anything inside .git/ of the borrowing repository that are ignored
because it has .git/common-dir (including .git/refs) should be a
cause of the same error, I would say.  That would be the same set
as symlinks created by contrib/workdir/git-new-workdir script.
