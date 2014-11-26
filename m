From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Extended splitting for "git add --interactive"
Date: Wed, 26 Nov 2014 10:57:38 -0800
Message-ID: <xmqq3895rdr1.fsf@gitster.dls.corp.google.com>
References: <5475F7E7020000A100018050@gwsmtp1.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Wed Nov 26 19:57:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xthmb-0006Ib-4D
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 19:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbaKZS5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 13:57:41 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58756 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751199AbaKZS5k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 13:57:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 358F221511;
	Wed, 26 Nov 2014 13:57:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vVqqGSZtYE3fc/68ZXMuLmGeGrQ=; b=ct6gQD
	COrpqm1Cu4DvLndVOJBJ2h05QX1NDGG+Iy2eX9uluNLQVegbok85bZh8RVtxz3th
	rNf3Rb8Drk5qIEax3g4nWv/jGdHb0f94okeUax5fzEYxfQkvSZVozpdF5KqV4zq1
	LVUXQOv65KNFbRV8AphvbA0UY75bE47VJvSZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eSElXgC3Pe1nDpqTLSVXwAUCWDPMx1cs
	asGsZkOenD8e/Gr6uSUYR8wA3y4mi8hxV5UJQ/YsMOfT8e3ZNJyYh31OaE/hBcYs
	OifPBABszm0W+3155NUqN81yIHQmG+FrM4G3EFD1G06wE+TKQu+GuIyrjexkKpaV
	cXN6LOJRXbQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BF0521510;
	Wed, 26 Nov 2014 13:57:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A66222150E;
	Wed, 26 Nov 2014 13:57:39 -0500 (EST)
In-Reply-To: <5475F7E7020000A100018050@gwsmtp1.uni-regensburg.de> (Ulrich
	Windl's message of "Wed, 26 Nov 2014 15:55:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 18101992-759E-11E4-AC43-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260294>

"Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> writes:

> This is for git-1.7.12 (an older version from the SLES11 SP3 SDK). If
> the issue is solved meanwhile, I'll be happy, and I apologize for
> being too lazy to find out.

The answer is no ;-).

> Currently Git cannot split a block of changes like
>
> -AAA
> -BBB
> +CCC
> +DDD
>
> Into
> -AAA
> +CCC
> and
> -BBB
> +DDD

And it is unlikely to do so ever, because it is a wrong thing to do.

What makes the user happy to see above split when the user is
expecting this instead?

-AAA
and
-BBB
+CCC
+DDD

> Another split that is not possible is a split across an empty line, like:
>
> +AAA
> +     <empty line (in reality)>
> +BBB

Likewise.  An empty line is not that special.  AAA may be adding one
block of lines "if (condition) { ... }" and BBB may be another, and
it often happens that you would want to separate these into two
changes, with or without an empty line in between.

   +if (foo) {
   +  do foo thing
   +}
   +if (bar) {
   +  do bar thing
   +}
   
Having said all that, I am not opposed to a usable idea to allow the
user to specify where in a contiguous block of -*+* to break a hunk
and how.
