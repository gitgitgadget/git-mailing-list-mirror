From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] clone: Deprecate the --recursive option in favor of
 --recurse-submodules
Date: Wed, 03 Nov 2010 15:36:07 -0700
Message-ID: <7vbp66vxuw.fsf@alter.siamese.dyndns.org>
References: <4CD1ACF7.6040108@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Chris Packham <judge.packham@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Nov 03 23:36:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDlwN-0002t8-2V
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 23:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310Ab0KCWgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 18:36:18 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57608 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781Ab0KCWgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 18:36:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 280D31F6D;
	Wed,  3 Nov 2010 18:36:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F03qalwkOuyMNZSmJXRM05tQ9Pw=; b=GGdT5k
	51qYA9VBnYT8LCwQgkKN4BDb9Y7tdyNBe81A4+MWoUtLKeA7P5wvX+HMoVnrBh6c
	7RtdGtn+7sPOiShbTPk7Gt2ZaNietEIo6+9GL0mXeaN0A1qLImvv6P0rKRZBWoC6
	FpnwFtLg+XqxjivgwzjncjOdPK8bw/FiSztoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V0C+2a8OxMZa9ycp9QOuOfudkvLJnDhP
	Vbf3IwhAQbulchxK2tUCgUkR+xEE+KfNSGd/qU2h3cdpEqpM3iaNzqSjCnlWId8F
	JbWANH+FanYf7YSzYvy2YkpbP0fj70CmMSm7EGMRXQLVLoAlsiTzTWu1tFbNvqh2
	7qpBjlpOqXY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E50E41F6B;
	Wed,  3 Nov 2010 18:36:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0AAB21F69; Wed,  3 Nov
 2010 18:36:08 -0400 (EDT)
In-Reply-To: <4CD1ACF7.6040108@web.de> (Jens Lehmann's message of "Wed\, 03
 Nov 2010 19\:41\:59 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C3213208-E79A-11DF-A0D2-B51D107BB6B6-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160646>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> ... For my first recursion patches a
> few months ago I started with --recurse-submodules but then I noticed
> that "git clone" already used "--recursive" for the same purpose, and
> for consistency reasons I switched to using that too. But especially
> when looking at recursive grep it is really easy to misinterpret
> --recursive, so the idea came up to use --recurse-submodules everywhere.
>
> Opinions?

I think it would make sense to _add_ --recurse-submodules to "clone" to
make everybody consistent.

With the introduction of --recurse-submodules option, the user can rest
assured that --recurse-submodules is understood by any command that knows
how to descend into submodules.  A command may have --recursive option (or
it may not), and when it does, the option may or may not mean descending
into submodules.  E.g. if "git ls-tree" learns long options, --recursive
would mean "recurse into subtrees" and you would say --no-recursive to
countermand.

As it does not make any sense to say "clone --no-recursive" to limit the
clone to the top-level directory, --recursive to "clone" would need to
mean "descend into subprojects".  So in that sense, "clone --recursive"
shares a similar degree of obviousness with "submodule --recursive".  I
thing it is too strong to _deprecate_ the option in the context of that
command.
