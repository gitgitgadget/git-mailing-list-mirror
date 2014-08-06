From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 8/8] add tests for `git_config_get_string_const()`
Date: Wed, 06 Aug 2014 14:22:36 -0700
Message-ID: <xmqq4mxpmhyb.fsf@gitster.dls.corp.google.com>
References: <1407336792-16962-1-git-send-email-tanayabh@gmail.com>
	<1407336792-16962-9-git-send-email-tanayabh@gmail.com>
	<vpqmwbhvdkx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 06 23:22:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF8fb-00008n-37
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 23:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbaHFVWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 17:22:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50954 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753561AbaHFVWq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 17:22:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B206B30B9E;
	Wed,  6 Aug 2014 17:22:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0ZJ+gDZCxbOsmS8lp/pJ8u14Ny8=; b=r2hXnN
	uloiK+sRuO0IIqHtqDjd5MoXk6WGK3SsR8x81Mym9ooRmnhEgZ8VvGrGQltFu5j5
	5Mvh3Bzb7Qxg8JRPMlMxmOLpdOYLvWOKb57PsTglifwlF7hrn/VZkhUxgzg/sUU3
	AAf/Mb/lnBPB7gz2isCnONicGdOGyY6gTL3SY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q8Cb16U984O7B8hTBsazDeAcyZdCKmek
	VxEfKmHmrrzscYxlV8wF220ifacpD4xPDN1oGhK+q33cmWJJaHVifpcgYTOnQy1f
	QFvWmUiuVU92aRYldyhaMY7d7Opw8pcceh5LqMVjU0b7Uze8nSab+6pmn9MUTBtu
	yPFI82lQ47k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A4D2930B9D;
	Wed,  6 Aug 2014 17:22:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8484730B99;
	Wed,  6 Aug 2014 17:22:38 -0400 (EDT)
In-Reply-To: <vpqmwbhvdkx.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	06 Aug 2014 17:32:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CAB9330E-1DAF-11E4-8300-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254905>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Tanay Abhra <tanayabh@gmail.com> writes:
>
>> ...
>> +	grep "line 7.*.git/config\|.git/config.*line 7" result
>> +'
>
> This is still dependant on the locale ("line" is translated). You need
> to use test_i18ngrep instead of grep here (see its definition and
> comment in t/test-lib.sh).
>
> I don't think you need these two alternatives OTOH.
>
> BTW, Junio, I don't understand your remark "This test is too tight (the
> full string)" in the previous iteration. Can you elaborate?

The original test was trying to match the string fully, i.e.

> +	grep "fatal: bad config variable '\''alias.br'\'' at file line 2 in .git/config" result

As I already was feeling funny about seeing the phrase "file line"
in the message and expecting it to be corrected, I thought I should
encourage a check that does not depend on minor phrasing changes, if
it can be done without bending backwards.

I do agree with you that using "\|" in "grep" a pattern to trigger
ERE Alternation counts as "bending backwards" as that is a GNU
extension and not portable.
