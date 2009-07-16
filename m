From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] pull: support rebased upstream + fetch + pull
 --rebase
Date: Wed, 15 Jul 2009 17:26:17 -0700
Message-ID: <7vab35cw2e.fsf@alter.siamese.dyndns.org>
References: <1247702955-1559-1-git-send-email-santi@agolina.net>
 <1247702955-1559-2-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Thu Jul 16 02:26:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MREnt-0005Dv-Rd
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 02:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677AbZGPA0W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jul 2009 20:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756648AbZGPA0W
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 20:26:22 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60181 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756646AbZGPA0V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 20:26:21 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 185DB4C39;
	Wed, 15 Jul 2009 20:26:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 751D24C33; Wed,
 15 Jul 2009 20:26:18 -0400 (EDT)
In-Reply-To: <1247702955-1559-2-git-send-email-santi@agolina.net> ("Santi
 =?utf-8?Q?B=C3=A9jar=22's?= message of "Thu\, 16 Jul 2009 02\:09\:15 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4947F376-719F-11DE-A53D-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123347>

Santi B=C3=A9jar <santi@agolina.net> writes:

>  	reflist=3D"$(get_remote_merge_branch "$@" 2>/dev/null)" &&
> -	oldremoteref=3D"$(git rev-parse -q --verify \
> -		"$reflist")"
> +	num=3D0 &&
> +	while oldremoteref=3D"$(git rev-parse -q --verify "$reflist@{$num}"=
)"

Applying @{nth} reflog notation to something that identifies itself as =
a
"list" made me go "Huh?".  Why is this variable called refLIST?  Should=
n't
it be simply called something like "remoteref" or even "ref"?

> +	do
> +		test $oldremoteref =3D $(git merge-base $oldremoteref $curr_branch=
) &&
> +		break
> +		num=3D$((num+1))

I think we always write "num=3D$(( $num + 1 ))" for portability; notice=
 the
lack of $ in your version.

> +	done

Does this loop ever give up?  Should it?

What happens in the subsequent code outside of the patch context, when
this loop does not find any suitable "old" value?

Other than that, looking good.

Thanks.
