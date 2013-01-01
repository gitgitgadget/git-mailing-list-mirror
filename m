From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git filter-branch doesn't dereference annotated tags
Date: Tue, 01 Jan 2013 13:04:24 -0800
Message-ID: <7vk3rwaa3r.fsf@alter.siamese.dyndns.org>
References: <CAC_01E174m_6tDwPKZ5P0BUxnLNWUf9p+VkECFosPTzip0sYsA@mail.gmail.com>
 <7vsj6mdqeo.fsf@alter.siamese.dyndns.org>
 <CAC_01E3twtNq8YXQ8=SU5oXxmnAQS43L-46NF=7RyT4tFQvU5g@mail.gmail.com>
 <7vfw2kbs4h.fsf@alter.siamese.dyndns.org>
 <CAC_01E3VWtsFd8ww+7W8DMhRAs4WgHf=bm+xoh9wszCkb-DfUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: =?utf-8?Q?Gr=C3=A9gory?= Pakosz <gpakosz@visionobjects.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 22:04:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq90x-0008NC-3g
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 22:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461Ab3AAVE2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jan 2013 16:04:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65376 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752445Ab3AAVE0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jan 2013 16:04:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40AAFBF59;
	Tue,  1 Jan 2013 16:04:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Pgjuzfdd6YDP
	6arZ4f1mELg/Mcc=; b=Ls8vil+s7LRCz+b/f0BOHSfdv9qQDxWBYeVrGnEIA1WG
	lr8wMbqtRYBJpvkOX2mgXf/8UjFZp3ePZZPrjtq+2QkS7EQCDIYrq8C6k3GWIXuH
	EDtrJW6Y2jus+ilKU9gEjP1Lbct2rjVU//Aj0ntiNOTd1WrmZtmh5O4KVUeAqBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UKnAdT
	krSD1dTo+mM8RvBTOr7Q7jrL494rcPuiUnAZ+Vjwnyv8cQgBdA55F1u6NVlL8CI5
	zr6hnKCVRNFg9SdOB1gwoOfE7LTM4IZPAbRXqmxKNx1IW2Wm/HOznjuUHepBgk5H
	4MobgkRxEOTun7l/12Hyw+vxvY9owmGeoM/Sg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 306F2BF58;
	Tue,  1 Jan 2013 16:04:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 875DEBF57; Tue,  1 Jan 2013
 16:04:25 -0500 (EST)
In-Reply-To: <CAC_01E3VWtsFd8ww+7W8DMhRAs4WgHf=bm+xoh9wszCkb-DfUA@mail.gmail.com>
 (=?utf-8?Q?=22Gr=C3=A9gory?= Pakosz"'s message of "Tue, 1 Jan 2013 21:20:14
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D2D4F7B8-5456-11E2-91E7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212440>

Gr=C3=A9gory Pakosz <gpakosz@visionobjects.com> writes:

> Are you suggesting $sha1 should be obtained differently before
> entering case "$rewritten" ?
> That would mean changing sha1=3D$(git rev-parse "$ref"^0) at line 376=
 to
> something like $(git cat-file -t "$ref") =3D 'tag' && sha1=3D$(git
> rev-parse "$ref") || sha1=3D$(git rev-parse "$ref^0") ?

I was wondering if it should be

	sha1=3D$(git rev-parse --verify "$ref")

or something that does not dereference a tag at all.

The way I read what that loop seems to want to do is:

	Read each refname that was given originally from the file
	$tempdir/heads, find out the object it used to refer to and
	have it in $sha1, find out what new object the object was
	rewritten to and have it in $rewritten, and:

	(1) if the rewrite left the object unchanged, do nothing but
	    warn users just in case this was a mistake;
	(2) if the rewrite told us to remove it, then delete the
	    ref; or
        (3) if the rewrite gave us a new object, replace the ref to=20
	    point to that new one.

	And in the latter two cases, save the original one in
	$orig_namespace so that the user can choose to recover if
	this filter-branch was done by mistake.

So I do not think unwraping the ref at that point makes any sense,
unless it is not prepared to handle annotated tags at all by
unwrapping tags too early.

What am I missing?
