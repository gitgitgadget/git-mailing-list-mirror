From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 4/5] Implement line-history search (git log -L)
Date: Thu, 28 Feb 2013 14:23:05 -0800
Message-ID: <7vmwuogjsm.fsf@alter.siamese.dyndns.org>
References: <cover.1362069310.git.trast@student.ethz.ch>
 <9af548b2a7e4a4da9eb30e99b0223f20788b4fc1.1362069310.git.trast@student.ethz.ch> <7vbob4iaxh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Will Palmer" <wmpalmer@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 28 23:23:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBBt0-0007ow-P1
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 23:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275Ab3B1WXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2013 17:23:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49451 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751078Ab3B1WXI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2013 17:23:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A003B1B1;
	Thu, 28 Feb 2013 17:23:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GK6d8orgeuflNTuJhcTttdqWbeI=; b=ZLR2aE
	PqH6/Sh80QjQqi+U5V5ht5kHCD9njTGO049f0Ixh9y5gnm2wZcRzGZ31AToVhXE5
	BgUMpJebaT8PvRUXdIeat7ScQf68kgop/h0ReFHYII1SKkYQ8e3BDk0djWyQzLKx
	4mR+udvcdrKRTswoj4XrVTzUM8rpGAHFzAfWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HFW2ufH0cD6GmWSzFEhAULtudwUz+wr3
	4Fnk7K5cd8g6csJy5bzJ9ZoR0IoyXtfntAFHdE3A47kjS6s5VmL/7dY7mUK3q0va
	Wt1L91F3wYAIpodKCohVDa+JoA5UW4JAeBgVUFwDy9xXfEbp4aHswrmyD1bIZkWW
	+zMrzLokg14=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DEC1B1B0;
	Thu, 28 Feb 2013 17:23:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BEF5AB1AF; Thu, 28 Feb 2013
 17:23:06 -0500 (EST)
In-Reply-To: <7vbob4iaxh.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 28 Feb 2013 09:51:38 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6CDEEF64-81F5-11E2-BBDD-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217262>

Junio C Hamano <gitster@pobox.com> writes:

> Overall, I like this better than the "log --follow" hack; as the
> revision traversal is done without any pathspec when being "careful
> and slow" (aka -M), you do not suffer from the "just use a singleton
> pathspec globally regardless of what other history paths are being
> traversed" limitation of "log --follow".
>
> The patch series certainly is interesting.

Having said that, I notice that "careful and slow" is just "too slow
to be usable" even on a small tree like ours.  Try running

    $ git log -M -L:get_name:builtin/describe.c

and see how long you have to wait until you hit the first line of
output.

If some of the many NEEDSWORK in the code were fixed, this may
become "very slow but tolerable", but in the current shape, I doubt
it would be prudent to advance this to 'next' and further.
