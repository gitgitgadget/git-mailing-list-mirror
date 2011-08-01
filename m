From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] ls-files: fix pathspec display on error
Date: Sun, 31 Jul 2011 17:01:22 -0700
Message-ID: <7vipqiknjh.fsf@alter.siamese.dyndns.org>
References: <CAEBDL5XJbYT9yczZiVPpeA3mpROuKQdw+-AOJjUmRp4W6M5uzg@mail.gmail.com>
 <b535c21e1becdf8aeeb1d3f8ddaa7f5415830844.1311767679.git.git@drmicha.warpmail.net> <20110729130330.GA31941@toss.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, rrt@sc3d.org,
	john@szakmeister.net
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Aug 01 02:01:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnfwp-0000TU-J4
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 02:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216Ab1HAAB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 20:01:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38912 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752756Ab1HAABZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 20:01:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 766AB5A25;
	Sun, 31 Jul 2011 20:01:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NhQOOsW1V9tLJRuCX8H0vK0xEPU=; b=axRBBg
	9yj4T7ZeYuKVSniHQ30/8efuzoo4JVCIaQxbkZ368T6B4nbBBhiDR42aj4fILc+U
	Am/BiyGdiK7AmIl0ASajmmrY7NIoK40vDd8lRkq0e5leoaKqaDnpABAvr9VApFAi
	+uzes8OIVkLKvTGSv5J1vgKoQLy/B8jhcBG3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qBLHV4OPq15aQ3paNYD6wV7FfiADjifX
	NqgyBYcCOnqAYv4WKv33f2MMBVxIxAg+9NmcgbNFyjur65HCX5fYrLGqDe/8xXoV
	dqLfMI4FIquvr0Qd7dt0SyL1ytm3/gAsZ3yegHFW4wqZqJi2AKbN3UyhyM14Dryl
	R1ucND2wV/o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D0C25A24;
	Sun, 31 Jul 2011 20:01:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4DCC5A23; Sun, 31 Jul 2011
 20:01:23 -0400 (EDT)
In-Reply-To: <20110729130330.GA31941@toss.lan> (Clemens Buchacher's message
 of "Fri, 29 Jul 2011 15:03:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 650A54AE-BBD1-11E0-A185-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178285>

Clemens Buchacher <drizzd@aon.at> writes:

> The following sequence of commands reveals an issue with error
> reporting of relative paths:
>
>  $ mkdir sub
>  $ cd sub
>  $ git ls-files --error-unmatch ../bbbbb
>  error: pathspec 'b' did not match any file(s) known to git.
>  $ git commit --error-unmatch ../bbbbb
>  error: pathspec 'b' did not match any file(s) known to git.
>
> This bug is visible only if the normalized path (i.e., the relative
> path from the repository root) is longer than the prefix.
> Otherwise, the code skips over the normalized path and reads from
> an unused memory location which still contains a leftover of the
> original command line argument.
>
> So instead, use the existing facilities to deal with relative paths
> correctly.

Sounds sane; tests?
