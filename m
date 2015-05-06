From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/subtree: fix linefeeds trimming for cmd_split()
Date: Wed, 06 May 2015 12:49:11 -0700
Message-ID: <xmqqfv79trk8.fsf@gitster.dls.corp.google.com>
References: <CAMbsUu6xZrMu_jrV=jR4XNLf1UXLApBiAWJiWJuKRb4xN90QJQ@mail.gmail.com>
	<xmqq4mnqet5d.fsf@gitster.dls.corp.google.com>
	<CAMbsUu6=U92TRo-UeOL1qtaTipMQFzD+m+wM7sn1o-AjD6LJBw@mail.gmail.com>
	<xmqqwq0lbp87.fsf@gitster.dls.corp.google.com>
	<CAMbsUu4bix6pJA4OOoMSwYu0M6nO1+aZ7RLXU5sSOdOevN_Wzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git develop <git@vger.kernel.org>
To: Danny Lin <danny0838@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 21:49:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq5Jn-0007ay-Go
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 21:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbbEFTtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 15:49:15 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750930AbbEFTtO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 15:49:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A104B4FA77;
	Wed,  6 May 2015 15:49:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aGQZUSqzSUVQdXCU4Z3/nJBVV0k=; b=PV401a
	Zfgt/XqKeZM+hohEl9cr7t98Vel9jT8WJFaeyXdDM5zijFp+7uFVfEJoVaJpxZEP
	L+HdvREt2kfg4hwMOJtAw4ZscLsxwQJ4wotBhAZtXm4lGqgNcMKVvo/hgVJconDx
	vuq8+yCq94LS7OevMi906MyiEsLKxbebpSToY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xRZk1hga5Z11ZlbIUm/hBq3RxS88HVSt
	Lsxw65S7UOMEPjkY7NvT+M7eDQTPvy1y5R/v3wg0QTI3Mnw9GOJrUpwAfFycWY5p
	+ryIXVoyhU5WdGqN8r+XsmbnmuxLQZirmGuWjAguz5KDClW2wxqchqzXE5tK0eVe
	Zf7c2y/hDKk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A3E64FA76;
	Wed,  6 May 2015 15:49:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 05FFD4FA73;
	Wed,  6 May 2015 15:49:12 -0400 (EDT)
In-Reply-To: <CAMbsUu4bix6pJA4OOoMSwYu0M6nO1+aZ7RLXU5sSOdOevN_Wzw@mail.gmail.com>
	(Danny Lin's message of "Thu, 7 May 2015 02:58:21 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F8589656-F428-11E4-A6FE-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268488>

Danny Lin <danny0838@gmail.com> writes:

> cmd_split() prints a CR char by assigning a variable
> with a literal CR in the source code, which could be
> trimmed or mis-processed in some terminals. Replace
> with $(printf '\r') to fix it.
>
> Signed-off-by: Danny Lin <danny0838@gmail.com>
> ---
>  contrib/subtree/git-subtree.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index fa1a583..3a581fc 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -596,10 +596,11 @@ cmd_split()
>      revmax=$(eval "$grl" | wc -l)
>      revcount=0
>      createcount=0
> +    CR=$(printf '\r')
>      eval "$grl" |
>      while read rev parents; do
>          revcount=$(($revcount + 1))
> -        say -n "$revcount/$revmax ($createcount)
> "
> +        say -n "$revcount/$revmax ($createcount)$CR"

Interesting.  I would have expected, especially this is a portability-fix
change, that the change would be a single liner

-	say -n ...
+	printf "%s\r" "$revcount/$revmax ($createcount)"

that does not touch any other line.

>          debug "Processing commit: $rev"
>          exists=$(cache_get $rev)
>          if [ -n "$exists" ]; then
