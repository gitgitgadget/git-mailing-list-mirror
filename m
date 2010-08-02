From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] require_work_tree: Look for top-level instead of
 is-inside-work-tree
Date: Mon, 02 Aug 2010 10:46:18 -0700
Message-ID: <7v8w4onc0l.fsf@alter.siamese.dyndns.org>
References: <1280335624-90132-1-git-send-email-tor.arne.vestbo@nokia.com>
 <4C56D83F.3050507@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tor Arne =?utf-8?Q?Vestb=C3=B8?= <tor.arne.vestbo@nokia.com>,
	git@vger.kernel.org, trast@student.ethz.ch
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Aug 02 19:46:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ofz63-0005RW-7i
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 19:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995Ab0HBRqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 13:46:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33615 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933Ab0HBRqb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 13:46:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D3E4CABE8;
	Mon,  2 Aug 2010 13:46:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ks0U6bZYgR3GyJxMSFRRq5wH0Nk=; b=miBCHk
	a4ylYQH6MNhmu5JdSIAjly1bC8X34xdmCwSu4lrxDKiLPeHpVJXmYQ0o3gaLc6v5
	ozJdZoN07Tj7HQr50Qck8yPEolPpMWuw/GjjlQZy0AWOqqkG7CKKa/eamW1kCLmd
	o/Kw6+OrOWcU/aUJVqubIYRCjpbBIWUwHtyKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o3oHWdoC/YGe1ptxXtU95cg60LRjWwOi
	MmomeH0E/PfByAYvjKgKaQYeUBaTvUNpv8sldArEbEmLKwKJSsLLQc+rQkJDU9FC
	y9qHZ1MEXBVlME0/5OEBFbLTm3Gve6HEHyZVOIQe7EYZGpvDGV4HdOGuu+BHATSO
	qdnw17+fMgA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 35966CABE7;
	Mon,  2 Aug 2010 13:46:25 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4576ACABE6; Mon,  2 Aug
 2010 13:46:20 -0400 (EDT)
In-Reply-To: <4C56D83F.3050507@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon\, 02 Aug 2010 16\:37\:51 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DED272F4-9E5D-11DF-8444-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152430>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> An alternative which does not change the established behavior of
> require_work_tree would be changing the order of require_work_tree and
> cd_to_top_level in the callers where possible along the lines of
>
> http://mid.gmane.org/96abf622ca2cf92998ce4ed393ccaa75d95dd9a8.1279112025.git.git@drmicha.warpmail.net
>
> which got lost somehow. (The other callers, as mentioned by Junio, would
> need to be changed differently, e.g. by moving cd_to... earlier.)

Doesn't it sound stupid to "cd-to-toplevel" and then "require-work-tree"?

If you can go to the top-level, and once you successfully got there, you
already _know_ that you have a work tree (and also you already know at
that point you are in the work tree).  The reason why "require-work-tree"
has been placed before "cd-to-toplevel" is exactly for that purpose, I
think.  It is possible that some callers wanted to "require-work-tree" to
mean "I want you to not just _have_ a work tree, but actually be _in_ it",
but I somehow doubt it.  It is more like "I am going to ask you to go to
the top, but let's make sure that you do have a top before doing so", I
think.

I on the other hand do not think it is wrong to lose the existing calls to
require-work-tree if you know that you are going to call cd-to-toplevel
before doing any git operation that needs to have a work-tree, though.

> Another problem I noticed back then (I was away since) was that a
> relative GIT_WORK_TREE is left in place after a cd_to_top_level and
> messes things up completely - it does not seem to be relative to
> GIT_DIR. So, there seems to be more to fix in this area.

I agree; I don't think GIT_WORK_TREE was designed to be anything but an
absolute path to begin with.  If a command chdir's around and exports the
environment to its hooks and subcommands, it should be prepared to adjust
it before doing so.
