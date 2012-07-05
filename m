From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve revisions.txt
Date: Thu, 05 Jul 2012 11:06:48 -0700
Message-ID: <7vpq8aqdzb.fsf@alter.siamese.dyndns.org>
References: <1341506716-97920-1-git-send-email-max@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Thu Jul 05 20:07:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmqSB-0005mH-1F
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 20:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756580Ab2GESGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 14:06:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49869 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846Ab2GESGv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 14:06:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8ECF9945;
	Thu,  5 Jul 2012 14:06:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5dxzMMki73sRulgQtGSiumxv2XM=; b=xevQ89
	z7dqMsmx4zA0MTgsHipAWYiKSD2rQzFIC+svKJLY9zDdQ1zezzalsXbdAV3kSRsT
	oerdvZAeYyQyQXLlGb9bB2cL1rDhYq7jqZv8vXq0qDy3s/FNqNbQe27DKoDLR/rJ
	BJqOYL7D7KuzohqwTCXRJl+Pe82F9QwTjfZgg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Iq5vJ/pSPJWaUn+BR4qUC4DwohecZZZD
	ZKN90N9U//xZ96crZeFpDFuK1z3LBCNDQ9FppzZfmPdFB0DpdTz/DuYF+PYzoatG
	8pG9RqsjitQJ3oXkz2I7+MdguLjKJBKMZ3fzB808eKQMotfORsJvfrvY/eRQZ5V9
	0967hJh18Ew=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF90F9944;
	Thu,  5 Jul 2012 14:06:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1946F9940; Thu,  5 Jul 2012
 14:06:50 -0400 (EDT)
In-Reply-To: <1341506716-97920-1-git-send-email-max@quendi.de> (Max Horn's
 message of "Thu, 5 Jul 2012 18:45:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31557484-C6CC-11E1-8DFA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201057>

Max Horn <max@quendi.de> writes:

> One section talked about <name> when only <refname> was defined.

Thanks.  This is a definite improvement.

> And the description for r1^! was incorrect, talking about "parents"
> (which I understand as meaning direct parent commits),
> when really all ancestors were meant.

What makes ^! exclude "all ancestors" is that you fed it to rev-list
or log.  r1^! really means "mark r1 as interesting, but mark its
direct parents as uninteresting".  r1^@ means "r1's direct parents
are interesting".  For example, "git show -s r1^@" will show the
direct parents of r1 but not its ancestors.

While there is nothing wrong in the updated descriptin per-se
(because it is about "specifying ranges", aka "feeding these to
rev-list or log, here is what happens"), I am torn about this part
of the patch.  Perhaps ^! and ^@ may also deserve to be described as
a way to give individual revisions (not "specifying ranges")?

I dunno.

> Finally I added a few more examples (in particular one for "B..C")
> that helped me understand the whole thing.
> ...
> @@ -224,7 +225,10 @@ Here are a handful of examples:
>     D F              G H I J D F
>     ^G D             H D
>     ^D B             E I J F B
> +   B..C             C
>     B...C            G H D E B C
>     ^D B C           E I J F B C
> +   C                I J F C
>     C^@              I J F
> +   B^! C            B C
>     F^! D            G H D F
