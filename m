From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Marking commits as transitory for git bisect?
Date: Wed, 02 Dec 2009 08:49:32 -0800
Message-ID: <7vhbs9jp7n.fsf@alter.siamese.dyndns.org>
References: <871vjdyb59.fsf@lola.goethe.zz>
 <4B164501.7010902@drmicha.warpmail.net> <87tyw9wsfr.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Dec 02 17:49:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFsOi-0005oG-Ip
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 17:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560AbZLBQth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 11:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754455AbZLBQth
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 11:49:37 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49743 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319AbZLBQtg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 11:49:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A1454A38C9;
	Wed,  2 Dec 2009 11:49:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=6anaKpBqWFTHbA7cFi8KmexPit0=; b=s8hPB4cao2nWVT1/To+nmK3
	WFNvv+gZSXS4K68fMfG9gz5AXw/ziO7hPt7ruX4yw+Khi5mDnRKlGatymi9Y99i2
	ylLhyoJzIfpKabvsjSdAQOlvpUildKUkm7ZfI2cXrFoNJ3EPHeEMxxDOYPiuzz8E
	GMnIv/UoDKsTeHsdR0FA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ErLsHxDKMmKIpYJI4S9fOIcFRLZJlmKuE/IKGJ5aWrlRHYsfj
	2JcIVUQiiQwufwpUpvLoL10ygu9uUFynADzWrbAcnJe0CXyr4XKgmxUPdzLMIF+Z
	FR7Ik/sMGGWgDG3L5kBFHPR7Mdp7lRWWGQ3QAsKHC1FXVM9u2iw4LxKJIQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6F337A38C6;
	Wed,  2 Dec 2009 11:49:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3AD0CA38C5; Wed,  2 Dec 2009
 11:49:33 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ADD80E4E-DF62-11DE-9D48-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134349>

David Kastrup <dak@gnu.org> writes:

> Further comments/insights?

Just make sure that you state in the log message of the commits in the
series something like:

 - The way the series is split for easier review has to break X and Y
   and this commit does not even compile;

 - This is the second half of restructuring, and it compiles again;

 - Now A is fully restructured, test X works again, but Y is still broken;

 - This finally completes the series and everything works again.

for _human consumption_.  Bisect is not the only thing that needs to know
about these commits that are intentionally broken.  The reviewers and
people who test before accepting the history with these commits in their
history need to know about the known breakages, too.

Because you are talking about breakages that are _known_ when you make the
series, you can afford to follow this recommendation.  Object replacement
mechanism is _not_ the answer---it's whole point is that you can add it as
an afterthought by (virtually) squashing the series into one.

This way, the initial reviewers and a person who happened to hit such an
intentionally broken commit during bisect can deal with the situation
exactly the same way.  I.e. with "git log".
