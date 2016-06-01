From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] completion: create variable for untracked file modes
Date: Wed, 01 Jun 2016 00:02:06 -0700
Message-ID: <xmqqk2i91jf5.fsf@gitster.mtv.corp.google.com>
References: <5a3d279f-d3cc-90ec-a0e7-90b7ef438966@virtuell-zuhause.de>
	<20160601040542.GA18978@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 01 09:02:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b80AR-0006Jp-So
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 09:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbcFAHCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 03:02:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51147 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161029AbcFAHCK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 03:02:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 281B71AFC1;
	Wed,  1 Jun 2016 03:02:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RtYDGVFz2NxPel1c1UTr3Bp7uZc=; b=qcYq7o
	hkIFVEdr7L6uE4l3oVgH4mmu1NuwjrQpSH2AhVjKtzNfIdrDi8vYQtzSsxqmZABR
	ukVqsHmURhkz93CSPyODUeUwlJTTebPBiO+j0Il9KrxSCsEwtbFBj+asCO0VgS5+
	NiFF9Qi0AGNX6s84x3PaIQ7t+un6Bh0s4W9MM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LQPCYUVFYa0ifI4DZ9RGRUEFSdvY38bN
	RCUygtpkhRWRTL8PKcVvVeNqB8KHzf4oXjFbARnJLTSUwiPdRnaob768VQ52f4Kh
	K3wauGMzEDhVm6OXrm5CyMm/Y/j9I45oJNmOIt6JlXFHDQby1wL6XCIqe4lkjkvM
	jKhbGtGPiZI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F5F51AFC0;
	Wed,  1 Jun 2016 03:02:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 934231AFBF;
	Wed,  1 Jun 2016 03:02:08 -0400 (EDT)
In-Reply-To: <20160601040542.GA18978@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 1 Jun 2016 00:05:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C19EA84E-27C6-11E6-833D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296059>

Jeff King <peff@peff.net> writes:

>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index 3402475..57a0acc 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -1098,6 +1098,8 @@ _git_clone ()
>>  	esac
>>  }
>>  +__git_untracked_file_modes="all no normal"
>> +
>>  _git_commit ()
>>  {
>>  	case "$prev" in
>
> There's something funny about the formatting of your patch. The first
> "+" line is indented, which it shouldn't be. As it is, it looks like
> context (but it's not actually part of the preimage). But if it's not
> context, then you are missing a context line.

Not just that.  Count the context lines and notice that this appears
to have only 2 lines of precontext.

I think the MUA is somehow eating a blank line context (i.e. a
single SP on a line by itself) immediately after the closing brace
of the function before _git_commit and the next new line that began
with '+' in the original and made them into a single line.  I've
seen this exact breakage before, I think.
