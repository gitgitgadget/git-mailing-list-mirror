From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] mergetool: use more conservative temporary filenames
Date: Fri, 10 Oct 2014 14:16:43 -0700
Message-ID: <xmqq38av62x0.fsf@gitster.dls.corp.google.com>
References: <1412929187-57936-1-git-send-email-davvid@gmail.com>
	<5437C0CC.7030102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Sergio Ferrero <sferrero@ensoftcorp.com>,
	Charles Bailey <charles@hashpling.org>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 23:16:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XchYW-0004eM-4p
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 23:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbaJJVQw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Oct 2014 17:16:52 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65433 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751605AbaJJVQv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Oct 2014 17:16:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B64714014;
	Fri, 10 Oct 2014 17:16:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NIvpG6KYYOG/
	oHeOt0rSg6TVfJE=; b=Iga3tNAO1C1FjwvwP37HFFtTYhSCQhd0Kv30GkEqHO0p
	VjTWYY+vP6cHzLXoRXwu7cd/ev7K10DNxualz2LsaivsFbmSo73vX5QpGtks+b6S
	6N2nrjHXENPDeb6jRutg1sQPNw082PKDf96khMexs1MUQp3il5qVlkej5Zr5g7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vdurha
	dqWOzTg0tiUOUTo9F9rdxuabxmQfkywwhIVcD6eZJP7k+3FNR7vgxQKJThi2qnxN
	JT72Xj8dAVx+OXjoi3zb0iRKWOeLGmoqI5f0nd0tJdjUjJQFeLTUJ2v9BsARbGII
	fEHhZ6YJlBW7rYFGlWWrBG3RdqypAo9CHLbo4=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2196714013;
	Fri, 10 Oct 2014 17:16:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9BABD1400F;
	Fri, 10 Oct 2014 17:16:44 -0400 (EDT)
In-Reply-To: <5437C0CC.7030102@gmail.com> ("Jakub =?utf-8?Q?Nar=C4=99bski?=
 =?utf-8?Q?=22's?= message of "Fri,
	10 Oct 2014 13:19:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BCA13898-50C2-11E4-AB0B-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> Why use expr and not POSIX shell parameter substitution?
>
> BASE=3D${MERGED%.*}
> ext=3D.${MERGED##*.}
>
> Or something like that...

Because they are insufficient.  See David's illustrations for how.

Parameter expansion (e.g. ${parameter%word}) is fine for the
simplest cases (e.g. you know there is .c suffix to the $string and
want to strip it out) but not sufficient for other cases (e.g. you
may not even know if there is any suffix).  You can deconstruct your
regexps manually and use conditional if/else/fi if you are unable to
use expr, but I do not see how it buys us anything.
