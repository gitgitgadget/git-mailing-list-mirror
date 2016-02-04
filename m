From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Fix $((...)) coding style
Date: Thu, 04 Feb 2016 11:43:17 -0800
Message-ID: <xmqq1t8si7my.fsf@gitster.mtv.corp.google.com>
References: <cover.1454587284.git.johannes.schindelin@gmx.de>
	<20160204121437.GF29880@serenity.lan>
	<alpine.DEB.2.20.1602041334450.2964@virtualbox>
	<20160204130111.GG29880@serenity.lan>
	<alpine.DEB.2.20.1602041411520.2964@virtualbox>
	<20160204140609.GH29880@serenity.lan>
	<alpine.DEB.2.20.1602041619430.2964@virtualbox>
	<20160204155316.GI29880@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Elia Pinto <gitter.spiros@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Feb 04 20:43:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRPoL-0000Is-Go
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 20:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934127AbcBDTnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 14:43:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932372AbcBDTnU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 14:43:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3E64B414AD;
	Thu,  4 Feb 2016 14:43:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Lifu+gor+L8i3KaTYfpnp/JHvis=; b=I5RWWlowQzeacmO3pR/t
	l8D+/W6H+3ZYwx1FsC/wVpicaOT/by3BfcLqEDpZDy2btipwN2zcZIdL8Sk/rYmo
	W0ZlCrKc6h7EqR9EyL04Cx/UuTxVbab3+sFXZStBEO61t1dcdo6Krn1kGfP7dJNq
	ZuoXmGHv95AbttAMenawfC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=pcrIwDhyngCtsYhkvTM/0feW2LClwLvOoVSxUp/CDfpb89
	Gt/5kf21NJs/nnCIgbMSB3P9u+E36EWkoefdsAUBa+u4udzmBnfj1Q42zz9PdV04
	j5BmrIH1TuY52Z61o6kVHaSCc9E3a0X8T1N5mvPsRE5y2zH6JxZReIlFOHNfI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 342E1414AC;
	Thu,  4 Feb 2016 14:43:19 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A50CD414AB;
	Thu,  4 Feb 2016 14:43:18 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8A52E400-CB77-11E5-9415-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285484>

John Keeping <john@keeping.me.uk> writes:

> I avoided quoting CodingGuidelines in my previous message, but it says:
>
>  - Fixing style violations while working on a real change as a
>    preparatory clean-up step is good, but otherwise avoid useless code
>    churn for the sake of conforming to the style.
>
>    "Once it _is_ in the tree, it's not really worth the patch noise to
>    go and fix it up."
>    Cf. http://article.gmane.org/gmane.linux.kernel/943020
>
>> Also, we *did* document the policy in the CodingGuidelines:
>> 
>> 	As for more concrete guidelines, just imitate the existing code
>
> This is the first point I made.  To take one example, in
> git-filter-branch.sh there are five occurrences of the sequence "$((";
> your patch changes four of them to remove spaces.  If we standardise on
> having spaces only one needs to change:

I agree that our codebase seems to have a moderately strong
preference for having SP around binary operators, i.e.

	$term1 * $term2 + $term3

over not having one:

	$term1*$term2+$term3

and I think that is OK to declare it as our style, primarily because
that is how we encourage to write our expressions in C, as you
mentioned earlier.

One thing I was wondering about the $(( ... )) syntax while reading
this thread was about the SP around the expression, i.e.

	var=$(( $term1 * $term2 + $term3 ))

vs

	var=$(($term1 * $term2 + $term3))

I personally do not have strong preference between the two, but I
have a vague impression that we preferred the former because
somebody in the past gave us a good explanation why we should.

"git grep" however seems to tell us that we are not clearly decided
between the two, so I probably am misremembering it and there is no
preference either way.

In any case, it is good to catch a patch that mixes style changes
and other things during a review, and it also is good to clean up
the style before you start working on a specific part of the code
to make gradual improvement without stepping on others' toes.

Thanks.
