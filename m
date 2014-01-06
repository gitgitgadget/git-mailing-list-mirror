From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Mon, 06 Jan 2014 14:22:59 -0800
Message-ID: <xmqqha9ghhrw.fsf@gitster.dls.corp.google.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
	<1389028732-27760-3-git-send-email-artagnon@gmail.com>
	<xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
	<CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
	<xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
	<CALkWK0nSed9vvRvTR00_vV3tHL8mSQA=8JJ_Y7=pQchoVcvhzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 23:23:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0IZl-0006mB-IH
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 23:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289AbaAFWXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 17:23:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36004 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754093AbaAFWXH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 17:23:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFC3A614E7;
	Mon,  6 Jan 2014 17:23:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Svi7qrj6r8scIPK/041smwQsSXk=; b=yF9+v+
	lXE0Og3W8KaEKYVvV0KMyTCAYWw0Qjsya2dCIj0R0qszBo4eclk1JfO15q6Z7e3t
	5cWqdVBce2SG0IYH9yxGVINg3ayw/G3q2Uyro1zVC14BSlUzWBZMwHkih3kd5Ilo
	BCBkgG1QHw7T5R6mPK3DZFwQtwowT/KgWgUAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sBz6YmY1+mxA0Gly2l6liOaa3VAIFDcT
	KHM30ZTcznd5txMWkhLkFR06ylo8FVdpEDrfXk8N7CBzzAzrpQ9zDJmiIFxy0Zyv
	UjKeLGKhehIKJobDeOAXQ0M/R1Ur6rUdA9c4h5oGXccPpjmAjAhhOuJ53jNk61w0
	yITskwm8PLY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83F6A614E4;
	Mon,  6 Jan 2014 17:23:05 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A85A614E0;
	Mon,  6 Jan 2014 17:23:03 -0500 (EST)
In-Reply-To: <CALkWK0nSed9vvRvTR00_vV3tHL8mSQA=8JJ_Y7=pQchoVcvhzA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 7 Jan 2014 03:29:39 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1C32A318-7721-11E3-9366-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240075>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> I meant "a single branch" as opposed to "depending on what branch
>> you are sending out, you may have to use a different upstream
>> starting point", and a single "format.defaultTo" that does not read
>> what your HEAD currently points at may not be enough.
>>
>> Unless you set @{u} to this new configuration, in which case the
>> choice becomes dynamic depending on the current branch, but
>>
>>  - if that is the only sane choice based on the current branch, why
>>    not use that as the default without having to set the
>>    configuration?
>>
>>  - Or if that is still insufficient, don't we need branch.*.forkedFrom
>>    that is different from branch.*.merge, so that different branches
>>    you want to show "format-patch" output can have different
>>    reference points?
>
> Ah, I was going for an equivalent of merge.defaultToUpstream, but I
> guess branch.*.forkedFrom is a good way to go.

As I said in the different subthread, I am not convinced that you
would need the complexity of branch.*.forkedFrom.  If you set your
"upstream" to the true upstream (not your publishing point), and
have "remote.pushdefault" set to 'publish', you can expect

	git push

to do the right thing, and then always say

	git show-branch publish/topic topic

to see where your last published branch is relative to what you
have, no?  Mapping "topic@{publish}" to "refs/remotes/publish/topic"
(or when you have 'topic' checked out, mapping "@{publish}" to it)
is a trivial but is a separate usefulness, I would guess.
