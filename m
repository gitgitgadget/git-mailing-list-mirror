From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/8] status: Added missing calls to
 diff_unmodified_pair() in format_callbacks.
Date: Sat, 10 Apr 2010 15:31:54 -0700
Message-ID: <7vaatbueg5.fsf@alter.siamese.dyndns.org>
References: <cover.1270554878.git.grubba@grubba.org>
 <5962221bef558d15183c9937863b38bc7ca41339.1270554878.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Henrik_Grubbstr=C3=B6m_=28Grubba=29?= <grubba@grubba.org>
X-From: git-owner@vger.kernel.org Sun Apr 11 00:32:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0jDl-0004NH-AO
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 00:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330Ab0DJWcB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Apr 2010 18:32:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42682 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316Ab0DJWcA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Apr 2010 18:32:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6959AA96EF;
	Sat, 10 Apr 2010 18:32:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=G6Vz9tzi7b1LPMG0T4hC1NG4S
	mI=; b=exiV6ADNWxVjUbDCoBgpdi40QVabbmYAUpHm5fnVYdLGREbg312apmuAn
	thHhX1jAPDtKUFRe8Rrlneh3stqKwiB3RAf2XyaPGbelrGZzT0s1R/vzJ5lISpw/
	0b0myA9gYRAEVEQkGW/Z2P3bktEvANbF9yJowCt/rTrbtGOJmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=gHlbd2fVM4SMHUPnFcm
	ryzpe2h2UIYpMRbr3p+mP8lu5wBDdFOAcX8t9Geb2L2aTBTrZIMGuyrrTgOPJgbz
	wN//acVvpnr34jX0IGq7UzDppbQ48LahzS70UC5jDIJ9z/jgCKT7ERTCwIpE6Img
	p/5qhBtPZJoZVAvWi7jC9Ygs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 37053A96EB;
	Sat, 10 Apr 2010 18:31:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8643A96E8; Sat, 10 Apr
 2010 18:31:55 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DFCC6C62-44F0-11DF-9229-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144606>

"Henrik Grubbstr=C3=B6m (Grubba)"  <grubba@grubba.org> writes:

> The diff_queue_struct provided by diff_flush() is raw, and needs to b=
e
> filtered through diff_unmodified_pair() before being used.
> This is already done by most of the other functions operating on
> diff_queue_struct called by diff_flush().

That is true but only if you are letting the diff front-end to feed
unmodified pairs to begin with, e.g. --find-copies-harder.  I don't thi=
nk
the internal caller in wt-status does that.

I don't think the patch is wrong nor it would hurt, but I am puzzled wh=
y
you needed this patch.

>  wt-status.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
