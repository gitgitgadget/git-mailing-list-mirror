From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] Teach clone to set remote.default.
Date: Fri, 06 Jul 2012 12:39:24 -0700
Message-ID: <7vd348of0z.fsf@alter.siamese.dyndns.org>
References: <1341526277-17055-1-git-send-email-marcnarc@xiplink.com>
 <1341526277-17055-4-git-send-email-marcnarc@xiplink.com>
 <7vzk7dq0qk.fsf@alter.siamese.dyndns.org> <4FF6F811.7000808@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 21:39:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnENK-0004Di-7q
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 21:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757989Ab2GFTj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 15:39:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36491 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757763Ab2GFTj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 15:39:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55F49902F;
	Fri,  6 Jul 2012 15:39:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GNfADs7uWL5MlY1AySs539Ac+Eg=; b=tgYV0b
	bRPR54INUYL7+9AXua4CexpgNkoJl6P9BLnHboR1Mn/7WRyhWpR4l4jnVuZpQ2OD
	NKv1UZicN0z+jQQXrM2ygirL/KKE6oSpLKBFo1xBb22i3hprRKcpip5STB1KihNs
	tDMbvVy/XEaNpWu0KAGuFY36K47/5ANXNkNLg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jvFFM8VrtWp8+GAQpk52UC6g8d5yD4XN
	4M+zIAoycpnsiIW9LYaE5PJ7ZB60VRss+0SGGnCHXmGYn1uHfIadPW4FpwsSTIiB
	sphEUBjr8u/ipbJ8lQ/Vr8ZS2JU9CWqI47INqQ8xC41w2qor/weGFqsujOWh5A71
	w/HSOoReoso=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C4FD902E;
	Fri,  6 Jul 2012 15:39:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2BC8902C; Fri,  6 Jul 2012
 15:39:25 -0400 (EDT)
In-Reply-To: <4FF6F811.7000808@xiplink.com> (Marc Branchaud's message of
 "Fri, 06 Jul 2012 10:37:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B3CD0E6-C7A2-11E1-BEAD-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201142>

Marc Branchaud <marcnarc@xiplink.com> writes:

> If remote.default isn't set, then if someone does
> 		git remote rename origin foo
> the default remote will still be "origin" (modulo the currently-checked-out
> branch stuff).

Why?  I thought the proposed semantics was "if remote.default is
unset, the default value of 'origin' is used where remote.default
would have been used _everywhere_".  If "remote rename" wants to
update the value of remote.default from 'origin' to 'foo' (which may
or may not be the right thing to do, for which a separate discussion
seems to exist already), and if it sees that the repository does not
have remote.default, shouldn't it still set it to 'foo', just like
the case where remote.default exists and set to 'origin'?

Your updated "remote rename" must work correctly in a repository
that was created long ago, where remote.default was not set to
anything (and default 'origin' was used) after all.

Or am I missing some subtle issues?
