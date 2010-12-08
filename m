From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improved error messages when temporary file creation
 fails
Date: Tue, 07 Dec 2010 18:01:07 -0800
Message-ID: <7vpqtdm3a4.fsf@alter.siamese.dyndns.org>
References: <20101207181633.GF25767@bzzt.net>
 <7v62v5paj2.fsf@alter.siamese.dyndns.org> <20101207212041.GG25767@bzzt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arnout Engelen <arnouten@bzzt.net>
X-From: git-owner@vger.kernel.org Wed Dec 08 03:01:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ9La-0002QH-2D
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 03:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756941Ab0LHCBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 21:01:19 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34285 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756366Ab0LHCBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 21:01:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DC7CD29BC;
	Tue,  7 Dec 2010 21:01:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4a5kmfEEGXyzdJKQtIZf9razIas=; b=Vv8Sp2
	R32959HSZTk3kN/4t9kuWIJlP/o7D8Ddjs+7ViwtkBcV4ZN8T4qduqh8ECYZj97O
	ST9KIlBs0G8w5enwLhoCvGrxFL1N7TE9qiefa4cKFaDL6mQMBRfb/25xjSUTfU0i
	XV/udv1fhk9y8AGuW6+ACbRgc4qB+e9JkckNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bQYz5JpBrsZdTJ6cXEp/0hQo3zp1HGSh
	kBo0UwfpeqDzmXCcXe70SJLaSnTOSemhfK+MQJXIrzakkg6+RJXWJ4m6oYT8PYTC
	pOtMSud8AC3w4nGdl+sJoXZR3JYM2umNE41ALXZMACEpEntrWCWa60zPQv9valzr
	UE+/ND2hDWE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A715F29BB;
	Tue,  7 Dec 2010 21:01:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6694529BA; Tue,  7 Dec 2010
 21:01:33 -0500 (EST)
In-Reply-To: <20101207212041.GG25767@bzzt.net> (Arnout Engelen's message of
 "Tue\, 7 Dec 2010 22\:20\:41 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 16B0D722-026F-11E0-8B61-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163159>

Arnout Engelen <arnouten@bzzt.net> writes:

> Thanks to you and Jonathan again for the feedback.
>
> On Tue, Dec 07, 2010 at 12:56:17PM -0800, Junio C Hamano wrote:
>> > +	char origtemplate[255];
>> > +	strlcpy(origtemplate, template, 255);
>> 
>> Why "255"?
>
> Random - 'i had to choose something'.
>
>> It may happen to be sufficiently large for the current callers, but what
>> provisions if any are made to help the compiler or the runtime protect us
>> from new and broken callers?  Use of strlcpy() there hides the issue from
>> the runtime by avoiding segfault, but it actively harms us by making the
>> code silently behave incorrectly without segfaulting, no?
>
> Only in a small way: when a bigger template is encountered and the mkstemp 
> call succeeds, there is no problem. Only when xmkstemp fails *and* clears the
> template, the diagnostic error message shows a truncated version of the 
> original.

Ah, ok, it seems that I misread the patch.  This copy you are making is
not used to actually construct the filename used for creating the
temporary file, so there is no risk the function misbehaving; we would
just give a truncated error report, which is no worse than what we have
been giving the users anyway.
