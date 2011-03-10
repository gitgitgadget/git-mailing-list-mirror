From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP PATCH 0/5] support --exclude for diff/log commands
Date: Wed, 09 Mar 2011 22:11:46 -0800
Message-ID: <7vmxl37bdp.fsf@alter.siamese.dyndns.org>
References: <1299726819-5576-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 07:12:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxZ6S-0002qs-30
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 07:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456Ab1CJGL6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2011 01:11:58 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606Ab1CJGL4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 01:11:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 17019209E;
	Thu, 10 Mar 2011 01:13:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tM4ZMbs1ts1X
	1jk8AO58o5fFuCI=; b=C+SHriesNnp0ElDlr0qV/UCWGO+CyRvfTDBRSazo2q6q
	yUXBILJVei3GTjHeuIMOWK2UM8skWdRVadZw7RgK+Gsbl182MdHlKVW4pnFczobr
	PDbaCWQ7XqTB3ETokOMHHCoPD0kKSgrjjDSdBaHGRFxT0eXkrFAiH7McevmQ//E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=u1P9Yt
	WIYrH7YmL8kWX3XVURutJ3JaAW8THxjD3r5UvnIFzRjTBy+skjBzxQzLeQ9mLj7N
	bXQZJcqwz8kpLRyJKizt9daAWP5cEGR+gjx+/HrYGMlU/7RRXRHN7ewO1VrgU8wV
	uw4GoV4OTYnBOhCl9Hwc+Ms72DR9W8yz6TWXw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EA5E9209D;
	Thu, 10 Mar 2011 01:13:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0AB0A209A; Thu, 10 Mar 2011
 01:13:15 -0500 (EST)
In-Reply-To: <1299726819-5576-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 10 Mar
 2011 10:13:34 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E544010-4ADD-11E0-AE1D-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168789>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> On the other hand, if we go with ':' as a mark of special pathspecs, =
then
>
>  - ":/" mark pathspecs relative to worktree root
>  - ":!" may mark negative pathspecs

I am still moderately negative on this "negative pathspec" stuff, as it
will complicate the semantics (just one example: would a path that is
covered by both positive and negative pathspecs included or excluded?
would the last one win? would the more specific one win?) and makes the
design harder to explain to the users. Depending on the semantics chose=
n,
it may also make the implementation less efficient and more complex.

As the choice of the syntax goes, in the recent "grep --full-tree"
discussion, I thought people are more or less happy with the colon
prefixed "magic pathspec" syntax, and something along the lines of the
above two seems to be a good design.

The two most important things to consider are to make sure that people
with funny pathnames can work it around by quoting, and the prefixing
scheme is extensible so that other types of magic can later be introduc=
ed
with the same kind of escape hatch for people with funny pathnames that
begin with or contain new magic characters used to trigger the new magi=
c.

I said "something along the lines" above because ":/ for root, :! for
negative" does not yet specify how the scheme would satisfy the above
two consideration very well.
