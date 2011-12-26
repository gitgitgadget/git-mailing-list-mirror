From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add post-fetch hook
Date: Mon, 26 Dec 2011 00:09:54 -0800
Message-ID: <7vhb0n92jx.fsf@alter.siamese.dyndns.org>
References: <20111224234212.GA21533@gnu.kitenet.net>
 <7v4nwpbaxq.fsf@alter.siamese.dyndns.org>
 <20111225035059.GA29852@gnu.kitenet.net>
 <7vsjk99exw.fsf@alter.siamese.dyndns.org>
 <m3liq0fwkz.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 26 09:10:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rf5dj-0002lx-Ln
	for gcvg-git-2@lo.gmane.org; Mon, 26 Dec 2011 09:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824Ab1LZIKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Dec 2011 03:10:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647Ab1LZIKC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Dec 2011 03:10:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFC2F44FF;
	Mon, 26 Dec 2011 03:10:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w5PhHz853lKl+l1rWSHpCvpppZw=; b=VphRAY
	DKfHGpSw0tWVfaBWuLEEelAvn4KAaJoE+VcN2kFcJ29M5abiIdTy59BqY1S6V0qf
	BOUhPMPsB+O9Y+SgcbewKz/ahN7tSbGkNQbK1/kPUtqaCocgasvhe+BBwPi71Adu
	0lqLL5rqPZTBQlsPsQuBmCYkkKCo/v8Dc9C8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UzOkzTj5vD/XoGFh+bs1/3Y/3p3c6SgJ
	f3RAbfJEersWHSZhQAr4VeSiaZr/91gxZHAA28QdV4fBekpUkU3YDhhPmSZkgmUi
	h2OnuzlVeGnbfZBjTD5rzXpnTc0vAdnPWp9NqUMMXdVSpN8EdI7qIDNjo591/OjI
	Uhy/rjfi2hc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D75844FE;
	Mon, 26 Dec 2011 03:10:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9DCE44FD; Mon, 26 Dec 2011
 03:10:00 -0500 (EST)
In-Reply-To: <m3liq0fwkz.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Sun, 25 Dec 2011 08:24:52 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0211A35C-2F99-11E1-BC90-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187693>

Jakub Narebski <jnareb@gmail.com> writes:

> One thing that needs to be specified is what should happen if the hook
> changes "the refname at the remote" part...

Hmm, good eyes.

The mechanism is to allow the hook to rewrite what happened during the
fetch. If we decided refs/heads/master on the remote that points at the
commit $X should update refs/remotes/origin/master, we tell that to the
hook, and the hook reads it. The hook may tell us to pretend that we
fetched refs/heads/next on the remote that points at the commit $Y should
update refs/remotes/origin/pu. In FETCH_HEAD we leave where the commit was
fetched from and hook will affect that information (which is used in the
resulting merge commit log message), but otherwise I do not think anything
unexpected would happen, as tracking refs do not record where the stuff
came from (perhaps they are in reflog? I didn't check).
