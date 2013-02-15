From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/subtree: remove contradicting use options on
 echo wrapper
Date: Fri, 15 Feb 2013 14:39:06 -0800
Message-ID: <7vtxpdfbhx.fsf@alter.siamese.dyndns.org>
References: <CALeLG_=p9k2B6AmTG0iKf9GpGB=_6kcECmCdDV1nmruJ4bdGcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Adam Tkac <atkac@redhat.com>,
	"David A. Greene" <greened@obbligato.org>,
	"Jesper L. Nielsen" <lyager@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Techlive Zheng <techlivezheng@gmail.com>
To: Paul Campbell <pcampbell@kemitix.net>
X-From: git-owner@vger.kernel.org Fri Feb 15 23:39:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6TwM-0007BX-F6
	for gcvg-git-2@plane.gmane.org; Fri, 15 Feb 2013 23:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588Ab3BOWjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2013 17:39:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43564 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154Ab3BOWjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2013 17:39:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17B67AD9A;
	Fri, 15 Feb 2013 17:39:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mh9P43AHNblydgKr6ufA0FtGHHY=; b=lMIywP
	1Aq9kD38NYwdHWSANb2LE1h8w4JTLl5aIgd2IWDyFaovL3vTcR+nROH5cRrSDD08
	pOTQrZeypJ7PW80+6bRlNsHaM7VjHo3yY8VM7O4rOcVl/XGXyvPPAgV3+VsewiQk
	RWFzl9sztjxtT29Lifp58nob1bqd09S8d0JEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f4B09682tHqPXWVeEOT11Q8Qaz1DnKYg
	LCSTDL/QykZkmfXg8fQshbYmhE5U8eZynLDc5vLpLtqahKyAVJ/Rawc1TPNDpwz0
	leJho35YW6dUqx/73Cr9ggloMibokI1cQu8eCbOPKDtAq+MSmnjjA3zpBQXKMjZv
	GJg5apyfnRk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A44BAD99;
	Fri, 15 Feb 2013 17:39:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76CD9AD98; Fri, 15 Feb 2013
 17:39:07 -0500 (EST)
In-Reply-To: <CALeLG_=p9k2B6AmTG0iKf9GpGB=_6kcECmCdDV1nmruJ4bdGcw@mail.gmail.com> (Paul
 Campbell's message of "Fri, 15 Feb 2013 22:20:13 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 822983B4-77C0-11E2-B2F8-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216358>

Paul Campbell <pcampbell@kemitix.net> writes:

> Remove redundant -n option and raw ^M in call to echo.
>
> Call to 'say' function, a wrapper of 'echo', passed the parameter -n, then
> included a raw ^M newline in the end of the last parameter. Yet the -n option
> is meant to suppress the addition of new line by echo.
>
> Signed-off-by: Paul Campbell <pcampbell@kemitix.net>

I generally do not comment on comment on contrib/ material, and I am
not familiar with subtree myself, but

	for count in $(seq 0 $total)
        do
		echo -n "$count/$total^M"
                ... do heavy lifting ...
	done
        echo "Done                  "

is an idiomatic way to implement a progress meter without scrolling
more important message you gave earlier to the user before entering
the loop away.  The message appears, carrige-return moves the cursor
to the beginning of the line without going to the next line, and the
next iteration overwrites the previous count.  Finally, the progress
meter is overwritten with the "Done" message.  Alternatively you can
wrap it up with

	echo
        echo Done

if you want to leave the final progress "100/100" before saying "Done."

Isn't that what this piece of code trying to do?

> ---
>  contrib/subtree/git-subtree.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 8a23f58..51146bd 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -592,7 +592,7 @@ cmd_split()
>  	eval "$grl" |
>  	while read rev parents; do
>  		revcount=$(($revcount + 1))
> -		say -n "$revcount/$revmax ($createcount)
> "
> +		say "$revcount/$revmax ($createcount)"
>  		debug "Processing commit: $rev"
>  		exists=$(cache_get $rev)
>  		if [ -n "$exists" ]; then
