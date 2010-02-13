From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Speed up string search routines
Date: Sat, 13 Feb 2010 10:52:37 -0800
Message-ID: <7vk4uhklxm.fsf@alter.siamese.dyndns.org>
References: <20100213142014.GA9543@fredrik-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 19:52:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgN6p-0008Ua-7H
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 19:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757697Ab0BMSwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 13:52:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39518 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582Ab0BMSwp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 13:52:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 77F6F99E7F;
	Sat, 13 Feb 2010 13:52:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Gw8edaoN3N5ibQjDClvkFpJ564E=; b=rpVBwh
	T7Z9Bh0xHs+aSPzM3txp6WJ59aGdloq1HPMhD+XMBCVbWN7bHshuM5nmz1W4c4ul
	acF+jVhOsZGQTR+N8N/Z/Nau1P4Ccj0+luZUg3ZPwlEoknXUbly9YlULnLh5zVTO
	oECU4NS53tOfAH1oYTyWgQcKrYkrMafw3aGtA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=llPy/G5wFI3HeoLPGWuLwHpCI2EGb07+
	X7qCCbzXJkKeIPVZvKmOkVHp/gA6a8PnUWn7hpMHcSm/dbtW6Akr4ZIMRrhkJhSS
	3hkcf5RdkfEM3GkLGInWK/QPduqtyrbSEv7zssoVlHQMHH7PVsgSQG8b/0paIN8+
	gc+FgI4UzTk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 51DFC99E7E;
	Sat, 13 Feb 2010 13:52:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5F5E99E7D; Sat, 13 Feb
 2010 13:52:39 -0500 (EST)
In-Reply-To: <20100213142014.GA9543@fredrik-laptop> (Fredrik Kuivinen's
 message of "Sat\, 13 Feb 2010 15\:20\:14 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F7245038-18D0-11DF-92D4-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139821>

Fredrik Kuivinen <frekui@gmail.com> writes:

> This series speeds up git grep and pickaxe by using the string search
> routines from GNU grep.

Thanks.

It needs to be a bit more friendly to readers of "git log" and
ReleaseNotes by hinting why use of kwset is beneficial (e.g. "use kwset
instead of memmem to find fixed string more efficiently") in the commit
titles.

The preference of using GPLv2 version was already mentioned by a few
people.

Shouldn't obstack.[ch] be in compat/ so that people on platforms where
they are natively available do not have to compile our own copies?

It is somewhat curious that you gave numbers for only negative case in
pickaxe test and numbers for only positive case in grep test.  Does this
conversion have some interesting performance charasteristics such as
penalizing positive-match case to speed up negative-match case or vice
versa (the earlier "grep lookahead" work had that effect, even though the
downside was really small)?
