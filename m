From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Sun, 23 Oct 2011 13:16:44 -0700
Message-ID: <7v39ej5uqb.fsf@alter.siamese.dyndns.org>
References: <1319277881-4128-1-git-send-email-pclouds@gmail.com>
 <7vobx863v3.fsf@alter.siamese.dyndns.org>
 <CACsJy8B=TsC4A=R6b3jyYBCvorEDBYHQ8uA864WrB0-3pgNyKA@mail.gmail.com>
 <7vipng5k80.fsf@alter.siamese.dyndns.org>
 <CACsJy8CA2cqJqt7cUN1CdnOb3=qE6B2XTd1oQKZ7osVz09kSGg@mail.gmail.com>
 <7vehy459bg.fsf@alter.siamese.dyndns.org>
 <20111023160744.GA22444@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 23 22:16:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RI4TV-0002aY-N4
	for gcvg-git-2@lo.gmane.org; Sun, 23 Oct 2011 22:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902Ab1JWUQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Oct 2011 16:16:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50930 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751556Ab1JWUQs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2011 16:16:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FD42626C;
	Sun, 23 Oct 2011 16:16:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k+kimfTNq8CNTK9QOJP1eNZ6CxE=; b=XHyb+F
	pT1JOj6IoLaCUrUwtIepQuYZPagagaBb2KGZBHB/hcsUcbP1zzl9DoUb8PcMs2BY
	yZEEn6BHbsjxBcbb9EtReaA1F/+uXt3oPRX/RWHyFuDMGQvxKxCrOkqjSsudx4s2
	NSNJV56+la27TDJ80x8JTCmDGbhGZkeabmmNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G/ZG7WyQ/qlqF3otd3iFJwGKdfZVi4vV
	IWbiSz00nqsbiWJ2Ft+QdNATGi2er7S1GwV+jSOTTHbQg7SVyT/K7vZm+63FWQBp
	JibC0JiCKot7IByEDKqlOyOW40ObkDdtDHeVvPwcVvm3D7dxaO23c9EkvgozPFpT
	QvaihYRR798=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07413626B;
	Sun, 23 Oct 2011 16:16:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8AC0C6269; Sun, 23 Oct 2011
 16:16:46 -0400 (EDT)
In-Reply-To: <20111023160744.GA22444@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 23 Oct 2011 12:07:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EEA3B7B8-FDB3-11E0-B37D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184146>

Jeff King <peff@peff.net> writes:

> But as Duy mentions, we have an encoding header. Shouldn't we treat it
> like binary goo until we do reencode_log_message, and _then_ we can
> break it into lines?

That's sensible. If we go that route, I think the "one allocation of
separate struct commit_buffer pointed from a pointer field in struct
commit to replace the current member 'buffer'" is a reasonable thing
to do.
