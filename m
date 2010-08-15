From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] reset: Better warning message on git reset --mixed
 <paths>
Date: Sun, 15 Aug 2010 11:36:38 -0700
Message-ID: <7vr5hzg1u1.fsf@alter.siamese.dyndns.org>
References: <1281814499-11797-1-git-send-email-avarab@gmail.com>
 <20100814210505.GA2372@burratino> <7vvd7chcj4.fsf@alter.siamese.dyndns.org>
 <87tymwzjbk.fsf@catnip.gol.com>
 <AANLkTin3zyPvs3GjOt3=q6dOofFA2ba0sBAzt3=Ka1Wn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org, Ralf Ebert <info@ralfebert.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 15 20:37:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oki4p-0007nx-Ih
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 20:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861Ab0HOSgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Aug 2010 14:36:53 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61340 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab0HOSgw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Aug 2010 14:36:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB27CCDD4B;
	Sun, 15 Aug 2010 14:36:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pEwflcUFDsgTplLAqlbirI3hR18=; b=Pus4yD
	R69/yBZoLz7GQ3vadGL8yjl6yirsFpWuiwD2/8Jt1ieq2mP615wxJgdf6V26ZR8g
	Ceuy8PpV7ic8FE7f1xBGC8js+yAp29lbeMHHGHYbCdr/pUgz/yIzk9nSaIlViJKW
	1REgjNUJGdi5/+eK1fhLJl3g8QjQDYU8q9IJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LbirP5z8vaEPUUIGqL2NrdeltgGGMaMf
	kQQxgdWCFapMYWqaiziRpjMNQTp3WPYHGgVj90uOfN02tnFXPk0U47FSeTVvs4uz
	hHohWPHL5ZhhohK0YncEmYxHMWNt4EsgrpgGExhbGX0yxzTYZM3RIyBdurjgi7IV
	CsAqMt1zVTg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 99AFBCDD49;
	Sun, 15 Aug 2010 14:36:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 960A9CDD3C; Sun, 15 Aug
 2010 14:36:40 -0400 (EDT)
In-Reply-To: <AANLkTin3zyPvs3GjOt3=q6dOofFA2ba0sBAzt3=Ka1Wn@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun\, 15 Aug
 2010 08\:38\:16 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0F1768D2-A89C-11DF-A8B6-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153616>

Regarding the various modes that are forbidden with "reset", I've been
wondering if we can do things differently.

If you want to reset the index at selected paths, don't use any option, as
nothing but --mixed makes sense.  Hence we deprecated use of --mixed when
used this way.  But if _it_ makes sense, why deprecate it?  What harm
would it do if we took it silently?

IIRC, the reasoning that lead to the deprecation was that allowing --mixed
may give a false impression to confused users that other mode options also
might be usable with pathspec, e.g. "reset --soft [<commit>] <pathspec>".
It obviously should barf loudly, as there is no way to move the HEAD to a
named commit without touching the index and the worktree at only specified
paths, but then the error message belongs to --soft, not --mixed.

Also "reset --hard [<commit>] -- <pathspec>" is forbidden in a repository
with a working tree, but it is clear that what the user wanted to do with
that unsupported command was what "checkout [<commit>] -- <pathspec>"
would have done.

What if we:

 - change "reset --hard [<commit>] -- <pathspec>" to internally run the
   moral equivalent "checkout" without complaining;

 - change "reset --mixed [<commit>] -- <pathspec>" to do the same thing as
   it has always done without complaining; and

 - make sure "reset --soft [<commit>] -- <pathspec>" barfs loudly.

Do people see major downside?
