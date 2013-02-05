From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add contrib/credentials/netrc with GPG support, try #2
Date: Tue, 05 Feb 2013 11:47:56 -0800
Message-ID: <7vip66sftf.fsf@alter.siamese.dyndns.org>
References: <87ehgvua6h.fsf@lifelogs.com>
 <20130204211726.GB13186@sigill.intra.peff.net>
 <87mwvjsqjc.fsf_-_@lifelogs.com> <7vvca6u47f.fsf@alter.siamese.dyndns.org>
 <87k3qmr8yc.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 20:48:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2oVX-0007tg-QG
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 20:48:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756283Ab3BETsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 14:48:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63896 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756309Ab3BETsA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 14:48:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF5ED9FF6;
	Tue,  5 Feb 2013 14:47:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y6iqF3HF0inh0TzPFWkYo3KwnBk=; b=U8Bsz5
	8JFqjczN4c/iZTGNU3xAoB2kukJBlJPZTu1FFDWMHqIuChWpslsbhoBXxamJpTWN
	WpMfgPzg9KntuoGahMH9BEa/BegzgMeffS+9oR++q5dEsjgKCP1Odou8iShtphtd
	T+11uHg4N1r7qGiuK6pLGYojdckHsjDlIls0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qdnQiSzOvaaI3Y76csghxdrXLhQAlNdv
	a6Zy6hTwC76DWAz2F1L9kK40LLGdNincLLb+xY6CTno2nKF31htqH5LwvddGYRVs
	0NIbbnkfMVPTwI//XN6s9BrtiES+iVcnymOrl8M6JM5M/P2UqA1T5zZb6mfSX+o3
	CF8Fwi5Arb8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C45D39FF0;
	Tue,  5 Feb 2013 14:47:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE7969FE5; Tue,  5 Feb 2013
 14:47:58 -0500 (EST)
In-Reply-To: <87k3qmr8yc.fsf@lifelogs.com> (Ted Zlatanov's message of "Tue,
 05 Feb 2013 12:01:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1A196B0-6FCC-11E2-8034-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215528>

Ted Zlatanov <tzz@lifelogs.com> writes:

> JCH> Oh, another thing. 'default' is like 'machine' followed by any
> JCH> machine name, so the above while loop that reads two tokens
> JCH> pair-wise needs to be aware that 'default' is not followed by a
> JCH> value.  I think the loop will fail to parse this:
>
> JCH>         default       login anonymous    password me@home
> JCH>         machine k.org login me           password mysecret
>
> I'd prefer to ignore "default" because it should not be used for the Git
> credential helpers (its only use case is for anonymous services AFAIK).
> So I'll add a case to ignore it in PATCHv4, if that's OK.

You still need to parse a file that has a "default" entry correctly;
otherwise the users won't be able to share existing .netrc files
with other applications e.g. ftp, which is the whole point of this
series.  Not using values from the "default" entry is probably fine,
though.

Thanks.
