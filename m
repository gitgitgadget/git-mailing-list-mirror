From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Change configure to check if pthreads are usable without
 any extra flags
Date: Mon, 09 Jul 2012 10:44:47 -0700
Message-ID: <7vy5mskewg.fsf@alter.siamese.dyndns.org>
References: <1341529386-11589-1-git-send-email-max@quendi.de>
 <7vk3ydkmzq.fsf@alter.siamese.dyndns.org>
 <C56B4151-8912-4B3A-8A97-E769A878AE68@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Mon Jul 09 19:45:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoI13-0002Ek-8c
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 19:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661Ab2GIRov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 13:44:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44094 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522Ab2GIRou (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 13:44:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 241418376;
	Mon,  9 Jul 2012 13:44:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8JgqG1PP+YddgyzM0nn65FGK45I=; b=u/natM
	dqohj0qGaAw+5NShX9Vypb2Xte2YwuTVXZJHGYyQcHY2qXLXJiwTTubgoCnHhM/c
	p9pKvFyCgcT3MOYtNwlKKNNna3SdCk1EKDhhvLkXkQd61XDOowuKWrE5HKqrfLi0
	rM7Y1bjZiDjrXj3sRe4QSedfbrariAkXTXYCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yCHYYrS6dXbn4yWTkYSOK+lksOsOQWoU
	Xx6KoJCYDSpNa1O0dKr5o4CahqZNOOPi/Jbkj4whW9/IIDfZUEhf3264+hJn1QK1
	xIuDro9EQsIUhrypQQ0sC647JJG5sx5oK/N/idy4Kp4dkmtuErcS/uBQznj8c5m2
	qR9biShgc/o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1533B8375;
	Mon,  9 Jul 2012 13:44:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 754B28374; Mon,  9 Jul 2012
 13:44:49 -0400 (EDT)
In-Reply-To: <C56B4151-8912-4B3A-8A97-E769A878AE68@quendi.de> (Max Horn's
 message of "Mon, 9 Jul 2012 17:39:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7D5695E-C9ED-11E1-BD4B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201213>

Max Horn <max@quendi.de> writes:

>>> diff --git a/configure.ac b/configure.ac
>>> index 4e9012f..d767ef3 100644
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -1002,7 +1002,7 @@ if test -n "$USER_NOPTHREAD"; then
>>> # -D_REENTRANT' or some such.
>>> elif test -z "$PTHREAD_CFLAGS"; then
>>>   threads_found=no
>>> -  for opt in -mt -pthread -lpthread; do
>>> +  for opt in "" -mt -pthread -lpthread; do
>> 
>> Hmph.  Would it work to append the new empty string at the end of
>> the existing list, as opposed to prepending it?
>
> No, because that loop aborts on the first match that "works". Since no flags are necessary on OS X, but adding "-mt" to the flags "works" in the sense that it does nothing (except triggering a warning about an unknown argument), we need to check the empty string before "-mt" that. 

If the test in that "for opt ...; do" considers the linking "work",
why do you even want to tweak it, and instead let "-mt" be passed?

If the warning troubles you, would it be feasible for the purpose of
the check to tweak the definition of "works" used in the loop so that
it considers the warning as "not working"?
