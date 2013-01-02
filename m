From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git filter-branch doesn't dereference annotated tags
Date: Wed, 02 Jan 2013 15:19:25 -0800
Message-ID: <7v623f18ci.fsf@alter.siamese.dyndns.org>
References: <CAC_01E174m_6tDwPKZ5P0BUxnLNWUf9p+VkECFosPTzip0sYsA@mail.gmail.com>
 <7vsj6mdqeo.fsf@alter.siamese.dyndns.org>
 <CAC_01E3twtNq8YXQ8=SU5oXxmnAQS43L-46NF=7RyT4tFQvU5g@mail.gmail.com>
 <7vfw2kbs4h.fsf@alter.siamese.dyndns.org>
 <CAC_01E3VWtsFd8ww+7W8DMhRAs4WgHf=bm+xoh9wszCkb-DfUA@mail.gmail.com>
 <7vk3rwaa3r.fsf@alter.siamese.dyndns.org>
 <CAC_01E2iHgNvh5PnBh3TcNKr2pLazZwRojVK9ksaE3x0a1QHmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: =?utf-8?Q?Gr=C3=A9gory?= Pakosz <gpakosz@visionobjects.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 00:19:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqXbA-0000WB-2t
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 00:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757Ab3ABXTa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2013 18:19:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46661 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206Ab3ABXT2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jan 2013 18:19:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3CE3B087;
	Wed,  2 Jan 2013 18:19:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=fZ8VsTrS7ugQZkhnbQIy0pgSY
	Rg=; b=P2HBlp44ftLiSQ9iAr47r19umyuQlfPJ9MJWZVWcIUFPbtrj7kXBFFz7o
	FPX8yVV1xMoHnQWX4qOusxTgLhSO8nXnf6O6/F67MNsUkZk2tAcsu+Oymgv7albN
	BQ9ej0UqH55okyXv3AHzCgjoRtWpJo97S++2Kds+SThjLYsS90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=X5OtSdVlajXYVietls1
	HVfkiVCi0Jrwmhxwm1+CXXPzXAIJCczGzh+MRQgeRlqSprZ5EBDpk+U3+tifzZCZ
	ad7L9p8wQBjKM6Gw60fZBWcXycOvzPDJHS6w9b2LOtrJebxNtRJrZs8jmG9+8oVZ
	sMKcEe4CUt4TFpx8VfpNRjXo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A49B9B086;
	Wed,  2 Jan 2013 18:19:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21C4EB082; Wed,  2 Jan 2013
 18:19:27 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA2A32C6-5532-11E2-BFFE-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212555>

Gr=C3=A9gory Pakosz <gpakosz@visionobjects.com> writes:

> So we have an annotated tag that points to a commit that is rewritten
> to nothing as the result of the filtering. What should happen?

If the user asked to filter that tag itself, it may make sense to
remove it, rather than keeping it pointing at the original commit,
because the commit it used to point at no longer exists in the
alternate history being created by filter-branch.

> It's basically the same problem. In my opinion, lines 447-466 should
> take into account $new_sha1 is empty.

Yeah, I think that is a sensible observation.

Having said that, I welcome comments from others, of course.  My
involvement in this script has been very limited.
