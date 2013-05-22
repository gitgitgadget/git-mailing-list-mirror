From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Fixing volatile HEAD in push.default = current
Date: Wed, 22 May 2013 10:11:47 -0700
Message-ID: <7vppwjj5ws.fsf@alter.siamese.dyndns.org>
References: <1369160600-22337-1-git-send-email-artagnon@gmail.com>
	<7v38tgno2k.fsf@alter.siamese.dyndns.org>
	<CALkWK0m3QP_eE14y8UoJ+HeFzkKM=1nVKAnYJcTrwQMp+Atphg@mail.gmail.com>
	<7vppwkm682.fsf@alter.siamese.dyndns.org>
	<CALkWK0np7o0eH8ZsWQSwk1Cdwnnpj5B==gS8kAE+OkTskASOsQ@mail.gmail.com>
	<7v7girks4s.fsf@alter.siamese.dyndns.org>
	<CALkWK0kXonM+J92KHs+dW31A_kZ8h9jNqwYn8AqT_V+GJhe_vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 19:11:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfCZv-0004Pz-C2
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 19:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756250Ab3EVRLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 13:11:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58819 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755539Ab3EVRLu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 13:11:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C51AC20440;
	Wed, 22 May 2013 17:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5W/yRWiBa/Pzeq1GX9uJzmWOPQ0=; b=REav/K
	8+whBSMSgLEYfpJoXMAgVXAK/Iur5TAeR1OkKB48SbwxgwF5w/J074/558gp6Zpi
	iJqEJk8dSkoOXCjyvyBTODfM9VADyQnVSykwwcgjFTfxUMoRC5802hKfoW4qPBIY
	f5t/RaLSS4qXA2t9O6VNCjJCwj0FgV8nOBM1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=prF/AsaIN73OuRxHovAY2RkqDkYVXbZE
	dpaNILalHAhVHgGmvnWVmef+V1ShQ9RyvBQdvGT6rZz6Pcf5v46WKdzhUKcu287g
	jRV7ez9ZyMITnkLDy/AburzZeyRg6WgJdl2EuDJFegbZl4cXg2XU/pcmLLcmnmjT
	xkpBpy6LHDE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC33F2043F;
	Wed, 22 May 2013 17:11:49 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F7B32043C;
	Wed, 22 May 2013 17:11:49 +0000 (UTC)
In-Reply-To: <CALkWK0kXonM+J92KHs+dW31A_kZ8h9jNqwYn8AqT_V+GJhe_vg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Wed, 22 May 2013 20:13:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B06664A8-C302-11E2-9DB6-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225176>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> The patch may have been done by a wrong motivation, in that it does
>> not fundamentally "fix" the itch.  The particular "itch" is not
>> something we are going to promise to the end users, ever, anyway.
>
> Just out of curiosity, is it possible to write a correct fix at all?

Is there anything to "fix" in the first place, you have to wonder.

Your "git push there HEAD:master" would roughly do the following:

    (1) read HEAD to learn what commit you are pushing;

    (2) contact the other side and find where there tips are;

    (3) send a packfile that should be enough for the other side to
        have complete history leading to the commit you read in (1);

    (4) tell the other side to update its 'master' to the commit you
        read in (1).

If you drop step (1) and replace "the commit you read in (1)" in
steps (3) and (4) with "the commit you see in HEAD at this point by
re-reading HEAD", then such a "git push" that races with something
else you do in your other terminal may break---you can cause it to
see different commits at steps (3) and (4), potentially getting the
other side out of sync (but the receiving end does an independent
connectivity check so your push will likely to be rejected).

And the fix to such a breakage is to structure the code like the
above four steps to make it race-free.

If I understand your example correctly, you are talking about a
quite different thing.  "git push there HEAD:master" racing with
your other terminal that changes the HEAD sees different HEAD
depending on the order:

    (a) if the other terminal changes the HEAD first, step (1) will
        see that updated HEAD; or

    (b) if the step (1) reads HEAD before you change it in the other
        terminal, it will see the original HEAD.

But that is very much to be expected, isn't it?  It sounds similar
to

    I have "largedir" I want to get rid of, but there is a directory
    I want to save, "largedir/precious", in it, so I do

        cp -R largedir/precious precious

    and then run 'rm -rf largedir' in another terminal in parallel.

Is there anything to fix?
