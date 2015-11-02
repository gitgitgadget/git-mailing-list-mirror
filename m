From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] setup: do not create $X/gitdir unnecessarily when accessing git file $X
Date: Mon, 02 Nov 2015 12:51:16 -0800
Message-ID: <xmqqtwp4dt17.fsf@gitster.mtv.corp.google.com>
References: <xmqqwpu7klmu.fsf@gitster.mtv.corp.google.com>
	<1446491306-13493-1-git-send-email-pclouds@gmail.com>
	<20151102203507.GB10722@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, rappazzo@gmail.com, kyle@kyleam.com,
	sunshine@sunshineco.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 02 21:51:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtM4c-0005XX-K2
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 21:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962AbbKBUvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 15:51:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52434 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753325AbbKBUvT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 15:51:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 285AC25693;
	Mon,  2 Nov 2015 15:51:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mBlI4HvfO1sC24kqpc9iLIoBRSc=; b=fTtlNm
	VzFekt/e9uXhazu3ktT7oI7+TQMLSBPHv+q2phNwUHNIYLItSNQjkRLscqCwEwVA
	CvupyXKThbaV2j3kFPykFg7CglWLVo7w7sZWZ7UStw867aeVnmjHF0h99Bc0z+/p
	K5UOUjUg1Ej+maoQMxOhp+NJqTzZmwLIkFA0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=skFoi8JTwnNyLL8UZa6g869npm7kJjV4
	8R8HJIO24b1VHxdK1bDrzn9qvagZ7Ttq8t8v1MZ0eRvB9AuWFzf+Q7nV3VrdM+ph
	y8O+eqZLi+s0UPa6Hdc61tVRJ76vv5b5/WOfu5tMQebivNhxrQAv+ibMsd8kZSab
	hEXdp5Ffw3I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 20BA325692;
	Mon,  2 Nov 2015 15:51:18 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9A33B25691;
	Mon,  2 Nov 2015 15:51:17 -0500 (EST)
In-Reply-To: <20151102203507.GB10722@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 2 Nov 2015 15:35:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 76C7815C-81A3-11E5-8C85-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280716>

Jeff King <peff@peff.net> writes:

> [2] I suspect this code should use write_file_gently(). What happens if
>     I have a read-only linked checkout?

Or you may not be the owner of the repository, you think you are
doing a read-only operation, and you silently end up creating a file
that cannot be written by the repository owner?

Honestly, I think this whole "just in case the user moved without
telling us, we sneakily fix things without telling the user" should
just go away.  This is not the first incidence of a tool trying to
be overly clever and pretend to know better than the end user biting
us, is it?
