From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/31] rebase: improve detection of rebase in progress
Date: Tue, 28 Dec 2010 15:08:10 -0800
Message-ID: <7vaajpv6lh.fsf@alter.siamese.dyndns.org>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1293528648-21873-6-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 29 00:08:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXiee-0007ih-1J
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 00:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940Ab0L1XI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 18:08:27 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64056 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510Ab0L1XI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 18:08:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A4E1D3DE3;
	Tue, 28 Dec 2010 18:08:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=8pvRW5mg2iED6SEziClTgtqjg18=; b=qRzTC2IE9Zy8dZbAW1BnTAW
	Xp4xr/st28LdD5+SF4UNKfOKVxbwtLSRHzQfuzbQEXznvJb2HySc+iulndiHVOi4
	s8Jz+anh65NFp6kPTnaX59c+xBzFxv56yEEA0ZEl9JQgEJeZbyElkHSGRcI3qMPQ
	HmtoPi4Iu8vvCqNdmxNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=kw0YiusehiaVD1U/atr6BpLWebtGqYV0jfBUSTeXnOleaOEd+
	NCCN6kwJLzKeMTklEhsdfWoh5A00bxLQ3crt4kh+0skG7b7Y3N5bXR2wjc/GwON2
	oTZudhDSGwblHbh0Etsf6WdUJdGjUD3oNsUUUqtDOs9+/6Em9jIEw+50K8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 53D263DE0;
	Tue, 28 Dec 2010 18:08:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AB5C43DD6; Tue, 28 Dec 2010
 18:08:44 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6FBCF35A-12D7-11E0-8141-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164293>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> Currently, the existence of rebase-merge/ is tested with 'test -d',
> while the existence of rebase-apply/ is tested by creating the
> directory and then deleting it again. Any good reason for this?

I don't recall how the merge side reached the current shape of the code,
but I think the rebase-apply one was that we wanted to make sure not only
we don't have a directory but also we actually _can_ create one.  If
somebody had a bad permission set, "test -d" wouldn't help us much.  We
would fail later and error diagnosis codepath should do the right thing
anyway, so it is not a correctness issue, but is more about attempting to
notice an error early rather than late.
