From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/9 v13] difftool: teach difftool to handle directory
 diffs
Date: Wed, 18 Apr 2012 12:38:04 -0700
Message-ID: <7v8vhsltk3.fsf@alter.siamese.dyndns.org>
References: <1334335002-30806-1-git-send-email-tim.henigan@gmail.com>
 <CAJDDKr7Uw3Nwg4p7F2zaY8f82j3_tRf3WiiO+YSN+nA6a9wY6w@mail.gmail.com>
 <CAJDDKr78T1HNFXPPnvMUxBoJhAHP8XGdk9ZbpQCS1sZEQJfR8w@mail.gmail.com>
 <CAFoueth37aeHMorh-r2w_mwSp+uSgeF+PYbUfHNPy9-HVvL01w@mail.gmail.com>
 <CAJDDKr6djdBvUbV6qZZu75iR2UbFHt8_D0+V+K_C+-Dgx8BfVA@mail.gmail.com>
 <CAFouetjbHewYzQXZr33xGKgwk0k7D8R0XfoP7k2qAV6Nq_d+Ow@mail.gmail.com>
 <7vsjg1knwr.fsf@alter.siamese.dyndns.org>
 <CAFouetgWpyUC9SPo_QwpESrbfib7ct111WesKPP14HQ+SqpFaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	ramsay@ramsay1.demon.co.uk
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 21:38:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKahl-0005wJ-GL
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 21:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819Ab2DRTiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 15:38:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50752 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754768Ab2DRTiG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 15:38:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8268379A4;
	Wed, 18 Apr 2012 15:38:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YQ0NgBTc3jjxE/sAfUf++fJUBwg=; b=YuE+OY
	xOA1z9uUn1yKHgNnosP070Tg/GqJbE2Lb9IAkoW+f98xs07jIoqBa1CISUHRmOUP
	i5Ukqr3Ee2PO9Bf4iGgC1heJ/4AuizvzzuIdRTaA7ypowvZMES7YghluabGlXnoj
	xjwVbf2icpDq/gnBohLCApb3zW1J++cEJbVLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n+NlVWyzb2ZuiEx53+qTt7GWhK3S2hij
	Pe1E56Pa6yGwZlL14tspGEDm8+P+FS9DrYi0XNqmQmu4tCid0FdOvjfKZdJH49O0
	DPmzq9iWbATtLa/jKAttAHiDo2A221pq5LeHmMiM+05DlfiEgSTJsV/NcUQN/XyV
	ccsGXtY4/So=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 792EC79A3;
	Wed, 18 Apr 2012 15:38:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B22279A1; Wed, 18 Apr 2012
 15:38:05 -0400 (EDT)
In-Reply-To: <CAFouetgWpyUC9SPo_QwpESrbfib7ct111WesKPP14HQ+SqpFaQ@mail.gmail.com> (Tim
 Henigan's message of "Wed, 18 Apr 2012 14:28:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0507AE22-898E-11E1-8683-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195889>

Tim Henigan <tim.henigan@gmail.com> writes:

> Looking back on it now, I agree that it would have been better to use
> the plumbing commands from the beginning.  Changing from the porcelain
> to the plumbing commands will require new logic to parse the diff
> options to figure out which of 'diff-index', 'diff-files' or
> 'diff-tree' should be called.  We may also want to add support for
> some specific standard diff options (like '-R').

Yeah, didn't I already suggest that it is the only sane avenue in the long
term to move the whole "populate the two temporary trees" thing down to C
level?

> For now, would you object to an updated patch that simply detects and
> ignores options that change the output of 'git diff --raw'?

As a script that uses 'git diff' is a short-term hack anyway, I think the
most cost effective thing to do is to add '--no-renames' at the end and be
done with it.
