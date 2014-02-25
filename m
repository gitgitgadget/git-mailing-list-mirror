From: Junio C Hamano <gitster@pobox.com>
Subject: Re: `git stash pop` UX Problem
Date: Tue, 25 Feb 2014 11:12:10 -0800
Message-ID: <xmqqwqgj57n9.fsf@gitster.dls.corp.google.com>
References: <530B0395.5030407@booking.com>
	<CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
	<vpqlhx0a3cb.fsf@anie.imag.fr> <530C893D.7000108@ira.uka.de>
	<vpqzjlf5q2z.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Holger Hellmuth <hellmuth@ira.uka.de>,
	Brandon McCaig <bamccaig@gmail.com>,
	Omar Othman <omar.othman@booking.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Feb 25 20:12:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WINQZ-0005fC-K4
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 20:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbaBYTMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 14:12:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37338 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752598AbaBYTMW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Feb 2014 14:12:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 428C66D457;
	Tue, 25 Feb 2014 14:12:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GSDOXBuTiIh7INY2AfOely/WnO8=; b=yagiT2
	c17FA+bLZvhei5vDW5U9nRJ/5cB05RJqZP6BCKgeExoi+atYK+WOjEINrLJ3CfSn
	RdfIPagXWA/CVrWk3t5lyVpiyMF3oSNk/bIiyz4geBV2Jp1/6CEefGPokQ34mipu
	a5ayVWxSzTm4Z2OHl2MjI2DKz4Q+6khsi3+4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BsUyxWO+65dTFU1+TiLhP1LH5BGEjNID
	54JycA0ljMN1FQfP0YoFkgA8cmSwa5id/Ropu9MFWf+B0yHuWp3POMnbaZ1CtCiV
	jZD0yJTEafwcFulFCnSPWkU/+Kqd2r5WquUus+8k2l9SH9+um4C/FobfJoyN6/yp
	4n4ifdk1VVg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 291626D454;
	Tue, 25 Feb 2014 14:12:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5961B6D42C;
	Tue, 25 Feb 2014 14:12:15 -0500 (EST)
In-Reply-To: <vpqzjlf5q2z.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	25 Feb 2014 13:33:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BD6B9446-9E50-11E3-83FA-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242679>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Holger Hellmuth <hellmuth@ira.uka.de> writes:
>
>> Am 24.02.2014 17:21, schrieb Matthieu Moy:
>>> $ git add foo.txt
>>> $ git status
>>> On branch master
>>> Changes to be committed:
>>>    (use "git reset HEAD <file>..." to unstage)
>>>
>>>          modified:   foo.txt
>>
>> Maybe status should display a stash count if that count is > 0, as
>> this is part of the state of the repo.
>
> Maybe it would help some users, but not me for example. My main use of
> "git stash" is a safe replacement for "git reset --hard": when I want to
> discard changes, but keep them safe just in case.
>
> So, my stash count is almost always >0, and I don't want to hear about
> it.

"status" is about reminding the user what changes are already in the
index (i.e. what you would commit) and what changes are in the
working tree, from which you could further update the index with
(i.e. what you could commit).

One _could_ argue that stashed changes are what could be reflected
to the working tree and form the source of the latter, but my gut
feeling is that it is a rather weak argument.  At that point you are
talking about what you could potentially change in the working tree,
and the way to do so is not limited to "stash pop" (i.e. you can
"git cherry-pick --no-commit $a_commit", or "edit" any file in the
working tree for that matter, with the same ease).

So, I tend to agree with you, while I do understand where "I want to
know about what is in stash" is coming from (and that is why we do
have "git stash list" command).
