From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2012, #01; Sun, 3)
Date: Wed, 06 Jun 2012 10:58:02 -0700
Message-ID: <7vbokwmifp.fsf@alter.siamese.dyndns.org>
References: <7vr4twudqm.fsf@alter.siamese.dyndns.org>
 <CAMP44s0cQe3jdfzbJmFVoFS50Ho5hVPg9dpZx0KhG3sP_J8=_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 19:58:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScKUq-0000o2-Si
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 19:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757897Ab2FFR6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 13:58:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53615 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757891Ab2FFR6H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 13:58:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3A76876A;
	Wed,  6 Jun 2012 13:58:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bpT9wNmDkBz2bIn4NaOOFs4Oj3M=; b=eMnura
	Hh+wv4+uIlq1sYO6yQJ3dnt7zQUYd22K5vEa4HqrKcM9kQtGOWXAVEfzCp5B83Pb
	QUGkrjlIGL+u4ly6j9LIaq6JrCdDGyoRqaUioBW6jaU5P/CUDTHVHn5l4Inj6Zcw
	qJVaWjJVvDjK0qhN+by5H0epWeuFf3lXPxj+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q9PVWDf+709mAXaeoRUEO+CkgPRvX2ic
	BzsDUE9T7qCpwxv6JZ76bTfDUlQ2tKDl0GVAddhaOIsooUSlo93y4NI1AimxwgXZ
	Ui6uug6fYNp4r5Ufs1vZZeggra8/a36BypT8XJG2rmSfjhtGzdH0JGVAOpefxcmK
	8LLbKncDfMY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A72C38768;
	Wed,  6 Jun 2012 13:58:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DE1C8766; Wed,  6 Jun 2012
 13:58:03 -0400 (EDT)
In-Reply-To: <CAMP44s0cQe3jdfzbJmFVoFS50Ho5hVPg9dpZx0KhG3sP_J8=_g@mail.gmail.com> (Felipe
 Contreras's message of "Wed, 6 Jun 2012 14:22:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 29D16600-B001-11E1-953D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199342>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> The last remaining sticking point is what to do with the duplicated shell
>> function.
>
> What is the problem with leaving it as it is; having it as a duplicate
> function. It's not a *huge* maintenance burden, and it's a big problem
> if the functions diverge.

It is not even funny to see these two conflicting claims made in a
single sentence.  Given that you are aware that it will cause a huge
problem to the end users if they diverge, is there any mechanism in
the result of applying the series to prevent it from happening?

The preventative measure could be any of these:

 (1) a build structure that arranges the sources in such a way that
     there is only one copy for anybody who edits the function, so
     that by definition they cannot diverge;

 (2) a test that causes "make test" to notice that the duplicated
     copies diverged and makes the test fail, so that such a
     breakage is caught before being pushed out; or

 (3) a note near each of the duplicated definitions of the function,
     telling people that when touching one copy, the modifier must
     change the other copy to keep the duplicated definitions match,
     so that reviewers would notice the note in the context of a
     faulty patch that touches only one side.

I did not see anything like these.

I think I've sent out a patch along the line of (1) in an attempt to
help, but I do not recall you responded to it in any way. And the
first thing you do is to complain. The maintenance burden could be
made into "not huge", but what you are doing is to actively make it
more burdensome than necessary.

> I still plan to add a native helper for this, but I don't see what
> that would block these patches.

I do not want to see a native helper, if other approaches would
equally work to prevent divergence from happening, in which case
such a change to the core would be a useless code churn.
