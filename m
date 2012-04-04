From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rebase -p loses amended changes
Date: Wed, 04 Apr 2012 10:11:30 -0700
Message-ID: <7vpqbna0cd.fsf@alter.siamese.dyndns.org>
References: <592E2EEC-6CBA-48D6-8D44-34A971DD78EC@gmail.com>
 <CAH3Anrqorf481jw6GdHqOPg9WC0rD-OraOHZ7twWRF4+oJ9X4A@mail.gmail.com>
 <87fwcpun95.fsf@thomas.inf.ethz.ch>
 <CAH3AnrpasFU2bLEZsAXRQu4U+=R_YyW+-yRXDfzy2JQpqf9dNw@mail.gmail.com>
 <CADb3U=4Y0njLiYC1qrYbdm+h0h8vLh78yfz_u3B6veEqCX0xCQ@mail.gmail.com>
 <CAH3Anrq_Z0V=DpU1iH-A3F8RFWTG0_C1hEe3iDZYe=AYDTRT3g@mail.gmail.com>
 <CABURp0pnXvnT2=fDJXk-yiGctsJBHiNGSCOZiT4Vo74woi0Zxg@mail.gmail.com>
 <4F7BEA9F.3060805@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	J Robert Ray <jrobertray@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 19:11:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFTkA-0005RQ-Sv
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 19:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756993Ab2DDRLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 13:11:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45019 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756893Ab2DDRLd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 13:11:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC9B2602E;
	Wed,  4 Apr 2012 13:11:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=japskKYQtf1/tMDZ+EhSUBt2oiE=; b=votBYX
	9yCaFO4RfgLxabw2NMWgf2tvOUIDI6iaQzlgP2uZK+dmlq4qO8SFHpJtDv+qPsIb
	wIHtV815DIhvFvJuH1q14E8G5L9msPXyUI0kitlUIoNZawzhjQvdsvmL8EaN19pq
	StFi8lwqxlyci/PIfvEOSqvfnEsV5XkcrlP7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Abl2oDRFCOMOf49SOsBujNhLpe/HmDbG
	5TloOHYox04zLJZcgxxLuAQQiSViP4VUuF7JQJDrvlsTp9Vl+IQIMFRl3UE0/zcV
	cPN2oXOaFPfNyPrSUyTY9PKT5Mi7SVaMdflaMTnJ9M1RP96jfcHpP+h1qeZs/V0i
	HncaajcpXdY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2B2C602D;
	Wed,  4 Apr 2012 13:11:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F420602B; Wed,  4 Apr 2012
 13:11:32 -0400 (EDT)
In-Reply-To: <4F7BEA9F.3060805@viscovery.net> (Johannes Sixt's message of
 "Wed, 04 Apr 2012 08:30:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 39CBFC50-7E79-11E1-8637-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194709>

Johannes Sixt <j.sixt@viscovery.net> writes:

> IMO, it is a sub-optimal implementation of rebase -p that it attempts to
> redo the merge. A better strategy is to just replay the changes between
> the first parent and the merge commit, and then generate a new merge commit:
>
>    git diff-tree -p M^ M | git apply --index &&
>    git rev-parse M^2 > .git/MERGE_HEAD &&
>    git commit -c M
>
> This would side-step all the issues discussed here, no?

Or cherry-pick the change made by the merge to its first parent, i.e.

	git cherry-pick -m 1 M
