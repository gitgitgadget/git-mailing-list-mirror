From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] push: honor branch.*.push
Date: Mon, 24 Jun 2013 08:41:43 -0700
Message-ID: <7vy59zbjns.fsf@alter.siamese.dyndns.org>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
	<1372048388-16742-7-git-send-email-gitster@pobox.com>
	<CALkWK0=aDkCMB3ROSuH1crTmQKjCFyCmvJfvOTiQnBo4+NckBA@mail.gmail.com>
	<7vhagndis4.fsf@alter.siamese.dyndns.org>
	<CALkWK0kqyV+MTW8jDDBt-qEB1R7yvD+n4nTxwvW0QjA13J2=2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 17:41:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur8tr-0004d5-4i
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 17:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597Ab3FXPlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 11:41:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59205 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752568Ab3FXPlq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 11:41:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 477F72A095;
	Mon, 24 Jun 2013 15:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2d9vzbCeB3iYqoigkZDRqoAkw9I=; b=Pl0sug
	2UXLapSKIYoHE82I4M9wdXxgvhk+FJNr8hEZVnum5uD2Vov9R1oXIv9Hfy2gY6jb
	h0b8eNCo50sMjuaUp//iJW8niH/B8IdN3fMBQYYfRQXpCwNfOvMXyzP0Cm5xCPx4
	OiYbvrmosR5dQ/XDTK1dzfLsV96nZ1Wdfgh/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bhrCtwkKkwCb7ZBK9ASw9I806awMNR4R
	u+gDtlp9kM0SzpHqNjZ8qaJpaL8jwo3d1D/YG+TbTcKsh/nfNk5anwykL1Ku867Z
	fsx1YLEpJWlfQA6GuED8D5XP8awZx7Qw/fqZkJI/kHbKUzlIkPto6Ck24VQ2K6Px
	kCA37kfc+NI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C89B2A094;
	Mon, 24 Jun 2013 15:41:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A7812A091;
	Mon, 24 Jun 2013 15:41:44 +0000 (UTC)
In-Reply-To: <CALkWK0kqyV+MTW8jDDBt-qEB1R7yvD+n4nTxwvW0QjA13J2=2A@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 24 Jun 2013 19:49:38 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 92B2F3D0-DCE4-11E2-9705-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228841>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>>>   # on branch master, derived from origin
>>>   $ git push ram
>>>
>>> And branch.master.push is set to next?  Will you let her shoot herself
>>> in the foot like this?
>>
>> It is not shooting in the foot, if branch.master.push is explicitly
>> set to update next.  I do not see any issue in that part.
>
> The question does not pertain to master being mapped to next; it
> pertains to central-workflow versus triangular-workflow: origin versus
> ram.  If the user has set push.default to upstream, she _expects_
> triangular pushes to always be denied,...

If the user said "git push" without an explicit request to push to
"ram", and if branch.master.pushremote was not set to "ram", and
still the command "git push" pushed the branch to "ram", then I
would understand what you are worried about, but otherwise I do not
see how what you are saying makes sense.

A safety valve is different from a straight-jacket.  If you are
working largely with a central repository and have push.default set
to upstream, are you now disallowed to push out things to other
places to ask help from your colleague to check your wip?  Why?

Or are you saying that with push.default set to upstream, only these
two forms should be allowed?

    $ git push ;# no destination, no refspec
    $ git push there ref:spec ;# both explicitly specified
