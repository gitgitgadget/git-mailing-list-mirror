From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 6/6] rev-list/log: document logic with several limiting
 options
Date: Thu, 13 Sep 2012 15:29:45 -0700
Message-ID: <7v7grx5zfq.fsf@alter.siamese.dyndns.org>
References: <7v7grzdue6.fsf@alter.siamese.dyndns.org>
 <cover.1347544259.git.git@drmicha.warpmail.net>
 <49f89f65cd39306655a9b382a1244e34fb90fff1.1347544259.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 14 00:30:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCHv5-0001vY-Jy
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 00:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765Ab2IMW3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 18:29:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37317 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752419Ab2IMW3t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 18:29:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CDFB97EC;
	Thu, 13 Sep 2012 18:29:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HGLMuV55STdOGjrgsja8YLSnKu4=; b=JKv18M
	etYas25flXKmNkVjBwkhDGjI/386BpeqhTvuezBr1ElZnFRkDYWQCWP0oTfmHuBR
	/O934eDO7Pt5NaECw6WyfODkBnwSKucjMVUHUUNyauVr+JmSG4cTRPlzZ+StddbL
	CAHu4a0IKWkgEmJUuFOOuJeW9Qh729aPvYNqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mnf4fdUDzf5qLOxFGHSd7HFdLeqsviUV
	+xkWBpKsDNDATeDRkwBYK5qBMBc/KEbEYRvfCs+4A7wrgFVKP1zUMb8fraFbspVe
	VJdpmPBmJkn7KI/8EQYC+86SRnrILnJoHBOfhezYaZ4gDA2n8s8GwNerkyO32XaB
	xj51kEbkfeE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68C7797EB;
	Thu, 13 Sep 2012 18:29:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCC1097E6; Thu, 13 Sep 2012
 18:29:46 -0400 (EDT)
In-Reply-To: <49f89f65cd39306655a9b382a1244e34fb90fff1.1347544259.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu, 13 Sep 2012 16:04:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 85EA4760-FDF2-11E1-9186-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205439>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> The current behavior is probably as useful as it is confusing. In any
> case it is going to stay. So, document it.
>
> This does not take into account the issue of 'log --all-match
> --author=me --grep=foo --grep=bar' not honoring '--all-match' because it
> is hopefully a corner case (and, even more hopefully, fixed some time
> soon).
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  Documentation/rev-list-options.txt | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 5436eba..b2dbfb5 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -6,6 +6,19 @@ special notations explained in the description, additional commit
>  limiting may be applied. Note that they are applied before commit
>  ordering and formatting options, such as '--reverse'.
>  
> +Different options are ANDed: '--author=bar --grep=foo'
> +limits to commits which match both conditions.
> +
> +Several occurences of the '--grep' option are ORed: '--grep=foo --grep=bar'
> +limits to commits matching any of these conditions.
> +(If '--all-match' is given, the conditions are ANDed.)
> +
> +Several occurences of the '--author' and '--committer' options are ORed
> +(because there can be only one each per commit).

As I would really want to eventually see the revision command option
parser understand the full power of grep expressions in the future,
I would really want to avoid a misleading explanation that calls
what "--all-match" does as "ANDed".

With such a change, we could say something like

	git log --grep=commit --and --grep=count

to require the log message to have both "commit" and "count" on the
same line (in any order).  This obviously is different from

	git log --grep="commit.*count"

but more importantly, it is vastly different from

	git log --all-match --grep=commit --grep=count

that requires some line that has "commit", and some line (which may
not be the same line) that has "count", in the log message.
