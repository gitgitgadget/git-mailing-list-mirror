From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/3] gitweb: refactor If-Modified-Since handling
Date: Mon, 26 Mar 2012 11:39:26 -0700
Message-ID: <7vsjgvnr4x.fsf@alter.siamese.dyndns.org>
References: <20120326173646.GA6524@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "W. Trevor King" <wking@drexel.edu>
X-From: git-owner@vger.kernel.org Mon Mar 26 20:39:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCEpK-0006gR-Q5
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 20:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933014Ab2CZSja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 14:39:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47004 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932830Ab2CZSj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 14:39:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C05E379F4;
	Mon, 26 Mar 2012 14:39:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VlU+RrvknkbX0ngc9Pk31YeO2eI=; b=DGvTm8
	EbIO/0Afq2S4ZuH7XHGHljIdsXxYpl0vM1VOW7e8wqvppRLnKf7fncFi07LLHo0t
	ReIxK1vnNCPjNnuwJ2jQcwBgmcgSj4c0kxl7Yfp3tee/MkFF9eYB70GTaw9PQ8ii
	RcHO4RHTlQaMxEeNVJ5cvQu3tizGEvzA5JjV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yjwi4yEFrk7v1UxSzYyUM155Mp8ITvKV
	WJID3LMNy09UWUv37hm2bdDsqqsNQffScdT1p5FAJaTCT5qlyWsTES8i+cA8rq++
	92+vBf3yph5YDyUfRyXoR2kDxbbz07VOjVOQ3efNMC8uslB4Zdxni2xk6LlaBXVZ
	JadsBCdXKiU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B825379F3;
	Mon, 26 Mar 2012 14:39:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2EE8379F1; Mon, 26 Mar 2012
 14:39:28 -0400 (EDT)
In-Reply-To: <20120326173646.GA6524@odin.tremily.us> (W. Trevor King's
 message of "Mon, 26 Mar 2012 13:36:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 04B981D4-7773-11E1-96C6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193953>

"W. Trevor King" <wking@drexel.edu> writes:

> On Mon, Mar 26, 2012 at 10:12:36AM -0700, Junio C Hamano wrote:
> ...
> Only passing in the epoch.  We could reduce computation at the expense
> of complication by passing in both the epoch and a formatted time
> string, but after Jakub's suggestions, I felt like a simpler interface
> was the better approach.  I don't feel particularly committed to
> either way, so just tell me which you'd like best ;).

The existing codepath already had the call to parse_date() nearby and that
was the only reason I made the suggestion.  The caller in the snapshot
codepath would need to call parse_date() much earlier and it would have to
be conditional to the availability of %co, so the simpler interface would
probably be overall win.

>> Missing " &&" at the end (same in 3/3).
>
> Oops.  I wonder why my tests still passed :p.  Will fix in v5.

The test will pass if there is no breakage.  The offence of missing " &&"
after your "grep 200" is that it will let the test pass even if you did
not have "200" in the output, failing to catch future breakage.
