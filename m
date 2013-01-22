From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Build broken for contrib/remote-helpers...
Date: Tue, 22 Jan 2013 14:22:22 -0800
Message-ID: <7vehhcn9i9.fsf@alter.siamese.dyndns.org>
References: <CAEBDL5U+Yrny-YgN1fZj1T+XTJRVaiFvMixT13Zzb2DhhYgQsA@mail.gmail.com>
 <20130122194135.GA23521@sigill.intra.peff.net> <50FEFCD7.2060402@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 22 23:22:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxmEw-0005dw-SN
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 23:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667Ab3AVWWZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jan 2013 17:22:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51198 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797Ab3AVWWZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2013 17:22:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51273BECB;
	Tue, 22 Jan 2013 17:22:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=19WdboLpkpLH
	c00CfAQgO245CHQ=; b=ZfiThHusi4lo5cfdvzEmhYHcfF5KU4F8LYlQFNR4BxmX
	rASmHuLz4vcUz47Fq5HoNNu6DSBR4ocEU4iqV9J4mHnm6tPrkqV5+OUbBL6mKKPt
	YLkcP28GI+0KZjrGC2VbgceA8AwzhPnbZMfcUWfmb3z22LF2irIh/vi/TxB9PGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=J+mkbH
	+uXofVngbNCj+ZZZgOPS9ecg1fvcgiMZPvcsseaELyV/Xv/7ND/o4THogm8QbHzW
	tKrGa894ypWAVafibD9xSEJlEZPgxsJYOnllRzNtRoVoKdzoCpijXCYmUVb5MiWo
	UPV6k0hHdzUEB5y/JZRxmVy4YXXZ36WFnMsQU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46B91BEC9;
	Tue, 22 Jan 2013 17:22:24 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7B38BEC8; Tue, 22 Jan 2013
 17:22:23 -0500 (EST)
In-Reply-To: <50FEFCD7.2060402@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Tue, 22 Jan 2013 21:55:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31EE1A04-64E2-11E2-858A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214257>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> So it finds whatever is before the first "-", which would be the tes=
t
>> number in "t0000-basic.sh" or similar, and then looks for duplicates=
=2E
>
> would it help to filter for numbered tests before sorting like this:
>
> sed 's/-.*//' | grep "[0-9][0-9][0-9][0-9]"| sort | uniq -d

If you are using sed you do not need grep.  Just do that in a single
process, perhaps like

	sed -ne 's|\(.*/\)*t\([0-9][0-9][0-9][0-9]\)-.*|\2|p'

But more importantly, what do we want "duplicate numbers" sanity
check to mean in this context?  Is this other directory allowed to
have a numbered test that shares the same number as the main test
suite?  Is uniqueness inside the contrib/remote-helpers/ directory
sufficient?

Do we envision that perhaps someday the contrib material becomes
mature enough and will want to migrate to the main part of the tree?
If that is the case, perhaps should the check complain that these
tests are not numbered, instead of ignoring?
