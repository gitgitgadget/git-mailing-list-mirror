From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] blame: CRLF in the working tree and LF in the repo
Date: Tue, 28 Apr 2015 00:28:04 -0700
Message-ID: <xmqqbni8vhiz.fsf@gitster.dls.corp.google.com>
References: <553CD3DA.9090700@web.de>
	<xmqqzj5uxhls.fsf@gitster.dls.corp.google.com>
	<xmqqa8xtxy32.fsf@gitster.dls.corp.google.com>
	<553E90C0.4070103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>, kasal@ucw.cz,
	sandals@crustytoothpaste.net
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 28 09:28:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmzwC-0000xM-1w
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 09:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbbD1H2I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Apr 2015 03:28:08 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59576 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932140AbbD1H2G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2015 03:28:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 16A6C44670;
	Tue, 28 Apr 2015 03:28:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wA1L7dhYZBMp
	YtrAqjwlkkq4zJg=; b=sydtReoNx/yER1qRU4eVg7AHSx6hWOHi+bVvFhq8GwEb
	Vi5D6eeHTLzD2jpW9V2ITJ8XUshYqKkh8dS7UY2zPvzRbQ9+03VcyjE4KP8jCyPz
	8Cc1TLSHGaQCPrc1yzjIJlIZ7PyJbDK1xbNic8fb0IzS9SmY/FVSeTNrb2QzRNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tQfc/V
	LCxWWoBN6d32EQ1Jd4H5XBrK+n+Re8iWyP7nIDxQonQszY0WF2MJSDgRPJUmAOyL
	pqFGSVT/blDxXcl4a3pdzb2oslo0vBmm54aI5TFIqbexB3vd27JjfXNVxwL4v723
	cJOBjhJ15keOroIZ+WUMuPRe1j+Se9MBTSGgw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F3CC4466F;
	Tue, 28 Apr 2015 03:28:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 64F234466D;
	Tue, 28 Apr 2015 03:28:05 -0400 (EDT)
In-Reply-To: <553E90C0.4070103@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Mon, 27 Apr 2015 21:40:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1C483C18-ED78-11E4-AA0A-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267911>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> What do you think about the following test cases for a V2 patch ?
>
> test_expect_success 'create blamerepo' '
>     test_create_repo blamerepo &&
>     (
>         cd blamerepo &&
>         printf "testcase\r\n" >crlffile &&
>         git -c core.autocrlf=3Dfalse add crlffile &&
>         git commit -m "add files" &&
>         git -c core.autocrlf=3Dfalse blame crlffile >crlfclean.txt
>     )
> '
>
> test_expect_success 'blaming files with CRLF newlines in repo, core.a=
utoclrf=3Dinput' '
>     (
>         cd blamerepo &&
>         git -c core.autocrlf=3Dinput blame crlffile >actual &&
>         grep "Not Committed Yet" actual

Are you interested in seeing just some of the lines to show up as
"Not commited yet", or all of them?  I think it would be the latter,
so perhaps=20

    ! grep -v "Not Committed Yet" actual

or something?

>     )
> '
>
>

Two blank lines only here?

> test_expect_success 'blaming files with CRLF newlines core.autocrlf=3D=
true' '
>     (
>         cd blamerepo &&
>         git -c core.autocrlf=3Dtrue blame crlffile >actual &&
>         test_cmp crlfclean.txt actual
>     )
> '

OK

> test_expect_success 'blaming files with CRLF newlines core.autocrlf=3D=
false' '
>     (
>         cd blamerepo &&
>         git -c core.autocrlf=3Dfalse blame crlffile >actual &&
>         test_cmp crlfclean.txt actual
>     )
> '

Hmm, how's this blame invocation any different from the one done in
the set-up step at the very beginning?  In other words, I am not sure
what kind of breakage could cause this step to fail.

I see there is no "git blame HEAD crlffile" that bypasses the fake
latest commit altogether.  Wouldn't that be the most appropriate
thing to compare against (i.e. how to create crlfclean.txt in the
set-up step)?
