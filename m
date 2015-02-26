From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git probably bug
Date: Thu, 26 Feb 2015 13:36:11 -0800
Message-ID: <xmqqegpcl5is.fsf@gitster.dls.corp.google.com>
References: <1424979584.784776482@f205.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git <git@vger.kernel.org>
To: =?iso-2022-jp?B?GyRCJyMnWidkJ1EnXSdaJ1sbKEIgGyRCJyInYCdiJ14nYCdkGyhC?=
	 =?iso-2022-jp?B?GyRCJ2AnUxsoQg==?= <bormvit@mail.ru>
X-From: git-owner@vger.kernel.org Thu Feb 26 22:36:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR66V-0000Ar-Ab
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 22:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402AbbBZVgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 16:36:15 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59823 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753976AbbBZVgO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 16:36:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B02AD3B050;
	Thu, 26 Feb 2015 16:36:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qZbDEEEplK/U+ncsTQNHY2dHNAA=; b=wFIW2q
	06+bFwY3wiU+FCHtzVevJdQoxWTI5yjNh9wOi77Wv0l8oYnlHm1xki3whnlqomay
	dXn/vGplGk1EjyUtxhjbSUXw1KewPNIWzt1IikbhcVUNvaf0xPuRrm1u9kfyfyVE
	zno+1fw30Og97ExOU6zpvFkL5HTqf74fEaRWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Te5gTUgYYGkfUHgrWbYqt1DtHVjTJxdv
	WRngvfB7XaaiCnlBL9szrbmH4kvNZ6EVk84zD5PUqzMbfWPWf7S0yZdD8uOui3/e
	8AhkMpRkJD5Clu7NFbrY7Nqy/SIhSyv/wEghI99E5MOwRVOID0tKbABPcTIx+2lx
	8lZZY55iNYI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A89C53B04F;
	Thu, 26 Feb 2015 16:36:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 178833B049;
	Thu, 26 Feb 2015 16:36:13 -0500 (EST)
In-Reply-To: <1424979584.784776482@f205.i.mail.ru> (=?iso-2022-jp?B?Ig==?=
 =?iso-2022-jp?B?GyRCJyMnWidkJ1EnXSdaJ1sbKEIJGyRCJyInYCdiJ14nYCdkJ2AbKEI=?=
 =?iso-2022-jp?B?GyRCJ1MbKEIiJ3M=?= message of "Thu, 26 Feb 2015 22:39:44
 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7C80D976-BDFF-11E4-8194-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264468>

Виталий Бормотов  <bormvit@mail.ru> writes:

> When checking out into some different
> state, if there is no permissions to unlink files (if some files in
> the current state doesn't exist in the new) warnings are outputing,
> but then git says that checking out is successful, shows that we are
> in the new state and the non-unlinked files are marked as
> untracked.

This is done by reasonably old part of the codebase, and I think it
is exactly working as designed.  Unlinking of an existing path in
the filesystem is done for one of the two reasons:

 - The old tree has the path, the new tree does not.

 - The old tree has the path, the new tree has it but with a
   different content.

In both cases, we first attempt to unlink (and warn if we cannot)
and then attempt to create the path with the new contents in the
latter case (and die if we cannot).

The checkout itself succeeds, because having untracked cruft in your
working tree is not an error, but warnings are given to let you know
that you may want to remove them after fixing the screwy permission
problem yourself.
