From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add __git_ps1_pc to use as PROMPT_COMMAND
Date: Mon, 01 Oct 2012 12:13:21 -0700
Message-ID: <7v4nmec8fi.fsf@alter.siamese.dyndns.org>
References: <5064140E.50007@drmicha.warpmail.net>
 <50658C9B.6030809@nieuwland.nl> <7vipaym3ks.fsf@alter.siamese.dyndns.org>
 <50695ECE.5010101@nieuwland.nl> <7v626udse6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, s.oosthoek@xs4all.nl,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	schwab@linux-m68k.org
To: Simon Oosthoek <soosthoek@nieuwland.nl>
X-From: git-owner@vger.kernel.org Mon Oct 01 21:13:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIlQt-00020C-Ex
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 21:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332Ab2JATN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 15:13:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53817 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104Ab2JATNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 15:13:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1592C8B1B;
	Mon,  1 Oct 2012 15:13:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3lLvGGPAJBMq6Ad/YGQqhjERUeY=; b=i5ONDm
	jVn3mQVYBQ52SZO8B1+FeMhP/hhvZeGmwnywTZWpnYoFTD8QIMkeSY5JQeYAGhYi
	jL4VLRYTeQXKg6pmSUZoxX2TFSPpImORaHcdLaulFY4HntQLa8xtBlBQCnfKojAj
	WlTC34WgNfw0YryJcXX0/akCk7hpps3puE2es=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sJjCvRKpItTaxJmh7jDh7fngnwSG4mSu
	+zc+2We9yHACvuM2bZpcbVrHrNHkK0Qomkf2RlVM8DyLMTfyJRVe7tcBkRVPPK7b
	RcfdQnOCmeuwoc/tBE3+A8e3P4mG+Wlne0wPA5jR9gpc9uIYCNNKCvwsHhgfWKDm
	LWxcYpNJY5I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00D178B1A;
	Mon,  1 Oct 2012 15:13:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76B398B16; Mon,  1 Oct 2012
 15:13:23 -0400 (EDT)
In-Reply-To: <7v626udse6.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 01 Oct 2012 10:16:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11F277AC-0BFC-11E2-979E-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206758>

Junio C Hamano <gitster@pobox.com> writes:

>> I agree that it's ugly. How about the following:
>>
>> I modified __git_ps1 to work both in PROMPT_COMMAND mode and in that
>> mode support color hints.
>>
>> This way there's one function, so no overlap.
>
> I think the logical progression would be
>
>  - there are parts of __git_ps1 you want to reuse for your
>    __git_ps1_pc; separate that part out as a helper function,
>    and make __git_ps1 call it, without changing what __git_ps1
>    does (i.e. no colors, etc.)
>
>  - add __git_ps1_pc that uses the helper function you separated
>    out.
>
>  - add whatever bells and whistles that are useful for users of
>    either __git_ps1 or __git_ps1_pc to that helper function.

Hrm, let me ask a stupid question.  Why do we even need __git_ps1_pc
in the first place?  Wouldn't it be just the matter of

	PROMPT_COMMAND='__git_ps1 "%s"'

once you have __git_ps1 that works?
