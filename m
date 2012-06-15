From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 0/5] git log -L, all new and shiny
Date: Fri, 15 Jun 2012 08:23:42 -0700
Message-ID: <7v1ulgd2f5.fsf@alter.siamese.dyndns.org>
References: <cover.1339063659.git.trast@student.ethz.ch>
 <7vlijpchm2.fsf@alter.siamese.dyndns.org> <8762as4sax.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jun 15 17:23:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfYNN-000710-U8
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 17:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138Ab2FOPXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 11:23:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49357 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932111Ab2FOPXs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 11:23:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 297408A67;
	Fri, 15 Jun 2012 11:23:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G5dvKk43k9Nw9z95MuErD4Owaso=; b=nXqwom
	1ts6m2WKJOMjtw0whIHBEXgEoccJIJsqx3g+2YDOeu5GW1yJZDQBP7amM6TPVvwH
	1LkWHhxoDcZknu8YSBeOiTfH5gVP6XThngsjmJqIkqXjc07kEP5fgTIHyTKtIiOk
	fMKQBRX8b18wYI1V3VXueiRHwUJB7xKVvaCRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sZNXkAAQ+8xB167JEpMCH0mW3xHlo6c3
	eYbHWEmhYZOe42bt0jPiEI5XwAhbmLLn5ifoX81F1M/v5LJ2hcXAfMvTeOgqz6im
	uOXruLhsKHhFH7o5yFmkqiIrqsouTt3R9zMaiGXgFf4eALa0TcY/BkEUNXxLqrLk
	gSfKuvv49T4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F3E28A66;
	Fri, 15 Jun 2012 11:23:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 909208A61; Fri, 15 Jun 2012
 11:23:47 -0400 (EDT)
In-Reply-To: <8762as4sax.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Fri, 15 Jun 2012 15:29:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1A3E152C-B6FE-11E1-9170-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200061>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thomas Rast <trast@student.ethz.ch> writes:
>>
>>> I too thought it would never happen -- but then again this is still
>>> not ready, I'm just trying to give it some exposure.
>>> ...
>>> There's also a longer-term wishlist hinted at in the commit message of
>>> the main patch: the diff machinery currently makes no provisions for
>>> chaining its various bells and whistles.
>>
>> I am not convinced that it is "diff machinery makes no provivsions"
>> that is the problem. Isn't it coming from the way the series limits
>> the output line range and reimplements its own output routine?
>
> Well, in a very circular logic sense, yes: I reimplement the output
> routine because that's the only way I could think of doing it right now :-)
>
> However, notice that word-diff also reimplements its own output routine,
> though it probably has a better standing since it is a different format.

Also notice that word-diff uses the same xdi_diff_outf() machinery
to grab line-oriented diff as its input (cf. fn_out_consume), and
then does its thing on it.  If you limit what fn_out_consume sees,
you can have word-diff do exactly what you want, no?

> This would be the first backwards coupling between the revision-walk and
> the diff generation parts, at least that I know of.

I am not convinced if you need to have any unusual back-coupling to
begin with, by the way.

If you say "git log -p [--options] -- pathspec", the revision
machinery does filter commits that do not touch any paths that patch
pathspec with the TREESAME logic, but that does not necessarily mean
you will see _all_ the commits that are not TREESAME.  If you for
example use ignore-space-change options, even the preimage and the
postimage differ at the object name level (hence not TREESAME), the
diff machinery already knows how to tell the revision machinery not
to show the log message and stuff, causing the commit to be skipped
from the output, no?

I do not know why you think you would need to do the filtering
"range comparison and union" computation more than necessary.  If
the user asks "log -p", you need to do it once per parent-child pair
that is not TREESAME at the place the current code calls run_diff().
I suspect that "log -p --stat" could be improved to eliminate the
separate call to run_diffstat() by restructuring the code so that
the statistics is gathered inside run_diff(), but that is independent
of this series. If this series hooked into the level I hinted in my
earlier message, such an optimization will reduce calls to your
"range comparision and union" computation for free.
