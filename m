From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Useless error message?
Date: Wed, 21 Apr 2010 23:33:42 -0700
Message-ID: <7vwrw0573t.fsf@alter.siamese.dyndns.org>
References: <z2o3abd05a91004211417v263d5a0eg497341ddf7bd79a5@mail.gmail.com>
 <20100421221953.GA25348@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Aghiles <aghilesk@gmail.com>, git list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 08:34:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4pzK-0004om-Hi
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 08:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074Ab0DVGdw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 02:33:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44558 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab0DVGdu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Apr 2010 02:33:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 53004ACE57;
	Thu, 22 Apr 2010 02:33:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Ks6bvf7JA/s5
	/gkG6EMDV1uA0oA=; b=e7mos8tkHzsUKOWz/ib3eoF5c5y9XZhMg3fx/IgZtT/O
	0XaxPZmPhIRCcWliIWd1UCuN8yxm6zXyUtxd1XYNo/Ytq33WOc/wj0l5JUtKldxD
	+wugXi4R8e9sNJgBuyVw1w7uAW5K0sQwm+Otuli3xbIAvWi8QWuR/TDGIuj+T44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=d/xJNM
	fmQkVoBfAzxVyKx5nhwcVwwfV+Tj1L+5xDJa23YLJl0EQ6cWFJbTawwn+WWfqGEZ
	PA/iCrB+qrbYloYuR920NL3K6gBba/YtBRYk86yoV1vqPqSIBEV06tlgFI2iBZMc
	2m/MBy/MAC6ygBbKufjiSrN7ud66qGg8WXsoo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FA82ACE55;
	Thu, 22 Apr 2010 02:33:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68E3AACE53; Thu, 22 Apr
 2010 02:33:43 -0400 (EDT)
In-Reply-To: <20100421221953.GA25348@progeny.tock> (Jonathan Nieder's message
 of "Wed\, 21 Apr 2010 17\:19\:54 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0164697E-4DD9-11DF-BAFD-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145505>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The problem is this: as far as I can tell, the git protocols are
> designed around the success case.  Sometimes if there is an error or
> other interesting event, the servers are kind enough to notify the
> user =E2=80=9Con the side=E2=80=9D.  But in the end, all too often, t=
hey do not bother
> to inform the client _program_ that a fatal error occured.

The true story is a bit different.

To avoid information leak to git-daemon clients, we deliberately choose
not to give detailed error messages, so that you cannot tell if an erro=
r
means a user "u" does not exist or "u" does but ~u/repo.git repository
does not exist.

> So the trick is to make it expected more often.  See the side-band-64=
k
> capability in Documentation/technical/protocol-capabilities.txt: the
> goal is to have fatal error messages for as many failure modes as
> possible.

=46or authenticated users (read: services that typically are behind aut=
h) it
would be a good thing, but "as many as possible" you shouldn't be follo=
wed
blindly.
