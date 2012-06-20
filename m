From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git branch' when origin branch with same name exists
Date: Wed, 20 Jun 2012 11:07:52 -0700
Message-ID: <7v62alx3ev.fsf@alter.siamese.dyndns.org>
References: <4FE091FB.7020202@desrt.ca> <87a9zztdxt.fsf@thomas.inf.ethz.ch>
 <7v8vfj17de.fsf@alter.siamese.dyndns.org> <4FE0E493.1010308@desrt.ca>
 <CABURp0p6Hv8=Yg1MNb_DMRM3D2JWZtGNwn_GiOfP_x3MctrJ9A@mail.gmail.com>
 <7vr4t9x51j.fsf@alter.siamese.dyndns.org> <vpqa9zxan3a.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>, Ryan Lortie <desrt@desrt.ca>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 20 20:08:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShPJw-0007Td-5j
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 20:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756383Ab2FTSH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 14:07:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52533 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753473Ab2FTSHz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 14:07:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A4298565;
	Wed, 20 Jun 2012 14:07:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=trXUvZkS3OetTUw0mlHbzi+zkw0=; b=j7ltj+
	wnQO3LigkwZl7aFYbq+nHg4z9FVrGnkES0HFAK7T4JxE8QC/3LrHW5s5rbMUPUK2
	LfPbRed+QRbV04XIbGDK1LWqYhWBjyXG9wGo1z+XmP5PrUGuwRxK6g9uEjttUo6e
	3+1Bg3u/2+PB9iTwpta8yhxBKua7VOC0uN5TE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X6hLcOlwfFKNrQNgfK4s6ehITcAyfMYS
	Ok7DUwfoY4iji4M4u4JiGVpQjq0HU3sg2jsg1mwy3WX9t48MDdBqvWY0B3a+4eDv
	7zC7MUHYsKge1LFPKp3/MP3hHZqwhqisOBdXXTQeGwafzuXopqRn4Z5SgmfivSMw
	aiv8qlsJ9EQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CABF8563;
	Wed, 20 Jun 2012 14:07:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0474D8560; Wed, 20 Jun 2012
 14:07:53 -0400 (EDT)
In-Reply-To: <vpqa9zxan3a.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Wed, 20 Jun 2012 19:51:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB3C8CD8-BB02-11E1-8C33-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200312>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Requiring starting point and failing without --force will never
>> happen, but it could be a possible approach to issue an additional
>> advice message under reasonably narrow conditions, namely:
>>
>>  - The starting point was not given explicitly;
>>
>>  - It would have DWIMed to "git checkout -t -b it origin/it" when
>>    creating the branch (I think you need to check configurations
>>    like branch.autosetupmerge and existence of the tracking branch
>>    remotes/origin/it); and
>>
>>  - advice.branchNotTrackingCorrespondingRemote is not set to false.
>
> I like that. Stg like
>
> $ git branch next
> Creating local branch next starting from <sha1>.
> If you meant to checkout a new branch 'next' to track remote branch
> 'next' from 'origin', run these commands now:
> git branch -d next; git checkout next

Oh, another precondition would be that --force was _not_ given.

It is fairly clear "git branch -f next" is asking to forcibly update
an existing local 'next' to the current HEAD, not to origin/next,
and giving the above suggestion will be mildly irritating in such a
case.
