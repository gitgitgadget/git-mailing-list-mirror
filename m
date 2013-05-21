From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] sha1_name: fix error message for @{u}
Date: Tue, 21 May 2013 13:08:15 -0700
Message-ID: <7vtxlwm6z4.fsf@alter.siamese.dyndns.org>
References: <1369132915-25657-1-git-send-email-artagnon@gmail.com>
	<1369132915-25657-2-git-send-email-artagnon@gmail.com>
	<7vtxlwp9mf.fsf@alter.siamese.dyndns.org>
	<CALkWK0mTWtJ_U1O7ZkNU3aNFwGH456xtmDJhhmS3z1tfwFPNgA@mail.gmail.com>
	<7vfvxgnrdo.fsf@alter.siamese.dyndns.org>
	<CALkWK0nEXKXxercc1mNjyK-QX0pOBeKWAxPZtSPvN_h1eniO5g@mail.gmail.com>
	<CALkWK0m7VBz3wDGUACJAfp33M1GYqKCeMCkQwrgA7kqRMp_rtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 22:08:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uesr9-0008Oa-Cs
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 22:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599Ab3EUUIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 16:08:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63490 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752038Ab3EUUIR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 16:08:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E4FF20D59;
	Tue, 21 May 2013 20:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=py9DBwL0umRMOVtn4R48lzo6Liw=; b=Mp1no/
	2Rcw6hT7LeLsxZAQ515Mz2m9YSB5ZlqByxsQgvH0qsT9xGwFcrz/w5TdY7oF0twp
	TxyQSzUi7DuOf0UMcEzX/QvqJFJxUky2IyLorEwfMUvlt+k5dbNU3zP8HWiSZpgb
	vMbbzedms1kNE/vpkZXxN/4CxCmwqG4ah+xrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hB8steueXQPL3uEKw9T5vbI2+bYb0Th4
	V0372wTwx5FXNUp05k5KbavXO+2BPWYbM/3opTMx8dBNo5X3dxa9C5p96H0q3ysE
	EshyOmlb7toWWvKCRURnnxTfLgiJ+NB1bAUQirDNFRTN22Sau9ooD6KzLmq2v6g0
	vdZ9X4hNstM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6694F20D58;
	Tue, 21 May 2013 20:08:17 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C791B20D3E;
	Tue, 21 May 2013 20:08:16 +0000 (UTC)
In-Reply-To: <CALkWK0m7VBz3wDGUACJAfp33M1GYqKCeMCkQwrgA7kqRMp_rtQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Wed, 22 May 2013 00:49:47 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2CBD5FB8-C252-11E2-998D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225071>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Ramkumar Ramachandra wrote:
>> Junio C Hamano wrote:
>>> So did you or did you not audit the codepath?
>>
>> No; I was explaining why I didn't in the first place.  Going through it now.
>
> So, this is what I have:
>
> interpret_branch_name -> interpret_branch_name (recursion)
>                       -> get_sha1_basic -> get_sha1 [context] (end-user data)
>                       -> substitute_branch_name -> dwim (end-user data)
> 		      -> strbuf_branchname (callers pass a branch name; no @{u})
> 		      -> revision.c:add_pending_object [with_mode] (end-user data)
>
> [die_]verify_filename -> builtin/rev-parse.c (end-user)
> 		      -> builtin/reset.c (end-user)
> 		      -> builtin/grep.c:cmd_grep (end-user)
> 		      -> revision.c:setup_revisions (end-user data)

It seems that you are digging in the wrong direction?  I was worried
about the callers of interpret_branch_name().

But whatever.

I looked at the callers myself while waiting for the test suite to
pass for five integration branches and I think the patch is safe.
There were some silent error returns from the function but your
patch did not touch them (which is good).

> We used to die in die_verify_filename() earlier, but we die in
> interpret_branch_name() after the patch.

I think that is a desired outcome.  Thanks.
