From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/2] test: factor out helper function test_must_contain
Date: Sat, 21 Nov 2015 09:11:49 +0100
Message-ID: <56502745.2000307@kdbg.org>
References: <564DF6BE.6020609@web.de>
 <CAPig+cSXiGVLvq59sUFAzTRoQFf-QswAoMSk20LvJqntzaf65A@mail.gmail.com>
 <564E371E.50606@web.de> <20151120111454.GB11198@sigill.intra.peff.net>
 <564F8781.1080902@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 21 09:12:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a03Hc-00031E-Az
	for gcvg-git-2@plane.gmane.org; Sat, 21 Nov 2015 09:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbbKUILx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Nov 2015 03:11:53 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:33463 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752042AbbKUILx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2015 03:11:53 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3p2nX62JC3z5tlC;
	Sat, 21 Nov 2015 09:11:50 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id AC62E29D8;
	Sat, 21 Nov 2015 09:11:49 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <564F8781.1080902@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281546>

Am 20.11.2015 um 21:50 schrieb Ren=C3=A9 Scharfe:
> Extract a helper function for searching for a pattern in a file and
> printing the whole file if the pattern is not found.  It is useful
> when starting tests with --verbose for debugging purposes.

> +# Check if a file contains an expected pattern.
> +test_must_contain () {
> +	if grep "$1" "$2"
> +	then
> +		return 0
> +	else
> +		echo "didn't find /$1/ in '$2', it contains:"
> +		cat "$2"
> +		return 1
> +	fi
> +}

There is already test_i18n_grep. Should it be folded into this function=
?=20
Wouldn't we also want to have a function test_must_not_contain?

IMHO, we should not increase the number of functions that give a bonus=20
only when there is a test case failure. They do not scale well: There i=
s=20
a permanent mental burden on every reviewer to watch out that they are=20
used in new tests. But without those functions, the burden is on the on=
e=20
person investigating a test case failure, who has to live without the=20
debugging support.

-- Hannes
