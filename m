From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] log: add --show-linear-break to help see non-linear history
Date: Thu, 20 Mar 2014 12:15:02 -0700
Message-ID: <xmqqha6sy955.fsf@gitster.dls.corp.google.com>
References: <1395060676-23144-1-git-send-email-pclouds@gmail.com>
	<1395294254-941-1-git-send-email-pclouds@gmail.com>
	<1395294254-941-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 20:15:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQiQv-0000sS-Co
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 20:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933009AbaCTTPJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Mar 2014 15:15:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36209 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932279AbaCTTPH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Mar 2014 15:15:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7B2074263;
	Thu, 20 Mar 2014 15:15:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4A4df0vUqdGQ
	fxt/dSIFl4NgcrQ=; b=NM1rRoWxLlnzeloI1csxrirLD9ie5AIh7AhPJ3JqIqi1
	5gL1LJ4yQUvbpPXlGrMuYH+suV6B1omj2RGEUnhj/ih9Xd65HrsVfEZ0owIEOurV
	ibxwo0f1WnaFfsJ5hL2HDpqgNBtW5IU2l2Ly8HsrTsJI7jit24xtx0boRRoxrOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wHXpiK
	g0YenHORlMO0qE9phBtS9hU6cKh+rT8Xghr0BArMKCw4CGrULezj3DD4IrCqSvYT
	9YUJy7iy/UdzsC7qC1ecDKPKwR+6lgZ5JuV5u/MtepSZ5DfEJRY4vv1LGXGvnzX9
	AysN3iH0trohHIkpXDZKy+yh55Qd/goEkfrSs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC04174260;
	Thu, 20 Mar 2014 15:15:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5BC374257;
	Thu, 20 Mar 2014 15:15:05 -0400 (EDT)
In-Reply-To: <1395294254-941-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpCU5n4buNYw==?= Duy"'s message of "Thu, 20
 Mar 2014 12:44:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F1FEA4EE-B063-11E3-91E4-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244572>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Option explanation is in rev-list-options.txt. The interaction with -=
z
> is left undecided.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Thanks.

>  * Revert back to the old option name --show-linear-break
>  * Get rid of saved_linear, use another flag in struct object instead

I cannot offhand say if I like this change or not.  A flag bit is a
scarce and limited resource; commit slabs felt more suited for
implementation of corner case eye-candies.

>  * Fix not showing the break bar after a root commit if the dag graph
>    has multiple roots

I definitely do not like the way a commit-list data structure is
abused to hold a phoney element that points at a NULL with its item
pointer.  Allocate a single bit in revs that says "I haven't done
anything yet" if you want to catch the "first-ness" without breaking
what commit_list_insert() and friends are expecting to see---they
never expect to see a NULL asked to be on the list, AFAIK.

>  * Make it work with --graph (although I don't really see the point o=
f
>    using both at the same time)

I do not see the point, either.  I vaguely recall that the previous
iteration refused the combination at the option parser level, which
I think would be the right thing to do.

>  * Let the next contributor deal with -z

That is fine.
