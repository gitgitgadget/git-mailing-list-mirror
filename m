From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git stash takes excessively long when many untracked files present
Date: Tue, 13 Aug 2013 14:47:37 -0700
Message-ID: <7v61v9w9dy.fsf@alter.siamese.dyndns.org>
References: <20130810214453.GA5719@jtriplet-mobl1>
	<loom.20130813T120243-481@post.gmane.org>
	<7v7gfpy0wy.fsf@alter.siamese.dyndns.org>
	<1fc732a7-6b63-4d75-960f-0b1c6cf9c70e@email.android.com>
	<7vmwolwk94.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Josh Triplett <josh@joshtriplett.org>
To: Anders Darander <anders.darander@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 13 23:47:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9MRN-0005bB-S6
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 23:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757259Ab3HMVrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 17:47:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43604 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755502Ab3HMVrl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 17:47:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F5D038AA8;
	Tue, 13 Aug 2013 21:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KwWJH4DN+pUh9TpF6wOFTMfDipk=; b=P+IeiK
	mDpkewRYjlQhuY23BpT1pW1LbHZUAN9ZCijmcM2+cHNm+FKTI9KzTFogAESZAXEk
	O22RcD/KDdhT8xRvlEFvQGY4y625TAKGw1ZfOKaemBSDmDuLXBZ2ZaLfIriyoO5A
	kfPQmkfPUT3K3wV+2CnRE9+hIMZU6Q7OLMggI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h9LM+5Twf98idifgibCydccHWRwpf3Lq
	UaoUIXwknznsoVjFiTUU5YHjficSXKiIPdpO+PcIMp3bAVkjBoEPZSkP9KpaecLi
	Jfo6+vVCosXUdHA/nP6l1R3ldp6p20l1dEDO+vtU9LiUgWbxZiTNYLg0GUMIW++X
	NEm8Pp8SL5s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12CE638AA7;
	Tue, 13 Aug 2013 21:47:40 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A7B238AA6;
	Tue, 13 Aug 2013 21:47:39 +0000 (UTC)
In-Reply-To: <7vmwolwk94.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 13 Aug 2013 10:52:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F95236C4-0461-11E3-AE00-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232251>

[administrivia: people on the original thread added back on CC]

Junio C Hamano <gitster@pobox.com> writes:

> Anders Darander <anders.darander@gmail.com> writes:
>
>>>> Do anyone have any better idea on how to approach this?
>>>
>>>Teaching "ls-files" to leave early once it seens even a single
>>>output is probably a possibility.
>>
>> Would that mean that we're able to fail early?
>
> Heh, good point.  "Leave once you find one path" does not help the
> most common "sane" case where you do not kill any path, so it does
> not help us at all.

In any case, this is a regression introduced in 'master' since the
last release, and the attempted fix was for an issue that has long
been with us, so I'll revert a7365313 (git stash: avoid data loss
when "git stash save" kills a directory, 2013-06-28) soon.  For
today's -rc3, I'm already deep into the integration cycle, so it is
too late to do the revert it and then redo everything.

Then we will plan to re-apply the patch once "ls-files --killed"
gets fixed not to waste too much cycles needlessly, after the coming
release.

Thanks for a report and discussion.
