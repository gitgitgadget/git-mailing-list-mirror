From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] require pathspec for "git add -u/-A"
Date: Mon, 11 Mar 2013 00:04:01 -0700
Message-ID: <7vboaqbeou.fsf@alter.siamese.dyndns.org>
References: <1362786889-28688-1-git-send-email-gitster@pobox.com>
 <1362786889-28688-2-git-send-email-gitster@pobox.com>
 <vpqmwubgsqy.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 11 08:04:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEwmh-00045L-Aw
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 08:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612Ab3CKHEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 03:04:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62336 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944Ab3CKHEH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 03:04:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00F6FAA0E;
	Mon, 11 Mar 2013 03:04:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qJb6jK2lxLIm8mpx530TCfww5sk=; b=pmmpQs
	j2uISFfr8jQ+VK4BcNYYWGWdwaX35LsFLslFI6AqJKXi7hCaXs7UpGkPtwm4sXXm
	574maCWPnf49W6aM8VlIaYBPcvTLxB+La5wwqBdrh9BuqHJIlQrgHcpRIMZWQcKy
	Z5K9uXBuQ84ZuZEaLypeqRTdTXvO5YLzclHvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v1565a2gFvQ5s5gyR4R6F8C9SvBqrT5z
	WW+lWdZsEtd+5rg7KSVd5LBomiNHf1jpfaDBnqb5VXwf0iCOerNwdOmRLpXnh5pC
	UR2LOTW9QEC/RG7ST93dWaT0PaC3zpUnH7+vEqT3R2YOUDNZJWPE2RwIeg2kkAV8
	5+hHATlZUGI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E817AAA0D;
	Mon, 11 Mar 2013 03:04:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30BD2AA08; Mon, 11 Mar 2013
 03:04:04 -0400 (EDT)
In-Reply-To: <vpqmwubgsqy.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Sun, 10 Mar 2013 16:49:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC914934-8A19-11E2-B0C3-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217857>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> As promised in 0fa2eb530fb7 (add: warn when -u or -A is used without
>> pathspec, 2013-01-28), "git add -u/-A" that is run without pathspec
>> in a subdirectory will stop working sometime before Git 2.0, to wean
>> users off of the old default, in preparation for adopting the new
>> default in Git 2.0.
>
> I originally thought this step was necessary, but I changed my mind. The
> warning is big enough and doesn't need to be turned into an error.

I tend to agree.

The plan requires the warning to be big enough and warning period to
be long enough so that by the time Git 2.0 is released, no existing
users will run "git add -u/-A" without pathspec expecting it to
limit the operation to the current directory, so an extra step to
error out such a command invocation is simply redundant.  If it is
not redundant, that would only mean that the warning period was not
long enough.  The only effect the extra "error it out" step would
have is to hurt the people who jump on Git bandwagon after such
release ships, as they do not have any reason to retrain their
fingers---they instead can just get used to the new behaviour right
away.

So let's squash these two steps into one and keep that in 'next'
until 2.0 ships.

Thanks for an injection of sanity.
