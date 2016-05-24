From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t7800 test failure
Date: Tue, 24 May 2016 09:57:04 -0700
Message-ID: <xmqq1t4r75sv.fsf@gitster.mtv.corp.google.com>
References: <CALR6jEiJwx14zAyond9ggz29Q64Fz84URtjr8zaddjnrdY7TjA@mail.gmail.com>
	<vpqk2ijs8p2.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 24 18:57:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5Fdp-00036o-TV
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 18:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbcEXQ5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 12:57:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60244 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751337AbcEXQ5I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 12:57:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7421C1E390;
	Tue, 24 May 2016 12:57:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OLLSXifiikFeYgKkACURERsyCJI=; b=PVM9xd
	3Y/OEuaCOBVbv9d4O68kDmjKb8pNh+JAopdsUCCOg515ceIBKCtjIp3rBu3aZFet
	vzi5KeZhzDhYhBw3NvvKdB8xktLQUoCgXq3Bhr3AxH028nT7E/r7XiF//HA2jL6v
	Nhat54P+p9t9Vdr6KfahbL6s9vFP9805cKtr4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=COJ/KQLahdv3Ku68xr1OvhswWR4DAnq5
	3ylCuksq8YxZmVmoqr1PhgAka7ilC2jM3TwLKeGUDQHc4RzSwJ0OaCT2VSb68Y8y
	uwqop+aB0kGeKNIeqoPQRZkvoD/SRoKJsdt7C2vj7un5IaRz1nXtQmtTObd1nROd
	/faOaz66kQY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CC3A1E38F;
	Tue, 24 May 2016 12:57:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E964B1E38E;
	Tue, 24 May 2016 12:57:05 -0400 (EDT)
In-Reply-To: <vpqk2ijs8p2.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	24 May 2016 18:48:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8B8ED248-21D0-11E6-8422-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295505>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Armin Kunaschik <megabreit@googlemail.com> writes:
>
>> t7800 fails on systems where readlink (GNUism?) is not available.
>
> I don't think it's POSIX, but it is present on all POSIX-like systems I
> know. On which system did you get the issue?
>
>> +readlink() { ls -ld "$1" | sed 's/.* -> //'; }
>
> This is much less robust than the actual readlink. For example, if ->
> appears in the link name, it breaks.

I wouldn't allow it in our scripted Porcelain, but the environment
of our test scripts are under our control, so I do not think it is a
problem ("ls piped to sed" has been an established idiom before
readlink(1) was widely accepted, by the way).

> It would be acceptable as a fall-back if readlink is not present, but
> shouldn't activate the "ls" hack by default.

Yup.
