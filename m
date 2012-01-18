From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Checking out orphans with -f
Date: Wed, 18 Jan 2012 15:12:15 -0800
Message-ID: <7vk44oli5s.fsf@alter.siamese.dyndns.org>
References: <201201181207.05967.mfick@codeaurora.org>
 <7vsjjcljmj.fsf@alter.siamese.dyndns.org>
 <201201181550.23792.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Jan 19 00:12:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rneg4-0002UB-FI
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 00:12:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755210Ab2ARXMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 18:12:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40535 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752752Ab2ARXMS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 18:12:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F0197020;
	Wed, 18 Jan 2012 18:12:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k5wJqPuIcKn6aL7sAtkCWpgQHgg=; b=X19jTg
	1XCvoYgRrUTdsuNMJU2bzhy+nV0ZmUn8zNvOglFlDtI0K0MgK8TtESZXSJLjw7nv
	fwm8h//YwfDx0pGE9rkL2h5tkd6QPpa/4NJ+fFELFiqLMyUwET07R9ZxeFdXrX62
	+vldjDBtQTVogTb51IykfrXS3gnnBWH0g2FO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wbb7yhzKBbb/WdZTeK4wN9IjkyQ0UWCa
	kxrMJuZoBA/H8OZa2Fd/3EuWsxnQjcxwgw63V2JGg67qH8T/4rl9WyO8T3pvP6VN
	gFBwBOfFiH8vKTvy9r9VMwHP3W2oKCsKC5mo4PjgRDToAWlncmAsrnm66i78TkTy
	KvuNcG7eogc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05F46701F;
	Wed, 18 Jan 2012 18:12:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64F16701E; Wed, 18 Jan 2012
 18:12:17 -0500 (EST)
In-Reply-To: <201201181550.23792.mfick@codeaurora.org> (Martin Fick's message
 of "Wed, 18 Jan 2012 15:50:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD7338A0-4229-11E1-B216-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188777>

Martin Fick <mfick@codeaurora.org> writes:

> Actually, no I can't.  I can check out some other branch 
> (assuming I have one), but I cannot then delete a, it 
> appears to already be deleted by virtue of checking out 
> another branch.  I like that since I never checked it in, 
> better to clean up the garbage.

Good.

> ...but why can't I then 
> checkout another orphan to do the same thing?

I am not surprised if the original contributor who wanted to add --orphan
did not address corner cases.  It is very plausible that we did not try as
hard to nitpick the code for complete support of such corner cases as I
and other contributors usually do for more important features.

So... Patches welcome ;-)

Having said that, there are many things to consider to fill the corner
case you seem to be interested to add support for.

The "orphaned" state is like immediately after "git init". Because you do
not have any current commit, you cannot create an orphan branch based the
state immediately after "git init", either. You are nominally on your
'master' branch, but it does not have anything yet; you are expected to
turn it into a real branch by creating a commit soon, but until you do so,
you are kind of in-limbo. It is understandable that there will be many
operations that will not make any sense until you first get out of this
in-limbo state.  For example, you cannot (and do not have to) delete the
branch and if you have a commit (e.g. you can fetch one from another
place) you can check it out and the 'master' will be gone, because you
never created it in the first place.
