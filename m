From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug with branch names and case sensitivity
Date: Tue, 22 Nov 2011 10:01:25 -0800
Message-ID: <7vsjlgdoju.fsf@alter.siamese.dyndns.org>
References: <D144F6C9-C6A3-4516-BC88-B9EB50890EF4@bitart.com>
 <CAG+J_Dz6nK5fPhBRmoojmgYSv5OviN7pfgNKnRy9_9WmDS1_2w@mail.gmail.com>
 <4ECB315F.4080701@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, Gerd Knops <gerti@bitart.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Nov 22 19:01:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSuez-0000El-T3
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 19:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367Ab1KVSB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 13:01:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33087 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752749Ab1KVSB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 13:01:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D83BC4E68;
	Tue, 22 Nov 2011 13:01:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+yXX3umTdpOTEomBg+2WxMyTr9I=; b=ab3fHb
	wK0c9fXzyJfg0vECeFijeRKucALKF2yXh7Lk/nzIAMY9Rsw1y9gsOqB7Chv+i6oT
	h79swIzALHzt83QYoz53yNrav13Ma60p82dSwI2/d3NEST6w2cZjV62D6hQHxYes
	MNFwobtCr7gfsu/yR95qo6TNmgxvw+eY63tUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vlmZ1FGuq/LOtMmva7CavU/Jmw+2UC1W
	9oWQJH/P0jDRC2AGT7/yvg8r65BF0VeeLN1qQUOk/jMhWpvVQQJhFXjrcTZwUn6M
	VYYujsbaR2x6yTZRZg09OytbLPSlrTOdtbxldJJPzv570S1s4UmJS9f9zLL2L4NT
	LQ/oUieLX6Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF0204E67;
	Tue, 22 Nov 2011 13:01:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 461804E65; Tue, 22 Nov 2011
 13:01:27 -0500 (EST)
In-Reply-To: <4ECB315F.4080701@alum.mit.edu> (Michael Haggerty's message of
 "Tue, 22 Nov 2011 06:21:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF903AB4-1533-11E1-9776-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185803>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> If we want to consider bending git's behavior, there are a number of
> ways we could go:
>
> 1. Remain case-sensitive but prohibit refnames that differ only in case.

I do not see a strong enough reason to be that draconian.

> 2. Remain case-sensitive but prohibit refnames that differ only in case
> *when running on a case-insensitive filesystem*.

If you make it conditional, it should be per-project, not per-repository.
You may be participating in a cross platform project and you may happen to
be on the case-sensitive system, but absense of such a check for you may
end up hurting other participants who work on a case-insensitive one.

> 3. Change the handling of refnames to be case-insensitive but
> case-preserving.

I do not see it is worth the effort. If you were to expend much effort
then I could see in the longer term (now I am talking about Git 2.0 in
this paragraph) one solution is to remove on-filesystem $GIT_DIR/refs/
hierarchy, put it in a trivial database of some sort, keyed with case
sensitive strings.

The transfer of refs over the wire will stay case sensitive so such a
change would be purely local to the repository, so transition would only
matter if you network mount a new style repository and attempt to use with
older version of Git.

If you go that route, we still would need to think about how to deal with
the $GIT_DIR/logs/ hierarchy, though.
