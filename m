From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/WIP PATCH 0/4] less ignorance of submodules for ignore=all
Date: Mon, 09 Dec 2013 14:25:22 -0800
Message-ID: <xmqqy53tvezx.fsf@gitster.dls.corp.google.com>
References: <20131122215454.GA4952@sandbox-ub>
	<20131122220953.GI4212@google.com> <52910BC4.1030800@web.de>
	<20131124005256.GA3500@sandbox-ub> <52922962.3090407@web.de>
	<CAErtv2729o-xf=49xY06aVL1ZJzJpeH+cc_Pd1cAP52r32Ss_g@mail.gmail.com>
	<20131125174945.GA3847@sandbox-ub>
	<CAErtv259jxCtvbJYZHgQZv-VJ9U+JwNzWo0tn007SDTCCBScrA@mail.gmail.com>
	<20131204221659.GA7326@sandbox-ub>
	<xmqq7gbkjlgx.fsf@gitster.dls.corp.google.com>
	<20131204231932.GG7326@sandbox-ub> <52A0E753.5090908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Sergey Sharybin <sergey.vfx@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Dec 09 23:25:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq9Gn-0002By-D5
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 23:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760541Ab3LIWZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 17:25:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32895 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752909Ab3LIWZb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 17:25:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 151A459CC8;
	Mon,  9 Dec 2013 17:25:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OqlH56YGQ7xmhtJumsbssJF2NnA=; b=AifRKW
	MfafV6VEpsiUqxp7yBkuT/UGfjlNvSvuTI4bthTeoSYmJMUD2zNthygvtbokgSjf
	yqBTzkZxw9OHEBACe7Wi9Jfzl5tyJ840K8VWOR/FAIo9zDNjmz4zGpTe6IDoyAr7
	xBXhiWdo7OtqI79h+A7LCODZ3NhUNnEnWJyGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eQPJxL7670NFw+sQZNRfH+UhEDSjDvcC
	MaHSnbUwnxTMULVmoKaIbE2hqOZU6dPfwVytbJE2spEoY8Snl6nptGN5W+A2F58J
	U/lgT0nb2wOy2M0b1i8xwtr9MPR2oY1EfvO0B7erGoMexGDSVxLA2yC9pVPA8Fv2
	eKWw8I3CXoA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E364859CC7;
	Mon,  9 Dec 2013 17:25:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD53159CC6;
	Mon,  9 Dec 2013 17:25:26 -0500 (EST)
In-Reply-To: <52A0E753.5090908@web.de> (Jens Lehmann's message of "Thu, 05 Dec
	2013 21:51:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CE3FA900-6120-11E3-B61D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239113>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> I didn't check each site in detail, but I suspect each ignore option
> was added on purpose to fix a problem. That means we still need "all"
> (at least when diffing rev<->index). Unfortunately that area is not
> covered well in our tests, I only got breakage from the filter-branch
> tests when teaching "all" to only ignore work tree changes (see at the
> end on how I did that).
>
> So I'm currently in favor of adding a new "worktree"-value which will
> only ignore the work tree changes of submodules, which seems just what
> the floating submodule use case needs.

Could you help me clarify what it exactly mean to only ignore the
work tree changes?  Specifically, if I have a submodule directory
whose (1) HEAD points at a commit that is the same as the commit
that is recorded by the top-level's gitlink, (2) the index may or
may not match HEAD, and (3) the working tree contents may or may not
match the index or the HEAD, does it only have the work tree
changes?

If the HEAD in the submodule directory is different from the commit
recorded by the top-level's gitlink, but the index and the working
tree match that different HEAD, I am guessing that it no longer is
with "only the work tree changes" and shown as modified.

If that is the suggestion, it goes back to the very original Git
submodule behavour where we compare $submoduledir/.git/HEAD with the
commit object name expected by the top-level and say the submodule
does not have any change when and only when these two object names
are the same, which sounds like a very sensible default behaviour
(besides, it is very cheap to check ;-).
