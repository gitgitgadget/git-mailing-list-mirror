From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'untracked working tree files would be overwritten by merge' on ignored files?
Date: Tue, 14 Jun 2016 10:06:16 -0700
Message-ID: <xmqqy467aeev.fsf@gitster.mtv.corp.google.com>
References: <20160614160720.GA22675@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 14 19:06:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCrnF-0002SK-Sr
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 19:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbcFNRGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 13:06:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53087 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752142AbcFNRGU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 13:06:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 05A09245FD;
	Tue, 14 Jun 2016 13:06:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yqby63J0AHfMJRs+RmsnLFFodUg=; b=YW03UC
	EwMajRe0dVXj21use1Pgiiy2Dn8ydlbwqN78B6n9VzAOISEExwocAl54dcXSEcDT
	hbloFsoYwwnmLr8LZHiXWE0VZ3XvhAC9iY6UxtvqpJvFtz8PrsmPOmGIBhEWtCVN
	eJFpbI3kSRBlM1a0Z0rAGOrqAVzB8s4WpfAXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uHReBERCYJ2br5eURjNycLQJjLDOTs0U
	je0T5GMJ5xQ+2UXXP5FFjGnlNRa8tTFJeyd0sGyevowxmZJSzhXZvOA8kE3NoDEl
	CyLVxOVIo07MvU4UodC905uneOHYfeB3CG75Aa1EVy3khQEJiO/OqougJq3WbIjy
	oVKQ2o5y1iY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F1A6B245FC;
	Tue, 14 Jun 2016 13:06:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 76DD7245FB;
	Tue, 14 Jun 2016 13:06:18 -0400 (EDT)
In-Reply-To: <20160614160720.GA22675@inner.h.apk.li> (Andreas Krey's message
	of "Tue, 14 Jun 2016 18:07:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4F90F8F6-3252-11E6-A692-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297307>

Andreas Krey <a.krey@gmx.de> writes:

> when I have an ignored file in my workspace, is git
> then also assumed not to remove it in the course
> of a merge?

IIRC, untracked files are kept during merge and across checking out
another branch.  Files that are deliberately marked as ignored by
listing them to .gitignore mechanism are considered expendable, and
they will be removed as necessary.

This is because we do not have the fourth-class, "we do not want to
add them to the history as tracked contents, but we do not want to
lose them", aka "precious"; we only have three, i.e. "paths in the
index", "path that are untracked" and "path that are ignored".
