From: Junio C Hamano <gitster@pobox.com>
Subject: Re: suggestion: git status = restored
Date: Tue, 29 Mar 2011 11:51:43 -0700
Message-ID: <7voc4trc8w.fsf@alter.siamese.dyndns.org>
References: <imil67$oec$1@dough.gmane.org>
 <20110329145818.GC10771@sigill.intra.peff.net> <4D92179D.6050102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Neal Kreitzinger <neal@rsss.com>,
	git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 20:52:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4e1P-0002LI-V8
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 20:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459Ab1C2Sv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 14:51:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab1C2Sv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 14:51:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1190244EC;
	Tue, 29 Mar 2011 14:53:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yYtwd5rwrgDm2PGNWUkgYzlc9io=; b=oxxe1E
	fif2iUkneObYpuSRhf2y8hoMoH7FiIlMscjiiLHL3SbzjgMhURFoIRjg3WY1P03/
	ZA/vvN8jUUB5UMs0Y8zSqqakuiUKqlusjm8cwng97sOux2agBVzCAmcGTQBX6TDr
	rXTImFl5eeFoisCCjSa5A15AxjHEKCMllIGWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IryBXZV3RfFRmdG0rrKSqwud58pZVYPo
	s0vA0JqwRgZ3pp9Eru5i0YGZpgTLtpCk/76gcVKkYtvnhjgBwy04yUiRcl8OHyXd
	x/fGoisq5MTa3NR31Ww2mGouuEOrcjfwX5heuk46ChvpqJhDQbr+jUDTiJXolwJ8
	Bo0w0vea74A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C3C7244E8;
	Tue, 29 Mar 2011 14:53:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CE36A44DF; Tue, 29 Mar 2011
 14:53:32 -0400 (EDT)
In-Reply-To: <4D92179D.6050102@gmail.com> (Neal Kreitzinger's message of
 "Tue, 29 Mar 2011 12:32:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DBB83240-5A35-11E0-8927-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170304>

Neal Kreitzinger <nkreitzinger@gmail.com> writes:

> I see your point about the current worktree/index/HEAD.  I'm not a git
> developer, but my idea is based on the concept that the sha-1 of the
> content already exists in the object store regardless of its
> path(s). I'm talking about identical blob sha-1's, not "similar"
> content.

One thing you seem to be missing is that you would need to prove that a
commit that had that blob existed in the ancestor of the commit you are
standing on in order to call that restore.  You cannot restore something
that you didn't lose, and if you never had it in your history, there is no
way you lost it in the first place.  And that means you have to run around
in the history potentially digging down to the root.

Also a file that happens to have the same content is not necessarily
"restore".  If you are using a boilerplate to start a new file in a
verbose language, you may "git add" the initial state of such a file
before you start adding your own lines (perhaps adding a real method
implementation to a class), and then run another "git add" to record your
changes.  It wouldn't be surprising if such an initial snapshot for
different paths were identical.

A more trivial example would be a .gitignore file that has '*.o'; that can
appear in src/ and then in lib/ but the project may not want to have it at
the toplevel of the source tree.
