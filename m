From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] clone: run check_everything_connected
Date: Tue, 26 Mar 2013 14:50:13 -0700
Message-ID: <7vppylsuei.fsf@alter.siamese.dyndns.org>
References: <20130325201427.GA15798@sigill.intra.peff.net>
 <20130325202627.GI16019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 26 22:50:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKblW-0006Cd-TR
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 22:50:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521Ab3CZVuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 17:50:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52931 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212Ab3CZVuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 17:50:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAD27A949;
	Tue, 26 Mar 2013 17:50:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EVvj7aSqBbjpYF88AV2r1XDWopA=; b=sN/pGU
	pNztZvFp3NtW9BMi2UX6E34IeCeRIO8cc/S0eb8xEd1Q1BoErK8vVIKJOZ6BPsyE
	4jRMb2FmTF/TE1bwgn5IuIgg1HkdqgKdWZKb02IEYDfHp4ZZuhV/ho3hHiHpI7WJ
	TImm/QEVgzN1tGrKjFvkssUheuQ57YB1Esjls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ls07KRGga11YIi3MrWAb/3bHLexXKcYF
	BAbYbHB4eZ1/gKK5zRq16fPfPd1dyFCA+SXKRYxS1lfaY/+GlWfJgbzsMrDs+qr9
	OvUf9sxMxVv7L2ygADGJ3GxW2gvvMfOcg4Zeyl4Lfjtj37Y2Nz9smgN+ohDxtBp4
	/no8o0A1i80=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFB40A948;
	Tue, 26 Mar 2013 17:50:15 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 47E76A945; Tue, 26 Mar 2013
 17:50:15 -0400 (EDT)
In-Reply-To: <20130325202627.GI16019@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 25 Mar 2013 16:26:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2480C480-965F-11E2-902F-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219217>

Jeff King <peff@peff.net> writes:

> The slowdown is really quite terrible if you try "git clone --bare
> linux-2.6.git". Even with this, the local-clone case already misses blob
> corruption. So it probably makes sense to restrict it to just the
> non-local clone case, which already has to do more work.

Probably.  We may want to enable fsck even for local clones in the
longer term and also have this check.  Those who know their filesystem
is trustworthy can do the filesystem-level copy with "cp -R" themselves
after all.

> Even still, it adds a non-trivial amount of work (linux-2.6 takes
> something like a minute to check). I don't like the idea of declaring
> "git clone" non-safe unless you turn on transfer.fsckObjects, though. It
> should have the same safety as "git fetch".

True.
