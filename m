From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about git log --merge option
Date: Wed, 13 Apr 2016 13:37:21 -0700
Message-ID: <xmqqvb3ljldq.fsf@gitster.mtv.corp.google.com>
References: <CAArk4YMOkd3dEn-09-LMO7zf=X3iJqXUjCS0YNN5v4h=PjrTLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Andrey Hsiao <andreyhsiao@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 22:37:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqRXt-00056L-U8
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 22:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbcDMUhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 16:37:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51580 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752290AbcDMUhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 16:37:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BA7F512490;
	Wed, 13 Apr 2016 16:37:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0CGg8UBMjcnxftLQlb3FtqcweKk=; b=KYvE0h
	/XyRudwmoRyHQ+hyB0OZs1ijehhi6Udg2qnqd//x+nBywLIfkJPu3kv9MeXGEQDD
	rVgV20iRDuTAnwfgL1l7+xQZNOHrjgLK0C36pvoxRLM67itVVR9djHwZGgXx54on
	llGWUvO/bjX1D9UNM78LmsetjdpDAYpCsn1iI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UM1cvF9t4wJBxda2qi8sxwZBR7L6dJJX
	6tvqt16P9TjWVpATSDc1XN9PQ1tgLRKAZZyqXvsqLEtXuHWFpTltSWH5hP4nTULI
	5OW2k2B3KcxkyuRiXEHCZAHma/gdh/iXFHFfPW9jn61u5D+pPZzCaGr/NXkPasO6
	UYNgqoTIhSw=
Received: from pb-smtp2. (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B35871248F;
	Wed, 13 Apr 2016 16:37:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 269B11248E;
	Wed, 13 Apr 2016 16:37:23 -0400 (EDT)
In-Reply-To: <CAArk4YMOkd3dEn-09-LMO7zf=X3iJqXUjCS0YNN5v4h=PjrTLg@mail.gmail.com>
	(Andrey Hsiao's message of "Thu, 14 Apr 2016 00:53:26 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 86AFD404-01B7-11E6-92C4-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291483>

Andrey Hsiao <andreyhsiao@gmail.com> writes:

> Dear list:
>
> Just encountered the --merge option for git log.
>
> In the man page, it has the following explanation:
> - After a failed merge, show refs that touch files having a conflict
> and don't exist on all heads to merge.

	git log --merge [options] -- $paths

is roughly the same as

	git log [options] HEAD...MERGE_HEAD -- $paths'

where $paths' is $paths limited to those with conflicts.  You can
further think of that as a rough equivalent of

	git log [options] ^X HEAD MERGE_HEAD -- $paths'

where X is the merge base between the tips of these two branches:

    X---o---o---o---H
     \
      o---o---o---M

And the commits among these ('o's, H and M in the picture), the ones
that change any of the $paths' are shown.  If you further limit the
output (e.g. with -n<n>, or --since=<time>), you may not see all of
them, of course.
