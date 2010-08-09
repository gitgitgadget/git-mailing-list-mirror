From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] tests: A SANITY test prereq for testing if we're root
Date: Mon, 09 Aug 2010 09:55:24 -0700
Message-ID: <7vd3tr7mkj.fsf@alter.siamese.dyndns.org>
References: <1280934026-25658-1-git-send-email-avarab@gmail.com>
 <1281132549-11587-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 18:56:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiVdu-0008Am-OJ
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 18:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757223Ab0HIQz4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 12:55:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57060 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757216Ab0HIQzx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Aug 2010 12:55:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 272F11B72;
	Mon,  9 Aug 2010 12:55:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oMO3lC1TGrWz
	wv+2XAgEQL3t7Zc=; b=BmRMpOS5rDh22BjCZPwU7mP/pYRMxaI9gnHmOr3jS122
	TGM51cQf9ECRgAeotV01T1OxbH2N1NsR0CIA/gs58Iqdgp3YnAxLZJoBuR9AEsel
	3EOI9nCz/qEQsjPnZ0+Xckp97+sjG+B7yLYdcCmV1kddTYcipHaW+cDn9gbQ/c8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JfJpK3
	XKwE7PTi0CisAxwDbGRdesnQIRldwpeUaHulDYjdiZ7DDufc+jOCElylDVv8/Qzp
	XxHX0JM83LRUPz1hHgtCjHeD1gU4ypzQbJfg6IF2bdUv7I9Q3PS1uQmdXWtZJCJh
	gzPmBEegurJUo9hsD+WKSm+chtta/p799moTc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FE8B1B6E;
	Mon,  9 Aug 2010 12:55:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.126]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88A661B66; Mon,  9 Aug
 2010 12:55:34 -0400 (EDT)
In-Reply-To: <1281132549-11587-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\,  6 Aug
 2010 22\:09\:09 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F2836280-A3D6-11DF-8964-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152985>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> + - SANITY
> +
> +   Test is not run by root user, and an attempt to write to an
> +   unwritable file is expected to fail correctly.

As I said in the previous round, I am indeed in favor of having a singl=
e
"running as root---code that expects that the normal UNIXy permission
based protection to apply, aka 'running in sane environment', will not
work correctly" prerequisite token, rather than having separate "can I
expect an unwritable file to be unwritable?"  "can I expect an unreadbl=
e
file to be unreadable?" bits.  The name of the token _might_ be subject=
 to
debate (I am fine with either SANITY or NOROOT), but the explanation
should mention this is defined to be a bit more broad than "unWRITABLE"=
, I
think.  "test -w /" is a traditional way to approximately check if you =
are
running as root (technically, it only checks if you are running with
unduly high privilege---your sysadm _could_ have done "chmod 2775 /" an=
d
made it owned by the admin group).

But that is just a nitpick on the wording we could fix if necessary.

Thanks.
