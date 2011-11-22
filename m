From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug with branch names and case sensitivity
Date: Tue, 22 Nov 2011 09:49:26 -0800
Message-ID: <7vwrasdp3t.fsf@alter.siamese.dyndns.org>
References: <D144F6C9-C6A3-4516-BC88-B9EB50890EF4@bitart.com>
 <CAG+J_Dz6nK5fPhBRmoojmgYSv5OviN7pfgNKnRy9_9WmDS1_2w@mail.gmail.com>
 <4ECB315F.4080701@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, Gerd Knops <gerti@bitart.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Nov 22 18:49:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSuTP-0003GN-JQ
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 18:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564Ab1KVRta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 12:49:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61124 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752994Ab1KVRt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 12:49:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70B224ADC;
	Tue, 22 Nov 2011 12:49:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=32eEGgqAcVNwf912vaPpiJrCXQ8=; b=csAClG
	fgdjrPkvWU7nIsPbATkIpqY4u3CHJ5kFHpre5fwjuwLSPiFCBFVq//P3r6gNnfXF
	aLgg+ooAtQrrXDmGnfHCqsSzt+9sTU9ikVk+FFtYLbwIdzoSvHthzuID4xiw7hIN
	IaVB/1eOfaOLjsIA1IJjdV72IcSRhgqIW7Efo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wpBMq+UFJs2XwnvgToeAoAhKgYgpQ0aa
	GHWIq4GRvl7dGa+wnI7L/5sKxOX5SN1n5X6+Ljy1t/7/ECNvW3Cfe16bIy8ijgEK
	+FzyJEnUjCit8JHOKENHP5X5VRGTIN6IleVDB0OQpyaPVy0GhF06oX6xXJtxCLej
	aUnIIhpv3Kc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 679CB4ADB;
	Tue, 22 Nov 2011 12:49:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1F3B4ADA; Tue, 22 Nov 2011
 12:49:27 -0500 (EST)
In-Reply-To: <4ECB315F.4080701@alum.mit.edu> (Michael Haggerty's message of
 "Tue, 22 Nov 2011 06:21:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 52B665E4-1532-11E1-B8B0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185802>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Is it obvious how references *should* be handled on case-insensitive
> filesystems?  It's certainly not obvious to me (has it been discussed
> elsewhere?)  I don't think it is a good idea to "fix" this one problem
> without defining an overall policy.

Thanks for a very sane comment.

> Currently git handles references names case-sensitively and allows
> multiple reference names that differ only in case.

We do the same for in-tree paths, by the way.  Ultimately, I think the
sane thing to do is to appeal to the user's common sense.  In a project
where its participants may use, or in a project that is about, a platform
where a case-folding filesystem is the default choice, the project would
avoid in-tree paths that are different only in case and would not have
xt_TCPMSS.c and xt_tcpmss.c at the same time.  Even though Git allows you
on such a platform to add case-conflicting pair of paths by using
"update-index --cacheinfo", people would not do that, because it is not a
useful thing to do. And Git by default does not forbid recording such pair
of paths, as projects for whatever reason may want to use such pair of
paths if they know its participants can deal with case sensitivity just
fine.

I think refnames have exactly the same issue. In theory, you could have
"Master" and "master" branches, and nothing stops you from trying to do
so, but in practice, if it is not useful for you and your project, and
if it is equally fine to use some other name instead of "Master" for the
purpose of you and your project, then there is no strong reason for doing
so, unless you are trying to irritate users on case folding platforms.
