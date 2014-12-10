From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] convert read_packed_refs to use strbuf
Date: Wed, 10 Dec 2014 09:43:01 -0800
Message-ID: <xmqq7fxzjt96.fsf@gitster.dls.corp.google.com>
References: <20141209174958.GA26167@peff.net>
	<20141209180916.GA26873@peff.net>
	<xmqqa92wla34.fsf@gitster.dls.corp.google.com>
	<20141210073447.GA20298@peff.net>
	<CAPig+cQQThA7wiz8iwkKX=ipg1n5w+gyeS8NqtbjGui986Hn+g@mail.gmail.com>
	<CAPig+cR4p9C46wU2-nNVy7rpXzbW0fGmqzik85UP_1j3YUEmjA@mail.gmail.com>
	<CAPig+cT9rRXdZ5OS8HPBuNOh2P-+PVYZkGR-74rBfXsc2nj_Zw@mail.gmail.com>
	<20141210095319.GA9099@peff.net> <20141210103907.GA22186@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 10 18:43:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XylIA-0003NK-Bd
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 18:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbaLJRnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 12:43:09 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61113 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932261AbaLJRnH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 12:43:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE35122382;
	Wed, 10 Dec 2014 12:43:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4RMIqDu/4lOak7NVNjAmc1QEOSo=; b=wTR+Ac
	ZtPoRjU1yBJjrBltivFXjPIsNb0e0iQTi9DDjIhrgjReJ8I5uatnLc8TZsvQcJ3d
	2TzPK5P0uTHv39TpIhceSpH7r4gMEcOHqQZ7Ve43UFYEmmya1jtDQ/mgpfyQVRJp
	cDyTDnqJXi9U9DYu/68p3J/GRCyQdC7zt+w10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=shxwl6wQV0ttzad4M3gqhRX5voeKBLUf
	I21YgmEJcoImkxfoRi1Nd/HUEGTQCsgWbrIa/CUxEMrEfaTMEhetwapDNnt5D24j
	HhMyMNJ4Amv5BMRUQkcZ1IUGFT3a1JpmYRti/d9bP3JxZOmRmpHPhhb6M01elaFi
	nFDiP7XSW3o=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D4E6022381;
	Wed, 10 Dec 2014 12:43:05 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2F3922237A;
	Wed, 10 Dec 2014 12:43:03 -0500 (EST)
In-Reply-To: <20141210103907.GA22186@peff.net> (Jeff King's message of "Wed,
	10 Dec 2014 05:39:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FE3FB210-8093-11E4-ABF6-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261225>

Jeff King <peff@peff.net> writes:

> Here's a patch to do that. It still doesn't let you create long refs on
> OS X, as we get caught up in the PATH_MAX found in git_path() and
> friends. Still, I think it's a step in the right direction, and it fixes
> the shearing issue.
>
> Patches 2 and 3 are just follow-on cleanups.
>
>   [1/3]: read_packed_refs: use a strbuf for reading lines
>   [2/3]: read_packed_refs: pass strbuf to parse_ref_line
>   [3/3]: read_packed_refs: use skip_prefix instead of static array
>
> I checked, and this miraculously does not conflict with any of the refs
> work in pu. :)

Heh, I suspect that is largely because Michael's "reflog expire" is
kept out of my tree while it is still under discusson.
